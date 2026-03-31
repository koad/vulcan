---
id: obs-websocket-control
title: "OBS WebSocket Control"
type: task
project: project-obs-stack
status: active
priority: 1
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - obs
  - websocket
  - commands
  - koad-io
description: "Entity commands that talk to OBS via WebSocket — scene switching, recording start/stop, source management. The command layer over obs-websocket protocol."
complexity: low
network: zerotier
obs_websocket_version: "5.x"
depends_on: []
blocks:
  - obs-stack/entity-scene-mapping
---

# OBS WebSocket Control

A set of koad:io commands that wrap the OBS WebSocket API. Entities call these to control OBS without knowing the WebSocket protocol directly.

## Commands to Build

```bash
<entity> obs start              # switch to entity's scene + start recording
<entity> obs stop               # stop recording + switch to idle scene
<entity> obs scene <name>       # switch to a named scene
<entity> obs status             # current scene, recording state, stream state
<entity> obs record start|stop  # recording only (no scene switch)
<entity> obs stream start|stop  # streaming only
<entity> obs source show <name> # show a source in current scene
<entity> obs source hide <name> # hide a source in current scene
```

## Configuration (.env)

```env
OBS_HOST=<zerotier-ip-of-broadcast-machine>
OBS_PORT=4455
OBS_PASSWORD=<obs-websocket-password>
OBS_ENTITY_SCENE=<entity>-main    # convention: <entityname>-main
OBS_IDLE_SCENE=idle
```

## Implementation

Use `curl` + `websocat` for the WebSocket handshake and message exchange, or a small Node.js script if the auth (OBS WebSocket 5.x uses SHA256 challenge-response) is too awkward in bash.

OBS WebSocket 5.x auth flow:
1. Connect to `ws://<host>:<port>`
2. Receive `Hello` message with auth challenge
3. Send `Identify` with `sha256(sha256(password + salt) + challenge)`
4. Send request messages, receive responses

## Reference

The current `commands/spawn/process/command.sh` in Juno's repo already does a basic version of this. Extract and generalize it here.

## Deliverables

- [ ] `commands/obs/` with subcommands
- [ ] Auth handled cleanly (password from .env, never hardcoded)
- [ ] Works over ZeroTier (just needs the right OBS_HOST)
- [ ] Error handling: OBS not running, wrong password, scene not found
