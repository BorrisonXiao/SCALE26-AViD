# Compiler stopping point and training interface — 12 November 2026

The current recommendation is to freeze the checked compiler and start a small,
carefully reviewed relation-learning experiment. This is a proposed stopping
point, not a claim that all sentences compile correctly or all retained programs
are ready for empirical training. ADR-023 is unchanged.

## Completed compiler experiment

All 2,375 original claims and the entire saved rewrite set for the earlier
449-case failure cohort were replayed. The fixed final condition removes duplicate
auxiliary SRL frames, retains attached adverbs, and resolves a bounded explicit
interval reference. Passing originals bypass rewriting. No per-claim prompt or
compiler selection is used. The historical default remains available unchanged.

| Measure | Before | After |
|---|---:|---:|
| Direct automatic passes / 2,375 | 1,953 | 1,978 (83.28%) |
| Complete programs on 449 prior rejects | 87 | 108 |
| Retained combined development pool | 1,953 | 1,963 (82.65%) |
| Remaining excluded claims | 422 | 412 |

Automatic passes and retained-pool counts have different members and requirements.
Neither is independent semantic accuracy. All 25 changed complete programs were
inspected by the compiler author; 12 are retained, including two replacements of
already accepted splits. Ten additions result. Another 83 programs and logical
forms are identical and reuse their earlier judgments. Most of the earlier retained
pool was not re-reviewed. The full review is hash-bound in semantic_review.json.
The current All claims viewer shows the updated pool; the historical viewer JSONs
and source archives remain unchanged.

Duplicate auxiliary removal requires an existing lexical-head SRL frame and an
actual UD auxiliary dependency. Genuine copulas and auxiliaries without a body
frame remain. That ablation yields 1,960 direct automatic passes. The final condition
adds missed dependency-attached adverbs as explicit bound conditions, not ignored
words. Logical/focus/frequency/uncertainty words are excluded from that repair.
Lexical/phrasal interpretation still depends on the evidence function; retaining a
modifier does not establish its learned semantics.

The interval resolver requires an existing event and exactly one explicit parent
interval. It puts the typed range on that same event. A same-day end date may be
inherited; reversed endpoints, incompatible time scales, and ambiguous overnight
rollover are refused. A trailing timezone label scopes the interval without guessed
offsets. This repairs a real mixed-date/clock comparison bug. A whole prepositional
phrase stored as an SRL entity is replaced when an explicit phrase relation supplies
its target. The terrain claim still fails as a whole: its rewritten shifts clauses
have no event frame. No event is invented to make the interval example pass.

## Nominal-event experiment, excluded from the final condition

The compiler can represent a nominal event with an event variable, an event_type
predicate, and its original nominal argument links. In the authored collapse
example, the same collapse variable is the subject of block; of links the bridge.
No unlicensed PropBank agent/theme role is invented. Planned/prevented events are
not promoted to actual events in the tested contrasts. Two native inference tests
check the nominal event and block binding using constructed observations.

However, WordNet event/action senses misclassify electoral riding and camera shot.
Nominal typing is therefore opt-in and OFF by default. These examples are failure
evidence, not corpus gains. This is not a trained nominal SRL parser. NomBank
(https://nlp.cs.nyu.edu/meyers/NomBank.html) treats nominal predicates and their
arguments explicitly; a lexical heuristic does not replace those annotations or
word-sense disambiguation. Eleven authored construction checks are development
diagnostics, not independent held-out data.

## Remaining bottlenecks

The 412 exclusions stop at component compilation (179), alignment (148), failed
meaning review (68), composition (13), model refusal (1), or absent cached rewrite
for newly flagged legacy passes (3). Alignment includes 126 absent/ambiguous noun
heads. These are first stopping stages, not exhaustive linguistic diagnoses.
Remaining defects include unshared pronouns/reflexives, quantifiers represented as
ordinary modifiers, wrong clause/time/source scope, and inaccurate SRL roles.
The full ledger retains text, reason and diagnostic output for every exclusion.

A new concise prompt was drafted, but not run. H100 job1227635 and 80GB A100
job1227636 were both cancelled while pending. Slurm estimated the latter would
start on 13 November at15:17. New model requests=0; media inference=0. The proposed
prompt is saved as proposed_prompt.json and explicitly marked untested. Current
results use the previous single fixed prompt and cached responses.

## Native frozen-feature training check

The optional DirectVerifier interface now accepts a classifier and feature source.
The default six-score calibrator remains unchanged for historical experiments.
The new classifier receives 4,096-dimensional cached frozen Qwen3-VL-8B states
conditioned on the proposition and frames, not answer probabilities or labels.
Architecture: LayerNorm(4096), Linear(4096,64), GELU, Linear(64,3), softmax;
270,595 trainable parameters. Only the small classifier is updated by the native
DeepProbLog/PyTorch training loop, with claim-level labels.

Four assistant-inspected color clauses from development clip zlD_zgNiYJkRV1PS
are deliberately fitted for 30 CPU epochs. The exact losses, times, predictions,
versions and gradients are in feature_training_smoke.json. Features are detached;
source cache and original eligibility-file hashes stay unchanged. All four final
labels fit; this is an API/gradient check, not generalization or calibration.
Entity identities, school-bus descriptions, candidate coverage and reference time
are stipulated; evidence alignment is not learned. Audio-dependent labels remain
excluded. The original pilot remains ineligible for empirical training.

An initial smoke fixture mistakenly reused candidate IDs and allowed non-color
properties to share whole-clause features. It was corrected to use distinct actual
referents and only color relations, with a collision guard and exactly four neural
observations. Early outputs are preserved under development/ and excluded from the
reported result. This was a fixture error, not an empirical feature comparison.

## Validation and reproduction

411 tests pass; all 2,375 historical default outputs remain JSON-identical.
The compiler checks run on CPU; census time excludes upstream parsing/model loading
and is not native inference runtime for the full corpus.

From the project root:

```bash
envs/probabilistic-verification/bin/python scripts/run_compiler_readiness.py corpus
envs/probabilistic-verification/bin/python scripts/run_compiler_readiness.py cached
envs/probabilistic-verification/bin/python scripts/analyze_compiler_readiness.py
envs/probabilistic-verification/bin/python scripts/run_feature_training_smoke.py
PYTHONPATH=scripts envs/probabilistic-verification/bin/python -m pytest tests -q
```

Use the new source archive as the final overlay after earlier source archives for
the complete historical test suite. It also includes the specific prior inputs,
programs, judgments, cached parses and visual feature tensors needed to replay this
experiment. No model request or new media extraction is needed for replay. Models
and installed environments are not bundled. Historical archives must not be rebuilt.

## Proposed next steps and goals

1. Freeze the current condition and select a small, source-disjoint training/evaluation
   set. Review complete logical forms and intended visual/audio/speech/OCR support;
   a retained compilation is not a media label or automatic training eligibility.
2. Create checked binding edits and cache corresponding frozen features. Preserve
   which evidence source changes the label; human listening must check audio labels.
3. Train small relation classifiers and compare with frozen-model and simple
   aggregation baselines on held-out videos. Measure runtime and binding performance;
   reopen compiler work only for a concrete blocker in that experiment.
