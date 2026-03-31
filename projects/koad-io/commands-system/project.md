---
id: koad-io-commands-system
title: "Commands System"
type: task
project: project-koad-io
status: backlog
priority: 3
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - koad-io
  - specification
  - commands
  - cli
  - extensibility
description: "Define the commands system — how commands are discovered, resolved, and executed. The mechanism that makes koad:io extensible without a plugin registry."
complexity: medium
depends_on:
  - koad-io/entity-model
  - koad-io/cascade-environment
blocks:
  - koad-io/gestation-protocol
---

# Commands System

The extensibility mechanism. Commands are files on disk. Discovery is a search path. No registry, no plugin manager — just directories and executables.

## What to Define

- The command file contract (what a command file must be)
- The discovery/resolution order
- How arguments are passed
- How the environment is provided to commands
- Namespacing (nested commands via directory structure)

## Command File Contract

A command is an executable file named `command.sh` (reference implementation) or any executable, located at:

```
<search-path>/<verb>/command.sh
<search-path>/<verb>/<subverb>/command.sh   ← nested commands
```

The file receives:
- All arguments passed after the verb (as `$1`, `$2`, etc.)
- The full cascade-resolved environment
- `$ENTITY` set to the active entity name

## Discovery Order

```
1. ~/.<entity>/commands/         ← entity-specific (highest priority)
2. ./commands/                   ← working directory
3. ~/.koad-io/commands/          ← framework globals (lowest priority)
```

First match wins. This allows entities to override framework commands.

## Nested Commands (Namespacing)

Commands nest via directory structure:

```
commands/
  commit/
    command.sh          ← handles: <entity> commit
    self/
      command.sh        ← handles: <entity> commit self
```

This is how `juno commit self` and `vulcan commit self` work — each entity has its own `commands/commit/self/command.sh` with entity-specific logic.

## Invocation

```bash
<entity> <verb> [args...]
# resolves to: <search-path>/<verb>/command.sh [args...]
# with full env cascade applied
```

## Port Guidance

A compliant implementation must:
1. Implement the three-level search path in order
2. Support nested command namespacing via directory depth
3. Pass arguments and environment to the command file
4. Any executable is valid — not just bash scripts

## Deliverables

- [ ] Written specification (`spec.md`)
- [ ] Discovery algorithm pseudocode
- [ ] Example command implementations (reference)
- [ ] Port guidance for non-bash implementations
