# Build Meteor App Command

**Status:** Planned  
**Related Feature:** meteor-mongodb-development.md  
**Priority:** High

## Purpose

Build a Meteor application for production deployment.

## Command Signature

```
vulcan build meteor-app [--project <path>] [--target <platform>] [--output <dir>]
```

## What It Should Do

1. Validate project structure
2. Install dependencies (npm install)
3. Run tests (unless skipped)
4. Build for target platform
5. Minify and optimize assets
6. Generate source maps for debugging
7. Create deployable bundle
8. Output size and optimization report

## Inputs

- Project path
- Target platform (web, mobile, etc)
- Output directory

## Outputs

- Deployable Meteor bundle
- Size report
- Build log with warnings/errors
- Source maps for debugging

## Implementation Notes

- Support Meteor built-in build system
- Integrate with Docker for consistency
- Cache npm dependencies
- Warn on bundle size issues
- Pre-flight checks for production readiness
