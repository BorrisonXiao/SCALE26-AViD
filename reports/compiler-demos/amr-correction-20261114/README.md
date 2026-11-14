# Source checks, bounded AMR edits and native inference

Completed 14 November 2026. ADR-023 and compiler priority remain unchanged. No GPT/model judge, media prediction, SRL retraining or empirical relation training. Meaning/failure inspection is by the implementing assistant.

## Conclusions

Native DeepProbLog inference now works on the tested programs. Grouping Boolean outcomes belonging to the same categorical observation reduces the refined19-condition wind program from a12-second process limit to about 0.04 seconds for the first solve. Program probabilities and sharing are unchanged. This is an implementation improvement using standard variable ordering, not the paper contribution.

The bounded graph-edit experiment does not recover claims. One frozen Qwen model makes205 requests on 41 failed AMRs with a shared first attempt, then two compiler-feedback or generic retries. Both branches produce zero new automatic passes. A separate paired12-case input-format pilot makes48 requests; explicit triple indices reduce duplicate errors but still yield zero passes. Ignoring identical duplicate triples in the 205 cached responses also yields zero passes. This evidence does not support scaling this particular edit loop. It does not establish that all LLM semantic correction is impossible.

The existing retained pool remains1,981/2,375(83.41%),394excluded, with zero promotions. Training remains deferred.

## Full corpus rerun

All 2,375 originals use one cached amrlib BART-large AMR frontend and the same source-preserving converter.1,589 graphs convert, unchanged. Every emitted program is byte-identical to the preceding refined compiler.1,397 pass the combined source/semantic checks, versus 1,406 passing the previous source-only checks. Nine additional candidates are flagged; these are review requests, not nine proven semantic errors or newly repaired meanings.

New checks cover source-linked adjective arguments, result-state agency, content treated as physically located at media, media-boundary attachment and multiple time values on a date node. An initial blanket adjective check added25 alerts, including standard AMR degree/role structures. Before model generation it was restricted to event predicates lexically linked to the source noun, using WordNet derivational links and declared predicate-value roles. Its failed preflight is preserved separately. No model outputs informed that adjustment.

The final converted-graph issue counts are5adjective-argument alerts,2media-location alerts,2time-cardinality alerts,1media-time attachment and 1result-state agency; categories overlap with previous source flags. Unhandled complements remain631 of 786 conversion refusals. The nine additional source-pass alerts do not imply a corpus semantic-accuracy estimate. Source checks can also be overstrict on legitimate name expansion or unit normalization.

## Fixed correction comparison

Seventy cases were fixed:46 known AMR-development cases whose original strict direct compilation fails, plus 24 additional original claims. The 24 were selected by a fixed hash, excluding the earlier92AMR-reviewed cases; their original-text readings were frozen before new checks/model outputs. Their videos and cached parser results were processed earlier in the project. This is a fixed development diagnostic, not a new-source or independently annotated test.

All 70 original strict direct compilations fail.29checked AMRs already pass and skip model generation;41fail and are eligible. The 29existing programs reuse byte-identical prior assistant reviews:9 whole-reading matches,10 partial,7 incorrect,3 context-needed. This deliberately difficult cohort is not representative of corpus accuracy. Automatic passes are not newly approved training data.

The model is frozen Qwen3-30B-A3B-Instruct-2507, text only, vLLM0.18.0/XGrammar, float16, tensor parallel2, greedy temperature0/seed0, maximum 1,536output tokens, batch4, maximum 8triple edits. The original claim and dependency links accompany the current normalized AMR, original direct error and initial AMR errors. No reference reading, truth label, review judgment, claim ID or hard-coded format-version field enters messages. All prompts remain in scripts/prompts_phase2.py. No sentence rewriting, parser ensemble or per-claim selection.

Replace/remove operations refer to zero-based supplied triple indices; add supplies a triple, and the root can change. Roles, nodes, graph connectivity, source checks and scope-head preservation are validated. Coverage is always compared with the initial graph, so a retry cannot progressively erase a source word or scope head. These checks do not certify semantics.

First attempt41 requests gives0 new passes. Each feedback/generic branch permits two retries and retains original errors. All 205actual requests are saved; feedback and generic each end with 0 new passes. The 29 before-model passes remain the only automatic passes in all 70. Meaning labels never trigger a request or retry; original automatic direct passes bypass the model entirely. Separate processes block LLM imports and verify both passing routes make no requests.

Of205 attempts,135 have duplicate declaration/triple errors and 15 have empty undeclared targets. Other outputs retain unsupported complements, change names or preserve source errors. The model often copies existing triples or uses the wrong index rather than making targeted semantic changes. All 24 follow-up final graphs and proposed edits were inspected in failure_audit.json. There are no newly complete programs to approve; old reviews are reused only under exact program hashes.

## Input-format and duplicate diagnostics

A separate paired pilot selects the first 12 eligible known development failures, with no follow-up expansion. It uses the same frozen model, system prompt and numerical settings. Only the user message's graph changes: implicit triple-array positions versus explicit index/triple objects. Each gets one first attempt and one feedback retry,48 requests total. After the retry, duplicate errors decrease from 7/12 to3/12; both conditions still produce0/12 passes. All 48messages/results replay exactly. The primary205request comparison is unchanged; pilot attempts are not pooled into its results.

A CPU-only diagnostic applies set semantics to identical duplicate triples in all 205saved primary attempts, while still refusing conflicting declarations, dangling nodes and source loss. It produces zero automatic passes. Its feedback would have differed had it been used during generation, so this is not a counterfactual rerun of the retry loop. No model was called for this diagnostic.

## What the failed examples show

- Sound of fireworks exploding fails at sound-01 ARG1 explode-01. This is a basic audio-source scope construction, not a complicated sentence requiring arbitrary rewriting.
- Closer footage fails because close-10 is treated as an embedded event rather than a property; nominal shaking/flight also need better source alignment and typing.
- Goal-of-operation and missing-person questions require purpose/question scope. Copying the same event arguments cannot make unsupported structures representable.
- Phillies remains Phillipines in a birthday fragment. Haboob becomes the invented car name Hambob. These are actual lexical errors, distinct from compiler refusals.
- A full-name expansion of SCOTUS is plausible and can be overrejected by literal-name matching. Multiple one-second units can legitimately represent unspecified seconds. Do not call every source flag a hallucination.
- Political seats become seated people, and reported/projection contexts are lost. Preserving digits alone does not preserve party/count/role bindings.

The current result argues for improving shared semantic types, source scopes and normalization checks, rather than adding more retries or claiming that valid JSON establishes a faithful logical form.

## Inference implementation and tests

ordered_circuit.py groups each annotated-disjunction observation's outcomes before SDD compilation. It preserves probabilities, constraint groups, fact sharing, query/evidence labels and the standard DeepProbLog evaluator. DirectVerifier accepts an optional solver class; defaults and previous emitted programs remain unchanged. This adapter declares support for the categorical-constraint fragment, not arbitrary extra ProbLog constraints.

Same-program CPU controls use two PyTorch threads, Python hash seed0 and fresh processes with 12 seconds including imports. The refined19-observation wind example completes around 0.043 seconds unknown/mixed and 0.077 seconds with a constructed neural-gradient check; original ordering reaches the limit. A two-candidate-per-entity wind example has32 observations and finishes around 0.263 seconds.32/64independent-observation conjunctions finish around 0.064/0.133 seconds and match analytic probabilities. These are single-run diagnostics with placeholder evidence, not broad throughput or media accuracy.

564 tests pass in the project workspace. New checks cover source/graph disagreement contrasts, valid property-valued roles, exact shared-world probabilities, AND/OR/NOT/evidence composition,64-observation small-probability mass, matching nonzero gradients and cached reevaluation after a parameter change. Constructed score-calibrator tests verify the gradient path; they do not implement or train the paper's media-conditioned classifier. Fresh default AMR2,375, original2,375 and cached rewrite449 outputs reproduce exactly.

## Resources and reproduction

Pending A1001233864 and H1001233911 requests were cancelled before allocation. The final model uses2A100-40GB GPUs. Job1233928times out after 921 seconds with 77 responses saved; job1233981completes the remaining requests in500 seconds. All 77earlier response rows are hash-preserved and not regenerated. The input-format pilot1234040completes in166 seconds. Total allocation is3,174GPU-seconds,0.8817GPU-hours, peak2GPUs; all released. A shutdown message after pilot completion is retained in logs; all 48pilot outputs exist, replay exactly and the scheduler records completion.

The source ZIP is an overlay, not model weights or a complete historical environment. Cached reproduction needs the project Python environment, including installed WordNet data, but no network/GPU/model:

```sh
PYTHONPATH=scripts python scripts/run_amr_checked_corpus.py
PYTHONPATH=scripts python scripts/replay_amr_correction.py
PYTHONPATH=scripts python scripts/analyze_amr_correction.py
PYTHONPATH=scripts python scripts/diagnose_duplicate_amr_edits.py
PYTHONPATH=scripts python scripts/replay_numbered_amr.py
PYTHONPATH=scripts python scripts/replay_amr_correction_legacy.py
```

The current source, frozen primary snapshot, references, raw requests/responses, excluded preflight, primary and pilot outputs, native diagnostics and tests are included. Do not regenerate frozen reference readings/selection. All 33older ZIPs and 26 original viewer files stay byte-identical; the report retains five views and two Reports cards. See check_amr_correction_archive.py for clean extraction replay. Full564 tests were run in the workspace;26focused new tests also run from the extraction.

Sources: [WordNet](https://wordnet.princeton.edu/), [official PropBank frames](https://github.com/propbank/propbank-frames/tree/main/frames), including [tint's predicative color role](https://raw.githubusercontent.com/propbank/propbank-frames/main/frames/tint.xml), and [DeepProbLog](https://github.com/ML-KULeuven/deepproblog). This implementation work does not replace the paper's accepted methods direction.

## Proposed next steps and goals

1. Fix predicate typing and source scopes. Goal: distinguish nominal events and adjective properties from embedded clauses, and cover ordinary audio/source constructions without inventing world assertions.
2. Correct overstrict normalization checks. Goal: accept verified name aliases and unit representations while still rejecting changed names, amounts and bindings.
3. Rerun the fixed references and all 2,375 claims under one chosen compiler. Goal: measure faithful changes before more generation or media-conditioned relation training. Do not scale the current graph-edit loop.
