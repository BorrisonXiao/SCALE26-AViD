# Source preservation and shared AMR operators

Completed 14 November2026. This extends the fixed cached BART AMR comparison, with no new model calls, GPT/model judge, GPU allocation, media inference or empirical training. All meaning judgments are by the implementing assistant. ADR-023 and compiler priority remain unchanged.

## Results and what they mean

All2,375 originals use one cached amrlib BART-large parser and one converter, with no per-claim parser selection. Graph conversions rise from1,425 to1,589:164 newly convert, no previous conversion status is lost.786 refuse conversion. Of1,589 diagnostic programs,1,406 also pass necessary source checks and183 are flagged.1,406/2,375=59.20%. This is not semantic accuracy, automatic training eligibility or a comparison under the older direct compiler's checks.

The same60 references yield46 programs:43 pass source checks. Assistant whole-reading review:18 matches,12 partial,12 incorrect,4 context-needed,14 refused. Previously13/60 matched. The five additional matches are exact news76 overlay text (the source string is `news 76`), report-about topic scope, plural shared singing/dancing participant, am/pm in the depicted date interval, and the complete quotation on the protest sign. Neither the complicated directive nor the generic wind/adults claim is counted as a whole-reading match.

A32-case follow-up has28 programs,26 passing source checks. Review:12 matches,9 partial,4 incorrect,3 context-needed,4 refused. Eight claims per video were selected by a deterministic hash from four videos absent from the60-reference set. Their original-text readings were frozen before extension outputs. Earlier project work and cached parser outputs already existed for these videos. First individual follow-up inspection exposed a source noun tag on AMR land-01; the shared number rule was then restricted to participant entities, excluding event and measurement-unit nodes. Initial outputs and the change are preserved. Therefore final32 outputs are development diagnostics, not an independent or held-out accuracy estimate.

Across92 reviews:30 matches,21 partial,16 incorrect,7 context-needed,18 refused. Source checks flag five incorrect candidates;11 other incorrect programs pass. Passing source checks does not establish faithful relationships. The user has not approved the new programs. Most full-corpus outputs have not received this meaning review. Retained production pool stays1,981/2,375(83.41%),394 excluded; zero promotions.

## Implemented compiler changes

- `amr_source_alignment.py`: source word/lemma spans, a small explicit pronoun/person alias inventory and source-attached phrasal particles. Unique written artifacts bind the exact source quotation with a `written_text` condition, preserving original punctuation/typos, scope and externally shared references. Only owned quoted graph content is removed, with the removed triples saved. Human reading actions and ordinary speech are not converted to OCR.
- Clock handling restores uniquely aligned am/pm and retains elapsed `T+` notation without guessing field units or timezone offsets. Source checks flag changed/omitted names, unsupported values, missing calendar/clock information, broken amount/unit pairs and date-as-location mistakes. Proper names can be credited by executable timezone/value literals. These checks are necessary and can be overly strict on paraphrases; no general named-entity resolution or unit-rescaling claim.
- Source grammatical plurality is added inside the existing entity scope. Events and unit-denoting nodes retain it as metadata rather than participant plurality. Under no-NP absence, lack of clouds means lack of even one cloud, not lack of a plural-sized witness. General generics, collective/distributive readings, count/mass distinctions and universal quantification remain incomplete.
- `amr_composition.py` adds opt-in participant AND groups and OR assignments. AND retains members and one parent event rather than forcing separate member events. OR branches use the same selected candidate variable; repeated descriptions and names are preserved in each branch. Externally reentrant OR and annotated coordination still refuse. Defaults reproduce the previous converter.
- `amr_scope.py` groups declared frame/role complements into assertion, topic, prediction, directive, accusation, requirement, cancellation, attempt, failure, completion, cessation, prevention, result and reason classes. For example, report-about is topic and urge-to-stop is directive→cessation. Bare adjective values under declared frame91 relations can be predicate values. Official PropBank files inform the role inventory; unknown complements still refuse. These labels are contracts for evidence functions, not a full scope/projection/factivity system.
- `compact_backend.py` emits exact three-state support/refutation rules and derives internal unknown as neither. Categorical leaf outcomes, observation identity and gradients remain intact. The previous serializer remains the default; `DirectVerifier` accepts an optional program builder.

The fixed experiment is source preparation → one extended AMR converter → necessary source checks → compact program. Diagnostic candidates remain inspectable when checks refuse. There is no feedback generator, neural confidence model or hidden per-claim method choice in this run.

## Failure patterns

First graph-conversion stops among786:631 unhandled complements,46 annotated coordination,37 negative-argument scope,20 duplicate roles,17 cross-context event reentries,14 sentence modes,5 coordination size,5 untranslated nodes,4 polarity values,3 coordination reentries,3 media-modifier scope and1 unresolved reference. Among183 source-flagged programs, issue counts overlap:119 source-name omissions,72 changed names,39 unlicensed numbers,34 source-number omissions,10 amount/unit binding alerts,9 unresolved reading-event analyses,6 quotation alignments,2 month mismatches,1 date-as-location and1 missing clock.

Checked errors illustrate the remaining problem:

- `End of video velocity is12005mph` becomes an ending-velocity event, not a velocity value at end-of-video time. Its numbers and units pass.
- `A man has his eyes closed` becomes a close action. Shared eyes/man referents survive; the state does not.
- People `in the video` become people physically located at a video. An AND group does not repair depiction scope.
- IPC becomes IPCC; the necessary name check refuses it. One association's full name becomes two organizations; group composition does not repair identity.
- A complex visible overlay lacks a unique artifact node and refuses, while `Al-Wefaq News` is preserved exactly on a uniquely aligned overlay.
- Group locations do not establish distribution over both floors or put the top floor in the same building. The source's collective/distributed reading needs more than an untyped group link.

## Inference profiling and numerical checks

All profiles use native DeepProbLog, one placeholder candidate per variable, constructed distributions, two PyTorch CPU threads and fresh processes bounded to12s including imports. All three states are queried. Hash seed is not fixed: these are diagnostics, not a controlled general benchmark. Stack traces are retained.

Same older16-condition wind formula: generic and previous explicit-state encodings exceed12s, compact first solve about1.23s unknown/1.27s mixed. Mixed probabilities per independent observation are0.90supported,0.05refuted,0.05unknown. Final exact probabilities match the analytic conjunction:0.1853020189supported,0.5598733313refuted,0.2548246498unknown. No media accuracy is measured.

The refined wind formula has19 observations, including two scoped references and entity plurality. Both unknown and mixed compact checks exceed12s, without a verdict. The race and cloud-absence checks finish with unknown1. Compact rules help the older formula but do not solve scalability. Generic traces reach SDD construction; refined traces reach weighted circuit evaluation after grounding. Next work must profile categorical constraints and circuit structure before scaling candidate assignments or learning.

An initial mixed control caught probability loss from the library's default epsilon zero/one checks. Final profiles use exact float zero/one tests, as the existing DirectVerifier does, and never discard tensor-valued neural outcomes. The failed development result, initial source outputs and before-review hashes are preserved under development folders; they are not counted as successes.

538 tests pass in the project workspace, including exhaustive three-state equivalence with shared observations, constants/NOT, retained small probability mass, matching nonzero PyTorch gradients, shared names in OR, AND membership and source-preservation contrasts. These constructed tests do not train a relation classifier. A fresh replay reproduces all2,375 default AMR outcomes, including1,425 exact compilations/programs, plus all2,375 legacy originals/449 cached rewrite outputs. Older retained membership is unchanged.

## Reproduction

The source ZIP is a source/data overlay, not a checkpoint or complete historical environment. Use the existing project Python environment; cached replay needs no network/GPU:

```sh
PYTHONPATH=scripts python scripts/run_amr_refinement.py
PYTHONPATH=scripts python scripts/review_amr_refinement.py
PYTHONPATH=scripts python scripts/check_amr_refinement_regression.py
```

Do not regenerate the frozen reference readings/selection. `check_amr_refinement_archive.py` extracts the new archive and checks inventories and exact cached output replay. The full538-test run uses project fixtures; focused new tests run in the extraction. Time profiling is bounded separately; stored results are evidence, not a promise of identical timing on another machine. All32 older ZIPs and26 original viewer files remain unchanged. Current results remain in compiler-demos Overview/Examples with five views; initial AMR and earlier comparisons remain under History.

References: [official PropBank frames](https://github.com/propbank/propbank-frames/tree/main/frames), including [leave.11](https://raw.githubusercontent.com/propbank/propbank-frames/main/frames/leave.xml) for movement from a departure place; [AMR specification](https://github.com/amrisi/amr-guidelines/blob/master/amr.md). This compiler implementation is preparation, not the paper's novelty claim.

## Proposed next steps and goals

1. Check semantic types and argument attachments against source grammar. Goal: catch noun/event, modifier, result-state and depiction mistakes that source name/value checks miss.
2. Test one bounded source-conditioned semantic correction on strict failures. Goal: give one frozen model the original claim, aligned graph and explicit compiler errors, preserve copied source literals, and compare compiler feedback with a generic-retry control. Do not select different parsers per claim.
3. Resolve larger-program inference cost and review another frozen sample before training. Goal: establish faithful candidate availability and practical candidate-domain cost. Neither a valid program nor a confidence score repairs an incorrect meaning.
