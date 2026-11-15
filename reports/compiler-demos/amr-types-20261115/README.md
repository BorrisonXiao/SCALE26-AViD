# Predicate types, source contexts and normalization

Completed 15 November 2026. This is a development compiler experiment under ADR-023. No model requests, external judge, GPU allocation, media prediction or empirical training ran. The implementing assistant inspected meanings.

## Result

One fixed cached BART AMR frontend and one source-typed compiler processed all 2,375 original claims. Graph conversion increases from 1,589 to 1,785 (75.16%). Combined source/semantic-check passes increase from 1,397 to 1,559 (65.64%): 163 newly passing claims and one newly flagged old pass, a net increase of 162. No earlier graph-conversion pass is lost. There are 590 graph refusals and 226 flagged generated programs, or 816 automatic failures. These counts are not semantic accuracy.

The quality gain is smaller. In the same earlier 92 development readings, whole-reading matches increase from 30 to 31. The existing 24 follow-up readings contain two current matches; those 24 do not have a comparable complete baseline meaning review. Across all 116: 33 matches, 27 partial, 19 incorrect, seven context-needed, 30 with no program. Twenty-eight cases receive fresh inspection; 58 judgments are reused only when the conditions, variable kinds and sharing are identical modulo identifiers. Automatic refusals require no new semantic approval. Some generated meanings remain incorrect even when every check passes.

A separate 16-case diagnostic, selected by claim-ID hash among additional new passes after this run, has five matches, seven partial and four incorrect. This is a post-selection development inspection, not held-out accuracy. No new AMR output is promoted into the older retained pool. That pool remains 1,981/2,375 (83.41%), with 394 excluded; the two methods are not pooled. Most historical retained programs have not received the new meaning review.

## Changes

- A source-aligned adjective/adverb may denote a property rather than an ordinary event clause. Its original concepts, arguments, degree and modifiers remain conditions. A property is not replaced with an opaque phrase.
- An event expressed as a noun can align through WordNet derivational links. Derivational matching uses event/process/state/phenomenon/action noun senses, excludes person/artifact senses, and requires a unique anchor. Exact noun matches can still have the wrong sense; this does not implement general word-sense disambiguation.
- Declared AMR degree, quantity, organization/relationship-role and rate structures are typed as structural relationships. Their arguments may be entity/event values without being new asserted clauses. Unknown ordinary clause complements still refuse.
- `sound-01 ARG1` creates a sound context with route `audio_event`. `have-purpose-91 ARG2` creates purpose scope. An already introduced nominal event can be referenced inside a descendant context without reasserting its description. It cannot escape a belief to the outer claim or cross sibling contexts. Outer and scoped references share the same candidate variable.
- An explicit two-group identity resource accepts SCOTUS/the full US court name and US/USA/full country names with compatible entity types. Uppercase acronyms are case-sensitive; the pronoun “us” is not the United States. There is no fuzzy name repair or general entity linker. The graph name is retained, with a source-alias trace.
- A rate's implicit denominator of one is licensed only with linked matching numerator, denominator and units. Unspecified plural seconds can use a `multiple` node over one-second units, without choosing an exact duration. Bare one second, an invented count or a mismatched denominator still refuses. No arbitrary unit conversion or rate-range repair is implemented.

The shared AMR compiler accepts an optional predicate-type policy; its default path is unchanged. The new `compile_typed` entry point is separate from the old retained compilation pool. There is no parser ensemble, model correction, per-claim parser choice or new rewrite request.

The [AMR specification](https://github.com/amrisi/amr-guidelines/blob/master/amr.md) explicitly uses predicates for nouns and adjectives. It also explains that AMR abstracts away from much source syntax; a deterministic converter cannot reconstruct every omitted distinction. WordNet derivations identify plausible links, not the intended noun sense. Resource references are included in `resources/name_aliases.json`.

## Examples and remaining patterns

- **Sound of fireworks exploding:** the explosion is inside a sound context owned by the sound predicate. It uses audio-event support, with no requirement for visual depiction. Assistant reading matches.
- **Rinderknecht's phone signal was attested seconds after the flames erupted:** the unspecified duration is no longer rejected as an invented numeric one. Owner, attestation and relative time survive. Assistant reading matches.
- **Closer up footage of a government building on fire:** the comparative property and depicted building now compile. Spectators watching/filming remain outside depiction; the whole reading is partial.
- **The recovery operation's goal was to keep the port open:** the operation and goal compile with purpose scope and a shared operation reference. The past tense of the goal statement is not aligned to `have-purpose-91`; partial.
- **SCOTUS is skeptical of the administration's tendency to call everything an attack…:** identity normalization now passes, but tendency/calling scope still refuses. Name normalization does not repair the rest of the sentence.
- **Scientists work with complex manufacturing tools to build the spacecraft:** work/build still lacks a purpose interpretation; compilation refuses.
- **“Qian Dan” refers to expulsion of a monk:** the noun now aligns, but a definition becomes world expulsion conditions. Incorrect automatic pass.
- **Blue Ghost Mission 1 is a lunar landing mission:** landing is treated as an actual event rather than a mission goal/type. Incorrect automatic pass.
- **Phillies fan son's birthday:** the graph still changes Phillies to Phillipines. Identity checks correctly reject it.
- **A 2021 Bloc Québécois map with not as much red:** year/name changes and the comparative reading remain wrong.
- **Wipha moves at 20–25 km/h:** the one newly flagged old pass contains distances without the hourly denominator. Wipha also becomes a railway line. The refusal exposes an old error; it is not a lost faithful reading.
- **A sign with the rallying cry “Carlos Manzo lives!”:** an unrecognized written-text construction produces an actual living event without OCR scope. Incorrect automatic pass.

The largest graph-conversion stop remains unhandled complements: 421 of 590. Other graph stops include coordination scope 49, negative-argument scope 41, duplicate roles 20 and event-scope re-entry 19. Among the 226 flagged programs, overlapping source flags include 147 proper-name omissions, 88 changed names, 46 unsupported numeric values, 42 omitted numbers and 17 amount/unit bindings. Counts describe software diagnostics, not a complete linguistic taxonomy or independently verified failures.

## Validation

All 581 workspace tests pass. Seventeen new contrast tests cover sound/negation, comparative argument preservation, purpose without achievement, descendant nominal references, refusal to project out of belief, unsupported modal scope, unique event-noun alignments, unrelated names, acronym case/type, denominator changes and unspecified plural duration. Default AMR 2,375 outputs, including 1,425 exact programs, plus the earlier 2,375-original/449-cached-rewrite paths reproduce exactly.

Four actual new programs—sound, closer footage, recovery goal and a linked rate—each run through native DeepProbLog with two constructed inputs: all unknown, or independent probabilities 0.90 supported / 0.05 refuted / 0.05 unknown. All eight results match analytic distributions. They use the existing grouped categorical solver and placeholder candidates, with a 15-second process bound. These are engineering checks, not real media evidence, calibration, throughput or training results.

Earlier development outputs are preserved separately and excluded from final statistics. One early diagnostic exposed the denominator regex matching “s” at the start of “second”; another exposed legitimate references to an outer operation inside its purpose. Both were fixed before the final frozen corpus run. All 34 earlier source ZIPs and 26 original viewer files remain immutable.

## Reproduction

The source ZIP is an overlay containing code, cached inputs, final outputs, readings, judgments and excluded development snapshots. It needs the existing Python dependencies and WordNet data; no model weights, GPU or network are needed for cached replay.

```sh
PYTHONPATH=scripts python scripts/run_amr_types.py
PYTHONPATH=scripts python scripts/analyze_amr_types.py
PYTHONPATH=scripts python scripts/profile_amr_types.py
PYTHONPATH=scripts python scripts/replay_amr_correction_legacy.py
PYTHONPATH=scripts:tests python -m pytest tests/test_amr_types.py -q
```

`compiler_freeze.json` hashes the final compiler before the final full sweep. `preserved_files.json` protects historical source/viewer artifacts. The report remains in `compiler-demos.html` with five views and two Reports cards; earlier experiments move under History. Final archive and browser proofs are published alongside the report downloads.

## Proposed next steps and goals

1. Keep definitions, missions and requests in their intended context. Goal: avoid treating an event noun as a claim that the event occurred.
2. Distinguish event nouns from objects/results. Goal: interpret a drill as a tool and a ruling as a decision when that is the source meaning.
3. Evaluate one compiler on new-source references. Goal: measure faithful compilation and false passes before more generation or relation training. The current review is development evidence, not a basis for a corpus accuracy claim.
