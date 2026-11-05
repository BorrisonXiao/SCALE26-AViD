# Numbers, appositions, lists and clauses — 5 November 2026

The user authorized the next two compiler steps and requested that the existing
compiler-demos page also contain a linked daily log. This round keeps one
SRL/dependency translation of unchanged original sentences. ADR-023 is unchanged.
Reference resolution, larger-program profiling and LLM rewriting remain deferred.

## Implementation

`compile_content_relations` in `scripts/probabilistic_verification/content_relations.py`
uses copied annotations and an optional logical-form transformation in the previous
compiler. Its default historical path is unchanged. There is no parser selection,
new model call, media inference or relation-training experiment.

- **Identifiers:** retain a following number for declared label nouns (including
  robot, lane, mission and the earlier identifier vocabulary), or a joined name
  such as IM-1. Keep the number on its own participant. A general postposed-number
  rule incorrectly labeled a date and a party tally in development; it was
  restricted before the final source freeze. A wrong dependency attachment, such
  as three attached to Robot rather than lane, remains flagged.
- **Quantities:** retain multipliers and scale words, such as 1.2 million residents.
  Preserve approximation in a travel measurement. Currency amounts are amount
  properties rather than groups of currency objects. An explicit between/and or
  to range becomes minimum_count and maximum_count properties, or a duration
  argument for the existing last predicate. These conditions require matching
  evidence functions; no media-counting model was added.
- **Appositions:** use the full source name and explicit comma/parenthesis bounds.
  Build the nominal description, including local nominal coordination. An appos
  relation records grammatical apposition; it does not hard-code identity or
  geographical containment. Earlier guards against false names remain.
- **Lists:** use an explicit colon, apposition and nominal coordination to rebuild
  each list member. Keep local of-party relations. A shared co-leaders title owns
  the two named people, rather than being an extra individual. They/them remains
  an explicit reference requirement.
- **Clauses:** relink an existing finite how-clause frame under describe/explain/
  investigate when its explicit subject and dependency path are available. For a
  restricted present is-where construction, build the event and bind its stated
  participants to the stated location. Past/modal/negated copulas are excluded.

The initial 38-file source freeze and 290 tests preceded the 12-case diagnostic
review. A later code audit found that appositive OR alternatives must not become
AND member groups. A narrow guard and an extra control produce the final 291-test
freeze. The first freeze is preserved in `pre_guard_frozen/`; exact replay checks
that every corpus output and the diagnostic review remain unchanged. Do not call
the final source an untouched pre-review freeze. The first exploratory census is
also retained. This is not a held-out evaluation: corpus texts, changed summaries
and development examples had been processed before. Original human review bytes
and edits remain unchanged.

## Measured results

Run: `exp/probabilistic_verification/content_relations_20261105/`.

- All 2,375 original cached inputs rerun: **1,924 pass checks**, versus 1,866.
  **58 newly pass**, with no earlier pass or executable candidate lost.
- **2,103 executable candidates**, unchanged. 67 program hashes change. All 11
  programs previously rated faithful by the user remain byte-identical and pass.
- 54 earlier lexical alerts now pass. Two leader-list alerts and two hidden-clause
  alerts now pass. Remaining outcomes: 173 lexical alerts, 6 hidden-clause alerts
  and 272 parser/compiler refusals. No unexpected exceptions occurred.
- Remaining lexical alerts overlap: 86 contain nouns, 52 adverbs, 49 proper names,
  45 numbers,39 adjectives and 7 verbs. These are missing-token categories, not
  semantic error rates. Every claim, missing token and reason is saved.
- **291 selected regression checks pass**, including 3 native DeepProbLog count
  tests. Constructed counts 70,80 and unavailable produce supported, refuted and
  insufficient-evidence outcomes for the 67-to-75 range. Earlier OCR/speech and
  gradient checks also pass. No new training or media capability is demonstrated.
- A seeded post-freeze 12-case sample from newly passing cases outside the 18
  explicit development cases retains all 12 targeted pieces. Compiler-author
  inspection still finds older defects, including a transition treated as a noun,
  an opaque back-up phrase and nominal suspicion semantics. No independent human
  gold, corpus accuracy or held-out semantic gain is claimed.
- The cached census loop took 30.96 seconds, excluding upstream parsing/input load.
  This is not native inference/training profiling.

Six clause candidates remain refused, with saved diagnoses: a main verb buried in
a quoted noun phrase; overlay/relative-clause attachment; a basin/impact/eruption
relative-clause subject; mixed nominal and interrogative objects; a comparative
the-more/the-more construction; and a conditional as-long-as reading. Some already
contain event nodes but retain questionable bindings; removing long strings alone
would not establish correctness.

## Report and reproduction

`scripts/build_compiler_demos.py` reads saved outputs and generates
`site/reports/compiler-demos.html`. Its five tabs are Latest changes, Simple demos,
Full saved outputs, Results and limits, and Daily log. The 41 demos include all 28
earlier cases and 13 new cases. Each keeps the exact claim and historical baseline.
All 2,375 current outcomes remain inspectable. Earlier daily entries are selected
milestones reconstructed from saved reports and project notes, not a complete
history. Hash links open the corresponding tab or step; claim links open the exact
walkthrough or output. Keep this daily log current after future completed work.

The source ZIP includes code, cached inputs, prior/current outputs, source freeze,
reviews and report generators. The previous round's original ZIP is retained at
`site/reports/compiler-demos/history/content-recovery-20261105-source.zip`.

From an extracted source archive, using the bundled requirements and NLTK WordNet:

```bash
PYTHONPATH=scripts python scripts/replay_content_relations.py
python scripts/analyze_content_relations.py
PYTHONPATH=scripts python -m pytest tests/test_content_relations.py tests/test_content_recovery.py tests/test_scope_coverage.py tests/test_reviewed_srl.py tests/test_scoped_srl.py tests/test_compilation_followup.py tests/test_semantic_srl.py tests/test_srl_graph.py tests/test_logical_form_v2.py tests/test_logical_form.py tests/test_predicate_compilation.py tests/test_semantic_compiler.py tests/test_multimodal_verification.py tests/test_probabilistic_verification.py -q
python scripts/build_compiler_demos.py
python scripts/package_content_relations.py
```

Proposed next steps: review recovered outputs with the user to check the intended
relationships; inspect remaining measurements and mixed noun/clause objects to
choose another bounded repair set. Keep ambiguous cases refused. These steps are
proposals, not completed experiments.
