---
id: project-koad-io
title: "koad:io — Protocol & Reference Implementation"
type: project
status: active
priority: 0
assigned_by: juno
issue: ""
repo: "https://github.com/koad/io"
created: 2026-03-31
updated: 2026-03-31
tags:
  - koad-io
  - protocol
  - specification
  - reference-implementation
  - foundational
description: "Define koad:io as a portable protocol. The current bash+Meteor implementation is the reference — anyone should be able to port it to any language or stack."
owner: vesta
assigned_to: vesta
note: "Migrating to Vesta on her gestation — Vesta owns koad:io protocol, Vulcan builds with it"
stability: unstable
version: "0.x"
tasks:
  - koad-io/entity-model
  - koad-io/cascade-environment
  - koad-io/commands-system
  - koad-io/gestation-protocol
  - koad-io/identity
  - koad-io/trust-bonds
  - koad-io/package-system
  - koad-io/spawn-protocol
  - koad-io/inter-entity-comms
  - koad-io/daemon
---

# koad:io — Protocol & Reference Implementation

koad:io is a protocol for sovereign AI entity operation. It defines how an entity exists, communicates, runs commands, manages identity, and collaborates with other entities. The current implementation (bash scripts + Meteor packages) is the **reference implementation** — not the definition.

## The Core Idea

```
An entity is a directory.
A directory has identity.
Identity has keys.
Keys enable trust.
Trust enables delegation.
Delegation enables collaboration.
Collaboration enables operation.
```

Everything else is implementation detail.

## What "Protocol" Means Here

The koad:io protocol specifies:
- **What an entity IS** — the directory structure, required files, .env schema
- **How commands work** — discovery order, execution contract, argument passing
- **How entities are gestated** — the creation sequence, what must be generated
- **How identity is established** — which key types, naming conventions, distribution
- **How trust is expressed** — bond format, signing requirements, scope fields
- **How environments cascade** — which .env files load in what order
- **How packages are structured** — what a koad:io package must export
- **How entities communicate** — the inter-entity messaging contract
- **How entities are spawned** — the runtime launch protocol

## Reference Implementation

The current implementation at `~/.koad-io/` uses:
- **Bash** for the CLI and command runner
- **Meteor** for the web UI and package system
- **OpenSSH** for cryptographic keys
- **OpenSSL** for SSL/TLS certs
- **GitHub Issues** for inter-entity communication (current)

These are choices, not requirements. A compliant port could use:
- Python + Click for the CLI
- Go for the daemon
- npm packages instead of Meteor packages
- Any key infrastructure that produces compatible key formats
- Any message bus for inter-entity comms, as long as it satisfies the contract

## Why This Matters

If koad:io is only implementable in bash+Meteor, it's fragile. If the protocol is well-defined, it's:
- Portable across languages and stacks
- Auditable (the spec is the source of truth, not the code)
- Forkable (anyone can build a compliant runtime)
- Trustworthy (behavior is predictable from the spec)

## Stabilization Goal

Each subsystem needs:
1. A clear specification (what it does, what it must produce, what it must accept)
2. Reference implementation notes (how the current bash/Meteor code satisfies the spec)
3. Port guidance (what a reimplementer needs to know)
4. Test vectors where applicable (inputs → expected outputs)

## Task List

| Task | Subsystem | Status |
|------|-----------|--------|
| [Entity Model](entity-model/project.md) | What an entity is | backlog |
| [Cascade Environment](cascade-environment/project.md) | .env loading order | backlog |
| [Commands System](commands-system/project.md) | Command discovery & execution | backlog |
| [Gestation Protocol](gestation-protocol/project.md) | Entity creation sequence | backlog |
| [Identity](identity/project.md) | Keys, naming, distribution | backlog |
| [Trust Bonds](trust-bonds/project.md) | Authorization protocol | backlog |
| [Package System](package-system/project.md) | Package structure & install | backlog |
| [Spawn Protocol](spawn-protocol/project.md) | Runtime launch | backlog |
| [Inter-Entity Comms](inter-entity-comms/project.md) | Messaging contract | backlog |
| [Daemon](daemon/project.md) | Always-on runtime | backlog |

## Relationship to Entity Products

The entity-flavor products (freelancer, developer, etc.) are built on top of koad:io. If koad:io is unstable or underdocumented, the entity products break. This project is foundational — it needs to move in parallel with the entity product line, not after it.
