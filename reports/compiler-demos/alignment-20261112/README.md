# Separate sentence generation from original-mention alignment —12 November2026

The user authorized the two proposed steps: remove entity/context bookkeeping from the text model, then repeat a fixed meaning-preservation evaluation. They also requested the current pass rate on all2300+ claims. The intended fallback remains sentence-structure simplification after a strict direct-compilation failure. ADR-023 is unchanged.

## Completed results

All2375 original claims were freshly compiled. Every JSON-normalized result exactly matches the saved original baseline. Direct compilation passes1924/2375=81.01%;2103/2375=88.55% produce candidate programs. Candidate generation is weaker than passing content checks. Neither is a whole-corpus semantic-accuracy estimate.

The fixed new sentences-only condition supplies two assistant-reviewed faithful automatic recoveries: TFgw4IaR9R8s_1587 (Trump/image) and TMrQshDs8aH0_750 (police officers). Applying only those two exact outputs gives1926/2375=81.09% passing checks and2105/2375=88.63% candidates;449 strict failures remain. Improvement is0.08 percentage points. Only31 failed originals receive this experiment; no gain is extrapolated to other failures. No manually written subclaims are counted.

| Fixed31-case condition | Passing component clauses | All components pass | Programs generated | Reviewed faithful |
|---|---:|---:|---:|---:|
| Previous sentences and model-generated links |65/77|20|6|0|
| Exact same previous sentences; infer links from original mentions |65/77|20|4|2|
| New sentences-only prompt; infer links from original mentions |71/86|18|4|2|

The middle condition recovers police officers and the lane-three robot, whereas the final condition recovers police officers and Trump. They are complete development comparisons, not a per-claim prompt selector. The final condition is fixed for the corpus substitution. The simpler prompt does not improve the reviewed recovery count over the alignment-only comparison and still generates redundant/incorrect splits. All reviews are compiler-author assistant judgments, not independent human gold or an unseen test.

Earlier1927 came from three reviewed single-sentence replacements in a different diagnostic run. It is not the direct baseline or a cumulative production count. Do not union successes from multiple prompts and call that one automatic method.

## Design

Qwen returns only action(split/keep/refuse) and sentences. It receives the original claim, the same imperfect dependency/SRL parses and direct error, without labels/media/reference readings. There are no model-generated entity IDs, shared groups, context links, predicates, explanations or version indexes. The concise prompt is CLAIM_SENTENCES_SYSTEM in scripts/prompts_phase2.py. A distinct photo/Alice example illustrates splitting. The runner compiles/filters before model import/loading; passing originals are never queried.

Each sentence is parsed by the unchanged Stanza and BERT-SRL models and compiled by the frozen direct compiler. A separate module aligns compiled noun heads to unique original noun mentions. Repeated references to that original mention share identity. An absent noun, ambiguous repeated name or two local entities assigned one original mention is refused. Compatible properties are combined only when attached to the same original noun in the dependency parse; complex conflicting descriptions remain refused.

The adapter reuses a simple depiction source sentence and existing source/relative operators. Trump is shared; the holding event and document's signed attribute stay inside the image's visual context; no signer is assigned. Police-officer clauses use one group, with the van distinct. A generic in-the-second-shot clause is still refused because context inference currently requires a simple source sentence. This is a conservative alignment limitation, not proof that the short text is unfaithful.

Predicate matches also record original event-token IDs. Compatible sibling event descriptions can be joined; conflicting arguments or explicit original temporal features requiring unresolved reattachment remain refusals. Copular be clauses are not unified as one substantive event. Repeated event references and unit normalization are not claimed generally solved.

The initial alignment freeze/source precede output inspection. After the initial old-sentence diagnostics, two general changes recover dependency heads for non-numeric entity IDs and consult original tense/aspect features when refusing unsafe repeated-event merges. Both final conditions use that adapter. No direct compiler change or per-case prompt revision occurred. The38 core compiler hashes,23 previous ZIPs and26 original viewer JSON files are preserved.

## Failures and interpretation

The new condition has12 component refusals,10 entity-alignment refusals,3 source-alignment refusals,2 conflicting-description refusals and2 generated programs rejected on review. The whole-corpus remainder includes173 content omissions,109 unresolved clauses,59 duplicate-role diagnostics and34 missing predicates. These automatic categories are not independent semantic labels.

The earthquake/magnitude split now has correct distinct identities, but7.7 remains a generic entity in a copular relation instead of a scalar magnitude. No-narration produces a positive/negative contradiction. Building housing a publisher becomes a building being constructed, inventing an event. Quoted text is still expanded into world assertions despite the prompt. Speed/rainfall need typed measurements; quantified absence requires appropriate negation. Merely changing sentence length cannot repair these meanings.

One H100 job1226662 completed in207 allocated seconds, including7.54 generation seconds, then released resources. No new media verification, native DeepProbLog inference or relation training.42 focused tests pass; browser/source/publication proofs are recorded separately.

## Reproduction

Artifacts: exp/probabilistic_verification/split_alignment_20261112. Exact requests and responses, both condition results, full-corpus direct/reviewed outputs, hash-bound reviews, source history, parser provenance and summaries are retained. The historical original texts and annotations are untouched.

Extract the compiler source.zip baseline and dated alert-review, rewrite, rewrite-inspection and split overlays in their documented order, then alignment-20261112/source.zip. Validate SPLIT_ALIGNMENT_SHA256SUMS. Using the existing environments:

```sh
PYTHONPATH=scripts envs/probabilistic-verification/bin/python -m pytest -q tests/test_split_alignment.py tests/test_claim_split.py tests/test_claim_rewrite.py
envs/probabilistic-verification/bin/python scripts/evaluate_split_alignment.py --condition old_sentences
envs/probabilistic-verification/bin/python scripts/evaluate_split_alignment.py --condition sentences
envs/probabilistic-verification/bin/python scripts/run_split_alignment_census.py --combine
envs/probabilistic-verification/bin/python scripts/analyze_split_alignment.py
envs/probabilistic-verification/bin/python scripts/build_compiler_demos.py
```

Saved-parse replay needs no model/GPU. A fresh full original census is run_split_alignment_census.py without --combine; it checks exact original-record equality. Its elapsed time is naturally not deterministic. In an isolated extraction, package_split_alignment.py --allow-missing-history rebuilds the dated overlay while checking available compiler/viewer artifacts.

## Proposed next steps and goals

1. Handle explicit participant identifiers and routine source frames in bounded tests: reduce false refusals such as Robot1/Robot2 and in-the-second-shot without guessing references.
2. Define typed measurements and quantified absence independently: repair meanings that sentence simplification cannot provide. Rerun the full corpus after any change.
3. Expand evaluation on failures only after these contracts pass: measure complete meaning preservation before corpus-wide automatic fallback or new DeepProbLog training. Do not continue with prompt-only revisions as the main strategy.
