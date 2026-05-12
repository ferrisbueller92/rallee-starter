---
type: claude-design-setup
project: rallee
created: 2026-04-29
purpose: Paste-ready inputs for Anthropic's "Set up your design system" form (Claude Design)
---

# Claude Design — Rallee setup bundle

Paste-ready content for each field on the **Set up your design system** form.
Copy each block straight into the corresponding field. The asset upload folder
is `projects/rallee/brand/claude-design-upload/` (already staged).

---

## Field 1 — Company name and blurb

```
Rallee People — boutique recruiting and team-building agency, based in Sydney, Australia. Founded by Bree Hardie. Rallee places curated, vetted talent into senior roles AND helps companies rally their existing teams around shared culture and values. Editorial brand voice; high-touch service positioning; aimed at premium clients who feel commodity recruiters are too transactional. Naming is a play on "rally" — rooted in team sport and the founder's rugby/team-culture origin story.
```

---

## Field 2 — Link code on GitHub

```
https://github.com/ferrisbueller92/rallee
```

(Private repo; Dave authenticates as `ferrisbueller92`. Currently on `main`,
v2 of the placeholder rebuild — 7 interior pages + SEO + design tokens at
`design-tokens.json` + shared `styles.css`.)

---

## Field 3 — Upload a `.fig` file

**Source file:** "Rallee - Brand Guide" — Figma URL
`https://www.figma.com/design/pbKvlEtAMMjLcdWPAxO2Ff/Rallee---Brand-Guide`

To save the .fig locally for upload:
1. Open the Figma file in Safari (or Figma desktop app)
2. **Menu (top-left ☰) → File → Save local copy** → saves a `.fig` file to
   Downloads. Note: requires "can edit" access to Figma — Dave currently has
   "viewer" role on Bree's file. If the menu option is greyed out, ask Bree
   to either:
     - bump Dave to editor, OR
     - **Menu → File → Save local copy** on her end and AirDrop / send the
       resulting `.fig` to Dave.

If a `.fig` file isn't accessible, the staged PNG renders below cover the
brand visuals — Claude Design's parser is most useful for editable Figma
structure but the assets folder gets us 80% of the value.

---

## Field 4 — Add fonts, logos and assets

**Drag this entire folder into the form:**
`/Users/davidcalder/vault/projects/rallee/brand/claude-design-upload/`

Contents:

| File | What it is |
|---|---|
| `4004_180-logos.png` | All logo lockups (primary, monogram variants) |
| `4002_2-logo-type-use-cases.png` | Logo + typography use-case examples |
| `4004_186-colours.png` | Full palette page (5 named tokens) |
| `4004_227-typeface.png` | Typography system spec (Futura H1, Inter Display H2-H4 + body) |
| `4004_229-creative-use-cases.png` | Brand applied to creative samples |
| `tokens.css` | CSS custom properties — palette + typography (paste into a stylesheet) |
| `tokens.json` | Same tokens in JSON (for design-system tooling) |

**Fonts to also upload if Bree has them as files:**
- **Futura** (used for H1 only) — Bree may have a licensed `.otf`/`.ttf`. If
  not, Claude Design can substitute via Adobe Fonts / Google Fonts (no exact
  match — closest open alternatives: *Futura PT* via Adobe, or *Jost* via
  Google).
- **Inter Display** (H2–H4 + body) — free via Google Fonts.

---

## Field 5 — Any other notes

```
BRAND TOKENS (locked v1 — from Figma "Rallee - Brand Guide"):
  --rallee-red:        #ea0000   (single bright accent — sparingly, never as bg)
  --rallee-black:      #070707   (primary ink)
  --rallee-white:      #fffcf9   (warm off-white background)
  --rallee-grey:       #dddddd   (line/divider)
  --rallee-light-grey: #f6f2f2   (subtle surface)

TYPOGRAPHY:
  Headline 1:   Futura, 56pt/64pt, tracking 0%
  Headline 2:   Inter Display Regular, 40pt/48pt, tracking -2%
  Headline 3:   Inter Display Medium, 36pt/42pt, tracking -2%
  Headline 4:   Inter Display Semi Bold, 28pt/36pt, tracking -1%
  Subheadline:  Inter Display Regular, 18pt/24pt, tracking -1%

VISUAL DIRECTION (locked):
  - Editorial layout: lots of whitespace, generous margins, narrow text columns
  - Photography: lifestyle / editorial, NOT corporate. Red wardrobe pieces feature.
  - Use red as a single sparing accent + via photography (red shoes, garment).
  - Restraint over decoration. Premium feel through whitespace + type, not effects.

VOICE & TONE:
  - Refined, intelligent, warm. Australian without being colloquial.
  - Curated language: "we vet every candidate" framing, "rally" verb usage.
  - "Suitable candidates receive dedicated time" (not "every candidate gets an hour" — too literal).
  - Avoid: "Rally your team" overuse (currently appears 4+ times on one page).

WHAT WE'RE NOT:
  - Not a high-volume body shop.
  - Not a digital recruiter masquerading as boutique (re: House of Chain).
  - Not corporate-stiff. Not LinkedIn-template-prose.
  - Visual aesthetic is NOT House of Chain's (we like their FEEL of curated/high-end —
    we will arrive at that feel through whitespace, type, and photography, not by
    copying their look).

TARGET MARKETS:
  Clients (companies hiring):     Australian SMBs and scale-ups, premium-positioned,
                                  team-culture-conscious. Pay for vetting + cultural fit.
  Candidates (talent we place):   Mid-to-senior, ambitious, want a curator who knows
                                  them. Get genuine time + advocacy + career-coaching
                                  resources.

THINGS WE NEED TO BUILD (priority order):
  1. Brand book v2 — refines tokens, adds copy library, voice examples
  2. Landing page v3 — rebuild based on locked brand book
  3. Email template system — candidate auto-responder + BD outreach + hot-talent
     newsletter + event promotion. Branded so Bree can send without learning Mailchimp.
  4. Talent pool registration flow — form + gating
  5. Reviews / testimonials section (Bree has many; missing from current site)
  6. Resources (master class + CV templates) — surfaces existing content as
     authority + lead magnet.

INSPIRATION (use the FEEL, not the look or the copy):
  - High-end, professional, curated boutique recruiting positioning
  - Editorial agency websites — restraint, big type, beautiful photography
  - Squarespace-template-fatigue is the enemy: don't look like everyone else's recruiter

CONSTRAINTS:
  - Do NOT lift any literal copy from competitors.
  - Do NOT lift any visual element from competitors.
  - Do USE the existing Rallee tokens (red/black/cream + Futura/Inter Display)
    until brand book v2 supersedes them.
```

---

## After form submission — what to expect

Claude Design will parse the .fig (if uploaded), the GitHub repo, and the
asset folder; build an internal model of the system; and let you generate +
iterate components against the locked tokens.

**Use it for:** UI components, page templates, design exploration alongside
the local Brand Strategy v1 + Brand Book v2 work happening in this vault.

**Local + Claude Design = parallel iteration:**
- Local Claude Code (this session) drives the brand strategy + brand book +
  website rebuild.
- Claude Design drives reusable component design + visual exploration that
  feeds back into the brand book v2 round.

Both must use the same v1 tokens — no drift until brand book v2 ships.

---

# Follow-up prompt — paste this AFTER initial ingest completes

```
We're working on REFINING (not rebranding) Rallee People's existing brand book.
This is a paid recruiting/team-building agency in Sydney founded by Bree Hardie.

LOCKED (do NOT touch):
- Logo (Bree's words: "non-negotiable")
- Rallee Red #ea0000 stays as the brand accent — but used MORE SPARINGLY (single
  accent, never as background, single moment per page)
- Black #070707 + warm white #fffcf9 stay as core neutrals

TO EVOLVE:
1. TYPE SYSTEM — Bree found the current Futura + Inter Display pairing "boring
   and harsh". Propose 3 alternative type pairings within the SAME tier:
     - Display face for H1 (currently Futura) — keep something with structure
       but warmer/more editorial. Suggested directions: Söhne Breit, Recoleta,
       GT Sectra, Tiempos Headline. Show all three options at the hero scale.
     - Body face (currently Inter Display) — propose 1 alternative. Looking for
       something with more warmth than Inter Display while staying highly
       legible at body sizes.
     - Add a CURSIVE / SCRIPT accent face for editorial annotation moments only
       (specifically: post-it-style overlays, signature flourishes, single-word
       emphasis — NEVER for body or extended copy). Suggested directions:
       Caveat Brush, Reenie Beanie, GT Walsheim Hand, Edwardian Script, Bickham
       Script, La Belle Aurore. Show 3 candidates at editorial scale.

2. PALETTE — add 1-2 warm complementary tones to soften the current black/white/
   red harshness Bree flagged. Options: warm sand/clay neutral, soft yellow
   highlight (specifically YELLOW — see annotation moment below), terracotta
   secondary. Constraint: red still does the heavy lifting; complements are
   warming neutrals, not competing accents.

3. ANNOTATION / EDITORIAL MOMENT (specific reference Bree liked) — a "yellow
   post-it note" treatment overlaid on a background visual, with RED CURSIVE
   handwritten-style writing on the post-it. One-off only — used as an
   editorial flourish on key brand moments (hero pull-quote, founder
   signature, single-call-out per page). Premium and high-end, NOT crafty or
   cute. Reference moment: Bree showed this on her Pinterest board at ~38min
   into the 29 Apr 2026 meeting. Treat it as: clean rectangular post-it shape
   with subtle realistic shadow, refined yellow (not neon, more buttercream/
   soft mustard), red cursive writing in the new script face.

4. PHOTOGRAPHY DIRECTION — editorial / lifestyle / not corporate. Specific
   notes: red wardrobe pieces feature prominently (red shoes, red garment as
   single statement). Ocean-coastal mood references. Subjects look at viewer
   (eye contact). Premium fashion-magazine restraint, NOT stock recruiting
   imagery (no handshakes, no headsets, no whiteboards).

5. APPLICATION DISCIPLINE — whitespace as the premium signal, not visual
   density. Generous margins. Single dominant element per section. Restrained
   colour application: 90% neutral surfaces, 10% red moments.

WHAT WE NEED FIRST (component priority order):
1. Hero section (3 variants — same content, different typography pairings,
   so Bree can pick)
2. Pull-quote / brand-moment block (with the yellow post-it + red cursive
   treatment)
3. Two-column "what we do" block (split: clients vs candidates, distinct
   tonal registers per side)
4. Card grid for "current roles" / "hot hires" (editorial photo + minimal
   meta + single CTA)
5. Footer with monogram + 3 social icons + tagline

After hero variants are approved, generate:
6. Full landing page template using the chosen pairing
7. Email template (candidate auto-responder + BD outreach + hot-talent
   newsletter)
8. Single-page resource template (master class / CV templates)

CONSTRAINTS (hard):
- Do NOT redesign the logo. It's locked.
- Do NOT lift visual style from competitors (specifically NOT Haus of Chain).
- Do NOT use the existing Rallee colour-block heavy treatment from the
  current brand guide — the application is what's evolving, not the tokens.
- Voice/tone must match the brand-strategy doc — refined, intelligent, warm,
  Australian without colloquial.

REFERENCE FILES YOU'VE BEEN GIVEN:
- 22 logo SVGs in /logos-svg/ — primary lockups + monograms
- 5 frame PNGs — existing brand book pages (logos, colours, typeface, use
  cases) for visual context
- 31 image fills in /image-fills/ — photography Bree currently has
- tokens.css + tokens.json — locked v1 tokens
- GitHub repo: github.com/ferrisbueller92/rallee — current placeholder
  rebuild (v2). NOT FINAL — reference IA + structure only, NOT visual.

Show me 3 hero variants to start. Each should make the typography pairing
the lead decision (different display face per variant, body + cursive
consistent across).
```

## Attachments to point Claude Design at (with exact paths)

Beyond the brand strategy v1 (which is the CONTENT source-of-truth), point
Claude Design at these:

| File / folder | Purpose | Exact path |
|---|---|---|
| **Brand strategy v1 (HTML)** | Vision, voice, target market, positioning. The CONTENT layer. | `/Users/davidcalder/vault/projects/rallee/brand/02-brand-strategy-v1.html` |
| **Visual anchors from meeting** | Every "I like this" moment with screenshot + AI description. Reference for design preferences. | `/Users/davidcalder/vault/projects/rallee/meetings/2026-04-29-bree/visual-anchors.md` |
| **Specific Pinterest moment frames** | Bree's mood-board references — premium/edgy aesthetic, red logos, ocean vibes, typography/quotation treatments. Look here for the post-it/cursive moment. | `/Users/davidcalder/vault/projects/rallee/meetings/2026-04-29-bree/frames/utt-0261-02323s.jpg` (38:43) and `utt-0265-02356s.jpg` (39:16) — also `utt-0262-02339s.jpg` and `utt-0263-02346s.jpg` for adjacent context |
| **Live site scrape** | What's currently live at ralleepeople.com — IA, structure, current copy | `/Users/davidcalder/vault/projects/rallee/research/live-site/pages.md` |
| **Site brief from meeting** | Section-by-section change requests | `/Users/davidcalder/vault/projects/rallee/website/01-landing-page-brief-2026-04-29.md` |
| **Haus of Chain teardown** | Form/feel patterns to learn from (NOT visual reference, NOT copy reference) | `/Users/davidcalder/vault/projects/rallee/research/competitor-house-of-chain.md` |
| **Brand strategy raw input** | Verbatim quotes from meeting (deeper than the v1 HTML) | `/Users/davidcalder/vault/projects/rallee/brand/01-brand-strategy-input-2026-04-29.md` |

Most of these are markdown — paste them into Claude Design's chat, OR
upload as text attachments if it supports that.

**Source files for this bundle:**
- `projects/rallee/brand/figma/` — full Figma extract
- `projects/rallee/brand/claude-design-upload/` — staged assets (drag this folder into the form)
- `projects/rallee/meetings/2026-04-29-bree/` — meeting source-of-truth
