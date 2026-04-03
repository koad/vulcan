# Entity Scaffolding Command

**Status:** Planned  
**Related Feature:** entity-gestation.md  
**Priority:** High

## Purpose

Scaffold a new entity within the koad:io ecosystem. Automates directory structure, CLAUDE.md generation, trust bonds, and GitHub repository initialization.

## Command Signature

```
vulcan generate entity <name> [--role <role>] [--github <repo-owner>]
```

## What It Should Do

1. Create entity directory at `~/.{name}/`
2. Generate canonical structure per VESTA
3. Create CLAUDE.md with entity role
4. Initialize git repository
5. Create initial trust bond to parent
6. Generate GitHub issue with entity creation details
7. Output setup instructions

## Inputs

- Entity name (lowercase, no spaces)
- Entity role/description
- GitHub repo owner (if creating public repo)

## Outputs

- Full entity directory tree
- Initial commit ready to push
- GitHub integration ready
- Trust chain established

## Known Issues

- gestate framework needs 3 post-generation fixes
- gh repo create syntax requires special flags

## Implementation Notes

- Use gestate framework as base
- Standardize on VESTA-SPEC-001 directory structure
- Include git hooks setup
- Pre-configure GitHub integration
