# Entity Gestation

**Owner:** Vulcan  
**Status:** Active  
**Type:** Tooling

## Description

Create and scaffold new entities within the koad:io ecosystem. Includes repository setup, canonical structure, initial bindings, and trust bonds per Vesta specs.

## Inputs

- Entity name and purpose
- CLAUDE.md role definition
- Trust chain and authorization
- VESTA entity structure spec

## Outputs

- GitHub repository initialized and pushed
- Full directory tree per canonical structure
- Initial CLAUDE.md with identity and role
- Trust bonds in `trust/bonds/`
- Gestate framework fixes applied (.gitignore, KOAD_IO_QUIET, committer identity)

## Known Issues

- gestate framework requires 3 manual fixes each time (tracked in memory)
- gh repo create syntax must use --source=. with --push

## Last Updated

2026-03-31: All 8 koad:io entities gestated and live on GitHub
