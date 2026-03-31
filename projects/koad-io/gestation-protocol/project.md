---
id: koad-io-gestation-protocol
title: "Gestation Protocol"
type: task
project: project-koad-io
status: backlog
priority: 4
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - koad-io
  - specification
  - gestation
  - entity-creation
  - cryptography
description: "Define the gestation protocol — the canonical sequence for creating a new entity, including directory structure, key generation, and the KOAD_IO_VERSION manifest."
complexity: medium
depends_on:
  - koad-io/entity-model
  - koad-io/identity
  - koad-io/commands-system
blocks: []
---

# Gestation Protocol

The birth sequence. A compliant gestation produces a complete, usable entity directory with cryptographic identity, ready for operation.

## What to Define

- The required steps in order
- What must be generated (keys, certs, files)
- The `KOAD_IO_VERSION` manifest format
- The "mother" inheritance mechanism
- What the resulting entity must be able to do immediately after gestation

## Gestation Sequence

```
1. Validate: entity name is valid, directory does not exist
2. Create directory structure (per Entity Model spec)
3. Write KOAD_IO_VERSION manifest
4. Write minimum .env
5. Create wrapper command in ~/.koad-io/bin/<entity>
6. Generate cryptographic keys (per Identity spec):
   - Ed25519 SSH keypair
   - ECDSA SSH keypair (521-bit)
   - RSA SSH keypair (4096-bit)
   - DSA SSH keypair
7. Generate SSL artifacts:
   - Master elliptic curve parameters (prime256v1)
   - Master elliptic curve key
   - Device elliptic curve key
   - Relay elliptic curve key
   - Session key
8. (Optional --full) Generate DH parameters (2048 and 4096 bit)
9. If mother entity specified: inherit genes (commands, packages, skeletons, etc.)
10. If mother entity specified: copy mother's public keys into id/<mother>.*
```

## KOAD_IO_VERSION Manifest

```
GESTATED_BY=<mother or 'mary' for immaculate conception>
GESTATE_VERSION=<git short hash of koad-io at gestation time>
BIRTHDAY=<YY:MM:DD:HH:MM:SS>
NAME=<entity name>
```

## Mother Inheritance

If gestated from an existing entity (`<mother> gestate <child>`), the child inherits:
- `commands/` — mother's command library
- `packages/` — mother's packages
- `skeletons/` — mother's skeleton templates
- `recipes/` — mother's recipes
- `assets/` — mother's assets
- `cheats/` — mother's cheat sheets
- `hooks/` — mother's hooks
- `docs/` — mother's documentation
- Mother's public keys → `id/<mother>.<keytype>.pub`

## Port Guidance

A compliant gestation must:
1. Produce the required directory structure
2. Generate compatible key formats (OpenSSH-compatible)
3. Write a valid `KOAD_IO_VERSION` manifest
4. Write a minimum `.env` with required variables
5. Make the entity immediately usable (can run commands)

The cryptographic choices (Ed25519, ECDSA, RSA, DSA) are the reference — a port may use equivalent formats as long as keys are interoperable.

## Deliverables

- [ ] Written specification (`spec.md`)
- [ ] Sequence diagram of gestation steps
- [ ] KOAD_IO_VERSION format reference
- [ ] Mother inheritance rules
- [ ] Port guidance
