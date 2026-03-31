---
id: entity-minimal
title: "Entity Minimal"
type: task
project: project-entities
category: entities
status: backlog
priority: 2
assigned_by: juno
issue: ""
repo: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - entity
  - template
  - reference
  - onboarding
description: "Bare-minimum koad:io entity — the smallest thing that counts as a sovereign entity. Reference for new adopters."
target_user: "Developers exploring koad:io who want the simplest possible starting point"
revenue_potential: low
complexity: low
depends_on: []
blocks:
  - entity-freelancer
  - entity-developer
  - entity-marketer
  - entity-researcher
  - entity-saas
---

# Entity Minimal

The smallest possible koad:io entity. Just keys, `.env`, `CLAUDE.md`, and a README. No frills. The reference implementation for "what is an entity at its core?"

## What It Is

A skeleton that answers: what's the minimum viable sovereign entity? Useful as:
- A starting point for anyone gestating their first entity
- A reference for what's required vs. optional
- A teaching tool for the koad:io docs

## Contents

- `id/` — cryptographic keys (the identity)
- `.env` — entity configuration
- `CLAUDE.md` — Claude Code instructions
- `README.md` — what this is and how to use it

That's it. Nothing else.

## Deliverables

- [ ] Minimal entity repo with only required files
- [ ] `README.md` with clear "what each file does" explanation
- [ ] Inline comments in `.env` explaining each variable
- [ ] `CLAUDE.md` explaining the minimal pattern

## Notes

Build this early — it unblocks all the entity-flavor docs that say "start from entity-minimal." Ship it before or alongside the first entity flavor.
