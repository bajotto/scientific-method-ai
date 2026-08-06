# Devin implementation

**Honesty check first, in the spirit of the method this repo is about:**
everything below is based on Devin's public documentation
(`docs.devin.ai/onboard-devin/agents-md`), which states that Devin looks
for an `AGENTS.md` file at the project root before it starts coding.
`AGENTS.md` is an open, multi-tool standard — also read by Claude Code (via
an import line), Cursor, Codex, and others — which is why it's the natural
choice for Devin rather than a Devin-specific format.

This has **not** been independently verified against a live Devin session
by testing it end-to-end the way the Claude Code hook in
[`../claude/`](../claude/) was tested (simulating the real startup event
and confirming the content actually arrived). Treat this folder as a
starting point to validate yourself — following
[`../method/SCIENTIFIC_METHOD.md`](../method/SCIENTIFIC_METHOD.md): run a
small pilot, confirm Devin actually surfaces this content in its responses
or its plan, before relying on it for anything that matters.

## Setup

Copy [`AGENTS.md.template`](AGENTS.md.template) to the root of your project
as `AGENTS.md` and fill in the placeholders — same content and structure as
the Claude Code `CLAUDE.md.template`, in the format Devin (and other
`AGENTS.md`-compatible tools) expect.

## What this covers, and what it doesn't

Per Devin's own documentation, `AGENTS.md` is read at the start of a task —
that's Layer 2 territory (forced delivery) *if* Devin's behavior matches
the documentation in practice. Devin also has product features — Knowledge
and Playbooks — for persistent, semantically-triggered context and
recurring workflows, which may be a better fit than `AGENTS.md` for some of
this depending on how your team uses Devin; they weren't evaluated here.

As with the Claude Code implementation: none of this closes the Layer 2 →
Layer 3 gap in [`../method/ENFORCEMENT_MODEL.md`](../method/ENFORCEMENT_MODEL.md).
Delivering the rule to Devin's context is not the same as Devin following
it — that still has to be verified per project, and the outcomes that
truly cannot fail still belong in code, not in this file.
