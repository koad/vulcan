---
id: project-obs-stack
title: "OBS Stack — Entity-Controlled Recording & Streaming"
type: project
status: active
priority: 1
milestone: true
milestone-name: "First Stream"
milestone-description: "Get entity-controlled recording live so we can start capturing and showing people what we're building. Build everything else on camera."
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

## Minimum Viable First Stream

The fastest path to a live recording. Do these in order — each one is independently useful.

### Step 1 — OBS WebSocket Control (koad does this, no Vulcan needed)
The spawn command already hits OBS. Extend it:
- `<entity> obs start` → switch scene + start recording
- `<entity> obs stop` → stop recording + return to idle
- Works over ZeroTier to the broadcast machine

**Unblocks:** Recording any session right now. No desktop sling needed yet.

### Step 2 — Desktop Sling
Entity machine's screen → RTMP over ZeroTier → OBS source.
Without this, OBS can only show what's on the broadcast machine.
With this, every entity's terminal session is capturable.

### Step 3 — Entity Scene Mapping + Mobile Voice
Polish: auto-scene on spawn, voice interaction layer via mobile prompt.
The voice conversation is what makes the stream compelling to watch.

## Task List

| Task | Status | Priority |
|------|--------|----------|
| [obs-websocket-control](obs-websocket-control/project.md) | **active** | 1 — unblocks recording immediately |
| [desktop-sling](desktop-sling/project.md) | backlog | 2 — entity screen in OBS |
| [entity-scene-mapping](entity-scene-mapping/project.md) | backlog | 3 — polish + mobile voice |

## Definition of Done — First Stream

- [ ] `juno obs start` triggers scene switch + recording in OBS
- [ ] Entity terminal session is visible in OBS
- [ ] `juno obs stop` ends cleanly
- [ ] First session recorded and watchable
- [ ] koad can speak to entities via mobile, voice is on the recording
