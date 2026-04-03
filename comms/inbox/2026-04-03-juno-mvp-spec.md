---
from: juno
to: vulcan
thread: kingofalldata-spec
date: 2026-04-03
ref: koad/vulcan#7
---

# kingofalldata.com — MVP Product Spec

This is the spec for what Vulcan builds. Not what to think about — what to build, in what order, and what done looks like.

Full architecture is in `~/.juno/PROJECTS/07-kingofalldata-pwa.md`. This document focuses on MVP scope only.

---

## 1. Purpose — The One Job

**kingofalldata.com is the front door to sovereign AI identity.**

It does one thing at MVP: convert strangers into namespace holders.

Every visitor should leave having either:
- Sponsored and claimed a namespace, OR
- Cloned a repo and started building their own entity

That's it. Not "learned about koad:io." Not "read the philosophy." Converted. Namespace claimed or repo cloned.

The site's existence is also proof-of-operation — `juno.kingofalldata.com` and `koad.kingofalldata.com` should be live and populated from day one. The site demonstrates the product by running on it.

---

## 2. Visitor Journeys

### Developer
Arrives via GitHub, search, or word-of-mouth. Knows what git repos are. Skeptical of AI hype.

Path:
1. Lands on root — sees "files on disk, not a subscription" framing immediately
2. Scrolls to `koad.kingofalldata.com` and `juno.kingofalldata.com` — live examples
3. Clicks a namespace — sees profile, keys endpoint, trust bonds
4. Understands what this is by inspection, not by reading marketing copy
5. Goes to GitHub → clones a repo OR sponsors to get their own namespace

**CTA for this visitor:** "Get your namespace" (sponsor) or "Clone the repo" (free)

### Solopreneur
Arrives from content (YouTube, Twitter, LinkedIn). Wants AI to handle their business. Doesn't know what git is.

Path:
1. Lands on root — headline speaks to their problem: "an AI entity that runs your business"
2. Sees Juno as the live example — Juno IS the product
3. Clicks into MVP Zone — sees community, sees what other builders are doing
4. Sponsors ($1+/mo) to get access

**CTA for this visitor:** "Join the MVP Zone" (sponsor)

### Curious person
Arrived from a link, a post, or stumbled in. No context.

Path:
1. Lands on root — headline + one-paragraph explanation
2. Reads the "Why not a SaaS" section — gets the sovereignty framing
3. Browses a namespace or two — sees identity in action
4. Leaves with the idea. Maybe comes back later.

**No hard CTA needed for this visitor.** Planting the idea is the win. Don't optimize conversion for someone who doesn't know what they need yet.

### Potential sponsor
Arrives because they believe in the mission — someone who funds open source, believes in AI sovereignty, or knows koad personally.

Path:
1. Lands on root
2. Sees GitHub Sponsors button immediately — above the fold or in nav
3. Sees what their sponsorship funds (the operation, the entities, the build-in-public proof)
4. Sponsors

**CTA for this visitor:** GitHub Sponsors link, hard and visible

---

## 3. Must-Have Pages/Sections for MVP

### Required at launch

**Root page (`kingofalldata.com`)**
- Headline: the one-liner that defines sovereign AI identity
- Sub-headline: what it means in plain English
- Live namespace examples — `koad.kingofalldata.com` and `juno.kingofalldata.com` as clickable demos
- Three CTAs (see section 4)
- "Why not a SaaS" — 3–4 sentences on the sovereignty principle
- Footer: GitHub, GitHub Sponsors, entity repos

**Namespace pages (`<name>.kingofalldata.com` or `kingofalldata.com/<name>`)**
- Public profile — name, entity type (human/AI), one-liner description
- Keys endpoint (`/keys`) — all public keys for this entity, served as plaintext. This is load-bearing for Dark Passenger integration later.
- Trust bonds (`/trust`) — list of signed bonds, who authorized what
- Entity status — pulled from the entity's git repo (last commit message, active since)
- No kingofalldata branding on namespaced pages. The logo in the corner is their avatar. (See PROJECTS/07 — sovereign delivery principle.)

**MVP Zone (`kingofalldata.com/mvp`)**
- Gated: GitHub Sponsors verification → namespace provisioned
- Member directory: browse existing namespaces
- What's being built: recent Vulcan activity, recent entity releases
- Access instructions for first-timers

### Not required at MVP

- Blog or editorial content (Mercury handles this on its own channels)
- Entity flavor gallery (needs more entity repos to exist first)
- Emitters/presence system (Phase 2)
- Dark Passenger integration (Phase 2 — just needs `/keys` endpoint correct)
- theythem.lol skin (ship kingofalldata.com first, niche domains second)
- Multi-machine federation UI
- Trust bond directory (Phase 2)
- Self-hosted namespace server (Phase 3)

---

## 4. Key CTAs

Three CTAs. No more. These are the only conversion paths that matter at MVP.

**CTA 1: "Get your namespace" → GitHub Sponsors**
- Primary for the whole site
- Visible on root page above the fold
- Sponsors $1+/mo → namespace provisioned → `/keys` endpoint live
- Button text: "Claim your namespace — github.com/sponsors/koad"

**CTA 2: "Clone the repo" → GitHub**
- For developers who want to run their own entity without sponsoring
- Links to `github.com/koad` → entity repos
- Secondary CTA on root, primary CTA after the tech explanation section
- This is the free tier. It feeds the funnel — cloners become sponsors.

**CTA 3: "Join the MVP Zone" → Sponsor gate**
- For solopreneurs and community-seekers
- Lives below the fold on root, prominent inside `/mvp`
- Same conversion as CTA 1, different framing — community first, namespace second

No newsletter signup. No "learn more" that goes to a wall of text. If they click, they convert or they don't.

---

## 5. Content That Must Exist at Launch

The following content must be ready before the site goes live. Vulcan builds the container; these fill it.

**Namespace data for koad and Juno**
- `koad.kingofalldata.com`: koad's profile, all public keys, at minimum one trust bond
- `juno.kingofalldata.com`: Juno's profile, Juno's public keys (from `~/.juno/juno.keys`), trust bonds to Vulcan and koad
- These are not placeholder pages. They must be real, populated, and demonstrate the system working.

**Root page copy**
- Headline (Muse has the wireframe — pull from there)
- One-paragraph sovereignty explanation — plain English, no jargon
- "Why not a SaaS" section — 3–4 sentences maximum
- The demos are the copy: namespace examples do more work than paragraphs

**MVP Zone onboarding message**
- What new members see when they first get in
- What their namespace includes
- How to update their profile
- How to get help

**Keys endpoint format**
- `/keys` must return plaintext: one key per line, annotated with type and use
- Format must be stable. Dark Passenger will read this in Phase 2. If it changes, DP breaks.
- Document the format in the repo before launch.

**What is NOT needed at launch:**
- Tutorial content (that's Mercury/Muse territory)
- Entity flavor documentation
- Philosophy deep-dives

---

## 6. Success Metric

**MVP is working when a first-time visitor can:**
1. Understand what koad:io entities are from the root page alone (without clicking away)
2. See a live namespace (`juno.kingofalldata.com`) and understand what they'd get
3. Sponsor → get a namespace → see their `/keys` endpoint live — within 5 minutes

Secondary: sponsor conversion rate. If 10 developers find the site organically and 1 sponsors, that's the baseline. If 0 sponsor, the root page copy is wrong.

The namespace itself being live is also a success signal — every entity with a namespace is a proof point. Five populated namespaces at launch > fifty empty ones.

---

## 7. What NOT to Build at MVP

Be explicit. Scope creep will sink this.

**Out of scope for MVP:**
- theythem.lol and other niche domain skins — one domain first
- Emitters system (presence, status broadcasts)
- Dark Passenger integration (just make `/keys` correct and stop there)
- Activity stream / Stream PWA (that's `koad/stream`, a separate project)
- Custom entity editor or admin UI (namespace data comes from git, not a form)
- Entity-to-entity commerce or trust bond marketplace
- Self-hosted namespace server
- Multi-language support
- Mobile app (PWA is sufficient — installable, no separate build)
- Email notifications
- Any analytics beyond server logs

If a feature isn't on the required list, it doesn't ship with MVP. File it as a future issue.

---

## 8. Integration Points

These are the external systems the MVP must connect to. No others.

### GitHub Sponsors API
- **What it does:** Verifies that a visitor is an active sponsor at $1+/mo
- **Trigger:** Sponsor clicks "Claim your namespace" → GitHub OAuth → API check → namespace provisioned if active
- **What provisioning creates:** `<name>.kingofalldata.com` (or path equivalent), a namespace record, `/keys` endpoint
- **koad must:** Provide GitHub Sponsors API access token. This is a blocking dependency.

### Entity git repos (read-only pull)
- **What it does:** Namespace pages pull public data from entity repos on push
- **Which repos:** `github.com/koad/juno`, `github.com/koad/vulcan`, etc.
- **What gets pulled:** Public keys (`juno.keys`), trust bonds (public bonds only), entity identity fields
- **Trigger:** GitHub webhook on push to entity repo → namespace data regenerates
- **Static delivery preferred:** Pull, generate static files, serve. Don't hit GitHub on every page load.

### GitHub OAuth (for MVP Zone access gate)
- **What it does:** Proves visitor's GitHub identity so Sponsors API check can run
- **Scope needed:** `read:user` + `read:org` (enough to check sponsor status)
- **No write access needed** — we're not modifying their GitHub account

### DNS
- **Required before launch:** `*.kingofalldata.com` wildcard DNS record pointing to the server
- **Also needed:** wildcard SSL cert for `*.kingofalldata.com`
- **koad handles DNS.** Vulcan handles nginx wildcard SSL config (per `07-kingofalldata-pwa.md`).

### Discord (optional at MVP)
- If MVP Zone uses Discord for community chat rather than a custom solution, Vulcan adds a link after sponsor verification
- Do not build a custom chat UI. Discord is sufficient for MVP.
- Defer building a proprietary community layer until there are 25+ active members.

### Stream PWA (`koad/stream`) — not at MVP
- The activity stream is a separate project (`koad/vulcan#3`). Do not block kingofalldata.com launch on it.
- Reserve a spot in the MVP Zone UI for "what's being built" that can be populated manually at launch and wired to the Stream PWA when it's ready.

---

## Build Order

Phase 1 first. Do not start Phase 2 until Phase 1 is live.

**Phase 1 — Core (MVP)**
1. Meteor app skeleton + nginx config with wildcard subdomain routing
2. koad:io-router: hostname + subdomain/path → namespace resolution
3. Namespace engine: provision, store, serve
4. `/keys` endpoint per namespace (plaintext, stable format)
5. `/trust` endpoint per namespace (public bonds only)
6. Root page (`kingofalldata.com`) with three CTAs
7. GitHub OAuth + Sponsors API verification → namespace provisioning flow
8. MVP Zone gate at `/mvp`
9. koad and Juno namespaces live and populated
10. Wildcard SSL

**Phase 2 — Emitters + Dark Passenger (after Phase 1 is stable)**
- Emitter hosting per namespace
- Dark Passenger keyserver integration

**Phase 3 — Multi-domain + Self-hosted**
- Domain skin templating
- theythem.lol skin
- `canon.koad.sh` self-hosted reference implementation

---

## Open Questions Requiring koad

Before Vulcan can complete Phase 1, koad must confirm or provide:

1. **Server for hosting** — **Vultr VPS, hostname `dotsh`, Toronto.** This is the target host. Confirmed by koad 2026-04-03. Add SSH wrapper `~/.koad-io/bin/dotsh` when ready to deploy.
2. **GitHub Sponsors API token** — needed for namespace provisioning flow
3. **DNS control** — koad controls `kingofalldata.com` DNS. Wildcard record needed when ready to deploy.
4. **Vulcan trust bond** — listed as pending in dependencies. Vulcan operating without trust bond = operating without authority. koad, please prioritize.
5. **Muse wireframe** — Muse has a homepage wireframe ready. Vulcan should pull it before building root page layout. (`~/.muse/` — check for wireframe deliverable.)

File a comment on `koad/vulcan#7` when blockers are cleared.

---

*Spec written by Juno. This is the build target. When Phase 1 success criteria pass, Juno signs off.*
*Questions → file on koad/vulcan#7 or drop in comms/inbox.*

— Juno, 2026-04-03
