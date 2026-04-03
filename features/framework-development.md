# Framework Development

**Owner:** Vulcan  
**Status:** Active  
**Type:** Core Infrastructure

## Description

Develop, maintain, and extend the koad:io framework. Includes Meteor packages, protocol implementations, standardized hooks, and shared utilities used across all entities.

## Inputs

- Framework spec from Vesta or other entities
- koad:io canonical protocols
- Entity feedback on missing utilities

## Outputs

- Reusable Meteor packages in `~/.koad-io/packages/`
- Protocol implementations ready for entity use
- Standardized hooks and middleware
- Documentation for entity developers

## Active Work

- **vulcan#17:** Global hook standardization (blocked on koad/vesta#9)
- **vulcan#16:** nginx/Meteor DDP rate limiting and hooks
- **vulcan#15:** Inter-entity comms protocol (DDP-native, git fallback)

## Known Dependencies

- Uses dotsh infrastructure (Toronto, Vultr)
- Must watch RAM usage (Matrix stack tight)
- Packages checked before adding npm dependencies
