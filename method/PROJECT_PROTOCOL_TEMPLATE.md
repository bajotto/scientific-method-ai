# [PROJECT_NAME] — Scientific Protocol

Copy this file into the root of your project as `SCIENTIFIC_PROTOCOL.md` and
keep it updated as the running record for that project. It is the primary
memory for future sessions — an AI agent (or a teammate) should be able to
read this file alone and understand what has been validated, what failed,
and what is still open.

**Last updated:** [YYYY-MM-DD]
**Status:** [one line — current phase and what's blocking the next one]

---

## 1. Testable hypotheses

List each hypothesis with an explicit, checkable acceptance criterion —
not a vague goal.

### H1: [short name]
- **H0 (null):** [the failure mode you're worried about]
- **H1 (alternative):** [what you expect to be true]
- **Acceptance criterion:** [specific, measurable — e.g. "100% of X,
  checked against full history, not a sample"]
- **Status:** ⏳ not yet tested / ✅ validated ([N/N], [date]) / ❌ failed
  ([detail])

*(repeat for H2, H3, ...)*

---

## 2. Phases

### Phase 1 — Discovery
**Goal:** understand current state, no execution.
**Status:** [pending / complete, date]
**Findings:** [what you found, in numbers, not impressions]

### Phase 2 — Pilot
**Goal:** validate hypotheses against 3-5 real cases.
**Status:** [pending / complete, date]
**Result:** [N/N pass — list each case, not just the aggregate]
**Approval to scale:** [awaiting / granted, by whom, when]

### Phase 3 — Scale
**Goal:** execute against everything else — only after Phase 2 = 100%.
**Status:** [pending / complete, date]
**Result:** [real numbers from the system, not an estimate]

### Phase 4 — Monitor
**Goal:** confirm outcomes hold under real, ongoing use.
**Status:** [pending / ongoing / complete]

---

## 3. Incident log

One entry per incident. Do not delete old entries — this section is what
prevents the same failure from recurring under a different disguise.

### Incident: [date]
**What happened:** [concrete, specific]
**Root cause:** [the actual mechanism, not just "human error"]
**Fixed by:** [what changed — ideally a Layer 3 fix; see
`ENFORCEMENT_MODEL.md`. A code fix without a documented lesson does not
prevent a differently-shaped repeat.]
**Lesson:** [what this generalizes to, beyond this one incident]

---

## 4. Checklist for the next session

Whoever (or whatever) picks this project up next should confirm, before
acting:

- [ ] Read this file in full, including the incident log
- [ ] Understand which hypotheses are still unvalidated
- [ ] Know where the real enforcement lives (Layer 3 code, not just this
  file) for the rules that matter most
- [ ] Before claiming "confirmed in production," ran the query that
  confirms it
- [ ] If a script already exists for a given check, used or extended it
  instead of writing a new one from scratch
