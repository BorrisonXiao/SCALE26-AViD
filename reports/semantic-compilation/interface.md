# Semantic SRL compiler revision — 29 October 2026

The revision keeps one compilation path: original text → pretrained semantic role
labeling (SRL) and dependency annotations → explicit logical form → DeepProbLog.
The new entry point is `semantic_srl_form(record)` in
`scripts/probabilistic_verification/semantic_srl.py`. It uses the existing
`srl_graph_form` with `semantic_arguments=True`; the default remains the prior
behavior. There is no per-claim parser selection, LLM call or sentence rewrite.

## Implemented changes

- Source descriptions such as images, and predictions such as forecast rain,
  retain their nominal modifiers and embedded clauses in their source context.
  Unspecified nested evidence routes inherit the containing route.
- Predicational “is/was a/an NOUN” descriptions share the subject referent. For
  example, the registered vessel and the named Mississippi must be the same
  candidate. Equative and bare mass-noun copulas remain incomplete.
- Nominal location complements expose entities and relations rather than one long
  literal. Possessives and near/far-side modifiers receive limited normalization.
- Missing embedded subjects use enhanced dependency subject links when present,
  then declared lexical classes for subject/object control. A controller is the
  participant understood as the subject of an embedded event. Unknown controllers
  can be refused. Synthesized roles are `nsubj` or `nsubj:pass`, not a universal
  ARG0. Existing PropBank roles are retained; an existing wrong SRL role remains a
  known failure.
- Participial and concessive clauses, proper-name modifiers and nominal temporal
  modifiers receive limited attachment corrections. These are rules over cached
  parser predictions, not a new trained semantic parser.

The scoped compiler and probabilistic backend are unchanged. The caller explicitly
allows relative, complement, prediction and concession contexts. A missing evidence
function returns unknown. A valid program is not proof of faithful meaning.

## Evaluation and measured results

Run directory: `exp/probabilistic_verification/srl_semantics_20261029/`.

- All 2,375 original inputs: prior 1,997 compiled / 378 refused; revised 2,042
  compiled / 333 refused (1,870 claims and 172 nominal descriptions).
- Paired transitions: 1,971 compiled by both, 307 refused by both, 71 newly
  compiled, 26 previously compiled but now refused. Acceptance is not accuracy.
- Development 24: prior 7 faithful / 9 partial / 4 incorrect / 4 refused;
  revised 13 / 7 / 1 / 3.
- Fresh 20 IDs reserved before changes: prior 7 / 4 / 4 / 5; revised 8 / 5 / 2 / 5.
  No previously faithful fresh output regressed. This small descriptive review is
  by the same assistant, within the corpus, without independent human gold or a
  source-disjoint evaluation.
- Twenty-four manually specified reference readings compile independently of the
  automatic frontend. Ambiguous interpretations are noted. They were audited
  during development and frozen before fresh review; they are not human gold.
  The damaged-event/nominal identity in reference 21 is still missing from the
  revised frontend, whose output is marked partial.
- 156 tests pass. CPU replay reproduces all 2,375 outcomes/program hashes and the
  24 reference compilations. Sixteen constructed point-mass logical checks cover
  correct and misleading bindings on parsed and reference graphs. Three old graphs
  accept the corresponding misleading facts. Native DeepProbLog passes two checks;
  the nested damage/image case times out after 30 seconds including process
  startup. Full-corpus inference and training throughput are unmeasured.
- The cached CPU census loop takes 15.3 seconds, excluding upstream parser
  inference/loading. No GPUs, LLM calls, media inference or training were used.

## Reproduction

Install `requirements-compilation.txt`, `requirements-verification.txt`, and NLTK
WordNet in an isolated environment. From the project or extracted source archive:

```bash
PYTHONPATH=scripts python scripts/replay_semantic_srl.py
PYTHONPATH=scripts python -m pytest tests/test_semantic_srl.py tests/test_srl_graph.py tests/test_logical_form_v2.py tests/test_logical_form.py tests/test_predicate_compilation.py tests/test_semantic_compiler.py tests/test_multimodal_verification.py tests/test_probabilistic_verification.py -q
```

`sample_manifest.json` records the development/fresh IDs; `frozen_manifest.json`
records compiler/reference hashes fixed before fresh review. The archive includes
inputs, all outcomes, references and assistant annotations. Historical published
source archives remain unchanged. Native inference is separately invocable with
`scripts/check_semantic_srl_logic.py --native-one 8` (or 10/21); case 21 can be slow.

## Proposed next steps and goals

1. Fix event/nominal references, bare mass-noun predication and duration types —
   preserve the remaining identity and value relationships in accepted programs.
2. Audit missing/wrong SRL frames and recover explicit participants — address
   absent predicates and wrong actors that attachment rules cannot repair.
3. Profile DeepProbLog startup, grounding, compilation and evaluation separately —
   locate the nested-case timeout before weak-label training.
4. Freeze the next compiler and obtain an independent review on new source videos —
   measure meaning preservation without reusing development cases.

These steps are proposed, not implemented. Media verification and relation training
remain deferred. ADR-023 is unchanged; sentence rewriting is still unimplemented.
