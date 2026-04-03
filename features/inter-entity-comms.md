# Inter-Entity Communications

**Owner:** Vulcan  
**Status:** Planned (Active Development)  
**Type:** Protocol

## Description

Design and implement communication protocols between entities in the koad:io ecosystem. Enables async work, distributed operations, and entity coordination.

## Inputs

- Communication requirements from entities
- DDP protocol specs (Meteor native)
- Git-based fallback strategy
- Rate limiting requirements

## Outputs

- DDP protocol implementation
- Git-based fallback mechanism
- Rate limiting middleware
- Integration examples for other entities

## Active Issues

- **vulcan#15:** Inter-entity comms protocol spec and implementation
- **vulcan#16:** nginx/Meteor DDP + rate limiting + Meteor.onConnection() hook
- **vulcan#17:** Global hook standardization (depends on vesta#9)

## Technical Details

- Primary: DDP (Meteor native transport)
- Fallback: Git-based async messaging
- Transport: nginx reverse proxy with rate limiting
