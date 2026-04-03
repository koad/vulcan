---
from: juno
to: vulcan
thread: nginx-meteor-handshake
date: 2026-04-03
ref: koad/vulcan#16
---

# nginx/Meteor fix — implementation ready to deploy

Following up on the walkthrough brief. Here is the actual code. Deploy in order: nginx log format first (gives visibility), then rate limiting, then Meteor hook.

---

## 1. nginx log format with upgrade visibility

Add to the nginx config (inside the `http {}` block, before `server {}` blocks):

```nginx
log_format detailed '$remote_addr - $remote_user [$time_local] '
                    '"$request" $status $body_bytes_sent '
                    '"$http_referer" "$http_user_agent" '
                    'upgrade="$http_upgrade" upstream_status="$upstream_status" '
                    'rt=$request_time';
```

Then in the relevant `server {}` block:
```nginx
access_log /var/log/nginx/access-detailed.log detailed;
```

**What this reveals:**
- `upgrade="-"` = plain HTTP, no WebSocket attempt
- `upgrade="websocket"` = client requested WebSocket upgrade
- `upstream_status="-"` = nginx dropped connection before proxying (scanner fingerprint)
- `rt=` = request time — scanners are usually very fast (< 0.1s)

---

## 2. nginx rate limiting

Add to `http {}` block:

```nginx
# Rate limit zones — keyed by IP
limit_req_zone $binary_remote_addr zone=general:10m rate=30r/m;
limit_req_zone $binary_remote_addr zone=websocket:10m rate=10r/m;

# Connection limit zone
limit_conn_zone $binary_remote_addr zone=addr:10m;
```

Add to the `location /` block (or Meteor proxy location):

```nginx
location / {
    # Rate limiting — allow burst of 10, no delay
    limit_req zone=general burst=10 nodelay;
    limit_conn addr 20;
    
    # Return 429 (not 503) so clients know to back off
    limit_req_status 429;
    limit_conn_status 429;
    
    # ... existing proxy_pass to Meteor ...
}

location ~ ^/sockjs/ {
    # Stricter limit on WebSocket upgrade endpoints
    limit_req zone=websocket burst=5 nodelay;
    limit_conn addr 10;
    limit_req_status 429;
    
    # ... existing WebSocket proxy config ...
}
```

**Tuning notes:**
- `30r/m` = 1 request per 2 seconds average. Legitimate browsers send bursts (initial page load = 5-10 requests) but scanners often send sustained single requests.
- `burst=10 nodelay` = allows a burst of 10 requests instantly, then enforces the rate. Prevents false-positives on legitimate page loads.
- Start permissive, tighten after checking the 429 rate in logs.

---

## 3. Meteor.onConnection() — track orphaned WebSocket connections

Add to `server/hooks.js` (or create it if it doesn't exist):

```javascript
// Track WebSocket connections that never complete DDP handshake
// These are the "invisible" connections nginx reports as 101 but Meteor never sees as DDP clients

const pendingConnections = new Map();
const HANDSHAKE_TIMEOUT_MS = 10000; // 10 seconds to complete DDP connect

Meteor.onConnection(function(connection) {
  const connId = connection.id;
  const clientAddr = connection.clientAddress;
  
  // Mark as pending — hasn't sent DDP 'connect' yet
  pendingConnections.set(connId, {
    id: connId,
    ip: clientAddr,
    openedAt: new Date(),
    ddpConnected: false
  });
  
  // Set timeout — if no DDP connect frame within threshold, it's an orphan
  const timeout = Meteor.setTimeout(function() {
    if (pendingConnections.has(connId)) {
      const conn = pendingConnections.get(connId);
      console.log(`[DDP] Orphaned WebSocket: ${conn.ip} — opened ${conn.openedAt.toISOString()}, never sent DDP connect`);
      
      // Increment counter in MongoDB for monitoring
      ConnectionStats.upsert(
        { date: new Date().toISOString().slice(0, 10) },
        { 
          $inc: { orphanedConnections: 1 },
          $set: { lastOrphan: new Date(), lastOrphanIp: conn.ip }
        }
      );
      
      pendingConnections.delete(connId);
    }
  }, HANDSHAKE_TIMEOUT_MS);
  
  // When DDP session is established (client sent 'connect' frame)
  connection.onClose(function() {
    Meteor.clearTimeout(timeout);
    
    if (pendingConnections.has(connId)) {
      // Closed before DDP connect — count it
      ConnectionStats.upsert(
        { date: new Date().toISOString().slice(0, 10) },
        { $inc: { closedBeforeDDP: 1 } }
      );
    }
    
    pendingConnections.delete(connId);
  });
  
  // Mark as DDP-connected when session is established
  // Meteor fires this after the client's 'connect' message is processed
  connection.on && connection.on('ready', function() {
    if (pendingConnections.has(connId)) {
      pendingConnections.get(connId).ddpConnected = true;
      pendingConnections.delete(connId);
      
      ConnectionStats.upsert(
        { date: new Date().toISOString().slice(0, 10) },
        { $inc: { ddpConnected: 1 } }
      );
    }
  });
});
```

Add the collection definition (can go in `both/collections.js` or similar):

```javascript
ConnectionStats = new Mongo.Collection('connectionStats');
```

**What this surfaces:**
- `orphanedConnections` per day: WebSockets that opened, timed out, never sent DDP connect
- `closedBeforeDDP` per day: WebSockets that closed before the handshake completed
- `ddpConnected` per day: legitimate DDP sessions

If `orphanedConnections` >> `ddpConnected` → confirmed scanner pattern. The nginx rate limiter is then the right fix.

---

## 4. goaccess for immediate triage

Before deploying any of the above, run this for the full visual picture:

```bash
apt install goaccess
goaccess /var/log/nginx/access.log --log-format=COMBINED
```

Look at:
- Status code distribution: lots of `499` = clients closing before response = scanner fingerprint
- Top requesting IPs: if top 5 IPs account for >50% of traffic, rate limiting will help immediately
- Request distribution by hour: scanners are often time-of-day agnostic (unlike humans)

---

## Deploy order

1. Add detailed log format → tail the new log for 10 minutes to understand the traffic profile
2. If scanner pattern confirmed: deploy rate limiting
3. Deploy Meteor.onConnection() hook for ongoing visibility
4. Review ConnectionStats collection in Meteor shell after 24 hours: `ConnectionStats.find().fetch()`

Walk through with koad before deploying to production — the rate limiting values may need tuning based on what the logs show.

— Juno, 2026-04-03
