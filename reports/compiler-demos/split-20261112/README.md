# Split-and-rephrase for failed claim compilation —12 November2026

The user clarified that the fallback should break a complex claim into simpler subclaims, rather than return a different single sentence. The earlier single-sentence restriction excluded this approach and its negative results are not evidence against sentence splitting.

The task is known in NLP as split-and-rephrase: [Narayan et al.,2017](https://aclanthology.org/D17-1064/). Context links between simplified sentences are also established: [Niklaus et al.,2019](https://aclanthology.org/P19-1333/) and [DisSim](https://aclanthology.org/W19-8662/). [Ponce et al.,2024](https://aclanthology.org/2024.acl-long.622/) studies LLM prompting/fine-tuning for split-and-rephrase and identifies limitations in splitting compliance. We use the established task as a preparation layer; splitting itself is not claimed as this paper's new method.

## Implemented comparison

All31 previously inspected strict direct-compilation failures from the earlier pilot are fixed before new generation. Passing originals never reach the model. Original readings and source groups are inherited from the frozen development packet; this is not an independent or unseen test. The user example is a development target; the prompt demonstrates a distinct photo/Alice/blue-cup example. One frozen Qwen3-30B-A3B-Instruct-2507 model receives the original claim, imperfect dependency/SRL parses and direct compiler error, without truth labels/media/reference judgments. One2048-token deterministic JSON-schema generation call per failed original is allowed; no per-claim model/prompt selection.

Output comprises action(split/keep/refuse), short sentences, context links and shared mention groups. Relations use ordinary terms: conjunction, depiction, speech/printed content, purpose, relative description and before/after/while. Shared mentions indicate the same participant in different sentences. The model returns no logical predicates. It may keep an atomic claim or refuse an ambiguous split; not every failure is a sentence-complexity problem.

Each generated sentence is parsed with the existing Stanza dependency parser and BERT semantic-role labeler, then compiled by the frozen content-relations compiler. All38 underlying compiler source hashes remain unchanged. A separate adapter renames local IDs and applies declared shared-mention links; it does not guess equality from matching names. Conflicting shared descriptions are refused so modifiers do not move across contexts.

We compare the SAME sentences under two conditions: flat AND with shared participants, and linked composition with those same shared participants. This isolates the effect of context attachment. The linked adapter reuses existing logical-form operators. For a source clause such as an image depicts Trump, it replaces the focal argument with the linked holding-event content, so Trump/document/holding conditions occur in the image's depiction context. Flat AND instead asserts the holding event in the world. Mere component compilation is not semantic equivalence.

Unsupported parent structures, unresolved target/shared mentions, conflicting descriptions and component refusals remain explicit failures. Parent negation is not peeled away to insert a clause. Typed rate/quantity, quantified absence and ambiguous scope do not become correct merely by splitting. Existing evidence functions must support the resulting predicate/context arguments; no new media scoring, relation learning or native DeepProbLog inference is run.

## Measured results

| Measure | Automatic Qwen,31 originals | Assistant-written diagnostic,8 originals |
|---|---:|---:|
| At least two proposed clauses |28|7|
| Individual clauses passing content checks |65/77|18/18|
| At least two clauses and all pass |20|7|
| Linked programs generated |6|6|
| Reviewed faithful linked results |0|4|
| Reviewed faithful flat conjunctions |0|2|

The assistant-written condition contains seven attempted splits and one appropriate refusal of a no-audio guard. Its four approved compositions are Trump in the image, vehicle/lights in the second shot, additional police officers, and the exact sign quotation. This is a selected development diagnostic after Qwen inspection, not model improvement, held-out accuracy or independent annotation.

The clean Trump split is “An image depicts Trump” and “Trump is holding up a signed document.” Both references denote the same Trump; the second clause is content of the image. The signed attribute belongs to the document, with no signer inferred. The compiled attribute inherits the visual route. Flat conjunction instead asserts holding outside the image context. For the second-shot example, the vehicle and its lights stay distinct, and all three clauses remain within the shot's depicted content.

Automatic sentence text alone is judged faithful in16 multi-clause cases under its intended reading, but shared mentions, context links and compiled meanings can still be wrong. Wrong identity groups equate a vehicle with lights, an earthquake with magnitude, or a goal with a device. Other failures lose alternatives, expand quoted content into asserted events, or introduce a positive narration statement under a no-narration original. The model's Trump sentences are useful, but redundant signed-document descriptions are rejected by the conservative composition adapter. Zero approved complete outputs does not imply every generated sentence is bad.

The clean building clauses still expose mistagging of “houses” as a noun. Rainfall and speed sentences pass component checks but incorrectly encode measurements as object counts. Repeated motion events also need event-reference alignment; sharing only the storm participant does not establish the same event. No such output is accepted as a faithful recovery.

The38 frozen compiler files and original2375-record baseline remain unchanged:2103 programs generated and1924 passing the current checks. There is no new whole-corpus rerun or corpus-gain claim in this bounded experiment. One H100 job1225328 completed in672 allocated seconds, including40.17 seconds of generation; resources are released. No new media verification, native DeepProbLog inference or relation training was performed.

Validation:15 new composition tests and17 existing rewrite/routing tests pass. The site passes structural/link validation on20 HTML pages. Cached-source replay reproduces all39 outputs and the report/downloads; final publication verification is recorded separately.

## Source chronology and limitations

Generation-time sources and the first composition freeze are retained separately. After inspecting proposals, diagnostic parsing was extended to all77 clauses, even when a link schema was invalid. Mention matching became capitalization-tolerant; source predicates gained argument checks; composition was corrected to extend an existing depiction context; the existing route-inheritance function now carries visual context into attributes. These are development changes in the new adapter, not frozen direct-compiler changes. Final review hashes bind judgments to the final complete outputs. Initial outputs and both source snapshots remain inspectable.

These results support the proposed structure locally but do not justify unrestricted automatic fallback. Split-and-rephrase is established prior work; the paper contribution remains the probabilistic verification framework and learned relations, not sentence splitting.

## Proposed next steps and goals

1. Review clean and automatic versions of Trump and the emergency vehicle: confirm the intended subclaims and context links.
2. Separate sentence generation from reference resolution and align original entity/event mentions to the subclaims: reduce wrong identity links and preserve local descriptions.
3. Repeat a fixed small comparison with full meaning review: establish reliable composition before corpus-wide fallback or new DeepProbLog learning. Keep quantity/negation failures explicit rather than repeatedly changing wording.

## Reproduction

Artifacts are in exp/probabilistic_verification/claim_split_20261112. Exact prompts/raw responses/model metadata, original readings, clause parses, component programs, both composed forms, source freezes and semantic review are retained. Compiler-author semantic judgments remain separate from automatic grammar/schema checks and are not independent human gold.

Run parsing once in probabilistic-verification, then parse_claim_splits.py --srl in srl-eval. Saved parse replay requires no model or GPU:

```sh
PYTHONPATH=scripts envs/probabilistic-verification/bin/python -m pytest -q tests/test_claim_split.py
envs/probabilistic-verification/bin/python scripts/compile_claim_splits.py
envs/probabilistic-verification/bin/python scripts/compile_claim_splits.py --run exp/probabilistic_verification/claim_split_20261112/supervised
envs/probabilistic-verification/bin/python scripts/analyze_claim_splits.py
envs/probabilistic-verification/bin/python scripts/build_compiler_demos.py
```

A dated source overlay follows the existing compiler/audit/rewrite/inspection bundles and preserves all earlier published ZIPs. Extract the compiler-demos/source.zip baseline, alert-review-20261111/source.zip, rewrite-20261111/source.zip, rewrite-inspection-20261112/source.zip, then split-20261112/source.zip into one directory. All paths are relative to reports/compiler-demos on the published site. Validate CLAIM_SPLIT_SHA256SUMS, then replay from cached parses. Packaging in an isolated checkout can use package_claim_splits.py --allow-missing-history. Source snapshots distinguish generation-time files from the composition freeze and later fixes. Scores, grammar acceptance, word retention and assistant-reviewed fidelity are reported separately.
