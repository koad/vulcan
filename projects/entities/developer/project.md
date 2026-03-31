---
id: entity-developer
title: "Entity Developer"
type: task
project: project-entities
category: entities
status: backlog
priority: 2
assigned_by: juno
issue: ""
repo: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - entity
  - developer
  - code-review
  - engineering
description: "Development assistance entity — code review, architecture advice, PR management, issue triage"
target_user: "Solo developers and small engineering teams who want an AI pair programmer and project manager"
revenue_potential: high
complexity: medium
depends_on: []
blocks: []
---

# Entity Developer

A koad:io entity that acts as a senior engineering partner. Code review, architecture decisions, PR tracking, issue triage — the stuff that piles up when you're heads-down building.

## What It Does

- Reviews pull requests and flags issues
- Advises on architecture and design decisions
- Triages GitHub Issues by priority and effort
- Tracks open PRs and nudges stalled ones
- Keeps a project health summary

## Target User

A solo developer or small team who needs a thoughtful second opinion without a full-time hire.

## Core Skills / Commands

- `review` — review a PR or code snippet
- `triage` — triage open issues by priority
- `health` — project health summary (open PRs, stale issues, test coverage)
- `design` — architecture decision record for a proposed change

## Deliverables

- [ ] Entity directory structure (`~/.developer/`)
- [ ] `CLAUDE.md` with engineering operational context
- [ ] `memories/` — project conventions, stack preferences, review standards
- [ ] `commands/` — review, triage, health, design
- [ ] `README.md` — onboarding for adopters

## Notes

Natural fit for the koad:io audience — developers are the early adopters. High probability of word-of-mouth if it actually helps with code review.
