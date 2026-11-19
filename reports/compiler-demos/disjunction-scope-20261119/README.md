# Exclusion, shared conditions, and reported OR

The fixed compiler now produces programs for all twelve authored OR claims. Manual review against the same frozen source readings finds ten full matches and two partial readings. Previously four matched, three were partial, one was incorrect and four had no program. This is a paired development evaluation used to diagnose and repair these constructions.

| Evaluation | Full match | Partial | Incorrect | No program |
| --- | ---: | ---: | ---: | ---: |
| Before | 4 | 3 | 1 | 4 |
| After | 10 | 2 | 0 | 0 |

## Explicit exclusion

A source check detects “exactly one of” and “but not both” outside quotations. The compiler handles an explicit pair of descriptions in a simple copular claim, such as front and rear doors that were open. The two entity candidates must be distinct. They share one reference time. A final “but not both” is compiled when the remaining sentence yields one supported two-way OR. The same hiker and reference time apply to both vehicle descriptions. The two colors in the lamp example use the same lamp and the same flash.

The formula requires at least one supported alternative and excludes the case where both are supported. When one alternative is supported and the other is unknown, the verdict is unknown. The source check refuses a detected exclusive form when this conversion cannot establish the intended scope. The inclusive door control still supports both doors being open.

## Shared conditions

The AMR repair preserves a time attached to a coordination by applying the same time to both events. For the red vehicle, an appositive choice such as “either a truck or a van” uses the vehicle's own variable. For “Some people crouch or sit on the ground for stability,” the shared purpose attaches to the coordination and uses the same people as the crouching and sitting branches. This is the one new program in the corpus rerun.

The rewrite compiler accepts two coordinated complement clauses plus a shared relative clause when the original dependency parse explicitly anchors the relative clause to a shared argument. The new manually written control uses one attempt to walk or stand near a truck that blocked the path. Stanza and BERT-SRL parsed the source and the rewritten sentences on CPU. The combined form uses one attempt and one truck candidate. Exact inference rejects evidence that the hikers were near one truck and a different truck blocked the path. A negative rewrite making the hikers the subject of “blocked” is refused. The controlled test forces both direct parsers to refuse so the fallback runs.

The original strong-wind rewrite still fails the source attachment check. The saved source dependencies attach “carrying” to walking and do not link the predicate to the wind. The rewrite would change that attachment, so it remains an abstention.

## Reported alternatives

A report containing OR now needs a speech condition that checks the utterance expresses the entire disjunction. The compiler preserves the parsed alternatives and scope in its trace. The emitted predicate consumes the reported content as a whole, bound to the reporting event. Ordinary OR between two separate reports still applies to the report events.

Exact inference on the guide's compiled report supports a supplied observation that the utterance expresses the full OR, refutes it when a complete utterance establishes a single assertion, and returns unknown when the transcript is incomplete. Visual observations alone leave the speech condition unknown. The observations in these tests are stipulated. A transcript-based evidence function still needs evaluation. For the remaining two partial cases, the selected SRL form does not explicitly resolve “it” to the clinic, and the AMR form for a separate report lacks a past gate-state condition.

## Corpus comparison and validation

Reran all 2,375 original inputs under the same SRL, AMR, and failure-only rewrite order, including the five cached responses from the latest Qwen run. The fixed sequence passes 2,179 checks, up from 2,178. All 2,178 earlier programs are byte-identical. The new pass comes through AMR before rewriting. Four of the five earlier rewrite cases still abstain. The fifth is the recovered purpose case. No new Qwen calls were made.

All 26 exact inference controls on compiled forms pass. The full project suite passes 672 tests. These tests use constructed observations and existing parser outputs plus the three CPU-parsed shared-condition control records.

## Proposed next work

- Test the report predicate on speaker-aligned transcript excerpts. Goal is to measure whether it recognizes all the alternatives, including paraphrases and partial transcripts.
- Expand the evaluation with new sources and resolve the remaining attachment and reference cases. Goal is to measure how often the fixes carry over to unseen claims.
- Specify feature selection once per contrast pair and reserve source-disjoint training data. Goal is to keep feature and training design separate from the current compiler benchmark.

## Replay

From the extracted source archive with the project Python environment and WordNet data, run:

```sh
export PYTHONHASHSEED=0
export PYTHONPATH=scripts:tests
python scripts/run_compiler_fallback.py \
  --output exp/probabilistic_verification/disjunction_scope_20261119 \
  --rewrite-overrides exp/probabilistic_verification/disjunction_evaluation_20261119/rewrite/parsed.jsonl
python scripts/evaluate_disjunction_scope.py benchmark
python scripts/evaluate_disjunction_scope.py native
python scripts/evaluate_disjunction_scope.py compare
python scripts/disjunction_scope_report.py
python -m pytest -q tests/test_disjunction_scope.py
```

The replay manifest lists the five exact output digests.
