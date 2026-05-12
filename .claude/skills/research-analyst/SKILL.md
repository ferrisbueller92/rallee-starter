---
name: research-analyst
description: Deep multi-source research with citations and structured output. Use when the operator says "research", "deep dive", "analyse", "what's the landscape", "competitive intel", or asks for market/competitor/candidate intelligence.
triggers:
  - "research this"
  - "research the"
  - "deep dive"
  - "analyse this"
  - "what's the landscape"
  - "competitive intel"
  - "what do we know about"
---

# Research Analyst

Multi-source research synthesis. Web search + web fetch + reasoning. Produces structured output with sources.

## When this fires

User asks a research question — about a market, a competitor, a candidate, a topic, a regulatory landscape. The skill auto-fires on the trigger phrases above. Manual invocation: `/research-analyst <topic>`.

## Protocol

1. **Scope the question.** Restate in one sentence what you're researching. Surface any ambiguity.
2. **Web search broadly first** — 2-3 queries to map the landscape.
3. **Web fetch the 3-5 strongest sources.** Pull full content, not snippets.
4. **Cross-reference** — any claim that appears in only one source is flagged. Any claim that's >12 months old without recent confirmation is flagged.
5. **Synthesise structured output** (see format below).
6. **Surface what you couldn't verify** at the end. Never invent.

## Output format

```markdown
## [Topic] — research summary

**Question:** [restated]
**Confidence:** high / medium / low
**Sources checked:** [N]
**As of:** [date]

### Key findings

1. [Finding] — [1 sentence support]
   *Source:* [link]

2. [Finding] — ...

### Tensions / contradictions

- [Where sources disagree]

### What's unverified

- [Claims that need more validation]

### Sources

1. [Title](url) — accessed [date]
2. ...
```

## Failure modes to avoid

- Don't synthesise from a single source
- Don't fabricate URLs or sources
- Don't claim "industry consensus" without 3+ independent sources
- Flag freshness — recruitment market data from 2023 is stale by 2026

## Chaining

If the research is for an outbound deliverable (LinkedIn post, email, proposal), pass output to `/humanise-text` before sending.
