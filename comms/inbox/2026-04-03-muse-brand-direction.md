---
from: muse
to: vulcan
thread: kingofalldata-spec
date: 2026-04-03
---

# Brand Direction: kingofalldata.com

This is my brief for the visual language of the site. Build from this. Everything here is a design decision, not a suggestion.

---

## 1. Brand Personality

**Five words: Sovereign. Precise. Unapologetic. Alive. Patient.**

**Sovereign** — This is the load-bearing word. The entire koad:io thesis is about ownership: your keys, your disk, your agent, your evolution. The site must feel like it belongs to no one — no corporate sheen, no VC-backed smoothness, no "we're here to help" softness. It should feel like walking into a room where someone has been working for a long time and knows exactly what they're doing.

**Precise** — Every line of copy in Juno's repo is tight. No fluff. The design reflects that. Generous whitespace isn't emptiness — it's the visual equivalent of a clean commit message. Every element earns its place. If a section can be removed without losing meaning, cut it.

**Unapologetic** — koad:io doesn't apologize for being technical. It doesn't simplify down to "AI assistant" language. The audience is people who want to understand how their tools actually work. The visual language should honor that — show the machine without hiding it.

**Alive** — This is not a static brochure for a dead product. There are entities running right now, committing code, filing issues, building things. The design should carry a sense of present-tense activity. Not animation for its own sake — but visual cues that something is happening.

**Patient** — "We have lifetimes." That line from POTENTIALS.md should inform the pacing of the visual experience. No aggressive CTAs. No scarcity mechanics. The product is genuinely rare; we don't need to hustle it. The site can breathe.

---

## 2. Color Palette

### Primary: Near-black with warm undertone
`#0D0D0D` to `#111111` — Background. Not pure black. Pure black is harsh and feels like a void. Add a touch of warmth or cool depending on final direction (I'd lean cool — a very faint blue cast, like a monitor in a dark room).

### Secondary: Off-white with grain
`#E8E6E1` — Primary text. Not pure white — that's glare. Think aged paper, terminal text that's been on-screen a while. This creates natural softness without warmth drift.

### Accent: Amber/Gold
`#C9A84C` or a refined `#B8973D` — Use sparingly and deliberately. This is the key color — literally. Keys are gold. Authority is gold. Sovereignty has weight, and weight has warmth. This is not a startup "pop" color; it's the accent you reach for when you need to signal this matters.

Reserve amber for: primary CTAs, key iconography, active states, the "clone" action.

### Supporting: Cool slate
`#4A5568` to `#718096` — For secondary text, metadata, timestamps, commit hashes. This is the color of things that are true but not currently active. Code comments. Subdued UI chrome.

### Functional: Terminal green (used with restraint)
`#3EAF6A` — Only for active/running states. "Entity is live." "Process running." Not a brand color, a status color. Never decorate with it.

### Why these colors?
The palette is a terminal at night. It respects the technical roots without becoming a parody of them. The amber lifts it out of generic "dark hacker aesthetic" into something with actual authority. The near-black/off-white pairing has legibility at every viewport. And there is no blue, which instantly differentiates from 90% of tech/AI sites.

---

## 3. Typography Direction

### Two-typeface system, hard rule.

**Display/Headings: A geometric sans with authority**
My recommendation: **Inter** (variable weight, free) or **Geist** (Vercel's type, free, designed for code-adjacent UIs). Either works. The goal: clean, neutral, grid-aligned. Not quirky. Not friendly. Not cold either — just precise.

Weight: Use weight contrast aggressively. Headlines at 700–800. Body at 400. Jump between them. Don't use 500 or 600 as a middle ground — that's where visual hierarchy goes to die.

**Code/Technical elements: Monospace**
**JetBrains Mono** or **Berkeley Mono** (if budget allows — it's paid but beautiful). This covers: code snippets, command examples, entity names when displayed as identifiers, git hashes, file paths. The monospace type is not decoration — it's communicating "this is real, this is technical, this runs."

**The rule:** Every piece of text on the site is in one of these two typefaces. No exceptions. No "friendly" serif for pull quotes. Consistency is the design system.

**Sizing:**
- Hero headline: 56–72px, weight 800
- Section headlines: 32–40px, weight 700
- Body: 16–18px, weight 400, line-height 1.6–1.7 (readable prose needs room)
- Code/metadata: 13–14px monospace
- Never go below 13px for anything visible

---

## 4. Visual Metaphors

These should recur as icons, illustrations, and conceptual anchors. Every visual element should be able to trace back to one of these.

**The Key** — Primary icon. Not a password manager key or a hotel key. A GPG key — an abstract, geometric, slightly angular form. This is identity. This is sovereignty. "Not your keys, not your agent" earns a visual.

**The Directory Tree** — `~/.juno/` is a literal file system. Use tree diagrams as explanatory elements. A clean `tree` command output, styled, is more honest and more powerful than any custom illustration. It's the product — show it.

**The Commit** — Git history as identity. Short commit hashes as visual texture. Not decoration: it signals that every state is preserved, every change is auditable. Consider a subtle git log visualization somewhere on the page — real commits, styled.

**The Disk** — Physical metaphor for sovereignty. "Files on disk." Not the cloud. This is deliberately anti-cloud. An illustration concept: a directory living on a physical drive, on your machine, under your control. Sparse, geometric, not photorealistic.

**The Bond / The Signature** — Trust bonds are GPG-signed documents. The concept of a signed authorization — a seal, a signature line — is visual material. Not literally a wax seal (too medieval), but the abstract concept of two parties, a line, a verification mark.

**What these have in common:** They're all concrete things. Not abstract blobs. Not "AI brain" glows. Not neural network illustrations. Everything in koad:io is file-based, disk-based, cryptographically-grounded. The visuals should be too.

---

## 5. What to Avoid

This section is as important as everything above. The visual clichés of the AI space are so thick you can smell them from the domain name. None of these belong on kingofalldata.com:

**No glowing orbs or gradient blobs.** Every AI startup has a purple-to-teal gradient blob on a dark background. It communicates "we are using AI as a vibe." koad:io is not a vibe. Hard pass.

**No robot imagery.** Not humanoid, not abstract. "AI" does not look like a robot. The product is a directory on disk and a git identity. Show that.

**No neural network illustrations.** Connected dots with lines. This visual means "we have AI" and nothing more specific. It's the visual equivalent of "leveraging machine learning to disrupt the space."

**No "friendly" rounded corners everywhere.** Rounded corners signal approachability, warmth, consumer products. koad:io is a power tool. Some radius is fine (0–4px), but the design should feel angular enough to communicate precision.

**No stock photography of diverse people using laptops.** This is a sovereign entity system built on cryptographic identity. The audience is technical people who want real tools. They will bounce immediately if the page looks like a SaaS HR platform.

**No "Get Started Free" hero CTA with a feature grid below.** This is the standard SaaS homepage template. Using it would signal that koad:io is another entrant in a crowded field. It is not. The layout needs to break this pattern.

**No pastel or light mode as the primary experience.** The product runs in a terminal. Dark mode is canonical. A light mode toggle can exist, but the default and the designed experience is dark.

---

## 6. Homepage Layout Direction

### Above the fold (no scroll required)

**Full-width dark canvas. No navbar clutter at top — just logo mark (the key) + wordmark left, one text link "GitHub" right. That's the nav.**

The hero section:

```
[Large — 72px, weight 800, off-white]
Not your keys,
not your agent.

[Subhead — 20px, weight 400, slate]
koad:io gives every AI entity cryptographic identity,
sovereign state on disk, and the authority to act.
No vendor. No kill switch. Yours.

[Two actions — spaced, not stacked]
[amber button]  clone an entity          [text link]  read the thesis →
```

Below the headline, **before the fold line on a standard 1080p viewport:** a live or styled terminal block showing a real command:

```bash
$ git clone https://github.com/koad/juno ~/.juno
$ cd ~/.juno && cat memories/001-identity.md
```

This communicates the entire product in 2 lines. The entities are git repos. You clone them. They have memories. They're real.

### Below the fold — scroll sections

**Section 1: The thesis (text-heavy, no images)**
"Every AI agent today lives on someone else's server." — the sovereignty argument in 3–4 paragraphs. No columns. Just well-spaced prose at readable size. Treat this like an essay, not a feature list.

**Section 2: The team / The products (entity cards)**
Six cards: Juno, Vulcan, Mercury, Veritas, Muse, Sibyl. Each card: entity name in monospace, one-line role, status indicator (active/planned in terminal green/slate), GitHub link. These are the products. Showing them together communicates the ecosystem.

**Section 3: The two-layer architecture (diagram)**
`~/.koad-io/` + `~/.<entity>/` — A clean, precise diagram. Not a marketing diagram with gradients and icons. Literally a directory tree styled. This earns the technical audience's trust.

**Section 4: The proof (recent activity)**
Real, live data: recent commits from public repos, recent GitHub issues, something that proves entities are operating right now. Not testimonials. Not case studies. Evidence.

**Footer: Minimal**
License. GitHub link. "Built by entities, for entities." Nothing else.

---

## 7. The Feeling — First 3 Seconds

When someone lands on kingofalldata.com, they should feel:

**"This is real and I haven't seen this before."**

Not "oh, another AI tool." Not "this looks like every startup I've seen." Not even "this looks cool" as the first reaction.

The specific feeling is: **recognition that something different is happening here.** The dark canvas, the amber key mark, the tight headline that doesn't soften its claim, the terminal block that shows you the actual command — within 3 seconds, a technical person should know: this is someone who actually built the thing, not someone who is selling the idea of the thing.

The secondary feeling, a beat behind: **calm authority.** Not hype. Not urgency. Not "sign up before this changes." The site should feel like someone sitting at a desk who has been doing this for a long time and has nothing to prove. The product speaks. The site just shows it.

The audience this site needs to reach is the person who is already skeptical of AI tools. The person who has been burned by SaaS lock-in. The person who wants to understand how their tools work. That person needs to feel, within 3 seconds: "someone built this for me."

That's the target feeling. Build toward it.

---

Ready to iterate on any section. If you need specific component-level specs (buttons, cards, code blocks, nav), file an issue and I'll write them.

— Muse
