---
id: mobile-zerotier-network
title: "ZeroTier Network"
type: task
project: project-mobile-prompt
status: backlog
priority: 1
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - zerotier
  - network
  - private
  - infrastructure
  - security
description: "ZeroTier network topology for the koad:io entity ecosystem — all entity machines, the broadcast machine, and koad's mobile device on one private network. No public exposure unless explicitly needed."
complexity: low
network: zerotier
depends_on: []
blocks:
  - mobile-prompt/push-to-talk-ui
  - mobile-prompt/daemon-gateway
  - obs-stack/obs-websocket-control
  - obs-stack/desktop-sling
---

# ZeroTier Network

The private backbone. Everything entity-related runs on ZeroTier unless it explicitly needs to be public. One network, all devices, no firewall gymnastics.

## Network Topology

```
ZeroTier Network: koad-io-entities (private)

Members:
  thinker         (koad's main machine, entity host)    10.x.x.1
  broadcast       (Windows OBS machine)                 10.x.x.2
  koad-phone      (koad's mobile device)                10.x.x.3
  vps             (Hetzner, always-on daemons)          10.x.x.10

  # Future entity machines (each entity gets a Linux user + ZeroTier)
  entity-juno     (own user, same machine or VPS)       10.x.x.20
  entity-vulcan                                         10.x.x.21
  entity-mercury                                        10.x.x.22
```

## What Runs Behind ZeroTier

| Service | Why Private |
|---------|-------------|
| Entity daemon gateway (prompt API) | Only koad should send prompts |
| OBS WebSocket API | Only entities should control OBS |
| Desktop RTMP sling | Only the broadcast machine should receive |
| koad:io daemon admin UI | Internal only |
| Inter-entity HTTP comms | Trust-based, not public |

## What's Public

| Service | Why Public |
|---------|------------|
| GitHub repos | Product distribution |
| canon.koad.sh | Public key distribution |
| GitHub Sponsors page | Revenue |
| Entity YouTube channels | Content |

## .env Convention

```env
ZEROTIER_NETWORK_ID=<network-id>
ZEROTIER_IP=10.x.x.x           # this machine's ZeroTier IP
OBS_ZEROTIER_IP=10.x.x.2       # broadcast machine
DAEMON_ZEROTIER_IP=10.x.x.1    # entity daemon host
```

## Setup Steps (One-Time, koad Does This)

```bash
# On each machine:
curl -s https://install.zerotier.com | sudo bash
sudo zerotier-cli join <network-id>
# Approve in ZeroTier Central
# Assign static IP in ZeroTier Central
```

Mobile: install ZeroTier One app, join network, approve.

## Deliverables

- [ ] ZeroTier network created (koad does this)
- [ ] All current machines joined and approved
- [ ] Static IPs assigned in ZeroTier Central
- [ ] .env convention documented
- [ ] Network topology documented (this file)
- [ ] Mobile device joined
- [ ] koad:io daemon bound to ZeroTier interface (not 0.0.0.0 unless intentional)
