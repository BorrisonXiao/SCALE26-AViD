# Compiler repairs and bounded rewrite feedback — 12 November 2026

The compiler remains the priority. No SRL retraining, media inference or empirical relation training ran. ADR-023 and direct-failure-only rewriting remain unchanged.

## What the seven cases actually show

1. **Small motorized vehicles.** The cached Stanza dependency parse already contains `Small —amod→ vehicles`. The cached BART AMR also retains the modifier. The converter creates the vehicle from a shorter first SRL argument and then reuses that object without adding the adjective. The repair copies a missing, source-attached adjective into that same entity. Already represented adjectives and nonintersective modifiers such as former/alleged are excluded. This is not a limitation of noun-modifier parsing in general.
2. **People were evacuated … destination … date.** The rewrite is acceptable English. Our old noun-only aligner could not connect evacuation to evacuated. A uniquely licensed derivational reference now uses the original event variable. Location and date therefore constrain that evacuation, not a new unrelated event. Ambiguous event references and references across modal/source scopes are refused.
3. **The robot repositions itself upright …** The SRL model misses reposition, while the existing dependency fallback recovers the event. UD marks itself as reflexive; the cached AMR repeats the robot node in the two roles. The converter formerly declared another entity. The repair uses the local grammatical subject and matching compiled participant. It does not guess a distant antecedent. An authored example where reposition is tagged as a noun still fails explicitly.
4. **Six shots fired or the sound of explosions.** Yes: rewrite into “Six shots were fired” OR “The sound of explosions was heard.” The structured response contains sentences and an AND/OR formula with numbered sentence leaves. Every sentence must appear exactly once. Operators can nest. Six belongs only to shots; the source does not specify six explosions. Source/relative attachments remain conservative; arbitrary conditionals are not reduced to AND/OR.
5. **Power outages likely in residential area.** “Power outages are likely in the residential area” is a reasonable rewrite. More directly, the compiler can place the existing outage description and its location inside a likely qualification. It must not turn likely into a property of an area or assert certain outages. This bounded rule covers a simple root/copular proposition; it is not a general solution for modal scope in complex clauses. The corpus recovery comes from this compiler repair, not a measured prompt-only improvement on this exact case.
6. **There are no containers fully in the water.** The frozen SRL argument merges the noun and location. We separate the grammatical subject and explicit prepositional phrase before conversion, then put the entire qualified condition inside NOT EXISTS. Partly submerged containers are allowed; fully submerged containers refute the claim. This is a conversion/quantifier problem despite the simple sentence.
7. **man exclaims “just like that!” / written graffiti.** The English is plausible. The compiler lacked exclaim in its quoted-speech handling and could detach content from its event. Exact quoted words now remain an argument of the same speech event. Quoted writing uses OCR support, never world truth for the quoted proposition. Separate writing-location phrases are preserved. These are explicit vocabulary/context rules, not a learned general quotation parser.

## Existing tools and related methods

- [Stanza dependency parsing](https://stanfordnlp.github.io/stanza/depparse.html) supplies grammatical links; [UD amod](https://universaldependencies.org/u/dep/amod.html) is the standard adjective-modifier relation. Our actual saved output already has the relevant link.
- [AMR guidelines](https://github.com/amrisi/amr-guidelines/blob/master/amr.md) represent modifiers, repeated nodes and and/or concepts. Actual cached graphs support the first and third diagnoses. AMR quantification is shallow: an AMR graph is not automatically a complete first-order-logic treatment of quantifier scope.
- [Stanza coreference](https://stanfordnlp.github.io/stanza/coref.html) is an existing pretrained option for broader reference resolution. It was not downloaded or benchmarked here. Local reflexives do not require retraining SRL.
- [Logic-LM](https://aclanthology.org/2023.findings-emnlp.248/) translates language to symbolic formulations and refines them using solver errors. The proposed feedback loop is established practice; its success must be measured on our claims.
- [PICARD](https://aclanthology.org/2021.emnlp-main.779/) constrains generated formal syntax. Our JSON grammar serves a related syntactic purpose. Valid syntax does not guarantee faithful meaning.

## Conditions and accounting

`scripts/run_compiler_repairs.py corpus` reruns all 2,375 saved originals with one opt-in compiler. `cached` replays all 449 earlier rejects and all 419 saved rewrite responses. Passing originals bypass rewriting. `analyze_compiler_repairs.py` inspects every changed complete program in that cohort, reuses exact program/form judgments and records targeted reviews of changes to previously retained programs. It preserves prior development acceptance for the other old rows; this is not a fresh whole-corpus gold audit. The result is1,983 direct automatic passes,114 complete programs on449 cases, and1,972/2,375 retained development compilations (83.03%),403 excluded. Thirteen changed complete programs yield nine approvals;101 exact judgments are reused and seven prior retained changes receive targeted review. See summary.json for exact counts.

The separate model pilot fixes 24 known strict failures before generation; the direct logical-form comparison fixes its first 12. These are development diagnostics, not held-out accuracy. Model conditions are not pooled into full-corpus coverage or selected per claim. Each rewrite condition allows at most one retry, and only after an actual compilation failure. First-pass successes are retained without another model request, even if later meaning review rejects them.

The first Qwen3-30B-A3B prompt prefers minimal rewriting and often copies the rejected original. Its two rewrite rounds finished; the job timed out in the separate direct-form phase before saving any direct response. A second condition uses a shorter, explicitly structural rewrite prompt and frozen Qwen3-VL-8B with text inputs only. Prompt, model and compiler snapshot differ, so improvement cannot be attributed solely to prompt tuning. Exact inputs, prompts, outputs, compiler errors, model configs and source hashes are preserved.

The initial 8B direct-form diagnostic omitted an output-format explanation from the text prompt and returned 12 refusals. This is a prompt defect, not evidence against direct semantic parsing. A separately frozen guided condition supplies a compact format explanation and example on the same 12 cases. The guided condition yields2/12 automatic passes, both rejected on review: purpose becomes a free event entity, or acronym participants become undeclared strings. All attempts remain visible. No new model response is promoted to the corpus pool in this experiment.

## Validation and reproduction

Use envs/probabilistic-verification/bin/python with PYTHONPATH=scripts. Frozen parser probes use Stanza and the existing BERT SRL checkpoint on CPU; AMR diagnoses use cached predictions. No parser was retrained. Tests include actual native DeepProbLog inference on constructed evidence for OR versus AND, shared event identity and qualified absence. They do not assess any real video or audio.

Run:

```sh
PYTHONPATH=scripts envs/probabilistic-verification/bin/python scripts/run_compiler_repairs.py corpus
PYTHONPATH=scripts envs/probabilistic-verification/bin/python scripts/run_compiler_repairs.py cached
PYTHONPATH=scripts envs/probabilistic-verification/bin/python scripts/analyze_compiler_repairs.py
PYTHONPATH=scripts envs/probabilistic-verification/bin/python -m pytest tests -q
```

The source bundle is a new overlay and includes cached replay inputs, all model conditions and source snapshots. Older ZIPs and original claim-viewer files remain unchanged.

## Proposed next steps and goals

1. Improve event/mention alignment and source-scoped composition on the fixed remaining cases. Goal: accept faithful short sentences without losing who/what they describe or where the content comes from.
2. Test one fixed guided rewrite or predicate-generation condition on the remaining strict failures, with at most one compiler-feedback retry. Goal: measure coverage and faithful meaning together, without best-of-prompt selection.
3. Review changed programs and source-disjoint claims before moving to relation learning. Goal: establish a compiler subset whose scope and bindings are reliable enough to support the planned experiment. Empirical training remains deferred.
