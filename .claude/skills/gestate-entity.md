---
name: gestate-entity
description: Gestate a new koad:io entity — keys, directory, GitHub repo, CLAUDE.md
---

Create a new sovereign entity using the koad:io framework.

## Steps

1. Run gestation:
   ```bash
   koad-io gestate <entityname>
   ```
2. Initialize git and push to GitHub:
   ```bash
   cd ~/.<entityname>
   git init
   git add .
   git commit -m "Gestate <entityname>"
   gh repo create koad/<entityname> --public --push
   ```
3. Write CLAUDE.md — entity identity, role, specialties, tools, workflow position in the team
4. Write README.md — public-facing: what this entity is, how to clone and use it
5. Commit and push
6. Comment on the originating issue (koad/vulcan) with the GitHub repo URL

## Expected output

- `~/.<entityname>/` exists with full structure
- `github.com/koad/<entityname>` is public
- CLAUDE.md and README.md written
- Issue updated with result
