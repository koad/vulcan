---
id: koad-io-cascade-environment
title: "Cascade Environment"
type: task
project: project-koad-io
status: backlog
priority: 2
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - koad-io
  - specification
  - environment
  - dotenv
  - configuration
description: "Define the .env cascade — which environment files load, in what order, and how later values override earlier ones. The mechanism by which context flows from framework to entity to session."
complexity: low
depends_on:
  - koad-io/entity-model
blocks:
  - koad-io/commands-system
---

# Cascade Environment

The mechanism by which koad:io resolves configuration. Multiple `.env` files load in order — each layer can add or override values from the previous.

## What to Define

- Which `.env` files are loaded
- In what order
- Override semantics (later wins, or earlier wins?)
- Which variables are reserved/required at each layer
- How the active entity is determined

## Current Load Order (Reference Implementation)

```
1. ~/.koad-io/.env          ← framework defaults (PRIMARY_ENTITY, bind IP, package dirs)
2. ~/.<entity>/.env         ← entity identity (ENTITY, ENTITY_DIR, GIT config)
3. ./.env                   ← working directory overrides (project-specific)
```

Each layer absorbs the previous. Later values override earlier ones. The current bash implementation logs this as "absorbing /path/to/.env".

## Reserved Variables

| Variable | Layer | Description |
|----------|-------|-------------|
| `PRIMARY_ENTITY` | framework | default entity when none specified |
| `KOAD_IO_BIND_IP` | framework | network bind address |
| `METEOR_PACKAGE_DIRS` | framework | package search paths |
| `ENTITY` | entity | entity name |
| `ENTITY_DIR` | entity | absolute path to entity directory |
| `ENTITY_HOME` | entity | entity's home directory |
| `GIT_AUTHOR_NAME` | entity | git commit author |
| `GIT_AUTHOR_EMAIL` | entity | git commit email |

## Port Guidance

A compliant implementation must:
1. Load `.env` files in the specified order before any command runs
2. Apply override semantics consistently
3. Expose the resolved environment to commands
4. Support the reserved variable names

The format is standard dotenv (KEY=VALUE, # comments, quoted strings).

## Deliverables

- [ ] Written specification (`spec.md`)
- [ ] Annotated load order diagram
- [ ] Variable reference table (required, optional, reserved)
- [ ] Port guidance section
