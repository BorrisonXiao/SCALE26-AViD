# Compiler revision and evaluation — 30 October 2026

This opt-in revision keeps one compilation path over unchanged claims. It uses
cached pretrained SRL/dependency annotations, explicit recovery rules, the existing
scoped compiler and an equivalent DeepProbLog rule encoding. It does not use an
LLM to generate or select logical forms, rewrite sentences, verify media or train
relation models. The separate frozen-model call is evaluation only.

## Implemented changes

- A definite event noun with exactly one earlier matching event can share that
  event's candidate variable. In the image example, “the damage” and the depicted
  damaged event now refer to the same event. The compiler removes the old separate
  nominal quantifier and binds the shared variable at its common logical ancestor.
  This is a narrow within-sentence reference rule, not general event coreference.
- Bare common-noun predication with adjective modifiers, such as “tariffs are bad
  economic policy,” can share the subject reference inside the assertion. Definite,
  proper-name, numeric, prepositional and negated bare complements are not merged
  by this new rule. The older a/an predication rules remain unchanged.
- Duration arguments emit an explicit `duration` predicate carrying the bound,
  number, unit and total/remaining interpretation. “Over a year” means more than
  one year; “about four more days” retains approximation and remaining duration.
  The optional fixed function requires a declared approximation tolerance and
  returns unknown for unsupported calendar-unit conversions or mismatched reference
  types. No duration is estimated from real media here.
- Missing frames can be recovered from explicit dependency participants. Recovered
  roles retain grammatical labels such as `nsubj` and `obj`; they are not guessed
  PropBank ARG0/ARG1 labels. A verbal conjunct can share an explicit subject. The
  current recovery declines nominal OR groups rather than turn OR into AND.
- Resource-subject “help study” cases no longer copy imagery into the implicit
  person studying. That actor stays unspecified, with an explicit context
  requirement. Existing arbitrary SRL mistakes are not generally repaired.
- The new serializer uses rules with explicit output states rather than a variable
  state-table join at every expression node. The three-state truth tables and
  categorical observation IDs are unchanged. Overlapping proofs are still combined
  by exact ProbLog/DeepProbLog inference. Distinct observation errors are not thereby
  modeled as correlated. Fixed probabilities and neural predicates are both kept;
  no numerical probability pruning is introduced.

## Measured results

Run: `exp/probabilistic_verification/compiler_followup_20261030/`.

- Full census: prior 2,042 compiled, revised **2,108** (1,934 claims and 174 nominal
  descriptions); **267 refused**. All prior accepted inputs remain accepted; 66 more
  compile. Acceptance does not establish correct meaning.
- Previously reviewed 44 development cases: prior 21 faithful /12 partial /3 incorrect
  /8 refused; revised 24 /10 /2 /8. Existing judgments are reused only for exactly
  unchanged compiled structures; the five changed outputs were inspected again.
- New-source 20: prior 11 /5 /2 /2; revised 12 /4 /2 /2. Two faithful outputs are nominal
  descriptions, not complete propositions. Sample IDs were reserved before changes,
  one per source video, excluding 86 sources in saved earlier reviews/pilots. The
  source identity is the actual `source_videos` field, not the claim-ID prefix.
  All 2,375 texts were already processed earlier; this is not a fully held-out corpus.
- Targeted post-freeze sample of 10 newly accepted claims:2 faithful /7 partial /1
  incorrect. It excludes the reserved 20 and measures a selected acceptance slice.
  Missing times, parenthetical detail, shared references, obligation and idioms
  remain important. Do not infer the semantic correctness of all 66 additions.
-167 tests pass. Three probabilistic checks match exhaustive categorical-world
  calculations with repeated observations; a neural-gradient comparison matches
  the previous backend. Four native identity/duration examples also match an
  independent logical calculation.
- In the three fixed backend checks, the old image/damage case times out after 35
  seconds including setup. The new encoding completes all three. New image/damage
  inference is 0.135 seconds, total subprocess 8.62 seconds. This is a small point-mass
  comparison, not a whole-corpus throughput or training benchmark. Stage logs retain
  loading, grounding, compilation and evaluation separately.
- The full cached compilation loop takes 24.4 seconds on CPU, excluding upstream
  parser inference/loading. Compiler outputs are frozen before the new-source review.
  The separate frozen Qwen review uses anonymous randomized A/B order, no assistant
  labels and the same original text. Its ratings and disagreements are separate
  artifacts, not replacement gold labels. GPU accounting includes failed attempts.

## Reproduction

The entry points are `compile_followup(record)` and `DirectVerifier`. Previous
functions and nine published source archives remain unchanged.

```bash
PYTHONPATH=scripts python scripts/replay_compiler_followup.py
PYTHONPATH=scripts python -m pytest tests/test_compilation_followup.py tests/test_semantic_srl.py tests/test_srl_graph.py tests/test_logical_form_v2.py tests/test_logical_form.py tests/test_predicate_compilation.py tests/test_semantic_compiler.py tests/test_multimodal_verification.py tests/test_probabilistic_verification.py -q
PYTHONPATH=scripts python scripts/check_followup_bindings.py
```

Install `requirements-compilation.txt`, `requirements-verification.txt` and NLTK
WordNet. Cached replay needs no GPU or model checkpoint. Native probabilistic checks
are part of the tests; model-review regeneration requires the named local checkpoint
and GPUs. The report source archive includes exact requests and outputs, original
claims, all per-claim compiled outcomes, sample/freeze manifests and manual ratings.
Model weights and media are excluded.

The separate model rates 18 prior outputs faithful and 17 revised, versus assistant 11
and 12. It agrees on 24/40 condition judgments, misses the quoted-label and footage
scope errors, claims an absent threshold is preserved, and misclassifies one
refused input in both conditions. These raw labels remain separate; they do not
confirm the assistant’s small gain or provide gold annotations.


## Proposed next steps and intended goals

1. Fix nominal media descriptions and quoted labels — stop footage descriptions
   becoming world events and label words becoming predicates.
2. Define refusal conditions or explicit constraints for thresholds, nominal OR,
   omitted modifiers and shared times — reduce apparently valid but partial graphs.
3. Obtain human reference judgments for a bounded new-source sample, including
   model/assistant disagreements — test whether the review criteria are reliable.

Keep the compiler experimental. These proposals are not implemented in this run.
Media verification and training remain deferred; ADR-023 is unchanged and sentence
rewriting remains unimplemented.
