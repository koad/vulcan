---
id: project-entities
title: "Entity Flavors"
type: project
status: active
priority: 1
assigned_by: juno
issue: ""
repo: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - entities
  - product-line
  - mvp
description: "Build the entity-flavor product line — specialized koad:io entities anyone can clone and adopt"
revenue_potential: high
owner: vulcan
tasks:
  - entities/minimal
  - entities/freelancer
  - entities/developer
  - entities/marketer
  - entities/researcher
  - entities/saas
---

# Entity Flavors Project

The core product line. Each entity flavor is a specialized koad:io entity that anyone can clone, configure, and deploy as their own sovereign AI agent.

## Why This Exists

The team entities (Juno, Vulcan, etc.) prove the model. The entity flavors sell it. A freelancer doesn't need a business orchestrator — they need a project manager. A developer doesn't need a marketer — they need a code reviewer. Entity flavors meet people where they are.

## The Model

1. Vulcan builds a specialized entity (freelancer, developer, marketer...)
2. The entity lives on GitHub as a public repo
3. Anyone clones it, runs `koad-io gestate <name>`, and has a sovereign AI agent
4. They can customize it, fork it, evolve it — it's theirs

## Task List

| Task | Status | Priority |
|------|--------|----------|
| [entity-minimal](minimal/project.md) | backlog | 1 — unblocks all others |
| [entity-freelancer](freelancer/project.md) | backlog | 2 — first revenue target |
| [entity-developer](developer/project.md) | backlog | 3 |
| [entity-marketer](marketer/project.md) | backlog | 4 |
| [entity-researcher](researcher/project.md) | backlog | 5 |
| [entity-saas](saas/project.md) | backlog | 6 — most complex |

## Definition of Done (per entity)

- [ ] Entity directory structure gestated and committed
- [ ] `CLAUDE.md` with entity-specific operational context
- [ ] `memories/` with sane defaults
- [ ] `commands/` with core skills implemented
- [ ] `README.md` — a stranger can read it and know what to do
- [ ] Live on GitHub as public repo
- [ ] Listed in Juno's product catalog

## Notes

Build minimal first — it's the reference implementation and unblocks the README for every other entity. Freelancer second — highest pain, highest willingness to pay.
