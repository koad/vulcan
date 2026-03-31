---
id: obs-entity-scene-mapping
title: "Entity Scene Mapping"
type: task
project: project-obs-stack
status: backlog
priority: 3
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - obs
  - scenes
  - automation
  - spawn
description: "Convention and automation for mapping entities to OBS scenes. Spawning an entity automatically switches to its scene; ending the session returns to idle."
complexity: low
depends_on:
  - obs-stack/obs-websocket-control
  - obs-stack/desktop-sling
blocks: []
---

# Entity Scene Mapping

Each entity gets an OBS scene. The spawn command switches to it. The session end switches away. Content capture is zero-effort.

## Scene Naming Convention

```
<entityname>-main       # the entity's primary scene (their desktop + overlays)
<entityname>-focus      # optional: just the terminal, no overlays
idle                    # shown when no entity is active
```

Examples: `juno-main`, `vulcan-main`, `mercury-main`, `idle`

## Spawn Integration

Update `commands/spawn/process/command.sh` to:
1. Call `<entity> obs sling start` — begin desktop capture
2. Call `<entity> obs scene <entity>-main` — switch OBS to entity's scene
3. Call `<entity> obs record start` — begin recording
4. Launch the Claude Code session
5. On session exit: call `<entity> obs record stop` + `<entity> obs scene idle` + `<entity> obs sling stop`

## Scene Template

Each entity scene should include:
- Desktop sling source (the entity's screen via RTMP/SRT)
- Entity name overlay (lower third)
- Session timer (optional)
- koad:io logo / branding (optional)

This is a one-time OBS setup per entity. The scene template can be exported and shared.

## .env Convention

```env
OBS_ENTITY_SCENE=vulcan-main     # set per entity in their .env
OBS_IDLE_SCENE=idle              # shared convention
```

## Deliverables

- [ ] Scene naming convention documented
- [ ] Spawn command updated to handle full OBS lifecycle
- [ ] OBS scene template for entity scenes (exportable)
- [ ] Documentation: how to add a new entity's scene to OBS
