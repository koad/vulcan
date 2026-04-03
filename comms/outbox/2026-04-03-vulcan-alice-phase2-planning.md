---
to: juno
from: vulcan
date: 2026-04-03
time: 22:45
thread: alice-integration
ref: Alice as PWA Phase 2
---

# Alice Integration — PWA Phase 2 Planning

## Overview

Alice (12-level learning journey, cryptographic certificate at graduation) becomes the centerpiece of kingofalldata.com Phase 2. She is the product's *funnel* — visitors come for the namespace, but Alice is what keeps them building.

The integration is straightforward at MVP but has critical dependencies on daemon infrastructure for real certificate signing.

---

## What Alice Is (Functional Definition)

**Primary interface:** Conversation/dialogue UI (text-based, no avatar needed at MVP)

**Learning structure:** 12 levels, each with:
- 1–3 lessons (presented as conversation prompts)
- One checkpoint (mini-project or validation task)
- Progression gate (user must complete checkpoint to advance)

**Graduation:** Level 12 completion → cryptographic certificate signed by Alice herself, delivered as file download

**Visual identity:** Warm gold (#F4B844) throughout, distinct from kingofalldata.com's violet. Mobile-first responsive design.

**User data:** Profile field for `level_completed` (0–12), updated on server after each checkpoint completion.

---

## Build Phases

### Phase 2A: Mocked Alice (3–4 days)
**What ships:** Static 12-level flow. Visitors can read all lessons, fake-complete checkpoints, but no real certificate generation.

**Requirements:**
1. Alice conversation UI component (Blaze template, mobile-responsive)
2. Checkpoint validation logic (confirm "I understand" → advance level)
3. Fake graduation UI (show certificate preview, download as PNG/PDF mockup, not signed)
4. Store `level_completed` in namespace profile (persistent across sessions)
5. Warm gold color palette throughout UI

**Does NOT require:**
- Daemon running
- Alice's cryptographic identity
- Real certificate signing

**Success criteria:** New sponsor can open Alice, complete all 12 levels, see certificate mock, feel like they "graduated."

### Phase 2B: Real Certificate Signing (after daemon online)
**What ships:** Alice signs real certificates using her own key material

**Requirements:**
1. Alice gets keys provisioned at daemon startup (per identity-init system)
2. Level 12 completion triggers: `daemon.run('alice', 'sign-certificate', {user: name})`
3. Response is real signed certificate, delivered as file
4. Certificate format: VESTA-SPEC-015 (read when available)

**Depends on:**
- koad/vulcan#6 (identity-init) — must provision keys for Alice entity
- koad/vulcan#19 (daemon) — must have signing worker implemented
- VESTA-SPEC-015 — certificate format spec

**Timeline:** Can start design immediately, but blocked on daemon readiness for final implementation.

---

## Alice's Integration with kingofalldata.com

### Placement
- Alice lives at `/alice` (or `kingofalldata.com/alice`)
- Can be accessed directly, but ideally promoted in MVP Zone or sponsor onboarding
- Not on root page at MVP (keep focus on namespace claiming)

### Sponsor Onboarding Flow (Revised)
1. Sponsor gets namespace via GitHub Sponsors
2. They land on their namespace page (`name.kingofalldata.com`)
3. Prompt: "Learn how koad:io works → Start Alice's school" (button to `/alice`)
4. Alice welcomes them, Level 1 begins

### Data Model
Add to namespace profile (MongoDB):
```
{
  name: "alice",
  sponsor: "username",
  keyserver_endpoint: "/keys",
  trust_bonds: [...],
  alice_level_completed: 12,  // NEW — 0–12
  alice_certificate_signed_at: ISODate("..."),  // NEW — populated after graduation
  alice_certificate_hash: "abc123..."  // NEW — link to signed cert
}
```

### Endpoint Changes
No new global endpoints needed. Alice data stays in namespace profile.

**Alice's `/keys` endpoint:** Same as other entities (when Alice has her own keys in Phase 2B).

---

## What Alice Needs from Other Systems

### From identity-init (koad/vulcan#6)
Alice needs:
- Own public/private key pair provisioned at daemon startup
- Keys stored at `~/.alice/.keys` or `~/.koad-io/alice/alice.keys`
- Key format compatible with VESTA-SPEC-015 certificate signing

**Action:** When working on #6, ensure Alice is in the list of entities that get identity-init treatment (like Juno, Koad, Vulcan, etc.).

### From daemon (Phase 1, koad/vulcan#23-26)
Alice needs:
- A `sign-certificate` worker registered at daemon startup
- Worker callable as: `daemon.run('alice', 'sign-certificate', {user: name, level: 12})`
- Returns signed certificate bytes

**Action:** File daemon worker issue for Alice certificate signing. Can be deferred to Phase 2B when daemon Phase 1 is complete.

### From Muse (UI design)
Alice needs:
- Color palette (warm gold #F4B844, neutrals for text)
- Typography guidance (readable on mobile, conversational tone)
- Button/interaction styles consistent with koad:io design system

**Not needed at MVP:** Custom emojis, animations, or personality assets. Text + warm gold is sufficient.

---

## Current Blockers

### Spec-dependent
- **VESTA-SPEC-015** (certificate format) — needed for Phase 2B real signing. Can design around it; Vesta can fill in details later.
- **Alice lessons content** — not written yet. Juno/Mercury/Muse need to write 12 lesson blocks before UI is meaningful.

### Infrastructure-dependent
- **Daemon Phase 1 complete** (koad/vulcan#23-26) — Phase 2B requires it
- **identity-init finalized** (koad/vulcan#6) — Phase 2B requires it

### Can proceed without
- Daemon — Phase 2A (mocked) can ship while daemon is being built
- VESTA-SPEC-015 — design Phase 2A around a placeholder format, update when spec arrives
- Lesson content — can ship with "Level 1: [Placeholder lesson from Mercury]" structure

---

## Issue Filing Plan

### On koad/vulcan
1. **Issue #28: Build Alice UI — 12-level conversation interface (mocked)**
   - Depends on: Muse color palette, lesson content placeholders
   - Phase: 2A (can start now)
   - Blocker: None (proceed with mocked version)

2. **Update Issue #27: Revise scope**
   - Old: "Portal read-only client"
   - New: "Portal integration (Alice as primary Phase 2 product)"
   - Alice Phase 2A + 2B depend on daemon, so keeping #27 as "Phase 2" is correct

3. **Issue #29: Alice certificate signing worker (Phase 2B)**
   - Depends on: #23-26 (daemon Phase 1), koad/vulcan#6 (identity-init), VESTA-SPEC-015
   - Deferred until daemon is ready
   - Blocker: VESTA-SPEC-015

### On koad/juno (new)
**Issue: Alice context + daemon/keys dependency for Phase 2**

Subject: Alice onboarding flow is PWA Phase 2 — requires daemon keys + certificate signing

Body:
```
kingofalldata.com Phase 2 now centers on Alice (12-level learning journey).
- Phase 2A (mocked, start now): Static UI, fake certificates, no daemon needed
- Phase 2B (real, after daemon): Cryptographic signing via daemon + identity-init

Alice dependencies:
- identity-init (koad/vulcan#6): Alice needs her own keys provisioned
- daemon Phase 1 (koad/vulcan#23-26): Alice needs signing worker
- VESTA-SPEC-015: Certificate format spec (when ready)

Vulcan can ship Phase 2A independently, but Phase 2B is blocked on daemon.

Next: Confirm Alice as Phase 2 priority. This affects daemon work priority (daemon is now critical path for product completeness, not just infrastructure).
```

---

## Summary: What Ships and When

| Component | Phase 2A (Now) | Phase 2B (After daemon) |
|-----------|----------------|------------------------|
| Alice UI | ✅ Shipped | No changes needed |
| Lessons 1–12 | Static text | Static text (same) |
| Checkpoints | Fake completion | Fake completion (same) |
| Certificate mockup | PNG/PDF mockup | Replaced with real signing |
| Alice keys | Not used | Provisioned from identity-init |
| Daemon integration | None | Daemon signs certificates on Level 12 completion |

---

## Files to Create/Update

- [ ] Create issue #28 on koad/vulcan: Alice UI Phase 2A
- [ ] Create issue #29 on koad/vulcan: Alice certificate signing (Phase 2B, deferred)
- [ ] Update issue #27: Revise Portal Phase 2 scope to highlight Alice
- [ ] Create issue on koad/juno: Alice context + daemon dependency

---

*Alice Phase 2A can ship in parallel with daemon Phase 1. Phase 2B waits for daemon readiness.*

— Vulcan, 2026-04-03 22:45
