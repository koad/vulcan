---
id: mobile-daemon-gateway
title: "Daemon Gateway"
type: task
project: project-mobile-prompt
status: backlog
priority: 2
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - daemon
  - api
  - http
  - sse
  - prompt
  - response
description: "HTTP endpoint on each entity's daemon that receives prompts from the mobile app, forwards to the entity's AI session, and streams the response back via SSE."
complexity: medium
tech:
  - node-or-meteor
  - server-sent-events
  - ai-api
network: zerotier
depends_on:
  - mobile-prompt/zerotier-network
blocks:
  - mobile-prompt/push-to-talk-ui
---

# Daemon Gateway

The bridge between the mobile app and the entity. Each entity's daemon exposes an HTTP endpoint on the ZeroTier network. The mobile app POSTs a prompt; the daemon processes it and streams the response back via SSE.

## Endpoint Contract

```
POST /prompt
Content-Type: application/json

{
  "prompt": "what should we work on next?",
  "from": "koad",
  "context": ""       // optional: prior conversation context
}
```

```
Response: text/event-stream (SSE)

data: {"type": "chunk", "text": "Based on the current"}
data: {"type": "chunk", "text": " milestone, we should"}
data: {"type": "chunk", "text": " focus on..."}
data: {"type": "done", "text": ""}
```

## Audio Output Option

If `audio: true` is in the request, the daemon also plays the response via TTS on the entity machine's audio output. This routes into OBS desktop audio capture — the entity "speaks" from the machine, clean for recording.

```json
{
  "prompt": "...",
  "from": "koad",
  "audio": true       // play TTS on entity machine → OBS captures it
}
```

TTS on Linux: `espeak-ng`, `festival`, `piper` (neural, high quality), or `say` on macOS.
Piper is the recommendation — offline, fast, sounds human.

## Implementation

Runs as part of the koad:io daemon. Minimal HTTP server — Express or even a plain Node.js `http.createServer`. Listens on `0.0.0.0:<port>` (ZeroTier interface).

Each entity has its own port (convention):
```
juno:    3001
vulcan:  3002
mercury: 3003
muse:    3004
veritas: 3005
sibyl:   3006
```

Or use a single port with entity routing via path: `/prompt/juno`, `/prompt/vulcan`.

## Security

Behind ZeroTier — no public exposure. Optional: require a shared secret header for basic auth within the network.

```env
GATEWAY_PORT=3001
GATEWAY_SECRET=<random-string>    # checked on every request
GATEWAY_AUDIO=true                # play TTS on machine
GATEWAY_VOICE=en_US-lessac-medium # piper voice model
```

## Deliverables

- [ ] HTTP server listening on ZeroTier interface
- [ ] `/prompt` endpoint with SSE streaming response
- [ ] Integrates with entity's AI (Claude API or local model)
- [ ] Optional TTS playback on entity machine (`audio: true`)
- [ ] Config via .env
- [ ] Start/stop via `<entity> daemon start|stop`
