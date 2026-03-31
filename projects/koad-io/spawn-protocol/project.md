---
id: koad-io-spawn-protocol
title: "Spawn Protocol"
type: task
project: project-koad-io
status: backlog
priority: 7
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - koad-io
  - specification
  - spawn
  - runtime
  - process
description: "Define the spawn protocol — how an entity launches another entity as a sovereign, independent process with its own environment and session."
complexity: medium
depends_on:
  - koad-io/entity-model
  - koad-io/cascade-environment
  - koad-io/commands-system
blocks:
  - koad-io/daemon
---

# Spawn Protocol

How one entity brings another to life as an independent process. The spawn is the moment an entity transitions from a directory on disk to an active, operating session.

## What to Define

- The spawn command contract
- How the spawned entity's environment is isolated
- How an optional prompt/task is passed to the spawned session
- Integration hooks (OBS, terminal emulators, etc. — reference only)
- What the spawned entity receives at startup

## Spawn Command Contract

```bash
<parent-entity> spawn process <target-entity> ["optional prompt"]
```

The spawning entity:
1. Loads the target entity's `.env` (isolated environment)
2. Opens the target entity's directory as the working context
3. Launches the target entity's AI session (reference: Claude Code via `claude .`)
4. Optionally passes a startup prompt

## Environment Isolation

Each spawned entity operates with its own environment:
- `ENTITY` set to the target entity name
- Full cascade from target's `.env`
- Working directory: `~/.<target-entity>/`
- Git identity: target entity's `GIT_AUTHOR_NAME` / `GIT_AUTHOR_EMAIL`

The spawning entity's environment does not bleed into the spawned session.

## Startup Prompt

An optional string may be passed as a task for the spawned entity to begin working on immediately. This allows delegation:

```bash
juno spawn process vulcan "build the entity-freelancer skeleton"
```

## Reference Implementation

`~/.juno/commands/spawn/process/command.sh` — the current implementation:
1. Hits OBS WebSocket API to switch scene and start streaming
2. Opens `gnome-terminal` with:
   ```bash
   cd ~/.<target>/ && claude .
   ```
3. Stops stream when the process exits

The OBS and gnome-terminal integrations are reference-specific. The protocol itself is the environment isolation + directory context + optional prompt.

## Port Guidance

A compliant spawn implementation must:
1. Set the target entity's environment before launching
2. Set working directory to `~/.<target-entity>/`
3. Launch the AI session in that context
4. Pass the optional prompt if provided
5. Maintain environment isolation

The terminal emulator and streaming integration are optional enhancements.

## Deliverables

- [ ] Written specification (`spec.md`)
- [ ] Spawn sequence diagram
- [ ] Environment isolation requirements
- [ ] Port guidance (different terminals, different AI runtimes)
- [ ] Reference to current `spawn process` command implementation
