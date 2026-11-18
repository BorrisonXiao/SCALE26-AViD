# Fixed SRL/AMR fallback — 18 November 2026

The user accepted complementary frontends: SRL first, AMR on detected failure, one bounded simplification/rewrite after both fail, then explicit parsing abstention. This supersedes earlier no-pooling restrictions for separate comparison experiments. Routing never uses meaning-review judgments, media evidence or claim labels. ADR-023 and compiler-before-training priority remain unchanged.

## Measured full-corpus result

All 2,375 originals are processed once. **2,177 pass automatic compilation checks (91.66%)**; **198 abstain**. Selected stages: 1,978 SRL, 178 AMR and 21 rewritten programs. Attempts: 2,375 SRL, 397 AMR and 219 rewrite stages. No later stage runs after an earlier pass.

The unchanged original SRL path still generates 2,146 candidates and passes its earlier checks on 1,983; all historical 2,099 candidate IDs remain. Shared new checks flag five of those earlier passes. The previous 2,166 total was a paired either-parser count under older checks, not the new sequence. The earlier retained pool stays 1,981 and is not automatically extended by this experiment. Generation, check passes, review retention and faithful reading are separate measurements.

## Complete 183-case audit and final addition reviews

All original 183 potential AMR recoveries were inspected: **42 full-reading matches, 83 partial, 45 incorrect, 13 context-needed**. This comprises 145 fresh source/graph/scope inspections and 38 exact-output prior reviews. No independent gold or new human approval is claimed. References are original wording and existing readings, not a new untouched reference set.

Final selected AMR additions: 178 reviewed, {"incorrect": 38, "matches_reference": 45, "partial": 82, "context_needed": 13}. Selected rewrite additions: 21 reviewed, {"matches_reference": 5, "partial": 13, "incorrect": 3}. Unchanged judgments are reused only for equal emitted logical conditions, variable kinds and allowed routes. Changed programs are inspected afresh. Existing SRL passes are not fully re-reviewed, so these numbers do not provide whole-corpus semantic accuracy. Partial means some binding, scope or meaning is unresolved or insufficiently exposed, even when much of the source wording is present.

## Implementation

- `compiler_fallback.py` implements one fixed lazy sequence, restoring the common compiled-claim structure and returning one outcome per input. Both frontends use the same three-state logic backend. Their predicate vocabularies are not assumed to be semantically identical; evidence functions must implement their declared argument conventions.
- `fallback_semantics.py` applies shared necessary checks and source qualification. Main-clause **would** encloses content in an explicit source-modal context. It does not guess conditional, future-in-past or habitual subtype. Nested ambiguous would refuses; it is not moved over an outer reporting event. Exact source literals are protected from being reparsed as internal modality/quantification.
- Written quotations require exact strings bound to a carrier. AMR normalization uses explicit artifact-to-saying/writing links, source spans and the declared PENMAN subtree, including inverse-role modifiers. AND/OR operators joining quoted strings are structural; their deletion does not drop an additional unquoted event. Shared or externally anchored content remains guarded. Whole-claim quotation marks alone do not imply an inscription.
- Explicit generic comparative dependencies and recognized universal expressions refuse when the available existential formula cannot express them. This does not implement generalized quantifier inference or detect all generic statements. A source implication cannot silently become an AND after rewriting.
- Verified [PropBank frames](https://github.com/propbank/propbank-frames) supply bounded complement/sense rules: look.02 is seeming; blame.01 ARG2 is blamed content; call.03 is demand; tweet.02 is posting a message; sound.02 is noise production. Explicit source constructions, not global frame aliases, license call/tweet/sound corrections. The five XML files, URLs and hashes are cached in `frames/`.
- Named-entity spans and explicit person-role nouns outrank unrelated person/people matches. This prevents reported people from imposing plurality on Trump or the narrator. It does not repair an intrinsically malformed named graph, such as Mandalay naming a near predicate.
- One fixed cached rewrite condition is replayed only after both original paths fail. Component programs must pass checks, and source/entity/event alignment must succeed before composition. Clauses share referents and keep original contexts; no gold-selected retry or parser choice is used.

## Rewriter and parser preparation

Historical rewrite condition: frozen local **Qwen3-30B-A3B-Instruct-2507**, float16, greedy, seed 42, maximum 3,072 tokens, context limit 32,768, at most 12 simpler sentences. Model data contains original text, dependency/SRL annotations and compiler diagnostic, not claim truth labels, media or review readings. It returns sentences, not a proposed final verification label. The prompt/schema/message-builder match the saved historical condition; versions remain run metadata, not prompt fields.

There were eight genuinely uncached current failures. This round generated **8** additional failure-only responses under the same system prompt/schema/model/decoding settings, with the actual current SRL/AMR errors. They are not selected from alternate prompts. `missing_rewrites/prompt_equivalence.json`, routing, exact messages, raw responses, model config and job logs preserve this preparation. Failed initialization/loading attempts are not counted as generated responses. The two new automatic programs receive one full-reading and one partial judgment. All eight text rewrites were inspected separately, including the six remaining refusals. The experiment allocated one A100-80GB at a time: 472 seconds of cancelled cold loading plus 411 seconds for the completed job,883 GPU seconds total (0.2453 GPU hours). The completed batch generated eight responses in 10.36 seconds after loading. All experiment jobs ended; the pending H100 request was cancelled before allocation. Primary full-corpus replay itself uses saved outputs and makes no model call.

For the existing 20 external texts, frozen BERT-SRL runs on CPU; the AMRs and original-text readings are already cached. No parser retraining, GPT/model judge, new media inference or empirical relation training occurs.

## External diagnostic

The previously selected AVeriTeC set contains 20 texts, not an untouched evaluation set. Neither truth labels nor evidence are used. SRL produces 15 candidates/11 check passes; AMR 10/6. Fixed selection: {"abstained": 7, "srl": 11, "amr": 2}. Whole-reading judgments: {"srl": {"not_compiled": 5, "partial": 7, "matches_reference": 4, "incorrect": 4}, "amr": {"not_compiled": 10, "partial": 5, "matches_reference": 4, "incorrect": 1}, "fallback": {"not_compiled": 7, "partial": 7, "matches_reference": 4, "incorrect": 2}}.

The boycott example demonstrates that a primary automatic pass can stop a better secondary interpretation from being selected. Quoted future/metaphorical content and generic causation still expose defects. Program generation and calibrated confidence must not be confused with faithful meaning. The original external readings were saved before the earlier parser run, but this set has already informed development diagnostics. No pristine held-out accuracy is claimed, and dataset assertions are not endorsed as true.

External attribution: [AVeriTeC](https://fever.ai/dataset/averitec.html), Schlichtkrull et al., CC-BY-NC-4.0. Selection/provenance are preserved from `amr_contexts_20261118/external_manifest.json`; no truth labels/evidence are redistributed.

## Failure handling and paper evaluation

A failed parse returns **parsing abstention**, no selected program and no evidence distribution. The evidence verifier is never called. A compiled claim with unavailable observations instead returns **insufficient evidence**. Neither is silently treated as refutation. All 2,375 inputs remain in the evaluation denominator.

The attempt budget is finite: SRL once, AMR after failure, one rewrite response with bounded clauses, then abstention. This avoids an unbounded compilation search; it does not prove general probabilistic inference tractable with many evidence candidates. Candidate-domain cost and real inference scalability remain separate checks.

A controlled binding-training experiment may use checked logical forms with inspected synthetic text edits and media labels. A complete automatic test must include parsing failures and report coverage/fidelity/performance/cost separately. Dropping difficult test claims cannot establish end-to-end reliability. No such training starts in this run, and unrestricted compilation correctness is not established.

Remaining final stops: {"rewrite_component": 115, "entity_alignment": 69, "conditional_scope": 1, "sentence_parse": 2, "missing_shared_participant": 1, "event_alignment": 3, "shared_description": 2, "description_alignment": 3, "source_alignment": 2}. Codes identify software stops, not a full linguistic taxonomy. Examples in the report show quotation/generic refusals, temporal terrain relations, ambiguous participants, changed names/amounts and incorrect automatic passes.

## Validation and cached reproduction

640 full tests pass, including 33 new fallback/source tests. Seven native DeepProbLog controls on four actual selected programs use constructed observations, plus a separate parse-abstention policy check. Printed strings require OCR rather than speech; missing modal qualification remains unknown; a parsing abstention never invokes evidence inference. These are engineering checks, not model accuracy, learned probabilities or media results.

Default typed AMR 2,375, original AMR 2,375 (including 1,425 exact programs) and earlier SRL 2,375/rewrite 449 reproduce exactly. Historical archives and viewer JSONs remain immutable. The main report keeps five views/two Reports cards; the old retained-pool viewer moves under History, while All claims shows the new complete sequence.

With the existing Python environment and WordNet resources, cached replay requires no network, GPU or model generation:

```bash
PYTHONPATH=scripts:tests python -m pytest -q tests
python scripts/run_compiler_fallback.py
python scripts/evaluate_fallback_external.py
python scripts/analyze_compiler_fallback.py
python scripts/analyze_compiler_fallback.py --summarize
python scripts/profile_compiler_fallback.py
python scripts/check_compiler_fallback_defaults.py
```

The source overlay includes input/compiler hashes, all 183 baseline reviews, final addition reviews, raw rewrite requests/responses, external inputs/readings, exact stage records and source checks. Model regeneration is separate and uses the stored local-model configuration; cache replay, rather than identical floating-point generation across GPU types, is what the archive verifies.

## Proposed next steps and goals

1. Repair participant bindings and noun readings in detected failures: recover faithful meaning rather than merely executable programs.
2. Improve checks on incorrect primary-parser passes: allow a useful fallback to run when the first output is misleading.
3. Prepare checked logical forms for controlled binding data while retaining the full automatic test set: separate relation-learning ability from parsing coverage without hiding failures. Training remains deferred.
