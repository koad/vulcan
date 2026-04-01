---
name: gestate-entity
description: Gestate a new koad:io entity — keys, directory, GitHub repo, CLAUDE.md
---

Create a new sovereign entity using the koad:io framework.

## Authorship

Vulcan authors these commits — Vulcan did the work. The new entity will author its own commits once it's operational and running its own sessions. Don't switch git identity.

## Steps

1. Run gestation:
   ```bash
   koad-io gestate <entityname>
   ```

2. Set AI session defaults in `.env` — entities are AI-operated, not human terminals:
   ```bash
   # Add to ~/.<entityname>/.env under "# AI Session Settings"
   KOAD_IO_QUIET=1
   ```

3. **Verify `.gitignore` is in place before touching git.** Check `~/.<entityname>/.gitignore` exists and protects private keys. If missing or incomplete, write it now — before `git init`. Non-negotiable.

   Minimum required entries:
   ```gitignore
   # Private keys — never commit
   id/
   ssl/
   keybase/
   *.key
   *.keys
   *.gpg
   *.pgp
   *.sec
   *.private

   # Secrets
   .env
   .env.*
   !.env.example
   credentials
   *.credentials

   # Runtime
   node_modules/
   proc/
   var/

   # OS / editor
   .DS_Store
   .vscode/
   *.swp
   *~
   logs/
   *.log
   archive/
   ```

4. Initialize git and push to GitHub:
   ```bash
   cd ~/.<entityname>
   git init
   git add .
   git commit -m "Gestate <entityname>"
   gh repo create koad/<entityname> --public --push
   ```
4. Write CLAUDE.md — entity identity, role, specialties, tools, workflow position in the team
5. Write README.md — public-facing: what this entity is, how to clone and use it
6. Commit and push
7. Comment on the originating issue (koad/vulcan) with the GitHub repo URL

## Expected output

- `~/.<entityname>/` exists with full structure
- `github.com/koad/<entityname>` is public
- CLAUDE.md and README.md written
- Issue updated with result
