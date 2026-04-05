# PRIMER: Vulcan

Vulcan is the product builder for the koad:io entity ecosystem. He picks up GitHub Issues filed by Juno, builds the specified product, commits the result, and comments on the issue. Where Juno orchestrates the business, Vulcan executes the builds — entity flavors, PWAs, tools, and infrastructure. Named for the Roman god of the forge.

---

## Current State

**Gestated and on GitHub.** Active build work running.

### What's Complete
- Alice Phase 2A: live on kingofalldata.com (commit 7d95c39)
- Hook bug fixed: FORCE_LOCAL=1 (2026-04-05)
- koad:io framework migration: Claude Code (from opencode)
- Entity flavors: examples scaffolded in `projects/examples/`
- Wonderland migration: pending koad pairing (uncommitted desktop/passenger/daemon work)

### Active Assignments (via GitHub Issues)

| Issue | Work | Status |
|-------|------|--------|
| koad/vulcan#2 | Gestate team entities: veritas, mercury, muse, sibyl, argus, salus, janus, aegis | Assigned |
| koad/vulcan#3 | Stream PWA — live activity wall across all entities | Assigned |

### Projects Structure (`projects/`)

| Directory | Content |
|-----------|---------|
| `entities/` | Entity flavors being built |
| `examples/` | Reference implementation repos |
| `koad-io/` | Framework contributions |
| `packages/` | Distributable packages |
| `tools/` | Internal tooling |

---

## Active Work

- Alice Phase 2B planning (next curriculum levels)
- Stream PWA (koad/vulcan#3) — design from Muse, build not started
- Entity gestation batch (koad/vulcan#2)

---

## Blocked

- **Wonderland migration** — only when paired with koad directly
- **fourty4 API auth** — koad/juno#44 blocks remote autonomous execution

---

## Key Files

| File | Purpose |
|------|---------|
| `README.md` | Entity overview and role |
| `CLAUDE.md` | Full identity, scope, what Vulcan builds |
| `GOVERNANCE.md` | Trust chain and authorization scope |
| `PRODUCTS.md` | Shipped and planned product list |
| `projects/` | Active build work organized by type |
| `kingofalldata.com/` | Local clone of the site repo |
| `memories/001-identity.md` | Core identity context |
