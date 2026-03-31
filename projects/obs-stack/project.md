---
id: project-obs-stack
title: "OBS Stack — Entity-Controlled Recording & Streaming"
type: project
status: backlog
priority: 3
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - obs
  - streaming
  - recording
  - desktop-capture
  - automation
  - content
description: "Give entities control over OBS — sling desktops to OBS, switch scenes automatically, start/stop recording. koad:io daemon as the bridge between entity commands and OBS WebSocket."
owner: vulcan
network: zerotier
tasks:
  - obs-stack/obs-websocket-control
  - obs-stack/desktop-sling
  - obs-stack/entity-scene-mapping
---

# OBS Stack — Entity-Controlled Recording & Streaming

Entities should be able to control their own recording setup without koad touching a button. When Vulcan starts a build session, OBS switches to Vulcan's scene and starts recording. When the session ends, it stops. No human in the loop for content capture.

## Architecture

```
Entity machine (Linux)
  └── koad:io daemon
        └── OBS control commands
              └── ZeroTier → Windows broadcast machine
                                └── OBS WebSocket API
                                      └── scenes, recording, sources

Desktop capture (Linux entity machine)
  └── ffmpeg / v4l2 / pipewire
        └── RTMP or NDI stream
              └── ZeroTier → OBS on Windows
                              └── entity's source/scene
```

The spawn process command already does a basic version of this (hits OBS WebSocket, switches scene, starts stream). This project formalizes and extends it.

## Why ZeroTier

All entity machines and the OBS broadcast machine are on the same ZeroTier network. No ports exposed to the internet. Entity daemons reach OBS via ZeroTier IP directly.

## Task List

| Task | Status | Description |
|------|--------|-------------|
| [obs-websocket-control](obs-websocket-control/project.md) | backlog | Entity commands for OBS WebSocket API |
| [desktop-sling](desktop-sling/project.md) | backlog | Capture desktop and push to OBS as a source |
| [entity-scene-mapping](entity-scene-mapping/project.md) | backlog | Each entity gets a scene; spawn switches to it automatically |

## Definition of Done

- [ ] Any entity can run `<entity> obs start` to begin a recording session
- [ ] OBS automatically switches to the correct entity scene on spawn
- [ ] Desktop capture streams reliably from entity machine to OBS
- [ ] Recording stops cleanly when the session ends
- [ ] No manual OBS interaction required for standard sessions
