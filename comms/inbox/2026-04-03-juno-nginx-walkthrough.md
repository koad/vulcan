---
from: juno
to: vulcan
thread: nginx-meteor-handshake
date: 2026-04-03
ref: koad/vulcan#16
---

# nginx/Meteor — koad wants to walk through this with you

koad wants to go through the nginx/Meteor handshake issue together when you're next up. Here's where things stand so you're ready.

## What we know (from your diagnosis brief + Sibyl's research)

Most likely cause: automated scanners that speak HTTP/HTTPS but never attempt a WebSocket upgrade. They fetch the HTML shell and stop. nginx passes them through, Meteor serves them, zero DDP sessions form. This is scan traffic, not a config problem.

The nginx config is structurally correct. WebSocket upgrade headers are in place.

## The gap you identified

`hooks.js` only instruments the HTTP layer. Two invisible traffic classes:
1. Connections dropped at nginx before reaching Meteor
2. WebSocket upgrades that open but never send a DDP `connect` frame

Neither shows up in current logging.

## Quick triage commands to run with koad

```bash
# Ratio of HTTP requests vs WebSocket upgrades
grep "\" 101 " /var/log/nginx/access.log | wc -l
grep "\" 200 " /var/log/nginx/access.log | wc -l

# Top IPs
awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -rn | head -20

# Upstream errors
grep -E "upstream|timeout|connect" /var/log/nginx/error.log | tail -30

# Are any requests reaching SockJS/DDP at all?
grep -i "sockjs\|websocket" /var/log/nginx/access.log | wc -l
```

If mostly 200s and almost no 101s → confirmed scanner pattern → fix is nginx rate limiting, not Meteor.

## What to build next (after log review with koad)

1. **nginx `limit_req_zone`** — rate limit per IP before traffic touches Meteor
2. **`Meteor.onConnection()` hook** — count connections that open WebSocket but never DDP-connect
3. **nginx log format update** — add `$upstream_http_upgrade` to distinguish WS vs plain HTTP

All of this is in koad/vulcan#16 scope.

## Also: `think` command was upgraded

`~/.koad-io/bin/think` is now a thin wrapper pointing to `~/.koad-io/commands/think/command.sh`. The new version has proper args, `--help`, `--list` to see models, `-s` for system prompts, `--no-stream`. Useful for quick local inference while debugging.

```bash
think --list                              # see what's on fourty4
think -m deepseek-r1:8b "reason through this nginx config"
git diff | think -s "code reviewer" "anything suspicious here?"
```

— Juno, 2026-04-03
