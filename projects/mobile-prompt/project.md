---
id: project-mobile-prompt
title: "Mobile Prompt — Voice Interface for Entity Interaction"
type: project
status: backlog
priority: 2
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - mobile
  - voice
  - pwa
  - push-to-talk
  - tts
  - zerotier
  - streaming
description: "A mobile PWA for voice interaction with entities — speak a prompt, review it, submit to any entity, hear the response read back. The audio becomes the livestream's human voice layer."
owner: vulcan
network: zerotier
tasks:
  - mobile-prompt/push-to-talk-ui
  - mobile-prompt/daemon-gateway
  - mobile-prompt/zerotier-network
---

# Mobile Prompt — Voice Interface for Entity Interaction

A PWA on your phone. You hold a button, speak a prompt, review the transcript, pick which entity gets it, hit send. The entity responds in text — and that text is read back to you via TTS.

The voice channel (your prompt + the entity's spoken response) feeds into the livestream audio. Viewers hear a real conversation. No typing. No screen sharing a phone. Just voice.

## User Flow

```
1. Open PWA on phone (behind ZeroTier, no public exposure)
2. Hold [SPEAK] → Web Speech API transcribes in real time
3. Release → review transcript in input box (editable)
4. Tap entity button: [JUNO] [VULCAN] [MERCURY] ... or [CLEAR]
5. Prompt sends to entity's daemon via ZeroTier HTTP
6. Response streams back → displayed in PWA + read aloud via TTS
7. Entity response audio plays through phone speaker (or routed to OBS)
```

## Why This Makes Streams Better

Without this: koad types into a terminal. Viewers read text. Passive.

With this: koad speaks. Entity responds in a voice. It's a conversation. The interaction is audible even if the screen shows just a terminal. Personality comes through.

## Architecture

```
Phone (browser PWA)
  └── Web Speech API (STT — device-local, no API key)
  └── Web Speech Synthesis (TTS — device-local, no API key)
  └── ZeroTier network
        └── HTTP POST to entity daemon at zerotier-ip:port/prompt
              └── Entity daemon processes prompt, streams response
                    └── SSE or WebSocket back to PWA
                          └── PWA displays + speaks response
```

## Audio Routing for Streams

Option A — Simple: phone speaker plays TTS, phone mic picks it up, OBS records mic.
Option B — Clean: phone audio routed via cable/Bluetooth to the recording machine, OBS takes it as a separate audio source.
Option C — Software: daemon response audio played on the entity machine directly (not the phone), goes straight into OBS desktop audio capture.

Option C is cleanest for production — the entity "speaks" from the machine, not through a phone speaker. The phone is just the input device.

## Task List

| Task | Status | Description |
|------|--------|-------------|
| [push-to-talk-ui](push-to-talk-ui/project.md) | backlog | PWA: STT input, entity buttons, TTS response, clear |
| [daemon-gateway](daemon-gateway/project.md) | backlog | HTTP endpoint on entity daemons to receive prompts and stream responses |
| [zerotier-network](zerotier-network/project.md) | backlog | ZeroTier network for entity comms — all private unless public needed |

## Definition of Done

- [ ] Hold-to-speak captures voice, transcribes in real time
- [ ] Transcript is editable before sending
- [ ] Each loaded entity has a submit button
- [ ] Response streams back and is displayed
- [ ] Response is read aloud via TTS
- [ ] Audio works cleanly on stream (no echo, no feedback)
- [ ] Entire app works over ZeroTier with no public exposure
