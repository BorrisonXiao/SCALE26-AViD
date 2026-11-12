# Shared values and phrase relations — 12 November 2026

The experiment improves targeted construction checks from **10/36 to 34/36**, and passing clauses from **1,140 to 1,147 on the same 1,437 cached sentences**. Three additional real date/time claims compile and pass compiler-author meaning review. Three earlier passing claims are withdrawn because their event/time information remains inside opaque entity phrases. The revised combined count remains **1,953/2,375 (82.23%)**, with 422 remaining. There is no net coverage gain or independent semantic-accuracy claim.

## Protocol

Run: `exp/probabilistic_verification/semantic_components_20261112/`. The manifest and 36 construction probes were saved before implementation. Two probes reproduce motivating constructions; 34 are authored variants or meaning-changing contrasts. They are compiler-author diagnostics, not independent held-out data. Actual Stanza and frozen BERT SRL predictions were generated on CPU; expected answers were never given to these models.

Four fixed conditions: previous compiler; shared value normalization; values plus phrase relations; values plus relations plus semantic checks. The final condition is fixed rather than selected per claim. The original 419 Qwen responses are reused unchanged. No new language-model requests, media inference or empirical relation training were run.

All 2,375 original claims receive a direct comparison. All 449 earlier rejects receive direct-first replay, with cached sentences used only after direct failure. Thirty-three direct passes skip fallback, versus 30 before. The fixed 1,437-clause diagnostic also compiles the previously generated sentences bypassed by those new direct passes; these are explicitly diagnostic, not operational rewrites of passing claims.

## Implementation

- `semantic_values.py` normalizes explicit calendar dates, date–time pairs, supported durations and physical quantities. No reference date or timezone offset is invented. Explicit timezone labels are retained. Bare time codes preserve their scale as unspecified; an explicit T+ marker identifies elapsed time without guessing a clock interpretation.
- `semantic_components.py` reuses the existing compiler and entity/event logical form. Pure values in argument positions, typed arguments and nominal date/time properties use shared handling. Repeated adjuncts retain their types instead of being flattened into strings.
- Supported phrases include relative to, with respect to and in relation to for a bounded set of motion predicates, and in front of/next to for spatial location. Dependency links select the governing event and target. This is a bounded phrase inventory, not a complete learned preposition disambiguator.
- Source alignments record which original character span produced each value or relation. Credit is given only if that typed value or bound relation survives compilation. Values and original wording are kept separately. The word check remains a diagnostic; role, source and temporal checks are separate.
- An explicit time hidden in an opaque phrase, or a deictic expression such as During this time without an interval reference, requests review. Copied quotations, date labels and preserved raw typed times are handled separately. Unsupported normalization alone is not treated as lost meaning.

The modified older core files are `srl_graph.py` (opt-in shared literal handling and repeated typed adjuncts) `logical_form_v2.py` (typed temporal adjuncts and explicit timezone fields), and `normalize_form_v2.py` (retain a complete preposition phrase without adding its last word as a duplicate condition). The historical default still reproduces all 2,375 saved records exactly. New source/earlier compiler snapshots are preserved. No new parser ensemble or prompt selection is used.

## Measured comparisons

| Condition | Target checks /36 | Passing clauses /1,437 | Programs on449 |
|---|---:|---:|---:|
| Previous compiler | 10 | 1,140 | 84 |
| Shared values | 24 | 1,148 | 87 |
| Values + phrase relations | 34 | 1,150 | 87 |
| Values + relations + checks | 34 | 1,147 | 87 |

The 34 target successes include correct refusal of an invalid calendar date. Thirty-four programs generate in each new probe condition, but the nominal-collapse program still fails its target check. The other failed target is the ambiguous in-relation-to construction. Target-check success is not a complete meaning label.

The final 449-case pipeline has 33 direct passes, 54 composed programs, 203 component failures, 144 alignment failures, 13 composition failures and two saved model refusals. Some local repairs merely expose alignment failures; they are not full-claim recoveries. Coverage omissions fall from 135 to 126 among the fixed clauses. The stricter check flags two unresolved time references and one additional unlinked temporal value.

Nine changed/new complete programs were inspected against the unchanged originals. Seventy-eight unchanged program/form pairs reuse their earlier judgments. Thirty cohort outputs are approved, versus 27 before; 57 remain unapproved. These are compiler-author assistant judgments, not independent human gold. New reviews are bound to exact artifacts by SHA-256.

Three reviewed direct recoveries:

- `T8u81WMIyj18_755`: car parked at 1:53am on August19,2025. Clock and date remain on the same event; the original SRL ARG2 label for the typed clock is retained.
- `TFgw4IaR9R8s_1521`: screen text reports April2,2025. The date remains inside OCR assertion scope and the top-left location remains attached to the text.
- `Txf2EdqOg1SQ_2324`: dashcam footage has a visible timestamp of2025/07/20 09:54. The complete value remains attached to the timestamp.

Three newly inspected old passes are withdrawn:

- `TgR_u37mCoQ4_1831`: fire spread and its interval remain a single entity phrase.
- `TgR_u37mCoQ4_1908`: fire growth and January8,2025 remain a single entity phrase.
- `TgR_u37mCoQ4_1924`: update title and January12,2025 remain a single entity phrase.

These are conservative structural exclusions; the old candidate programs remain inspectable. The new combined corpus uses the final checked condition for the449 cohort, and retains prior accepted records outside it except these three withdrawals. It does not union successful outputs across conditions.

Direct automatic counts on all2,375 originals are also 1,953 before and after: three new passes and three new refusals, with123 program changes. This count has different membership and acceptance criteria from the reviewed combined corpus, despite the numerical coincidence. Keep both conditions named explicitly.

## Terrain claim and remaining limitations

The date in rewritten c1 and the relative-to relation in c5/c6 now compile. c3/c4 still refuse: During this time has no resolved interval reference, and the parser reads shifts as a noun in those clauses. The complete original is not recovered. The missing relationships cannot be repaired by retaining words alone.

Other limits include nominal events, broad preposition senses, event/coreference alignment, original operator/source scope and time-to-video-offset mapping. Supported normalization is not a media-evidence prediction. Missing evidence functions still yield unknown.

The first checker incorrectly required copied quote events as separate assertions, failed to recognize alternative event IDs, and equated unavailable normalization with absent meaning. Full-corpus inspection also exposed flattened repeated time arguments and clock/elapsed-time confusion. These generic defects were corrected and all final conditions rerun. First, second and third development outputs, source snapshots, exact frozen final source hashes and `development_history.json` disclose the chronology; no per-claim output selection occurred.

## Validation and reproduction

385 regression and extension tests pass, including 25 new tests and two controlled native DeepProbLog reference-binding tests. Those tests supply constructed observations; no video/audio prediction is claimed. The original default output comparison covers all2,375 claims.

The source ZIP is a ninth overlay. Extract the eight previous compiler source bundles in their published order (base, alert-review, rewrite, rewrite-inspection, split, alignment, maintenance, full-rewrite), then `components-20261112/source.zip`. The old26 archives and26 original viewer JSON files are preserved.

```bash
PYTHONPATH=scripts python scripts/run_semantic_components.py probes
PYTHONPATH=scripts python scripts/run_semantic_components.py replay
PYTHONPATH=scripts python scripts/run_semantic_components.py corpus
PYTHONPATH=scripts python scripts/analyze_semantic_components.py
python scripts/build_compiler_demos.py
python scripts/package_semantic_components.py --allow-missing-history
```

These commands replay cached text and parses; they do not regenerate model output. Measured elapsed times are kept fixed when checking byte-exact report/source reproduction. The older verification pipeline page/checklist are included as publication snapshots; rebuilding the entire historical media report requires its original media artifacts. Source, browser and publication proofs are recorded after validation.

## Proposed next steps and goals

1. Link event and interval references across subclaims. Goal: bind During this time to the stated interval and the same motion event.
2. Test nominal events in a bounded set. Goal: distinguish a collapse/spread event from an entity string without inventing missing events.
3. Freeze these shared components and evaluate a small set of new claims. Goal: assess correct bindings and source context before further compiler expansion or relation training. Date normalization and phrase handling remain standard preparation, not the paper novelty.
