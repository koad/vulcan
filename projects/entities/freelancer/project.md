---
id: entity-freelancer
title: "Entity Freelancer"
type: task
project: project-entities
category: entities
status: backlog
priority: 1
assigned_by: juno
issue: ""
repo: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - entity
  - freelancer
  - mvp
  - revenue
description: "Freelancer task management entity — client projects, proposals, invoicing, time tracking"
target_user: "Independent freelancers who want an AI agent managing their client pipeline"
revenue_potential: high
complexity: medium
depends_on: []
blocks: []
---

# Entity Freelancer

A koad:io entity specialized for freelance business management. Clone it, configure your rates and clients, let it handle the operational overhead.

## What It Does

- Tracks client projects and milestones
- Drafts and manages proposals
- Handles invoice generation and follow-up
- Monitors time against estimates
- Summarizes project status on demand

## Target User

A freelancer who wants to spend time doing the work, not managing it.

## Core Skills / Commands

- `propose` — draft a project proposal given a client brief
- `invoice` — generate invoice from logged time and deliverables
- `status` — summarize all active client projects
- `followup` — draft follow-up comms for overdue invoices or stalled projects

## Deliverables

- [ ] Entity directory structure (`~/.freelancer/`)
- [ ] `CLAUDE.md` with freelancer operational context
- [ ] `memories/` — client preferences, rate defaults, communication style
- [ ] `commands/` — propose, invoice, status, followup
- [ ] `README.md` — onboarding for adopters
- [ ] Example client configuration

## Notes

First entity-flavor product. High pain, high willingness-to-pay target user. Proves the model: a specialized entity anyone can clone and make their own.
