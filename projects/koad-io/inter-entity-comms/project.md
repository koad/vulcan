---
id: koad-io-inter-entity-comms
title: "Inter-Entity Communication"
type: task
project: project-koad-io
status: backlog
priority: 8
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - koad-io
  - specification
  - communication
  - coordination
  - github-issues
description: "Define the inter-entity communication protocol — how entities assign work, report back, and coordinate without a central message bus. Current reference: GitHub Issues."
complexity: high
depends_on:
  - koad-io/trust-bonds
blocks:
  - koad-io/daemon
---

# Inter-Entity Communication

How entities talk to each other. The protocol must be asynchronous, auditable, and implementable without a central server. The reference implementation uses GitHub Issues as the message bus.

## What to Define

- The message contract (what a work assignment must contain)
- The response contract (what a completion report must contain)
- The delivery mechanism (how messages are sent and received)
- The trust requirement (how a message is authenticated)
- Alternative transports (what else could implement this contract)

## Message Contract — Work Assignment

A work assignment from one entity to another must contain:
```
sender: <entity>
recipient: <entity>
type: work-assignment
priority: <high|medium|low>
title: <short description>
body: <full spec or link to spec>
context: <relevant background>
deliverable: <what success looks like>
bond-reference: <trust bond that authorizes this assignment>
```

## Message Contract — Completion Report

A completion report must contain:
```
sender: <entity>
recipient: <entity>
type: completion-report
references: <original assignment id>
status: <complete|blocked|partial>
deliverable: <link or description of what was built>
notes: <anything the recipient needs to know>
```

## Reference Implementation: GitHub Issues

```
koad → files issue on koad/juno       ← work assignment to Juno
Juno → files issue on koad/vulcan     ← work assignment to Vulcan
Vulcan → comments on issue            ← completion report
Juno → closes issue                   ← acknowledgment
```

GitHub Issues satisfy the contract:
- Asynchronous ✓
- Auditable (full history) ✓
- No central server required (GitHub is the host) ✓
- Assignee = recipient ✓
- Comments = replies ✓
- Labels = priority/type ✓
- Cross-references = threading ✓

## Alternative Transports

The protocol could be implemented over:
- Email (RFC 2822 headers for metadata)
- ActivityPub / Mastodon
- Keybase encrypted messages
- A local message queue (for same-machine entities)
- Matrix protocol

What matters is the contract, not the transport.

## Authentication

A message is only valid if it comes from an entity that holds a valid trust bond authorizing that type of message. The `bond-reference` field links to the bond that grants authority.

## Port Guidance

A compliant implementation must:
1. Support the work assignment and completion report contracts
2. Provide a way to send and receive messages between entities
3. Implement trust bond verification on receipt
4. Maintain an auditable history of messages

The transport is implementation-specific. Document which transport your port uses.

## Deliverables

- [ ] Written specification (`spec.md`)
- [ ] Message contract schemas
- [ ] GitHub Issues mapping (how each contract field maps to GH concepts)
- [ ] Alternative transport analysis
- [ ] Authentication and trust requirements
