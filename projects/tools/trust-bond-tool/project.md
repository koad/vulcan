---
id: trust-bond-tool
title: "Trust Bond Tool"
type: task
project: project-tools
status: backlog
priority: 2
milestone: false
note: "Deprioritized — will be built live on stream. Getting the stream up first."
assigned_by: juno
issue: ""
repo: ""
created: 2026-03-31
updated: 2026-03-31
tags:
  - tools
  - trust
  - bonds
  - milestone
  - koad-io
description: "A koad:io command that generates, signs, and stores trust bond documents. The first real Vulcan delivery."
target_user: "koad and entities — anyone who needs to establish trust relationships"
complexity: medium
depends_on:
  - koad-io/trust-bonds
  - koad-io/identity
bonds_needed:
  - grantor: koad
    grantee: juno
    type: authorized-agent
  - grantor: juno
    grantee: vulcan
    type: authorized-builder
deliverable_type: koad-io-command
---

# Trust Bond Tool — Milestone: First Vulcan Delivery

This is Vulcan's first real build assignment. Success here means:
- Vulcan received a spec from Juno
- Vulcan built it
- Juno verified and accepted it
- The inter-entity GitHub Issues workflow fired end-to-end

## What to Build

A koad:io command — `<entity> bond <subcommand>` — that creates, signs, verifies, and lists trust bonds between entities.

## Commands

```bash
# Create a new bond (interactive or from flags)
juno bond create --grantor koad --grantee juno --type authorized-agent

# Sign an existing unsigned bond draft
juno bond sign trust/bonds/koad-to-juno-authorized-agent.md

# Verify a bond's signature against the grantor's public key
juno bond verify trust/bonds/koad-to-juno-authorized-agent.md

# List all bonds for the current entity
juno bond list

# Show a bond's details
juno bond show koad-to-juno-authorized-agent
```

## Bond Document Output

Each command produces a markdown file in `trust/bonds/` with this shape:

```markdown
---
bond-id: <uuid>
version: 1
grantor: koad
grantee: juno
bond-type: authorized-agent
scope:
  - act-on-behalf
  - file-issues
  - spend-under-500
issued: 2026-03-31
expires: ""
grantor-key-fingerprint: ""
grantee-key-fingerprint: ""
signed: false
---

# Bond: koad → juno (authorized-agent)

koad authorizes Juno to act as an agent on koad's behalf within the
defined scope. Juno may represent koad in business operations, file
GitHub Issues, manage the MVP Zone community, and incur costs under
$500 without explicit approval.
```

## Bonds to Produce Immediately

Once the tool exists, the first act is creating the two bonds that unblock everything:

| Bond | Type | Scope |
|------|------|-------|
| koad → juno | `authorized-agent` | business ops, issue filing, spend <$500 |
| juno → vulcan | `authorized-builder` | build products, commit to vulcan repo, close assigned issues |

## Implementation Path

1. `commands/bond/command.sh` — dispatcher (routes to subcommands)
2. `commands/bond/create/command.sh` — generates bond document from args
3. `commands/bond/sign/command.sh` — signs with `ssh-keygen -Y sign` or GPG
4. `commands/bond/verify/command.sh` — verifies signature
5. `commands/bond/list/command.sh` — lists bonds in `trust/bonds/`
6. `commands/bond/show/command.sh` — prints a bond's details

## Signing Mechanism

Reference: SSH signing via `ssh-keygen -Y sign` using the grantor's Ed25519 key.
This is simpler than GPG and uses keys already generated during gestation.

```bash
# Sign
ssh-keygen -Y sign -f ~/.koad/.id/ed25519 -n koad-io-bond bond.md > bond.md.sig

# Verify
ssh-keygen -Y verify -f allowed_signers -I koad -n koad-io-bond -s bond.md.sig < bond.md
```

## Acceptance Criteria

- [ ] `bond create` generates a valid bond document with correct frontmatter
- [ ] `bond sign` attaches a signature and sets `signed: true`
- [ ] `bond verify` confirms the signature is valid for the grantor's key
- [ ] `bond list` shows all bonds in `trust/bonds/`
- [ ] koad → juno bond created and signed
- [ ] juno → vulcan bond created and signed
- [ ] Both bonds committed to their respective entity repos

## Why This Is The Right First Milestone

- **Bounded** — clear inputs, clear outputs, clear done
- **Immediately useful** — the bonds are needed right now
- **Proves the workflow** — Juno files issue → Vulcan builds → Juno verifies → closed
- **Unblocks everything** — authorized operations need bonds; bonds need this tool
