---
id: mobile-push-to-talk-ui
title: "Push-to-Talk UI"
type: task
project: project-mobile-prompt
status: backlog
priority: 1
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - pwa
  - mobile
  - voice
  - stt
  - tts
  - ui
description: "The PWA itself — hold-to-speak input, editable transcript, entity submit buttons, clear, and TTS response playback. Runs in mobile browser over ZeroTier."
complexity: medium
tech:
  - html
  - vanilla-js
  - web-speech-api
  - web-speech-synthesis
  - sse-or-websocket
depends_on:
  - mobile-prompt/daemon-gateway
  - mobile-prompt/zerotier-network
blocks: []
---

# Push-to-Talk UI

A single-page PWA. No framework needed — vanilla HTML + JS is enough and keeps the footprint tiny. Runs in any mobile browser.

## Layout

```
┌─────────────────────────────┐
│  koad:io                    │
│                             │
│  ┌───────────────────────┐  │
│  │                       │  │
│  │  (transcript here)    │  │
│  │                       │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │  (response here)      │  │
│  │                       │  │
│  └───────────────────────┘  │
│                             │
│  [ 🎤 HOLD TO SPEAK ]       │
│                             │
│  [JUNO] [VULCAN] [MERCURY]  │
│  [MUSE] [VERITAS] [SIBYL]   │
│                             │
│  [        CLEAR        ]    │
└─────────────────────────────┘
```

## Speech Input

```javascript
const recognition = new webkitSpeechRecognition() // or SpeechRecognition
recognition.continuous = true
recognition.interimResults = true

// Hold button → recognition.start()
// Release button → recognition.stop()
// Results populate the transcript textarea (editable)
```

## Entity Buttons

Buttons are generated dynamically from a config object:

```javascript
const entities = [
  { name: 'juno',    endpoint: 'http://10.x.x.x:3001/prompt' },
  { name: 'vulcan',  endpoint: 'http://10.x.x.x:3002/prompt' },
  { name: 'mercury', endpoint: 'http://10.x.x.x:3003/prompt' },
]
```

Config loaded from a `config.json` served alongside the PWA. Add/remove entities by editing the config — no code change.

## Submit Flow

```javascript
async function submitToEntity(entity) {
  const prompt = transcript.value.trim()
  if (!prompt) return

  const res = await fetch(entity.endpoint, {
    method: 'POST',
    body: JSON.stringify({ prompt, from: 'koad' }),
    headers: { 'Content-Type': 'application/json' }
  })

  // Stream response via SSE
  const reader = res.body.getReader()
  // ... append chunks to response box as they arrive
  // ... speak each sentence via SpeechSynthesis as it completes
}
```

## TTS Response

```javascript
function speak(text) {
  const utterance = new SpeechSynthesisUtterance(text)
  utterance.voice = speechSynthesis.getVoices().find(v => v.name === config.voice)
  utterance.rate = 1.0
  speechSynthesis.speak(utterance)
}
```

Speak sentence-by-sentence as the response streams in. Feels responsive, not batched.

## PWA Config

Add `manifest.json` and a service worker so it installs to the home screen and works offline (input only — submission needs network).

## Deliverables

- [ ] Single HTML file + minimal JS + manifest
- [ ] Hold-to-speak with real-time transcript
- [ ] Editable transcript textarea
- [ ] Dynamic entity buttons from config.json
- [ ] Response streams in and displays
- [ ] TTS reads response sentence by sentence
- [ ] CLEAR button resets transcript and response
- [ ] Installs as PWA on iOS and Android
- [ ] Works over ZeroTier (no assumptions about IP ranges)
