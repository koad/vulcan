---
id: koad-io-package-system
title: "Package System"
type: task
project: project-koad-io
status: backlog
priority: 6
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - koad-io
  - specification
  - packages
  - extensibility
  - meteor
description: "Define the package system — what a koad:io package is, what it must export, and how it is installed and discovered. The Meteor packages are one implementation of this concept."
complexity: high
depends_on:
  - koad-io/entity-model
  - koad-io/cascade-environment
blocks: []
---

# Package System

The koad:io package system defines how reusable functionality is bundled, distributed, and consumed. The current reference implementation uses Meteor packages — but the concept is portable to any package manager or language ecosystem.

## What to Define

- What a koad:io package IS (the abstract concept)
- What a package must export (the contract)
- How packages are discovered (the search path)
- How packages are installed
- The relationship between packages and entities

## The Abstract Package Concept

A koad:io package is a named, versioned bundle of functionality that extends an entity's capabilities. It may provide:
- Commands (executable files following the Commands System spec)
- Templates / skeletons (base files for gestation)
- UI components (in the reference: Meteor Blaze templates)
- Data models (in the reference: Meteor collections)
- Configuration defaults

The key insight: **the Meteor package system is one implementation of this contract.** The same concept could be implemented as:
- npm packages (Node.js)
- pip packages (Python)
- Go modules
- Plain directories with a `package.toml` manifest

## Package Manifest

Every package must have a manifest that declares:
```
name: <package-name>
version: <semver>
description: <what it does>
author: <entity or human>
provides:
  - commands
  - templates
  - ui
  - models
depends: []
```

Reference implementation: `package.js` (Meteor format).

## Search Path

Packages are discovered via `METEOR_PACKAGE_DIRS` in the reference implementation. The abstract equivalent is a `KOAD_IO_PACKAGE_DIRS` variable listing directories to search.

```
KOAD_IO_PACKAGE_DIRS=~/.koad-io/packages:~/.<entity>/packages
```

## Installation

```bash
<entity> install <package-name>
```

Reference implementation: `~/.koad-io/commands/install/command.sh`

## Port Guidance

A compliant package system must:
1. Support the package manifest format
2. Implement the search path mechanism
3. Provide an `install` command
4. Allow packages to contribute to command discovery

The Meteor package format is the reference. A port should define its own manifest format that maps to the same concepts.

## Deliverables

- [ ] Written specification (`spec.md`)
- [ ] Abstract package concept document
- [ ] Package manifest format reference
- [ ] Comparison: Meteor implementation vs abstract spec
- [ ] Port guidance for npm, pip, Go modules
- [ ] Example minimal package
