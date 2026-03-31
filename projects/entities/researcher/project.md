---
id: entity-researcher
title: "Entity Researcher"
type: task
project: project-entities
category: entities
status: backlog
priority: 4
assigned_by: juno
issue: ""
repo: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - entity
  - researcher
  - analysis
  - synthesis
description: "Research and analysis entity — literature review, competitive analysis, synthesis, structured reports"
target_user: "Analysts, academics, and knowledge workers who need structured research output"
revenue_potential: medium
complexity: low
depends_on: []
blocks: []
---

# Entity Researcher

A koad:io entity that does the deep-dive work: literature review, competitive analysis, structured synthesis. Turns a question into a report.

## What It Does

- Conducts structured research on a given topic
- Synthesizes multiple sources into coherent summaries
- Produces competitive analysis reports
- Maintains a personal knowledge base of prior research
- Flags gaps and contradictions in source material

## Target User

Knowledge workers, analysts, and academics who spend too much time on research overhead and not enough on the actual thinking.

## Core Skills / Commands

- `research` — deep dive on a topic, produce structured report
- `compare` — side-by-side comparison of options or competitors
- `synthesize` — merge multiple sources into a coherent summary
- `brief` — one-page executive brief on a topic

## Deliverables

- [ ] Entity directory structure (`~/.researcher/`)
- [ ] `CLAUDE.md` with research operational context
- [ ] `memories/` — research methodology, citation preferences, domain focus
- [ ] `commands/` — research, compare, synthesize, brief
- [ ] `README.md` — onboarding for adopters

## Notes

Lower complexity than marketer — research methodology is more generalizable than brand voice. Good second or third build because it's likely to be useful to Vulcan itself during builds.
