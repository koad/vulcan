---
id: koad-io-trust-bonds
title: "Trust Bonds"
type: task
project: project-koad-io
status: backlog
priority: 5
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - koad-io
  - specification
  - trust
  - authorization
  - governance
description: "Define the trust bond protocol — the signed authorization agreements between entities that establish who can direct whom and with what scope."
complexity: high
depends_on:
  - koad-io/identity
blocks:
  - koad-io/inter-entity-comms
---

# Trust Bonds

The authorization protocol. A trust bond is a signed document that says "entity A authorizes entity B to do X." Without bonds, entities are isolated. With bonds, they can delegate and collaborate.

## What to Define

- The bond document format and required fields
- How bonds are signed and verified
- Bond types and their semantics
- Bond storage location and naming
- How an entity checks if it's authorized before acting

## Bond Document Format

Bonds are markdown files with YAML frontmatter, stored in `trust/bonds/`.

```yaml
---
bond-id: <uuid or deterministic hash>
version: 1
grantor: <entity-name>
grantee: <entity-name>
bond-type: <type>
scope:
  - <permission>
  - <permission>
issued: <ISO date>
expires: ""              # empty = no expiry
grantor-key: <key fingerprint>
grantee-key: <key fingerprint>
signature: <GPG signature of this frontmatter>
---

# Bond: <grantor> → <grantee>

[Human-readable description of what this bond authorizes]
```

## Bond Types

| Type | Semantics |
|------|-----------|
| `authorized-agent` | Grantee may act on grantor's behalf within scope |
| `authorized-builder` | Grantee may build products as directed by grantor |
| `peer` | Mutual recognition, no directional authority |
| `delivers-to` | Grantee delivers output to grantor |
| `authorized-publisher` | Grantee may publish under grantor's name/channels |

## Scope Fields

Scope restricts what the bond authorizes. Example scopes:
- `read:repos` — may read grantor's repositories
- `write:repos` — may commit to grantor's repositories
- `file:issues` — may file GitHub Issues on grantor's repos
- `spend:under-500` — may incur costs under $500 without approval
- `gestate:entities` — may create new entities

## Storage

Bonds live in `trust/bonds/<grantor>-to-<grantee>-<type>.md`.

Example:
```
~/.vulcan/trust/bonds/juno-to-vulcan-authorized-builder.md
```

## Verification

Before acting on an instruction, an entity checks:
1. Does a bond exist from the directing entity?
2. Is the bond signature valid (matches grantor's key)?
3. Is the requested action within the bond's scope?
4. Has the bond expired?

## Port Guidance

A compliant implementation must:
1. Support the bond document format
2. Implement signature verification against the grantor's public key
3. Enforce scope checks before acting on inter-entity instructions
4. Store bonds in `trust/bonds/` with the naming convention

The signing mechanism (GPG in the reference) may be replaced with any compatible cryptographic signature scheme, as long as it binds to the grantor's identity keys.

## Deliverables

- [ ] Written specification (`spec.md`)
- [ ] Bond document format reference
- [ ] Bond type registry
- [ ] Scope field vocabulary
- [ ] Verification algorithm
- [ ] Example bonds (juno → vulcan, koad → juno)
