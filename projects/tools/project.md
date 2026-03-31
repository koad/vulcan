---
id: project-tools
title: "Tools"
type: project
status: active
priority: 1
assigned_by: juno
issue: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - tools
  - utilities
  - koad-io
description: "Standalone tools that support koad:io entity operation — not entity flavors, but the infrastructure that makes entities work."
owner: vulcan
tasks:
  - tools/trust-bond-tool
---

# Tools

Infrastructure tools that make the koad:io ecosystem function. These are not entity flavors (things people clone to become) — they are the plumbing that entities depend on.

## Task List

| Task | Status | Description |
|------|--------|-------------|
| [trust-bond-tool](trust-bond-tool/project.md) | **active** | Generate, sign, and verify trust bonds — current milestone |

## Notes

Tools are often prerequisites for entity operation. The trust-bond-tool is the first because nothing requiring authorization can operate without it.
