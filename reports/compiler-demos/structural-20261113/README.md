# Partial parses, structural correction and neural alternatives

Completed on 13 November 2026. Compiler correctness remains the priority; ADR-023 is unchanged. No SRL model was retrained, no new media inference ran, and no empirical media-relation training was started.

## Results and interpretation

Fresh compilation of all 2,375 originals and replay of all 449 cached cases are byte-identical to the previous release: 1,983 automatic direct passes and 114 complete cached programs. The retained development pool remains **1,981/2,375 (83.41%)**, with **394 excluded**. Every previously retained program remains unchanged. Most old passes have not been fully re-reviewed; none of these numbers is independent semantic accuracy or training eligibility.

Of the 394 exclusions, 367 fail the strict original compiler and 27 pass automatic direct checks but failed earlier meaning review. The latter receive no new model request. Among the strict failures, 149 already have a failed logical form and 218 lack one. The new collector recovers unfinished structure for **189 of those 218**, leaving 29 without a usable form. These are partial drafts, not accepted programs.

A fixed 40-case development diagnostic contains 20 existing drafts and 20 newly captured partial drafts. Eight named motivating failures are included where available; the remaining selection is deterministic round-robin over original error codes within each group. Selection is saved before model outputs. It is not a random or held-out accuracy sample.

| Fixed condition | Shared first programs | Final generic programs | Final feedback programs | Newly retained meanings |
|---|---:|---:|---:|---:|
| Permissive literal schema, development trial | 4 | 6 | 8 | 0 |
| Strict literal types and structural edits | 5 | 5 | 7 | 0 |

All 13 unique complete program/form pairs across both trials were inspected by the compiler author. The robot-slams-into-man example is close to the intended reading, but is withheld because `during race` is compiled as a location adjunct instead of a temporal condition. Other programs misplace source scope, assert goals, flatten disjunctions or introduce incorrect bindings. The strict feedback branch alone is the primary condition; neither a control nor a development program is selected per claim. The negative result does not support expanding this correction method to all 338 eligible drafts.

## Implementation

`partial_parse.py` uses an opt-in context-local collector. Small hooks in `srl_graph.py` retain actual participants, event state and source attachment links before an exception. Completed fragments and unfinished fragments remain distinguishable. Embedded fragments are not independently asserted. Ordinary compilation retains the original outputs and refusal policy, as checked on the full corpus. A partial form always requires an explicit model correction and whole-program review.

`structural_edits.py` extends typed JSON Patch with replacement of an existing logical subtree, including the root. At most four edits are allowed. The whole entity list is not replaced. This bound can limit complex repairs; it is an experiment setting, not a claim that four edits suffice for arbitrary sentences.

The source checks require shared participants in infinitival purposes when SRL and dependency information agree. A dependency-only subject is advisory; parser annotations are not treated as gold. Numeric-modifier relationships cannot target an unrelated object referent. These checks are bounded, not general semantic-equivalence tests. The clause-as-text check still misses some copular or locative constructions, as visible in the color-fills example; no correctness guarantee is claimed.

The first trial exposed a schema problem: measurement fields were allowed on ordinary text literals. The strict condition uses separate literal types and standard PropBank/UD argument roles, and rejects some clauses hidden as text. This removes malformed type combinations, not all wrong meanings. Optional variable-type resolution handles both node operators and literal kinds. The trials differ in their checker/decoder schema; they are not a causal prompt-only comparison.

Both new retry branches explicitly retain the original compiler error on every request. The feedback branch additionally receives diagnostics for the latest proposed structure; the generic branch gets a failure notice. Each trial shares exactly one first attempt across its controls, allows two retries, and stops at first automatic success or refusal. Meaning review never triggers another request.

**Correction to the preceding typed-edit report:** its saved generic retry messages did not explicitly include the original direct-compiler error, despite the earlier description. Its saved outputs and numerical results are unchanged. The new comparison corrects this control input. Historical source ZIPs remain immutable.

## Models and resources

Both structural trials use frozen, text-only Qwen3-30B-A3B-Instruct-2507 with vLLM/xgrammar, float16, greedy decoding, 2,048 output tokens and batches of four. All requests validate on CPU before model loading. There are 180 unique compiler requests in the development trial and 179 in the strict trial. The common first attempt is counted once within each trial.

Jobs 1230471 and 1230713 completed on one H100 each, sequentially: 8m05s and 5m15s. The strict job also ran the separate 63-program neural meaning diagnostic. Total local requests: 359 compiler requests plus 63 classifier requests = 422. No GPU remains allocated. The eight-GPU user limit was respected; peak use in this work was one.

## Frozen neural meaning diagnostic

The same frozen text model checks the preceding experiment's 63 complete programs, using only the sentence, final logical form and semantic compiler metadata. Author review labels are kept outside the model messages. It accepts ten programs: six agree with retained author judgments and four do not. It rejects three retained examples and fifty rejected examples. This gives 60.0% precision and 66.7% recall **relative to author development judgments**, not independent semantic accuracy.

The always-reject comparison has no false approvals and misses all nine retained examples. Some neural disagreements concern subtle or unresolved interpretations. A clear false approval is the Congress example: the program omits laws as the object of pass and makes laws the agent of delegate, yet the neural checker claims the roles are correct. This is not reliable enough for automatic promotion. No confidence model was trained and no parse posterior was calibrated.

## Neural and probabilistic alternatives

Seventeen primary works were verified and eleven candidate approaches are recorded in `research/compiler_alternatives_20261113/`. This is a local assessment. Automatic approval rejected sending unpublished artifacts/results to an external GPT-5.5 reviewer; that review did not run, and no external scores or independent ranking were invented.

The most concrete next frontend comparison is one frozen neural semantic parser with a compositional converter. The existing cached BART AMR gives the wind-speed causer and the Sheinbaum attribution. It also makes mistakes: a separate sweep relationship in the robot case and portable as a participant of charge in the charger case. Those four selected examples do not establish corpus accuracy. No new AMR inference or checkpoint download ran. Established AMR-to-FOL semantics provide a more principled foundation than noun-head matching, while source fidelity and scope still need evaluation.

A small source-conditioned neural ranker is plausible after collecting checked positive/negative meanings. Its inputs would be the sentence and candidate graph, unlike the paper's separate media relation classifier, which uses frozen visual/audio features. Current development labels are not enough for a credible video-disjoint generalization result. Arbitrary claim IDs should be removed in any learned confidence model.

Native DeepProbLog checks implement a categorical choice over logical forms with supplied weights. In the telescope example, weights 0.6/0.4 and support values 0.9/0.1 give support 0.58. OR over observations gives 0.91 and asks a different, weaker question. A second example retains parser-abstention mass separately from insufficient media evidence; an all-unparsed case is tested. Shared observations are declared only once. All probabilities are stipulated engineering inputs: there is no learned semantic parser or empirical calibration result.

Probabilistic semantic parsing is established by P3 and related work. Recursive semantic parsing plus deterministic compilation is established by NL2Logic. These frontend choices alone are not our paper novelty; the accepted direction still requires evidence on typed multimodal support, media-conditioned binding learning and shared evidence inference.

## Validation and replay

484 tests pass, including real parser-failure preservation, source immutability, shared-subject positive/negative contrasts, typed literal/role constraints, label exclusion from neural inputs, and native DeepProbLog mixture tests. The full 2,375/449 original/cached outputs are unchanged.

The new ZIP is a source/data overlay. It contains current source, generation-time snapshots for both trials, exact prompts, raw responses, errors, review hashes and cached replay inputs; model checkpoints are excluded. Full historical report builds/tests also need older fixtures from the preserved source bundles. The complete suite was run in the project workspace.

In a clean extraction using the existing project Python environment, cached replay requires no GPU:

```sh
PYTHONPATH=scripts python scripts/replay_structural_corpus.py
PYTHONPATH=scripts python scripts/replay_partial_capture.py
PYTHONPATH=scripts python scripts/replay_structural_outputs.py --condition development
PYTHONPATH=scripts python scripts/replay_structural_outputs.py --condition strict
PYTHONPATH=scripts python scripts/run_parse_mixture_examples.py
PYTHONPATH=scripts python scripts/analyze_structural_compiler.py
```

The output replay uses each trial's frozen generation-time checker in a fresh process. Model generation is not claimed to be reproduced by cached CPU replay. The archive checker verifies inventories and exact artifacts. The web report preserves earlier inspectors/URLs, all 30 historical ZIPs and the original 26 viewer files.

## Proposed next steps and intended goals

1. Create a small varied reference set of roles, source scope, alternatives and time. Goal: evaluate actual meaning and resolve near-correct cases without using executability as the label.
2. Compare a fixed AMR-to-logic frontend on the same claims. Goal: reuse neural semantic links with principled composition, without selecting different frontends per sentence.
3. Measure candidate coverage and source-conditioned confidence. Goal: establish whether a small learned ranker and calibrated parse mixture can improve reliability before media-relation training.
