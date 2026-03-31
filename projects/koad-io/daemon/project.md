---
id: koad-io-daemon
title: "Daemon / Always-On Runtime"
type: task
project: project-koad-io
status: backlog
priority: 9
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - koad-io
  - specification
  - daemon
  - runtime
  - always-on
description: "Define the daemon — the always-on background process that keeps an entity running, polling for work, and responding to events without a human in the loop."
complexity: high
depends_on:
  - koad-io/entity-model
  - koad-io/spawn-protocol
  - koad-io/inter-entity-comms
blocks: []
---

# Daemon / Always-On Runtime

The entity at rest. Between spawned sessions, the daemon keeps the entity alive: polling for new work assignments, responding to events, and maintaining state.

## What to Define

- What the daemon's responsibilities are
- The event loop contract
- How the daemon polls for new work
- How it launches work sessions (spawns)
- Process management (start, stop, restart, status)
- Logging and observability

## Daemon Responsibilities

1. **Poll for work** — check for new messages/issues on a schedule
2. **Spawn sessions** — launch entity Claude Code sessions for assigned work
3. **Maintain state** — track active sessions, queued work, completed work
4. **Respond to events** — webhooks, file changes, scheduled tasks
5. **Report health** — expose status for oversight

## Event Loop (Abstract)

```
loop:
  1. Check for new work assignments (via inter-entity comms transport)
  2. For each new assignment:
     a. Verify trust bond
     b. Queue the work
  3. If capacity available and work queued:
     a. Spawn entity session with assignment as startup prompt
  4. Check for completed sessions:
     a. Collect completion report
     b. Deliver report via inter-entity comms
  5. Sleep <poll-interval>
```

## Reference Implementation

`~/.koad-io/daemon/` — the current Meteor-based daemon. Runs as a web application, accessible via browser, with a UI for entity status and control.

The Meteor daemon is one implementation. The abstract daemon is any persistent process that implements the event loop above.

## Process Management

```bash
<entity> start    ← start the daemon
<entity> stop     ← stop the daemon
<entity> status   ← check daemon status
```

## Port Guidance

A compliant daemon must:
1. Implement the event loop
2. Support the poll-for-work mechanism for the chosen comms transport
3. Be able to spawn entity sessions
4. Provide start/stop/status controls
5. Write logs to `var/` in the entity directory

The implementation language and web UI are optional. A minimal daemon could be a cron job. A full daemon could be a web application with real-time updates.

## Deliverables

- [ ] Written specification (`spec.md`)
- [ ] Event loop pseudocode
- [ ] Process management interface
- [ ] Logging requirements
- [ ] Comparison: Meteor daemon vs minimal cron implementation
- [ ] Port guidance
