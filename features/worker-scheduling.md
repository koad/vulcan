# Worker Scheduling & Daemons

**Owner:** Vulcan  
**Status:** Planned  
**Type:** Infrastructure

## Description

Build self-aware daemon processes that schedule work, coordinate background jobs, and manage periodic tasks across the koad:io ecosystem.

## Inputs

- Job specs and scheduling requirements
- Resource constraints and priorities
- Monitoring and alerting needs

## Outputs

- Daemon process implementations
- Scheduling strategies
- Health check and monitoring integration
- Coordination protocols for distributed workers

## Active Issues

- **vulcan#19:** Self-aware worker scheduling via daemon (blocked on Salus hook)

## Known Dependencies

- Depends on Salus hook implementation for resource awareness
- Must work within dotsh tight memory constraints
