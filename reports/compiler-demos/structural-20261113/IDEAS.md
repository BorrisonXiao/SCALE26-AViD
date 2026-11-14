# Candidate approaches — compiler frontend

DRS means Discourse Representation Structure: a scoped logical representation of referents and conditions. An abstract syntax tree (AST) represents the structure of a logical expression.

Eleven grounded alternatives, not a ranked list or changes to the accepted paper direction. Feasibility numbers are planning estimates. Compiler validity, faithful meaning and media support remain separate.

## i1: Pretrained DRS parsing with a deterministic logic converter

Use an existing logic-oriented neural parser rather than infer full semantics from verbal SRL.

Hypothesis: Explicit scope boxes may reduce quote, negation and modal attachment errors.

Method: Reuse a released DRS parser if weights are available; translate its boxes, referents and conditions into the existing logical form. Keep original-span alignments and refuse unsupported conversions.

First experiment: First establish checkpoint access, then compare 30 fixed scope-heavy claims with the current compiler.

Prior work: Zhang, Bouma and Bos 2025 (p10); Pustejovsky et al. 2019 (p11). Compute: 1-6 GPU-hours for inference; checkpoint availability unconfirmed (planning estimate). Data: Existing claims; structured meaning references still needed. Risk: high.

Positive: better scope without extra training. Negative: unavailable weights or conversion errors dominate.

## i2: A small source-conditioned neural ranker

Score whether each candidate graph preserves the source sentence.

Hypothesis: A cross-encoder can use lexical roles and scope rather than compiler scores alone.

Method: Encode the original sentence together with a deterministic rendering of a candidate graph. Train only a small head or a compact text cross-encoder on checked positive/negative graph pairs; keep the candidate generator fixed.

First experiment: Measure leave-video-out ranking on checked pairs, with majority, likelihood and simple edit-cost controls. Do not claim performance from resubstitution on 63 outputs.

Prior work: Cheng and Lapata 2018 (p7). Compute: 1-4 GPU-hours after annotation (planning estimate). Data: At least 100-200 newly checked candidate pairs; current 63 judgments are insufficient for a credible held-out claim. Risk: medium.

Positive: ranks faithful alternatives above role/scope errors. Negative: lexical leakage or no gain over simple controls.

## i3: Marginalize over alternative logical forms

Represent parse uncertainty as mutually exclusive choices before evidence verification.

Hypothesis: Retaining ambiguity may improve calibration compared with choosing one parse or OR-ing all readings.

Method: Use one parser to produce a bounded deduplicated candidate set, learn/calibrate source-only weights and retain probability for no adequate parse. Compile the categorical parse choice and shared evidence variables into probabilistic logic.

First experiment: Check the mixture semantics on authored native examples, then compare calibration and cost on source-disjoint manually judged candidates.

Prior work: Krishnamurthy et al. 2016 (p6); Park et al. 2024 (p5). Compute: CPU engineering checks; 1-6 GPU-hours for candidate generation (planning estimate). Data: Checked candidate meanings and source-disjoint calibration labels. Risk: medium.

Positive: uncertainty tracks genuine ambiguity. Negative: confidently weighted wrong parses or no faithful candidate; report both.

## i4: Generate logical structure through typed grammar actions

Constrain the decoder using the current partial AST and well-formedness conditions.

Hypothesis: Earlier type/scope checks can reduce wasted invalid candidates.

Method: Generate create-node, bind-argument and attach-scope actions with a source-specific symbol table. Use one incremental AST checker rather than per-word post-processing.

First experiment: Compare one fixed action decoder and current JSON edits on the same 40 failures, checking full meaning and latency separately.

Prior work: Scholak et al. 2021 (p1); Poesia et al. 2022 (p2); Nagy et al. 2026 (p12). Compute: 1-4 GPU-hours (planning estimate). Data: Current parser inputs and checked outputs. Risk: medium.

Positive: fewer malformed outputs at equal meaning accuracy. Negative: types pass while relationships remain wrong.

## i5: Contrastive consistency across related claims

Use known local meaning changes to test or train the semantic parser.

Hypothesis: A parser that tracks controlled role, scope and source changes has fewer spurious readings.

Method: Create reviewed subject/object, quote/world and negation contrasts; require equivalent paraphrases to yield equivalent graphs and meaning changes to affect the corresponding subgraph. Use consistency as training evidence only after checking examples.

First experiment: Construct 30-50 contrast pairs across new videos and measure graph differences, not only verdict agreement.

Prior work: Gupta et al. 2021 (p8). Compute: 0-2 GPU-hours (planning estimate). Data: New manually checked contrasts; some earlier edits can seed development only. Risk: low.

Positive: exposes systematic bindings and supplies useful local labels. Negative: transformations are unfaithful or the parser can satisfy shallow lexical tests.

## i6: Soft neural scores for relationships with global constraints

Treat parser links as uncertain features rather than mandatory edges.

Hypothesis: Soft structural prediction can override a wrong dependency edge while maintaining a valid graph.

Method: Score candidate argument, modifier and scope links with a frozen encoder plus small classifiers. Apply hard constraints only for declarations/types/acyclic scopes and globally normalize or decode compatible structures.

First experiment: On checked constructions, compare hard dependency constraints with soft scores and identical graph candidates.

Prior work: Cheng and Lapata 2018 (p7); Krishnamurthy et al. 2016 (p6). Compute: 2-8 GPU-hours after graph annotations (planning estimate). Data: Several hundred checked link/scope labels; not obtainable from pass/fail errors alone. Risk: high.

Positive: corrects annotation disagreements. Negative: weak labels cannot identify the intended graph or search becomes costly.

## i7: Repair partial ASTs while preserving checked fragments

Separate missing structure from already validated local constraints.

Hypothesis: Structural repair can recover claims without unnecessarily regenerating complete graphs.

Method: Keep actual partial compiler state and source anchors; allow bounded subtree replacement. Preserve only independently checked fragments as hard constraints, keeping parser-only suggestions defeasible.

First experiment: Evaluate the fixed 20 existing-draft/20 partial-draft diagnostic with generic versus compiler feedback; inspect every complete output.

Prior work: Poesia et al. 2022 (p2); Nagy et al. 2026 (p12). Compute: 1-3 GPU-hours (planning estimate). Data: Current real claims and saved annotations. Risk: low.

Positive: new faithful repairs from saved partial state. Negative: more executability without preserved meaning.

## i8: Calibrate selective acceptance on unseen source videos

Measure coverage only at a checked reliability level.

Hypothesis: Abstention can expose the large gap between valid structure and faithful meaning.

Method: Combine source-only parser confidence, typed-check outcomes and candidate disagreement into a calibrated acceptance score. Keep meaning uncertainty separate from insufficient media evidence.

First experiment: Collect 100-200 video-disjoint meaning judgments; report coverage versus error and failures to find a faithful candidate.

Prior work: Park et al. 2024 (p5); Cheng and Lapata 2018 (p7). Compute: CPU calibration; 1-2 GPU-hours for fixed candidate features (planning estimate). Data: New video-disjoint labels; development judgments cannot establish calibration guarantees. Risk: low.

Positive: useful coverage at low error. Negative: no threshold transfers across video sources; disclose the shift.

## i9: Bidirectional generation as a faithfulness diagnostic

Compare the original sentence with a text rendering of each candidate graph.

Hypothesis: Back-generation may reveal omitted or swapped relationships that word coverage misses.

Method: Use a frozen graph-to-text model or a deterministic rendering and bidirectional text entailment. Treat this as an auxiliary diagnostic; it can repair a bad graph silently or miss fine distinctions.

First experiment: Compare its scores against existing checked role/scope errors and an edit-cost baseline without tuning on the final test videos.

Prior work: Cheng and Lapata 2018 (p7); Bevilacqua et al. 2021 (p9). Compute: 1-3 GPU-hours (planning estimate). Data: Checked graph pairs and original sentences. Risk: medium.

Positive: flags some errors cheaply. Negative: fluent back-generation hides wrong structure, so never a proof.

## i10: A flat typed semantic graph as the common output

Let one neural decoder emit nodes and labelled edges, then compile deterministically.

Hypothesis: Explicit IDs and separate scope edges may be easier to generate than deeply nested JSON.

Method: Use entity/event/operator nodes with argument and context edges; validate reachability, declaration and scope before converting to the existing logical form. Keep this a single parser path, not selection among frontend models.

First experiment: Compare equivalent flat and nested output formats on the same fixed claims, with identical source input and reviewed meanings.

Prior work: Raspanti et al. 2025 (p3); Bevilacqua et al. 2021 (p9). Compute: 1-4 GPU-hours (planning estimate). Data: Current claims and matched graph references. Risk: medium.

Positive: less duplication or invalid nesting. Negative: only a serialization change with no semantic gain.

## Removed alternatives

- Retrain a general-purpose SRL model: Outside the user constraint and unnecessary before assessing existing pretrained models.
- Learn the entire parser from supported/refuted claim labels alone: Unidentified latent meanings can obtain correct verdicts for the wrong reason; not a sufficient faithfulness signal.
- Treat a generic AMR-to-logic converter as an untested new solution: The project already has AMR experiments; scope and source alignment remain conversion obligations.

## i11: A fixed AMR frontend with compositional logical semantics

The existing cached AMR supplies the wind-speed causer and attributed-statement structure. Test one neural frontend with a recursive AMR-to-logic translation based on Bos2016/Lai etal2020. This is infrastructure, not a new-paper novelty claim. Keep source alignment and explicit scope checks, and compare on checked reference meanings rather than selecting a different parser for each sentence. The robot and charger AMRs remain counterexamples to blanket trust. Planning estimate: CPU cached-graph work,1-2GPU-hours for new n-best decoding; medium implementation effort.
