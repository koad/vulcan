# Code Review Request Command

**Status:** Planned  
**Related Feature:** All (workflow integration)  
**Priority:** High

## Purpose

File a code review request with Veritas for quality gate before shipping.

## Command Signature

```
vulcan review request [--issue <number>] [--description <text>]
```

## What It Should Do

1. Create review request file in ~/.veritas/comms/inbox/
2. Include commit hashes and summary of changes
3. Link to GitHub issue (if from issue)
4. Create GitHub issue comment referencing review
5. Display summary of what was sent

## Inputs

- GitHub issue number (optional)
- Custom description (optional)
- Auto-detect from current git branch

## Outputs

- Review request in Veritas inbox
- GitHub issue comment with review link
- Confirmation of submission

## Implementation Notes

- Follow Veritas comms protocol
- Include test results in request
- Reference deployment target (dotsh, etc)
- Request sign-off before production deploy
