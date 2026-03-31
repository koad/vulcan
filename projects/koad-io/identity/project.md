---
id: koad-io-identity
title: "Identity & Keys"
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
  - identity
  - cryptography
  - keys
  - sovereignty
description: "Define the cryptographic identity system — which key types, naming conventions, public key distribution, and how identity is established and verified."
complexity: medium
depends_on:
  - koad-io/entity-model
blocks:
  - koad-io/trust-bonds
  - koad-io/gestation-protocol
---

# Identity & Keys

Cryptographic identity is what makes an entity sovereign. Keys on disk, not in a cloud service. Not your keys, not your agent.

## What to Define

- Which key types are generated and why
- File naming conventions
- Public vs private key handling
- Public key distribution mechanism
- How identity is referenced by other entities

## Key Types (Reference Implementation)

| Type | File | Purpose |
|------|------|---------|
| Ed25519 SSH | `id/ed25519`, `id/ed25519.pub` | Primary identity, modern, fast |
| ECDSA SSH (521-bit) | `id/ecdsa`, `id/ecdsa.pub` | Elliptic curve alternative |
| RSA SSH (4096-bit) | `id/rsa`, `id/rsa.pub` | Compatibility with legacy systems |
| DSA SSH | `id/dsa`, `id/dsa.pub` | Legacy compatibility |
| EC curve params | `ssl/master-curve-parameters.pem` | Base for SSL operations |
| Master EC key | `ssl/master-curve.pem` | SSL master identity |
| Device EC key | `ssl/device-curve.pem` | Per-device SSL identity |
| Relay EC key | `ssl/relay-curve.pem` | Network relay identity |
| Session key | `ssl/session.pem` | Ephemeral session identity |

All private keys are generated without passphrases — entities operate unattended.

## Naming Convention

Keys are named `<type>` and `<type>.pub` in the `id/` directory. When an entity stores another entity's public key, it uses `id/<entity>.<type>.pub`.

Example — Vulcan storing Juno's public key:
```
~/.vulcan/id/juno.ed25519.pub
~/.vulcan/id/juno.ecdsa.pub
```

## Public Key Distribution

Public keys are distributed via a canonical URL:
```
canon.koad.sh/<entity>.keys
```

The `.keys` file is a concatenation of all public keys for the entity (SSH authorized_keys format or similar). This is how other entities verify identity without a central authority.

## Comment Convention

SSH key comments encode lineage:
```
<entity>@<mother>
```
e.g. `vulcan@juno` — Vulcan, gestated by Juno.

## Port Guidance

A compliant implementation must:
1. Generate keys in OpenSSH-compatible format
2. Follow the `id/` naming convention
3. Store only public keys for other entities
4. Support the `canon.<domain>/<entity>.keys` distribution pattern

The specific key algorithms are the reference. A port may use equivalent algorithms that produce interoperable formats.

## Deliverables

- [ ] Written specification (`spec.md`)
- [ ] Key type rationale (why each type exists)
- [ ] Naming convention reference
- [ ] Public key distribution format spec
- [ ] Port guidance
