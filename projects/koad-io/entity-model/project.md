---
id: koad-io-entity-model
title: "Entity Model"
type: task
project: project-koad-io
status: backlog
priority: 1
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - koad-io
  - specification
  - entity
  - directory-structure
description: "Define what an entity IS — the canonical directory structure, required files, optional files, and the .env schema that every compliant entity must satisfy"
complexity: low
blocks:
  - koad-io/gestation-protocol
  - koad-io/commands-system
  - koad-io/identity
---

# Entity Model

The foundational spec. Everything else builds on this.

## What to Define

An entity is a directory. The spec must answer:
- What directories must exist
- What files are required vs optional
- What naming conventions apply
- What the minimum viable entity looks like

## Required Directory Structure

```
~/.<entity>/
  id/                   ← cryptographic identity keys
  ssl/                  ← SSL/TLS certificates and parameters
  bin/                  ← entity-local executables
  commands/             ← entity commands (see Commands System spec)
  home/                 ← entity's home directory (like /home/<entity>/)
  var/                  ← runtime state, logs
  etc/                  ← configuration files
  lib/                  ← libraries and shared code
  archive/              ← historical data
  .env                  ← entity configuration (see Cascade Environment spec)
  KOAD_IO_VERSION       ← gestation metadata
```

## Required .env Fields

```env
ENTITY=<name>
ENTITY_DIR=/home/<user>/.<entity>
ENTITY_HOME=/home/<user>/.<entity>/home/<entity>
GIT_AUTHOR_NAME=<EntityName>
GIT_AUTHOR_EMAIL=<entity>@<domain>
```

## Optional but Conventional

```
  memories/             ← persistent context for AI sessions
  trust/bonds/          ← authorization agreements
  projects/             ← work tracking (this system)
  commands/             ← entity-specific commands
  CLAUDE.md             ← AI session instructions
  README.md             ← public identity
```

## Naming Conventions

- Entity name: lowercase, no spaces, no hyphens (e.g. `vulcan`, `juno`, `alice`)
- Directory: `~/.<entityname>/` — always dotfile in user home
- Wrapper command: `~/.koad-io/bin/<entityname>` — delegates to `koad-io`

## Reference Implementation

The current bash gestation script at `~/.koad-io/commands/gestate/command.sh` is the canonical example of entity creation. It defines what directories get made and what files get written.

## Deliverables

- [ ] Written specification document (`spec.md` in this folder)
- [ ] Annotated directory tree showing required vs optional vs conventional
- [ ] Minimum viable entity example (see `projects/entities/minimal/`)
- [ ] Port guidance: what a reimplementer must produce
