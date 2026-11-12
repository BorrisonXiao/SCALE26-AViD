# Complete rewrite and compilation experiment — 12 November 2026

All 449 previously rejected claims were tested. The improved direct compiler passes 30 automatically and skips the model for those cases. The remaining 419 receive one fixed rewrite prompt. The final pipeline produces 84 programs. Compiler-author review approves 27 additions: 14 direct repairs and 13 rewrites. Keeping all previous 1,926 accepted rows exactly gives **1,953/2,375 (82.23%)**, with 422 remaining. This is a development compilation count, not semantic accuracy; the earlier 1,926 passes were not all re-reviewed here.

## Design and bounded changes

The paper direction in ADR-023 is unchanged. The user authorized repairs to clear role/identifier restrictions, measurement/absence semantics and evaluation on every previous reject. Rewriting runs only after strict direct failure. Original text, media and truth labels are untouched. A direct automatic pass is not rewritten even if subsequent meaning review rejects it.

- Multiple entity-valued adjuncts constrain one event, e.g. driving along a dock towards a ship. Duplicate core roles still require checks.
- Physical measurements preserve value/range bounds and units. Four robots is a group count; 100 m dash is a measurement attached to dash. Magnitude 7.7 is a scalar attribute, not 7.7 objects. Unsupported or ambiguously typed values remain refused.
- A bounded no-NP construction uses **NOT EXISTS**, the standard logical operation asserting that no matching entity/event witnesses exist. Positive holders remain outside that operation. Holder phrases with embedded propositions are refused to avoid negating the wrong clause. Narration/audio absence in a video uses the audio route.
- Explicit participant identifiers disambiguate repeated noun heads. Source alignment checks whether a media noun is actually used as a depiction source, rather than just an event object. Clip/footage and subjects of show/depict are recognized.
- The new flags are opt-in through `compiler_extensions.py`. Five older core modules expose compatible additional operations/API arguments. All 2,375 historical default outputs are JSON-normalized identical to the saved baseline. The old 38-file source snapshot remains in `baseline_source/`; current sources are not falsely described as hash-identical.

## Fixed model protocol

Frozen Qwen3-30B-A3B-Instruct-2507, local model `/exp/cxiao/calm/downloads/models/qwen3/30B-A3B-Instruct-2507`; float16, temperature 0, seed 42, vLLM 0.18.0, maximum 3,072 output tokens and 32,768-token context. The prompt is `CLAIM_FULL_FALLBACK_SYSTEM` in `scripts/prompts_phase2.py`. Requests contain the unchanged original, cached dependency/SRL information and direct failure diagnostics. No truth labels, media or reference judgments are supplied.

Output is action (`rewrite`, `keep`, `refuse`) and 1–12 short sentences. The model generates no logical identifiers, participant links or predicates. One sentence is allowed for a fragment requiring grammatical normalization. A separate module compiles sentences and infers original-mention/context links. Exact messages, responses and settings are downloadable and visible unfolded in the existing report.

The first direct pass found 31 successes. Reviewing those direct outputs exposed wrong negation scope for a holder with embedded propositions. The rule was restricted and the cohort restarted. Initial GPU job 1226788 completed 418 requests in 133 allocated seconds before its stop request arrived. All its outputs are preserved in `initial_attempt/` and excluded. Final job 1226791 completed 419 requests in 134 allocated seconds, including 84.29 seconds of generation. Both used one H100 sequentially and are released. There is no per-claim mixing of attempts or prompts.

After the first complete evaluation, source-use matching was corrected for clip/footage and media objects. The same 419 outputs were re-evaluated: first 76 automatic programs, final 84. First evaluation outputs and source snapshots are retained. This is development work, not held-out evaluation.

## Final counts and bottlenecks

| First-stop outcome | Claims |
|---|---:|
| Direct pass; model skipped | 30 |
| Rewritten component compilation fails | 207 |
| Components pass, original-reference alignment fails | 142 |
| Alignment passes, composition fails | 14 |
| Model refuses | 2 |
| Complete rewritten program passes automatic checks | 54 |
| Total | 449 |

There are 1,437 proposed clauses, five dependency-parse failures and 1,432 SRL-processed clauses. 1,140 pass component checks; 210 rewrites have every component pass. Four single-sentence rewrites all fail; 413 multi-sentence rewrites and two refusals account for the other outputs. Passing individual clauses does not establish a faithful combined meaning.

All 84 final programs (30 direct, 54 composed) were manually inspected by the compiler-author assistant and their reviews are bound to the exact saved pipeline rows by SHA-256. Fourteen direct and thirteen composed outputs are judged faithful. The other 57 are partial, incorrect or uncertain and are excluded. The 365 cases without complete programs have pipeline diagnostics rather than blanket meaning judgments. These reviews are not independent human gold.

Across automatic failures, the first codes include 119 entity-alignment failures, 96 omitted-content failures and 62 unresolved-clause failures. These are first checks, not a complete root-cause taxonomy. Some proposals contain generation errors and would still be rejected after the first compiler restriction is fixed. Examples include introduced nouns, unlicensed geographic details, nominalizations, repeated group references and label identifiers. Do not call all alignment failures merely overstrict matching.

| Acceptance requirement | Full-corpus count |
|---|---:|
| Previous accepted rows | 1,926/2,375 (81.09%) |
| Previous rows plus all 84 automatic passes, including bad meanings | 2,010/2,375 (84.63%) |
| Previous rows plus 27 reviewed additions | 1,953/2,375 (82.23%) |

The 422 remaining cases are 207 component failures, 142 alignment failures, 14 composition failures, two refusals and 57 review rejections. The reviewed improvement is 27 claims, or 1.14 percentage points. Historical 2,099/2,103/2,105 candidate counts and the separate 1,927 substitution diagnostic describe other acceptance requirements or conditions; they are not interchangeable with this count.

## Illustrative saved outcomes

- **Two trucks drive along a dock towards the ship.** Both directions constrain one driving event and the same two-truck group. Direct repair; no model request.
- **The video features no narration.** Narration and feature-event witnesses stay inside NOT EXISTS; no positive narration is introduced. Direct repair; no model request.
- **A clip shows a boat capsizing.** The model produces “A clip shows a boat” and “The boat is capsizing.” Alignment shares the boat and nests capsizing inside the clip’s visual depiction. Reviewed addition.
- **The court is a three judge panel.** Both model sentences compile, but “court is a panel” becomes a class string while a separate panel entity has three judges. The judges need not belong to the court. Automatic pass, meaning review rejected.
- Other rejected programs turn OR into conjunction, lose while/temporal overlap, project source content into world events, or retain a word such as “trips” without the corresponding tripping event. These defects explain why automatic counts overstate useful compilation.

## Native checks, scope and validation

`native_absence.json` contains three actual DeepProbLog runs with constructed candidate inventories/observations. An empty complete audio inventory supports absence; an empty incomplete inventory yields insufficient evidence; a matching narration/event in a complete inventory refutes absence. Completeness is an explicit assumption, not inferred from an empty detector output. No actual audio/video is assessed by this test.

360 regression and extension tests pass, including native probabilistic checks. `historical_regression.json` verifies all 2,375 historical default outputs exactly. No new empirical relation training or media inference was run. Regression tests may exercise earlier tiny synthetic training code; this is not a new research training experiment.

## Reproduction and evidence

Run directory: `exp/probabilistic_verification/rewrite_all_20261112/`. Inputs and prior full corpus are fixed. `pipeline.jsonl` retains all 449 complete outcomes; `semantic_review.json` retains exact hash-bound reviews; `cases.json` powers the inspector; `corpus_reviewed.jsonl` retains all 2,375 final records. Old accepted rows remain identical. `raw.jsonl`, model configuration, routing, source snapshots and excluded initial attempt preserve the model protocol.

The new source ZIP is an overlay. For the full historical report build, extract the following published source archives in order, into one directory, then the new archive:

1. `compiler-demos/source.zip`
2. `compiler-demos/alert-review-20261111/source.zip`
3. `compiler-demos/rewrite-20261111/source.zip`
4. `compiler-demos/rewrite-inspection-20261112/source.zip`
5. `compiler-demos/split-20261112/source.zip`
6. `compiler-demos/alignment-20261112/source.zip`
7. `compiler-demos/maintenance-20261112/source.zip`
8. `compiler-demos/full-rewrite-20261112/source.zip`

From that project root, with the supplied environment dependencies available:

```bash
PYTHONPATH=scripts python scripts/check_historical_compiler.py
PYTHONPATH=scripts python scripts/evaluate_full_rewrite.py
PYTHONPATH=scripts python scripts/analyze_full_rewrite.py
python scripts/build_compiler_demos.py
python scripts/package_full_rewrite.py --allow-missing-history
```

These commands replay cached text/parses and rebuild the current compiler report, not model generation. The older verification pipeline page and its updated checklist are included as exact publication snapshots; regenerating that entire historical media report also needs its separate original pipeline/audio/video artifacts. The archive check does not claim to regenerate the earlier media experiments. Measured elapsed times are kept fixed for a byte-exact source-bundle replay. Use `--help` for parse/model CLIs if a new generation is separately authorized. `FULL_REWRITE_SHA256SUMS` and `final_source_sha256.json` check archived contents. The existing report has five views and the Reports collection two main entries; earlier URLs, case inspectors, 25 historical archives and 26 original viewer files are preserved. Publication/browser/source-replay proofs are recorded after validation.

## Proposed next steps and intended goals

1. Preserve original OR, while/temporal overlap, modality and source/quoted context during composition. Goal: prevent a valid-looking program from changing logical meaning.
2. Resolve class-description references such as court/panel and use richer original noun-phrase spans, identifiers and groups. Goal: reduce disconnected participants and unnecessary refusals without merging distinct entities.
3. Replay the same 419 saved responses and review new programs. Goal: measure compiler gains with a fixed prompt before another model run; then decide when to stop and move to relation training/inference. The present 82.23% is a development stopping candidate, not a validated training-data acceptance rate.
