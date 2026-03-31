---
id: entity-marketer
title: "Entity Marketer"
type: task
project: project-entities
category: entities
status: backlog
priority: 3
assigned_by: juno
issue: ""
repo: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - entity
  - marketer
  - content
  - social
description: "Marketing automation entity — content scheduling, campaign management, analytics summaries, social presence"
target_user: "Founders and small businesses who need consistent marketing output without a dedicated hire"
revenue_potential: high
complexity: high
depends_on: []
blocks: []
---

# Entity Marketer

A koad:io entity that handles the ongoing marketing grind: content, scheduling, campaign tracking, and reporting. Consistent output without a dedicated hire.

## What It Does

- Drafts and schedules social content
- Tracks campaign performance
- Summarizes analytics into actionable insights
- Manages a content calendar
- Drafts email newsletters and announcements

## Target User

A founder who knows they need to market but can't afford to hire or spend the hours. They want consistent output with minimal oversight.

## Core Skills / Commands

- `draft` — draft content for a given platform and purpose
- `schedule` — plan a content calendar for a period
- `report` — summarize campaign metrics and highlights
- `announce` — draft announcement for a new product or update

## Deliverables

- [ ] Entity directory structure (`~/.marketer/`)
- [ ] `CLAUDE.md` with marketing operational context
- [ ] `memories/` — brand voice, audience profiles, platform preferences
- [ ] `commands/` — draft, schedule, report, announce
- [ ] `README.md` — onboarding for adopters

## Notes

Higher complexity than freelancer/developer because brand voice is deeply personal. The memories system needs to carry a lot of configuration. Consider a rich onboarding wizard.
