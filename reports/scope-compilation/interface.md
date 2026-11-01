# Source scope and claim conditions — 1 November 2026

The opt-in entry point is `compile_scoped_srl(record)` in
`scripts/probabilistic_verification/scoped_srl.py`. Original texts, cached original
annotations, earlier compiler modules and ten historical source archives remain
unchanged. No LLM requests, rewriting, media inference or new training experiment
are used in this run.

## Implemented rules and limits

- Nominal visual-media descriptions with explicit “of” content retain depicted
  events under that source. Viewpoint descriptions remain attached to the footage.
  A preceding source predicate, including mistagged “Shows image of…”, prevents
  this nominal conversion. Unresolved clausal media modifiers are refused.
- Quoted labels/captions are protected before SRL frame recovery. Internal label
  words cannot become predicates. The complete source string becomes a literal;
  printed labels use OCR support. A quoted name/title does not automatically require
  OCR. A following participial modifier can attach to the described entity under
  an explicitly recorded reading; that attachment still requires review.
- A narrow affirmative enough-NP plus one infinitival goal retains the nominal
  argument and its sufficiency relation. For denied enough seats to form a coalition,
  the seats are not replaced by the formation event. The goal is inside a sufficiency
  context, not asserted to occur. The missing numeric threshold remains a context
  requirement. Other enough/negated constructions can be refused. This does not
  implement a general counting or degree-semantics solver.
- Supported binary nominal OR becomes inclusive alternatives, not an AND group.
  Existing modifier attachments are retained. Mixed, multiply referenced or otherwise
  unsupported alternatives are refused. This does not resolve all readings of OR.
- A leading temporal adjunct can reach a coordinated event with the same shared
  grammatical subject. An explicit second time is retained. Different coordinated
  subjects can trigger a temporal-scope refusal. An exact clock attached to a nominal
  participant is kept on that participant rather than copied to all events.

## Inference representation

A 19-observation sufficiency case exposed another cost problem in native inference.
The earlier direct-state encoding timed out at a 30-second subprocess limit during
compilation of the unknown query. A new wrapper flattens associative AND/OR,
removes repeated identical nodes, orders leaves by observation identity, and builds
balanced binary trees. NOT and evidence-combination boundaries are preserved.
This combines tree balancing and observation ordering; their separate effects were
not isolated. It is an equivalent expression encoding, not a new inference method.

The new process finishes all three states in 9.02 seconds including setup. Native
stage totals are about 0.14 seconds; unknown has probability one when sufficiency
support is unavailable. Mixed probabilities match an independent conjunction
calculation; gradients with repeated neural observations match the previous
encoding. Incomplete inventories and evidence conflicts are checked separately.
The initial 12-test run including the unbalanced full sufficiency inference passed
in 147.73 seconds; it was slow, not a semantic failure.

## Full-corpus results

Run directory: `exp/probabilistic_verification/scope_compilation_20261101/`.

- All 2,375 original inputs: prior 2,108 compiled /267 refused; revised **2,095
  compiled /280 refused**, comprising 1,924 claims and 171 nominal descriptions.
- Paired outcomes: 2,093 compiled by both,265 refused by both,15 previously accepted
  now refused,2 newly compiled. A refusal is a compiler outcome, not a false-claim
  label or automatic evidence of improved correctness.
- Changes recorded in accepted outputs include 64 depiction-route assignments,
  10 quoted-label protections,8 nominal clocks,7 nominal OR expansions,3 nominal
  media conversions,1 sufficiency goal and 1 shared-time propagation. Some outputs
  have multiple changes. Label-modifier attachment has 2 recorded readings.
- No unexpected Python exceptions in the full run. Cached census loop 24.76 seconds
  on CPU, excluding upstream parsing/loading. No GPUs or model downloads.
-187 tests pass. All per-claim outcomes, programs, refusal reasons and changed
  statuses are saved. Human semantic accuracy is **unmeasured**.

## Human reference review: prepared, not completed

Twenty claims were reserved before changes, from 20 source groups absent from 109
sources in saved earlier reviews/pilots. Selection includes 7 targeted text-pattern
cases and 13 random cases. It is not a uniform sample, a new-topic test, or a fully
held-out corpus: all 2,375 texts were processed earlier.

`reference_readings_template.json` has empty fields. The browser packet asks the
reviewer to write the intended meaning first, then shows randomized anonymous A/B
outputs with no assistant/model labels. Human ratings distinguish faithful, partial,
incorrect and unsure. Compiler refusals are assessed separately. Readings can note
ambiguous interpretations or missing context. Entries save locally and export as
JSON; the static site does not collect ratings automatically.

At publication preparation, **zero human readings and zero comparisons have been
received**. Do not call assistant checks or blank packet fields human gold.

To import an actual returned review:

```bash
python scripts/import_claim_review.py /path/to/returned-review.json
```

The importer validates packet/claim hashes, rating types and reading-before-rating
requirements. It preserves partial responses and updates the received-count status.
It does not fill missing answers or automatically publish reviewer data.

## Reproduction

Install `requirements-compilation.txt`, `requirements-verification.txt` and NLTK
WordNet. From the project or extracted source archive:

```bash
PYTHONPATH=scripts python scripts/replay_scoped_srl.py
PYTHONPATH=scripts python -m pytest tests/test_scoped_srl.py tests/test_compilation_followup.py tests/test_semantic_srl.py tests/test_srl_graph.py tests/test_logical_form_v2.py tests/test_logical_form.py tests/test_predicate_compilation.py tests/test_semantic_compiler.py tests/test_multimodal_verification.py tests/test_probabilistic_verification.py -q
PYTHONPATH=scripts python scripts/profile_scoped_srl.py
```

The profile bounds each subprocess at 30 seconds and retains timeouts. A small
constructed test set checks world evidence versus depiction, missing sufficiency
context, alternatives, shared dates, an explicit second date, quoted OR and names,
and exact clocks. It does not establish real-media verification accuracy.

## Proposed next steps and intended goals

1. Return the 20-claim human packet — supply actual intended readings and judgments.
2. Audit the 15 newly refused inputs against those readings or a separate diagnostic
   review — distinguish useful refusals from avoidable loss of coverage.
3. Fix the remaining supported constructions after that review and keep new sources
   reserved — improve meaning preservation without selecting on evaluation labels.

ADR-023 is unchanged. Verification, relation-model training and sentence rewriting
remain deferred. The human-review stage remains open until actual responses arrive.
