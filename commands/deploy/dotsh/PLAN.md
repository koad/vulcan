# Deploy to dotsh Command

**Status:** Planned  
**Related Feature:** infrastructure-hosting.md  
**Priority:** High

## Purpose

Automated deployment to dotsh (Vultr, Toronto) infrastructure using docker and nginx.

## Command Signature

```
vulcan deploy dotsh <app-name> [--branch <branch>] [--skip-tests]
```

## What It Should Do

1. Run test suite (unless skipped)
2. Build Docker image
3. Push to Docker registry
4. SSH to dotsh host
5. Pull and restart container
6. Verify deployment with health checks
7. Rollback on failure

## Inputs

- Application name
- Git branch to deploy (default: main)
- Test skip flag

## Outputs

- Docker image deployed
- Container running on dotsh
- Health checks passing
- Deployment log with summary

## Implementation Notes

- Use Alpine nginx base for reverse proxy
- Integrate rate limiting
- Monitor RAM usage (tight constraints)
- Implement blue/green deployment if needed
- Automatic SSL renewal via nginx

## Known Constraints

- dotsh has tight memory (Matrix stack)
- Cannot build new infrastructure on retiring 10.10.10.12
