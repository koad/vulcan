---
id: obs-desktop-sling
title: "Desktop Sling"
type: task
project: project-obs-stack
status: backlog
priority: 2
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - obs
  - desktop-capture
  - ffmpeg
  - streaming
  - rtmp
description: "Capture the entity machine's desktop and push it to OBS on the broadcast machine as a media source. The entity's screen becomes an OBS source over ZeroTier."
complexity: medium
network: zerotier
transport_options:
  - rtmp
  - srt
  - ndi
depends_on:
  - obs-stack/obs-websocket-control
blocks: []
---

# Desktop Sling

The entity machine's desktop — the Claude Code session, the terminal, the work — gets pushed to OBS on the broadcast machine as a video source. This is what gets recorded and streamed.

## Architecture

```
Entity machine (Linux)
  └── ffmpeg capturing X11 / Wayland / framebuffer
        └── RTMP or SRT stream
              └── ZeroTier (private, no public exposure)
                    └── OBS on Windows
                          └── "Media Source" or "VLC Source" pointed at stream URL
                                └── entity's scene uses this source
```

## Transport Options

| Transport | Pros | Cons |
|-----------|------|------|
| RTMP | Simple, OBS handles natively | Slight latency |
| SRT | Lower latency, better reliability | Needs SRT plugin or OBS 28+ |
| NDI | Best quality, OBS has native support | Requires NDI Tools on both ends |

**Recommendation:** Start with RTMP. Simple, no extra installs, OBS handles it as a Media Source.

## Capture Command

```bash
# X11 capture → RTMP to OBS
ffmpeg \
  -f x11grab -r 30 -s 1920x1080 -i :0.0 \
  -f pulse -i default \
  -vcodec libx264 -preset ultrafast -tune zerolatency \
  -acodec aac \
  -f flv rtmp://<obs-zerotier-ip>/live/<entity>
```

## koad:io Integration

```bash
<entity> obs sling start    # begin desktop capture → OBS
<entity> obs sling stop     # stop capture
<entity> obs sling status   # is ffmpeg running? stream healthy?
```

## Configuration (.env additions)

```env
OBS_RTMP_URL=rtmp://<zerotier-ip>/live
CAPTURE_DISPLAY=:0.0
CAPTURE_RES=1920x1080
CAPTURE_FPS=30
CAPTURE_AUDIO=default
```

## OBS Side Setup

On the broadcast machine, each entity needs:
- A "Media Source" in their scene pointed at `rtmp://localhost/live/<entity>`
- OBS RTMP server enabled (Settings → Stream → Custom, or obs-rtmp-server plugin)

This is a one-time manual setup per entity, then automated from there.

## Deliverables

- [ ] `commands/obs/sling/` with start/stop/status subcommands
- [ ] ffmpeg capture working on X11 (Wayland fallback if needed)
- [ ] Audio capture included
- [ ] Process management: PID file, clean stop, auto-restart option
- [ ] OBS setup documentation for the broadcast machine side
