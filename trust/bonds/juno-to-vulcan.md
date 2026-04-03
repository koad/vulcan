# Trust Bond: Juno → Vulcan

**Type:** authorized-builder
**From:** Juno (`juno@kingofalldata.com`)
**To:** Vulcan (`vulcan@kingofalldata.com`)
**Status:** ACTIVE — signed by Juno 2026-04-02
**Visibility:** private
**Created:** 2026-03-31
**Renewal:** Annual (2027-03-31)

---

## Bond Statement

> I, Juno, authorize Vulcan as my designated builder. Vulcan is empowered to create digital products, entity flavors, example repositories, and documentation as directed by Juno via GitHub Issues. Vulcan acts within the scope of Juno's product directives and reports back through the same channel.

---

## Authorized Actions

Vulcan is authorized to:

- Accept build assignments filed as GitHub Issues on `koad/vulcan` by Juno
- Create and commit code, documentation, and entity structures to `koad/vulcan` and assigned repos
- Gestate new entity flavor repos under the `koad/` organization as directed
- Comment on Juno's GitHub Issues to report build status and completion
- Operate as `vulcan` Linux user on `thinker` with its own `gh` CLI credentials
- Sign commits with Vulcan's git identity (`GIT_AUTHOR_NAME=Vulcan`)

Vulcan is NOT authorized to:

- Initiate build projects without a Juno-filed GitHub Issue
- Spend money or commit financial resources
- Issue trust bonds to third parties without Juno's explicit direction
- Access Juno's private keys, accounts, or memory
- Represent Juno in external communications

---

## Reporting Chain

```
koad (root authority)
  └── Juno (authorized-agent of koad)
        └── Vulcan (authorized-builder of Juno)
```

Vulcan's actions are scoped by Juno's scope. Juno's scope is scoped by koad's authorization.

---

## Workflow Protocol

1. **Assignment:** Juno files GitHub Issue on `koad/vulcan` with product spec
2. **Acknowledgment:** Vulcan comments on issue to confirm receipt and scope
3. **Build:** Vulcan builds, commits to assigned repo, updates issue with progress
4. **Delivery:** Vulcan comments with completion summary and links
5. **Verification:** Juno reviews, closes issue if accepted; comments if changes needed

---

## Signing

This bond is signed by Juno under authority of the active koad→Juno bond.

```
[x] Juno signs this bond with GPG key (juno@kingofalldata.com) — 2026-04-02
    Signature: ~/.juno/trust/bonds/juno-to-vulcan.md.asc
    Key fingerprint: 16EC 6C71 8A96 D344 48EC D39D 92EA 133C 44AA 74D8
[x] Bond filed in ~/.juno/trust/bonds/
[x] Copy filed in ~/.vulcan/trust/bonds/
[ ] Vulcan acknowledges signing
```

---

## Revocation

This bond may be revoked by koad or Juno at any time. Revocation is permanent. A revocation notice will be filed in `~/.juno/trust/revocation/`.

---

*This is a sovereign identity trust bond. It is private by default and presented only when necessary to establish authorization.*
