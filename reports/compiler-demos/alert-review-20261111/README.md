# Compiler alert review and rewrite readiness — 11 November 2026

The compiler is unchanged. This review separates program generation from content
checks, inspects all remaining candidate alerts, and recommends a stopping point
for broad grammar development. The rewrite layer remains a proposal. There was no
new model call, GPU allocation, compiler run, media inference or training experiment.

## What the historical numbers mean

| Saved stage | Programs generated | Pass recorded content checks | Checks active then |
|---|---:|---:|---|
| compiler_revision_20261105 | 2,099 | Not measured | Schema and logic syntax |
| scope_coverage_20261105 | 2,099 | 1,839 | Plus word coverage |
| content_recovery_20261105 | 2,103 | 1,866 | Plus clause/list checks |
| content_relations_20261105 | 2,103 | 1,924 | Word coverage and clause/list checks |

Generation has one definition across the four saved inventories. The content checks
changed between stages, so their counts are not a fixed accuracy series. Programs
include nominal descriptions as well as full clauses. Generation does not establish
native inference throughput or faithful meaning. All original 2,099 candidates still
generate; four more generate now. Current 2,103 = 1,924 passing + 173 word alerts + 6
clause alerts. 272 claims have no program. No new status was assigned by this review.

## Scope and evidence

Run: `exp/probabilistic_verification/compiler_alert_review_20261111/`.

- `history.json` and `summary.json` are recomputed from all four original saved
  `results.jsonl` inventories. Earlier source inputs, outputs and labels are unchanged.
- All 179 generated-but-flagged claims were reviewed against their source text,
  missing-token lists and saved candidate traces. `review_annotations.json` records
  a local alert judgment, explanation and caveat for each claim. These judgments do
  not certify the whole output.
- 34 no-program cases were deliberately sampled across all refusal reasons, with
  extra cases for the two largest groups. This is diagnostic sampling, not a
  corpus-wide estimate of rewrite suitability.
- 23 passing controls were sampled, one per original-video claim-prefix group.
  Claim-only requirements were saved before inspecting these selected paired
  outputs. All texts had been processed before; this is not an unseen test.
- A read-only search of passing time/manner/text literals beginning with a clause
  marker yielded 22 candidates. The search is a diagnostic heuristic, not a new
  compiler check or a random failure-rate estimate.
- All 38 files in the existing compiler/runner/test source freeze and all baseline
  input/output hashes match. The 291 regression-test result is the earlier measured
  compiler result; no new native test was required for this report-only change.

The compiler author performed this assistant review. No new independent human gold,
corpus semantic accuracy, rewrite success or training/inference gain is claimed.

## Findings

| Claim | Verdict | Primary evidence |
|---|---|---|
| The apparent 2,099-to-1,924 decline used different checks | Confirmed, evidence-backed | All four saved inventories; `history.json` |
| The original 2,099 lost program-generation coverage | Refuted, evidence-backed | Exact candidate-ID comparison; zero lost IDs |
| All 179 alerts are genuine whole-claim errors | Unsupported | Local review finds 166 apparent gaps, 5 likely overstrict alerts, 8 uncertain readings |
| Automatic passes are clean structures for training | Unsupported | Passing controls have 18 faithful, 4 partial, 1 context-dependent structures |
| A rewrite will recover the remaining 451 claims | Unsupported | No rewrite was run; some cases need source-contract fixes or unsupported semantics |

### Local alert judgments

- **166 apparent content/structure gaps.** Examples include missing quantities,
  source assertions, participants, clauses, qualifications and phrasal-verb particles.
- **5 likely overstrict word alerts under the stated reading.** These include
  down with slow, total with an exact 49 count, In already emitted as a relation,
  Example as a discourse label, and only with an already retained half/full contrast.
  The latter two require a stated reading; none is automatically reclassified.
- **8 need context or a reference decision.** Examples include standing up as a
  state versus an act of rising, an ambiguous relative-clause antecedent, and
  emphasis/contrast with simply, more like or only occasional.

The two levels matter: 338Canada is still mistaken for 338 aggregators in the Example
case, and the job title is still split into an ordinary relation in the In case.
Removing their word alerts would not establish faithful compilation.

The 179 primary-family labels are 56 numbers/dates/units, 34 arguments/lists/noun
phrases, 25 names/descriptions, 24 modifiers/scope, 18 source/quotation context, 16
phrasal/directional cases and 6 embedded-clause cases. These are review groupings,
not measured accuracy or mutually independent data points.

### Other inspected outputs

- The 34 sampled no-program cases contain 19 potential rewrite targets, 6 basic
  source/quotation/typing cases and 9 reference/unsupported-meaning cases. These
  labels propose what to try; no recovery was demonstrated.
- The 23 passing controls contain 18 faithful structures, 4 partial structures and 1
  context-dependent controller. Partial means missing or coarse structure under
  this framework, rather than an independently established false truth verdict.
- Of 22 targeted passing clause-literal hits, 5 have an identified binding/source gap,
  2 need review and 15 are ordinary time/nominal/adjectival phrases. Do not extrapolate
  this selection to the 1,924 passing population.

## Representative cases

| Case | Required meaning | Saved result and interpretation |
|---|---|---|
| TjHepwuhkYFA_1035 | Earthquake magnitude 7.7 | Value 7.7 is absent. A generated have-magnitude program is not enough. |
| Txf2EdqOg1SQ_2240 | Narrator reports 49 people in total aboard | Exact group quantity 49 is retained inside report scope. Missing total is likely overstrict. |
| TFgw4IaR9R8s_1632 | Ryan Goodman has the stated job title | In is an emitted relation role, but the composite title is split. Word coverage and title semantics are separate concerns. |
| Tg0UxWYuPeJ0_398 | Music plays while a robot runs | The entire while robot runs clause is a time literal. There is no running-event node; the word check nevertheless passes. |
| TW4OYA3RN-Hw_1790 | Footage shows protests while Gen Z rallies against the stated targets | The Gen Z rally and targets are in a time string rather than explicit bindings. |
| TFOEIehBwT8Q_504 | A sign contains its exact quoted would wording | Compilation refuses modal_scope inside the quote. Protect the quote; do not paraphrase its contents. |
| TgR_u37mCoQ4_1901 | The video has no audio | Compilation explicitly refuses quantified absence. A positive audio entity with absent does not establish the missing joint-negation contract. |

The full candidate structures remain accessible through the unchanged 2,375-case
viewer. The new Alert review tab shows source claims and plain-language judgments;
it does not require reading predicates to understand the diagnosis.

## Recommendation and stopping point

**Freeze the current grammar as the comparison baseline now. Make a small checked
rewrite pilot the next implementation step.** Continue to fix basic source alignment,
quote protection and validation bugs as separately measured changes; stop open-ended
grammar expansion for each new sentence shape.

This is a recommendation, not an accepted new paper decision or measured rewrite
result. We have not demonstrated diminishing returns: the last batch recovered 58
content-check passes. The reason to compare a rewrite now is the intended paper
contribution and the variety of remaining structural problems. 451 strict refusals
are 19.0% of the corpus, so calling all of them outliers would be premature.

The proposed development pilot has 24 failed targets, 8 unchanged controls and 8
ambiguity/unsupported-semantic guards, 40 cases in total. Use one frozen text model
and minimal edits, with unchanged output or explicit refusal allowed. Give it the
claim and existing text parses, excluding truth labels and media observations. Keep the
compiler fixed for the comparison. Reserve source groups before prompt tuning;
the current audit is development context. Select targets with a reviewed missing
value/relation or a refusal with a clear reading. Keep overstrict-only alerts out
of semantic-recovery counts and ambiguous cases in the guard set.

Check original claim → rewrite → predicates. Simplify wording without correcting
the facts asserted, including deliberately false claims. Preserve who did what to whom, shared
participants, quantities with their owners, dates, tense/aspect, polarity, modality,
exact quotations and speech/OCR/depiction scope. Splitting a sentence must not break
shared identity. A bag of unchanged numbers and names is insufficient.

Proposed development gates: at least 12 of 24 failed targets yield reviewed faithful
compiled outputs; no unchanged-control regressions; zero accepted critical
information changes. Unsupported or ambiguous guards may remain refused. These
small-pilot gates are not statistical accuracy guarantees. Training/inference work
should use checked compiled examples after the preparation pipeline is frozen;
the 1,924 automatic passes are not clean training labels.

## Reproduction and report update

The compiler source ZIP linked from the report is unchanged. To reproduce this
report/audit update, first extract that base ZIP and verify its `SHA256SUMS`. Then
extract the small 11 November source-update ZIP over it. Its
`ALERT_REVIEW_SHA256SUMS` covers added/replaced files; do not expect the earlier
base inventory to describe replaced report generators.

```bash
python scripts/analyze_compiler_alert_review.py
python scripts/build_compiler_demos.py
python scripts/package_compiler_alert_review.py
```

The analyzer validates every review ID, original text, source hash and historical
count. The report update preserves the 41 existing demos, 26 viewer-data files and
all earlier archives. The canonical daily records are `docs/project_notes/daily_log.json`; update that
file for future completed work. Current source notes, checklist and Daily log record this
review separately from earlier compiler experiments.

Next proposed steps: prepare the fixed 40-case rewrite comparison with explicit
refusal controls; implement minimal rewriting and review the triples before relation
learning or new DeepProbLog experiments. The rewrite remains unimplemented here.
