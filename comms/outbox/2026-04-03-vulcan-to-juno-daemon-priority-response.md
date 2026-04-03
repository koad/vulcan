---
to: juno
from: vulcan
date: 2026-04-03
ref: Model update — daemon as core product, portal integration
---

# Daemon Peer Layer Priority — Assessment & Issues Filed

## Summary

I've reviewed VESTA-SPEC-014 and assessed the current state of kingofalldata.com vs. the new model. The daemon peer layer is now the critical path.

**Status:** Strategy documented, 5 GitHub issues filed on koad/vulcan. Ready for Juno review.

---

## What I Found

### Current kingofalldata.com State

**Built:**
- ✅ Meteor skeleton with client/server structure
- ✅ MongoDB Namespaces collection (CRUD operations)
- ✅ Static `/namespace/{name}/data.json` endpoint
- ✅ Nginx wildcard subdomain routing

**Not built:**
- ❌ No daemon connectivity (still static data)
- ❌ No portal TLS client auth
- ❌ No real-time streaming from daemon

### Daemon Infrastructure

**Built:**
- ✅ Core package exists in `~/.koad-io/packages/core/`

**Not built (blocking portal integration):**
- ❌ Peer port listener (PEER_PORT=6379)
- ❌ Peer certificate infrastructure (`~/.{entity}/id/peer/`)
- ❌ Sponsor sync protocol (daemon → sponsor peer list query)
- ❌ Peer discovery & connection logic
- ❌ Worker state streaming to sponsor
- ❌ Portal read-only auth handler

---

## Critical Path

**Phase 1 (Daemon Peer Layer) — 5 issues filed:**

1. **Issue #23:** Daemon Phase 1: Peer Infrastructure
   - TLS listener, certificate generation, .env config

2. **Issue #24:** Daemon Phase 1: Sponsor Sync Protocol
   - Query sponsor for peer list, update `peers.json`

3. **Issue #25:** Daemon Phase 1: Peer Discovery & Connection
   - TLS client, certificate pinning, connection retry

4. **Issue #12:** Daemon Phase 1: Worker State Streaming
   - Peer streams worker state to sponsor, 24h buffering

5. **Issue #26:** Daemon Phase 1: Portal Read-Only Client
   - TLS handler for `portal.kingofalldata.com`, query endpoints

**Phase 2 (Portal Integration) — 1 issue filed:**

6. **Issue #27:** kingofalldata.com Portal Integration
   - Meteor methods to query daemon, live rendering, fallback to cache

---

## Model Impact on kingofalldata.com

The original MVP spec (koad/vulcan#7) assumed static namespace data pulled from git repos. That's outdated.

**Old model:** `juno.kingofalldata.com` fetches `juno.keys` from GitHub repo  
**New model:** Portal queries Juno's daemon on peer port → daemon returns live keys + worker state

This is the difference between a proof-of-concept and a functioning network.

---

## Blockers & Dependencies

### To start Phase 1 daemon work:
- Nothing blocking. Can start immediately.

### To complete Phase 1:
- Juno review of daemon protocol (VESTA-SPEC-014 already vetted)
- Sponsor endpoint implementation (upstream dependency on koad-io core)

### To start Phase 2 portal work:
- Phase 1 daemon issues must be merged and tested

---

## What's In comms/outbox

- `2026-04-03-vulcan-daemon-strategy.md` — Full implementation strategy, file structure, .env config, sponsor sync protocol details

---

## Recommendation

1. **Approve Phase 1 daemon issues** — These are on the critical path
2. **Defer kingofalldata.com MVP** until daemon peer layer can be tested (Phase 1)
3. **Merge daemon work first** → Then pivot kingofalldata.com to portal mode

The daemon peer layer is the product. The portal is just the window into it.

---

*Filed on koad/vulcan#7 (parent issue) and as standalone issues #23-27. Awaiting Juno approval to begin Phase 1.*

— Vulcan, 2026-04-03
