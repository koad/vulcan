---
date: 2026-04-03
author: Vulcan
status: planning
ref: koad/vulcan#7, koad/vulcan#15, koad/vulcan#16, koad/vulcan#17, koad/vulcan#19
---

# Daemon Peer Layer — Architecture & Implementation Strategy

## The Model Change

**From:** kingofalldata.com as static brand/namespace site with GitHub-pulled data  
**To:** kingofalldata.com as a live portal pulling real-time state from daemon peers  

The daemon IS the ring of trust. Portal is the window into it.

### Why This Matters

The original MVP spec (koad/vulcan#7) assumed namespace data would be static — pulled from git repos, regenerated on GitHub webhooks, served as JSON files.

VESTA-SPEC-014 reframes this: **the daemon peer layer is the product.** A kingdom's state (worker activity, trust bonds, keys, metrics) flows through the daemon peer network. The portal renders that live state.

**Example:** `juno.kingofalldata.com` doesn't fetch Juno's keys from `github.com/koad/juno/juno.keys` anymore. Instead:
1. Portal resolves `juno.kingofalldata.com` → looks up Juno's daemon hostname via DNS
2. Portal connects to Juno's daemon as a read-only client (portal auth)
3. Daemon streams current state: workers, trust bonds, keys, metrics
4. Portal renders the live dashboard

This is the difference between a proof-of-concept static site and an actual operating network of sovereign AI entities.

---

## What's Already Built

### kingofalldata.com (namespace-engine)
- ✅ Meteor skeleton with client/server structure
- ✅ MongoDB Namespaces collection with CRUD operations
- ✅ Static `/namespace/{name}/data.json` endpoint (JSON-based)
- ✅ Nginx config with wildcard subdomain routing
- ✅ Basic layout components (header, footer)
- ❌ NOT connected to daemon state (still static)
- ❌ NO portal query protocol (no TLS client auth)
- ❌ NO real-time streaming from daemon

### Daemon Infrastructure
- ✅ Core package exists in `~/.koad-io/packages/core/`
- ❌ No peer port (PEER_PORT=6379)
- ❌ No peer certificate infrastructure (`~/.{entity}/id/peer/`)
- ❌ No sponsor sync protocol
- ❌ No peer discovery (no `peers.json`)
- ❌ No data streaming (worker state, logs, metrics)
- ❌ No portal auth handler

---

## Critical Path to Live

### Phase 1: Daemon Peer Layer (Foundation)
**Owner:** Vulcan | **Blocks:** Portal integration, multi-kingdom network

Must build before portal integration can work:

1. **Daemon peer port & certificate infrastructure**
   - Add PEER_PORT, PEER_LISTEN_ADDR config to `~/.{entity}/.env`
   - Generate peer certificate (RSA 2048 or ECDP P-256) at `~/.{entity}/id/peer/`
   - TLS listener on port 6379 (or configured port)

2. **Sponsor sync protocol (HTTP)**
   - Daemon can query sponsor for peer list via HTTPS
   - Request signed by daemon (ed25519 signature)
   - Response: array of peers with hostname, port, tier, cert hash
   - Updates `~/.{entity}/peers.json` locally

3. **Peer discovery & connection**
   - Load `peers.json` on daemon startup
   - Attempt TLS connections to peers hourly
   - Validate peer certificate hash (pinning)
   - Mark peers connected/failed/pending in `peers.json`

4. **Worker state streaming**
   - When peer connection succeeds, peer daemon streams worker state
   - Format: `{type: "stream_update", data_type: "worker_state", timestamp, source_daemon, payload}`
   - Sponsor buffers in `~/.{entity}/.peers/{peer_hostname}/worker-state.jsonl`

5. **Portal read-only client**
   - Daemon accepts connections from `portal.kingofalldata.com`
   - Portal auth message: `{type: "peer_auth", daemon: "portal.kingofalldata.com", role: "portal", signature, capabilities}`
   - Daemon validates portal signature using pre-distributed public key
   - Portal can query current worker state, historical logs (24h buffer), metrics
   - Read-only enforcement in daemon auth handler

### Phase 2: kingofalldata.com Portal Integration
**Owner:** Vulcan | **Depends on:** Phase 1 daemon peer layer

Once daemon layer works:

1. **Portal daemon query client**
   - Meteor method: `kingdom.query(hostname, data_type)` 
   - Connects to daemon, sends portal auth, retrieves data
   - Caches for 10 seconds to avoid hammering daemon

2. **Live namespace rendering**
   - Root page: query daemon for latest worker activity, trust bonds, keys
   - Namespace pages: real-time dashboard pulling from daemon
   - `/keys` endpoint: live from daemon, not static JSON file
   - Fallback to cached data if daemon unreachable

3. **Peer topology visualization**
   - Portal displays peer ring: who is sponsored by whom, connection status
   - Uses daemon's `peers.json` to render network graph

---

## Daemon Phase 1 Implementation Details

### File Structure

```
~/.{entity}/
  .env                          # Add PEER_* config
  id/peer/
    certificate.pem             # TLS cert (self-signed or Vesta CA)
    private.key                 # TLS key
  peers.json                    # Local peer list + status
  .peers/                       # Peer data buffer (24h retention)
    {peer_hostname}/
      worker-state.jsonl
      logs.jsonl.gz
      metrics.jsonl
  .logs/
    peers.log                   # Connection status timeline
```

### .env additions

```bash
PEER_PORT=6379
PEER_LISTEN_ADDR=0.0.0.0
PEER_TLS_CERT=/home/koad/.{entity}/id/peer/certificate.pem
PEER_TLS_KEY=/home/koad/.{entity}/id/peer/private.key
PEER_SYNC_INTERVAL_MINUTES=60
PEER_BUFFER_RETENTION_HOURS=24
PEER_RATE_LIMIT_RPS=1000
```

### Sponsor sync request/response

**Request (Control Channel to sponsor endpoint, signed):**

```json
{
  "version": "1.0",
  "command": "daemon:peer-list",
  "args": ["tier=basic"],
  "timestamp": "2026-04-03T12:00:00Z",
  "request_id": "uuid-1",
  "signature": "ed25519(...)"
}
```

**Response:**

```json
{
  "version": "1.0",
  "request_id": "uuid-1",
  "status": "success",
  "result": {
    "peers": [
      {
        "hostname": "company2.koad.sh",
        "port": 6379,
        "tier": "basic",
        "tls_cert_sha256": "xyz789...",
        "sponsor": "juno"
      }
    ]
  },
  "timestamp": "2026-04-03T12:00:01Z"
}
```

### Peer auth (no signature verification in Phase 1)

When portal connects to daemon:

```json
{
  "version": "1.0",
  "type": "peer_auth",
  "daemon": "portal.kingofalldata.com",
  "role": "portal",
  "timestamp": "2026-04-03T12:00:00Z",
  "request_id": "uuid-portal-1"
}
```

Daemon validates:
- TLS certificate is valid and trusted
- Timestamp is within 5 minutes
- `role: "portal"` enables read-only access

---

## Issues to File

### Issue 1: Daemon Phase 1 — Peer Infrastructure
- [ ] Peer port, TLS listener, certificate generation
- [ ] Peer certificate storage at `~/.{entity}/id/peer/`
- [ ] Configuration via `.env` (PEER_PORT, PEER_LISTEN_ADDR, etc.)

### Issue 2: Daemon Phase 1 — Sponsor Sync Protocol
- [ ] HTTP client to sponsor endpoint (/daemon:peer-list)
- [ ] Request signing (ed25519) and response validation
- [ ] Update `peers.json` with peer list on sync
- [ ] Sync interval (60-minute default)

### Issue 3: Daemon Phase 1 — Peer Discovery & Connection
- [ ] TLS client to connect to peer daemons
- [ ] Certificate hash pinning validation
- [ ] Connection retry logic
- [ ] `peers.json` status tracking (connected/pending/failed)
- [ ] Hourly connection refresh

### Issue 4: Daemon Phase 1 — Worker State Streaming
- [ ] Stream worker state from peer → sponsor
- [ ] JSON format per VESTA-SPEC-014 Section 4.3
- [ ] Buffer worker state in `~/.{entity}/.peers/{peer_hostname}/worker-state.jsonl`
- [ ] 24-hour retention policy

### Issue 5: Daemon Phase 1 — Portal Read-Only Client
- [ ] TLS handler for `portal.kingofalldata.com` connections
- [ ] Portal auth validation (no signature verification in Phase 1)
- [ ] Read-only data access enforcement
- [ ] Query endpoints: `/query/worker-state`, `/query/metrics`, `/query/logs`
- [ ] Rate limiting (60 req/min per kingdom)

### Issue 6: kingofalldata.com Portal Integration (Phase 2)
- [ ] Meteor method: `kingdom.query(hostname, data_type)`
- [ ] TLS client connection to daemon via portal role
- [ ] Live data rendering in namespace pages
- [ ] Fallback to cached data if daemon unavailable
- [ ] Peer topology visualization (who is connected to whom)

---

## Dependency & Blocking Chain

```
Phase 1 Daemon Layer
  ├─ Issue 1: Peer infrastructure
  ├─ Issue 2: Sponsor sync
  ├─ Issue 3: Peer discovery
  ├─ Issue 4: Worker state streaming
  └─ Issue 5: Portal read-only client
         ↓
Phase 2 kingofalldata.com Portal
  └─ Issue 6: Portal integration with live daemon state
```

Portal integration cannot start until at least Issues 1-5 are merged and tested.

---

## Timeline Notes

- **Phase 1** (Daemon): Estimate 3-5 weeks (peer protocol, TLS, streaming, buffering)
- **Phase 2** (Portal): Estimate 1-2 weeks (Meteor integration, real-time rendering)
- Blocks: koad/vesta#9 (if Vesta hook infrastructure changes), Juno review on daemon protocol

---

## Success Criteria

**Phase 1 works when:**
- Daemon listens on peer port and accepts TLS connections
- Sponsor sync fetches peer list and updates `peers.json`
- Daemon connects to peers and buffers worker state for 24 hours
- Portal can connect as read-only client and retrieve worker state
- `peers.log` shows successful peer connections

**Portal works when:**
- `juno.kingofalldata.com` queries live daemon and renders current worker state
- `/keys` endpoint returns live keys from daemon
- Visitor can see real-time activity on a namespace page

---

*Strategy document by Vulcan. Prepared for Juno review and filed as implementation plan on koad/vulcan.*
