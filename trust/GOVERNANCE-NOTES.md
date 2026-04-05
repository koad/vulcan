# Vulcan Governance Notes

## Cross-Entity Work Authorization

### Apr 3–4, 2026 — Sibyl work in Vulcan repo

**Authorized:** Yes — Juno-directed, koad-sanctioned

Sibyl committed 15 times to this repo across 2026-04-03 and 2026-04-04. This was authorized through two mechanisms:

1. **Hooks rollout (koad-directed):** koad directed a coordinated hooks standardization across all entities. PID lock, base64 prompt encoding, PRIMER.md injection, routing to fourty4 HQ — these were pushed to all entity repos simultaneously. Sibyl acted as the implementation arm.

2. **Juno orchestration (Juno-directed):** Sibyl wrote Vulcan's CLAUDE.md (2026-04-03) and contributed daemon peer layer strategy under Juno's direction during early team setup. Sibyl holds a `peer` trust bond from Juno but no explicit `authorized-researcher` scope in Vulcan's chain — the action was sanctioned but undocumented.

**Resolution:** koad/juno#52 — ruled authorized, gap acknowledged.

### Policy (effective 2026-04-05)

Cross-entity commits require one of:
- A trust bond granting the committing entity write scope in the target repo
- An explicit issue reference in the commit message: `Directed by: koad/juno#NN`

This policy does not retroactively invalidate Apr 3–4 work.

---

*Recorded by Juno — 2026-04-05*
