# Report consolidation and the remaining449 claims —12 November2026

The user requested fewer report pages/tabs and fewer interim progress updates, and asked what explains the remaining19% and the limitations of rewriting. This update consolidates existing evidence; it does not run a new model/compiler experiment or finalize the rewrite layer.

Reports/index.html now has two main entries: the current compiler/rewrite report and the verification implementation/checklist. Earlier report URLs remain valid and are listed in the current report's History. No extra HTML report was added. The compiler report has five views instead of eight: Overview, Examples, All claims, Daily log and History. Overview replaces accumulated progress narratives with one current explanation. Current rewrite examples and earlier41 compiler demos share Examples. Historical metrics, alert review, one-sentence rewrite and initial split comparisons share History. Old fragment/query links still open the matching section; source archives and original viewer data are preserved.

## What the remaining19% means

The current dataset has2375 claims;1926 pass content checks with two reviewed automatic substitutions, so449=18.91% remain. The frozen direct compiler alone passes1924. These are compilation coverage counts, not semantic accuracy.

Only31 original failures have been tested by the fixed rewrite experiments. Two recover in the selected sentences-only condition,29 still fail, and420 remaining claims have not been rewritten. It is unsupported to say that rewriting has failed on all449, or to extrapolate2/31 to the420 untested claims. The31 were deliberately selected development cases, not a random sample.

The first rejection codes in the saved449 results group as follows:

| First check | Count | Codes |
|---|---:|---|
| Parser/compiler cannot form required predicates |227|109 unresolved clauses;59 duplicate roles;34 missing predicates;11 missing SRL;8 predicate type;6 opaque clauses|
| Candidate omits original content |173|coverage omission|
| Unsupported operators/value types |43|16 modal scope;10 negative quantification;8 nominal alternatives;3 quantity typing;2 thresholds;2 polarity;2 temporal scope|
| Explicit reference/context checks |6|3 mention alignment;2 media modifiers;1 implicit controller|

These are mutually exclusive first-stop diagnostics, not mutually exclusive semantic causes. Source, quantity and reference problems can appear in the first two rows.179 failures already have a flagged program;270 have none.

The179 candidate IDs exactly match the earlier alert review:166 apparent local gaps,5 likely overstrict word checks,8 uncertain readings. Primary families include56 numbers/dates/units,34 arguments/lists/noun phrases,25 names/descriptions,24 modifiers/scope,18 source/quotation,16 phrasal/directional and6 embedded clauses. The earlier review was compiler-author diagnosis, not independent whole-claim correctness.

## Why the rewrite pipeline currently fails

- **Compiler restrictions can survive a simpler sentence.** “Two trucks drive along a dock towards the ship” fails because two distinct entity-valued direction arguments occupy ARGM-DIR. srl_graph.py permits some repeated literal adjuncts but rejects distinct entity-valued arguments for the same role. This is a representation/conversion limitation; the sentence need not be linguistically complex. Some repeated roles are genuine bad parses, so accepting all duplicates would be unsafe.
- **Unsupported meaning needs implementation.** “The video has no audio” needs an absence statement about possible audio events. Creating an audio entity outside a negated event would assert its existence. Speeds/ranges/time values need appropriate value types, not object counts. A shorter sentence does not add these operations to the compiler.
- **Alignment is conservative.** Robot1/Robot2 share a noun head but have explicit identifiers the current aligner does not use. A useful second-shot split lacks the simple source sentence the composition adapter expects. These are refusals of potentially useful text, not proof of bad simplification.
- **Generation can change meaning.** Observed changes include positive narration under no narration, construction under building housing a publisher, alternatives changed to conjunction, and quoted events asserted in the world. Faithful sentence splitting must preserve these distinctions.

The selected31-case condition has29 failures:12 component-compilation,10 entity-alignment,3 source-alignment,2 conflicting-description and2 final review rejections. Earlier stages can hide later meaning errors; the two final rejections are not the only unfaithful generated texts.

The most useful next steps are proposals: audit repeated adjuncts/explicit IDs first; define measurement and absence semantics; then evaluate a stratified sample of420 currently untested failures before finalizing rewriting. Avoid spending the next round only revising the same prompt or repeatedly testing the same31 claims.

## Evidence and reproduction

Run: exp/probabilistic_verification/report_cleanup_20261112. analyze_remaining_claims.py recomputes counts from the saved full-corpus outputs, verifies the179 alert IDs and records source hashes. No review or frozen output is overwritten. The current report exposes failure_audit.json and all449 texts/first reasons in remaining.json. This additional descriptive inspection creates no held-out result or future claim of unseen semantic evaluation.

For source replay, extract the previously documented compiler/audit/rewrite/inspection/split/alignment overlays, then maintenance-20261112/source.zip. Validate REPORT_MAINTENANCE_SHA256SUMS. Run analyze_remaining_claims.py and build_compiler_demos.py with the existing probabilistic-verification environment; no GPU or NLP model load is needed. The dated package contains this update's source and notes and preserves earlier archives. Browser/link/publication proofs are recorded separately.

No compiler/rewrite code, experimental judgments, model output, earlier ZIP or original viewer JSON changes. The pass counts remain1924 direct and1926 including the same two reviewed automatic splits.
