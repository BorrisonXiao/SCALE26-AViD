# Fixed AMR-to-logic comparison

Completed 14 November 2026. The user explicitly requested self-review and no GPT review. No external/model judge was used. There were no new model calls, GPU allocations, rewrites, media inference or training. ADR-023 and compiler priority remain unchanged.

## What was tested

One cached neural semantic parser: amrlib BART-large, parse_xfm_bart_large-v0_1_0, beam 4. The four cached files contain exactly 2,375 original claims. One deterministic converter processes every graph, without selecting a parser per claim. Original Stanza lemmas/POS distinguish uniquely aligned nominal predicates and supply tense/aspect; SRL outputs are not used. This is a separate frontend comparison; the retained production pool remains 1,981/2,375 (83.41%),394 excluded. No per-claim pooling or automatic promotions.

The reference set contains the user's20 earlier confirmed readings plus the preceding fixed 40 failures. The 40 additional readings were written from the original text and frozen before converter execution. Four motivating AMRs and earlier project results had already been inspected. All 60 are development cases, used during implementation; they are not an independent/held-out sample. The user did not review the new programs. `references.json` and its hash preserve this distinction.

## Measured results

All 2,375 cached AMRs were processed. **1,425 graphs convert;950 refuse.** Conversion means graph conditions have a documented translation and the emitted ProbLog program parses. It is not sentence faithfulness, corpus accuracy or training eligibility. The old compiler applies different source-content checks, so these counts are not a head-to-head accuracy comparison.

Of 60 reference cases,37 convert. Assistant whole-reading review:13 match,11 partial,9 incorrect,4 need context;23 do not compile. Thirteen matches comprise 7/20 human-reference cases and 6/40 previous failures. A narrower relationship/scope check matches 20 cases, including partial readings; it must not replace the 13 whole-reading count.

The six matching previous failures are lane-three/second-place, complete 7 News.com.au logo, sunny/no-clouds/midday, the woman's19:00/July 21/Vietnam-time assertion, robot/man/during-race, and dark/calm/no-notable-weather. The wind-speed AMR now preserves the causer and appearance/sufficiency/result contexts, but its generic/plural adult reading remains incomplete. It is not counted among the 13 whole-reading matches.

First conversion stops:649 unhandled complements,192 coordinated participants,34 negative-argument scope,22 annotated coordination,20 duplicate canonical core roles,14 sentence mode,8 event context reentries,4 nonstandard polarity values,3 coordination size,3 media-modifier scope,1 untranslated node. These are first-stop software categories, not a full linguistic taxonomy. The first two account for 841/950 refusals. Detailed examples and frame/role pairs are in `failure_patterns.json`.

Clear upstream errors survive conversion:100 m becomes 100 million; Phillies becomes Phillipines; sweep-kick introduces a separate sweep event with Robot 1 as patient; portable becomes a charge participant; Mexico/date becomes a location event. A formal converter preserves these errors rather than repairs them. Exact OCR strings, am/pm, grammatical number, modality, reference and source projection remain material limitations.

## Design

The new opt-in `amr_composition.py` translates concepts, names, roles, literal attributes and graph operators into the existing `CompiledClaim`, `Atom` and `Expression` classes. `concept` checks a concept on a candidate; `role` checks an explicit relationship between candidates; `name`, `quantity` and `temporal` require matching evidence functions. These are declared predicate contracts, not newly implemented perception models. Missing observations return unknown in the native backend test.

Role directions are canonicalized with PENMAN before composition. An inverse modifier such as document ARG 1-of sign becomes sign ARG 1 document. Each predicate emits its own roles, so a negative have predicate keeps its subject and cloud conditions under NOT. The converter records a translation for every semantic graph condition; wiki links are explicitly provenance-only. Clause AND/OR are logical operators. Participant coordination refuses until group/distributive meaning is implemented.

Explicit PropBank-sense policies put assertion, depiction, desire, purpose, appearance and other supported complements into separate contexts. Unhandled complements refuse. Context conditions include all owning source/event variables: a context label alone cannot identify whose assertion is being checked. Assertion does not imply speech audio; written actors can select OCR, while unspecified sources remain unspecified. Bare AMR is not a general scope representation; this implementation does not claim a complete Bos/Lai continuation-semantics system. Inverse modal reentry, negative arguments and ambiguous media modifiers can refuse rather than flatten.

Two development snapshots are preserved and excluded: an initial version omitted context owner inputs; a second emitted inverse relationships outside their predicate's negation and could bypass an inverse scope head. Final tests cover both defects, shared actors/names, declaration order, nominal predicates, source routes, AND/OR, negation, map scope, tense and native unknown inference. Final corpus and review files are separate from the development folders. All 505 tests pass.

## Confidence-model preparation

`confidence_data.json` contains 22 development pairs:13 reference matches and 9 clear incorrect outputs. Inputs contain only the sentence and compiled conditions/formula; judgments/provenance remain outside inputs. Eleven partial and four context-dependent outputs are not forced into binary labels. No confidence model is trained, no split is claimed, and one saved candidate per claim cannot evaluate ranking or alternative-parse coverage. This is insufficient for independent calibration/generalization claims. A future source-conditioned text encoder is separate from the paper's media-conditioned binding classifiers.

## Reproduction and limits

The source ZIP is a source/data overlay, not a model checkpoint or a full historical environment. Using the existing Python environment, cached replay needs no GPU/network:

```sh
PYTHONPATH=scripts python scripts/run_amr_composition.py
PYTHONPATH=scripts python scripts/review_amr_composition.py
```

The 60 reference readings are frozen inputs; do not rerun preparation to redefine them. Runtime in summary excludes original neural parsing, cache loading and source snapshotting. Exact corpus/case/review artifacts are replayed; elapsed seconds naturally differ. Full 505 tests were run in the project workspace with older fixtures. Historical 31 ZIPs and 26 original viewer files remain unchanged. Earlier inspectors/URLs remain under History; the report keeps five views and two Reports cards.

Relevant foundations: [AMR specification](https://github.com/amrisi/amr-guidelines/blob/master/amr.md), [Bos 2016](https://aclanthology.org/J16-3006/), [Lai etal 2020](https://aclanthology.org/2020.dmr-1.1/). PropBank [include](https://raw.githubusercontent.com/propbank/propbank-frames/main/frames/include.xml) confirms ARG 1 included item/ARG 2 group; [report](https://raw.githubusercontent.com/propbank/propbank-frames/main/frames/report.xml) distinguishes reported content from topic. The latter helps diagnose the Washington/location error. Do not claim the frontend alone as the paper novelty.

## Proposed next steps and goals

1. Add source alignment and preservation checks for names, numbers/units, exact quotes, am/pm and grammatical features. Goal: detect or preserve information that AMR normalizes away, without changing its relationships blindly.
2. Implement coordinated participants and shared scope policies as documented operators, with contrast tests. Goal: address the two dominant conversion stops without per-sentence parser selection or automatic assertion of unknown complements.
3. Recheck a fixed new-source set before confidence training. Goal: measure faithful candidate availability and collect enough checked labels; the current 22 pairs do not justify a neural ranker or calibrated parser probabilities.


Native diagnostic: race and cloud-absence programs complete with unknown=1 using placeholder candidates and no media evidence. The nested wind program exceeds a10-second per-process limit, including imports. An earlier unbound-query run was terminated; a35-second bounded run also stopped after the race result and wind start. Neither is counted as an inference success. Program syntax/translation does not establish practical exact-inference cost. Profile the generic encoding/backend before training; this is not a general complexity claim about DeepProbLog. A reentrant whole-content entity also now emits an executable reference condition instead of disappearing into a constant; its pre-fix source/example is preserved.
