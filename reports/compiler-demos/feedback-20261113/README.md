# Compiler feedback and typed field edits — 13 November 2026

Compiler correctness remains the priority. This work changes the text-to-logic path only. No SRL retraining, media inference or empirical relation learning ran. The directory is `compiler_feedback_20261112` because work began on 12 November.

## Completed results

All 2,375 originals and all 449 cached fallback cases were rerun. The direct and cached files are byte-identical to the previous compiler-repairs run: 1,983 automatic direct passes and 114 complete cached programs. These counts differ from retained development compilations, which exclude known meaning errors.

Of the previous 403 exclusions, 376 fail strict direct compilation. All 158 with a saved draft were tested with one fixed field-edit method. The other 218 have no draft to edit. Among the 218 no-draft cases, direct errors include 96 unattached clauses, 33 duplicate roles, 33 missing predicates and ten missing-SRL records. The conversion often stops early despite useful annotations; a missing saved draft is not synonymous with total SRL failure. The remaining 27 exclusions pass direct checks but failed earlier meaning review: they receive no model request, preserving the failure-only policy.

| Fixed condition on the same 158 claims | Before model | Shared first attempt | After up to two retries | Retained meanings |
|---|---:|---:|---:|---:|
| Typed edits + generic retry | 2 | 41 | 46 | 8 |
| Typed edits + compiler feedback | 2 | 41 | 61 | 9 |

The first attempt has five retained meanings. Neither before-model pass is retained. Feedback adds 15 automatic passes over generic retries but only one additional retained claim. This is development evidence, not held-out accuracy or a statistically established effect.

The compiler author inspected all 63 unique complete final program/form pairs; identical judgments are reused by hash. Only the feedback branch updates the corpus: **1,981/2,375 retained (83.41%), 394 excluded**. All 1,972 earlier retained programs remain exactly unchanged. They were not all re-reviewed. The nine additions include one context-dependent mention, “Beijing recently.” Its standalone-mention requirement remains; it is not a complete event claim or automatically suitable for training.

Within the feedback cohort, 97 fail compilation and 52 produce a complete program rejected after meaning review. Untested exclusions retain their older stopping reason, so the remaining-case ledger is a mixed development record rather than a fresh linguistic error census.

## Method and design

The frozen Qwen3-30B-A3B-Instruct-2507 receives the original claim, dependency parse, SRL frames and failed logical form. The original sentence controls meaning; annotations can be wrong. No AMR or model-selection ensemble is used in this final condition. The prompt includes a compact field guide and short modifier-edit examples; there is no hard-coded representation version in the model input.

The output is a subset of standard JSON Patch: add, replace and remove. At most eight operations are allowed. Paths come from the existing draft; values are derived from the existing logical-form schema. A property requires a role/value object, an argument requires a declared reference or typed literal, and a proposition requires its supported scope/body structure. Required fields cannot be removed. The entire formula, entity list and node kind cannot be replaced wholesale. Edits are validated and applied atomically. The version marker is supplied by code.

The adapter validates reference declarations, source-specific vocabulary, typed values, scope, content coverage and native ProbLog compilation. Detailed feedback points to JSON fields and relevant source grammar links, including unused declarations and omitted content. A canonical date is credited only when one unique explicit source date matches its normalized value. Bounded checks detect several subject, purpose, quotation, literal and predicate-anchor errors; they do not establish equivalence.

Both branches share exactly the same first responses. Correction recorded on13November: the saved typed-edit generic retry messages do not explicitly include the original direct error; only the new structural comparison retains that error in every branch input. Only after an automatic failure does the feedback branch see diagnostics from the latest model output; the generic branch receives a failure notice. Both allow two retries, stop at first automatic success/refusal, and retain the original claim and parser input. Meaning review never causes a retry. There is no best-of-prompts or cross-branch selection, and generic outputs are not pooled into the corpus.

Final generation uses vLLM 0.18.0 with xgrammar constraints, float16, greedy decoding, maximum 1,536 output tokens and batch size four. One H100 ran job 1228934, completed in 19m36s; the GPU is released. There are 605 unique requests: 156 first attempts, feedback retries 117+102, generic retries 117+113. Two drafts pass before a model call. Constraints limit whitespace and type the values; truncation or later semantic checks can still reject a response.

## What was learned

- “A logo 'storyful' appears in the video”: adding storyful to the logo preserves the original appearance event.
- “Typhoon Wipha made landfall with wind force level 12”: restoring 12 on the wind-force level preserves the landfall relationship. It is a level label, not a count of typhoons.
- “Robot on lane three comes in second place”: three is restored, but an unsupported nummod relation from lane to Robot is also added. This complete program is rejected.
- “Sheinbaum: Movement promoted from abroad…”: the model makes Sheinbaum the promoter rather than the source of the statement. Word coverage does not detect the mistake.
- “2025 Montreal map…”: 2025 becomes a count of maps. Correctly including a number does not establish its semantic type.
- The wind-speed/sufficient-to-force-adults-to-crawl claim still fails. A three-addition authored engineering fixture compiles, but it is not a model recovery and is not counted.

Parser-dependent checks can reinforce bad annotations: sweep is incorrectly the subject of the robot-kick sentence in the original dependency parse. Local field edits also struggle with wrong roots, complex scope and missing shared participants. More compiler passes would conceal these defects without whole-program review.

## Preserved development work

Earlier whole-form correction trials cover a 24-case pilot and a fixed 72-case extension. The source bundle preserves all prompts, configurations, outputs, source snapshots and 68 whole-form meaning judgments. They are excluded from the final typed-edit corpus update. A promising wind-subject repair was only partial and is explicitly not approved. The untyped-edit trial on 158 drafts is also excluded: arbitrary JSON values frequently used the wrong field shapes. No earlier branch is substituted per claim.

Failed startup attempts and their source snapshots are retained. The first vLLM worker needed spawn rather than fork after CUDA initialization. A typed-edit startup exposed an unbound local variable before any generation; request construction was factored into a pure helper and all 158 complete requests were validated on CPU before the successful rerun. Earlier verbose/whitespace experiments changed several factors together and are not causal prompt comparisons.

## Validation and replay

466 tests pass. CPU replay reproduces all 158 before/first/final records and all four retry files byte for byte using `typed_edits/model_source`. Every unique complete final program has a hash-bound development judgment. Source archives omit model checkpoints and include exact messages, raw responses, decoder/configuration choices, parser inputs, source hashes and all replay data.

After extracting the source ZIP into a clean directory, use the existing project Python environment:

```sh
PYTHONPATH=scripts python scripts/replay_compiler_feedback.py
PYTHONPATH=scripts python scripts/replay_typed_edits.py
PYTHONPATH=scripts python scripts/analyze_typed_edits.py
```

This ZIP is a source/data overlay for cached compiler-feedback replay. The complete 466-test suite was run in the project workspace; some earlier tests also need fixtures from the older source bundles under History. Run the complete suite in that workspace with `PYTHONPATH=scripts python -m pytest tests -q`. The clean-directory commands above replay the current experiment.

The first command reruns the original 2,375/449 paths in the new run directory without overwriting the baseline. The second uses the frozen generation-time validator. The source ZIP checker verifies its SHA256 inventory and exact replay artifacts. No GPU or model checkpoint is required for cached replay. Generating new edits requires the separately held local model weights and the original environment; `run_logical_form_edits.py --help` documents options.

## Proposed next steps and intended goals

1. Keep partial logical forms when direct parsing fails. Goal: expose the 218 no-draft failures to constrained correction without inventing missing events.
2. Check participant identity, scope and noun relationships together. Goal: reject plausible field repairs that create wrong actors, sources, quantities or modifier attachments; treat parser labels as evidence rather than gold.
3. Evaluate a bounded structural correction on the same failures, then review unseen source videos. Goal: handle errors that local edits cannot express and assess reliable coverage before relation training. Keep a fixed condition and generic-retry control.
