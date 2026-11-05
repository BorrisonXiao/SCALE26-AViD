# Claim scope and missing content — 5 November 2026

This revision addresses the two compiler tasks authorized after the user reviewed
examples: keep embedded events in their intended contexts, and retain essential
source content or report its omission. It does not change ADR-023 or introduce
sentence rewriting, parser selection, media inference or relation training.

## Scope repairs

`preserve_content_scope` in `scripts/probabilistic_verification/scope_coverage.py`
uses explicit dependency paths, prepositions and a limited lexical table. It
transforms the copied logical form before the existing compiler emits predicates.
The original texts, input parses and historical source archives are preserved.

- **Preparation:** In the Blue Ghost example, the existing landing frame moves
  from a separate main assertion into the preparation's `purpose` proposition,
  itself inside `depiction`. Preparing for a landing does not assert a landing.
  If only a goal noun exists, the compiler retains that noun as goal content;
  it does not invent an event or actor. Ordinary prepare dinner is unchanged.
- **Investigation:** The violation frame moves from a person-relative description
  to a `complement` proposition owned by investigation. The subject-plus-gerund
  construction and into relation license this reading. Explicit ordinary relative
  clauses are not universally moved. Results still indicate an attributed
  conclusion about unsubstantiated accusations.
- **Question:** The copula/WH dependency path connects why they are there to
  dialogue. Its kind becomes `question`, with why retained as `question_word`.
  It is no longer a separate world event or a causal argument. They stays unresolved.

These use the existing purpose/complement/question kinds and the existing scoped
predicate inputs. No new probability aggregation rule is introduced. Scope remains
part of the evidence input: evidence for a goal or investigated content must not
be replaced by evidence for an actual world event. Constructed native tests show
that refuted world landing evidence does not refute supported preparation-goal
content. Missing scoped evidence still yields unknown.

## Content repairs and audit

- A narrowly constrained root correction recovers creaks, which the cached parser
  labeled a plural noun. It requires an immediately preceding singular nominal,
  an inflected-verb lexicon match and a finite while/when subordinate clause.
  The dolly becomes its grammatical subject; small attaches to the dolly. The
  existing builder recovers the frame and while relation; moving chairs remains
  a purpose. It still needs reference resolution: no dolly/it identity is guessed.
- A connected, contiguous proper-name component retains Bering Straight and four
  Sagaing Fault mentions. Expansion includes the entire earlier span, preventing
  truncation of Blue Ghost Mission 1 or LBHP Boat 1. The source spelling is unchanged.
- A postnominal identifier property retains 76 in news76 and120 on one highway
  sign. Counts before a noun keep their quantity interpretation. Numbers already
  inside complete names, such as Apollo11, gain no redundant constraint.

The audit compares original nouns, names, lexical predicates, modifiers and numbers
with reachable translated values. It ignores IDs, schema keys, unused declarations
and warnings. Inflection and existing comparison operators are recognized. A
same-predicate NOT can account for an original never, following the existing model;
this does not add a temporal theorem prover.

`compile_scope_coverage(record)` is strict by default. Unaccounted content raises
`LogicalFormError` with code `coverage_omission` and a diagnostic candidate attached.
The census retains that candidate and its program, clearly marking it unaccepted.
Passing is only necessary lexical coverage: words in a wrong role or an opaque
clause string can still pass. Some legitimate paraphrases may be flagged. Functional
operators, scope, senses and coreference still require separate checks/review.

The existing `compile_reviewed_srl` gains one optional `transform_form` callback.
Its default path is unchanged on all2,375 complete saved records. This shares the
existing duration/reference handling instead of duplicating the compiler.

## Measured results

Run: `exp/probabilistic_verification/scope_coverage_20261105/`.

- All2,375 original cached inputs rerun. Exactly the same2,099 claims have executable
  candidates;276 earlier parser/compiler refusals remain. Eleven program hashes
  change: six discussed examples, four Sagaing Fault names and one highway identifier.
- **1,839 pass the new coverage check;260 require review.** This acceptance decrease
  is the audit's effect, not a measured accuracy gain or a loss of executable
  candidates. All11 user-faithful programs remain byte-identical and accepted.
- Alerts include missing nouns in106 claims, modifiers in100, names in93, numbers
  in78 and lexical predicates in6. Categories overlap. Every alert retains its
  exact tokens and diagnostic program. In a seeded12-alert assistant inspection,
  all12 have real omissions; this is not a precision estimate for all260.
- **228 selected regression checks pass**, including native supported/refuted/unknown
  goal-context tests, input immutability, existing probability/gradient checks,
  full-name preservation and numeric/goal controls. Constructed evidence is not
  perception output or a training experiment.
- A new20-case sample was reserved before changes, excluding150 recorded review
  sources and prior IDs/duplicate texts.150 claims were eligible; selected cases
  have mutually disjoint actual source videos. All texts had been parsed earlier;
  sampling is nonuniform and does not constitute a fully held-out corpus.
- The compiler-author assistant froze claim-only readings before examining outputs.
  All20 programs/statuses are unchanged:9 faithful,5 partial,2 incorrect,4 refused
  in both conditions. No new human references or fresh semantic gain are claimed.
  The rules changed one other claim in an excluded development source group, the
  highway sign; its identifier improves but its earlier speech/OCR route error remains.
- Remaining fresh failures include timelapse content outside depiction, a personal
  name mixed with a label, rocket landing hidden in a time string, and aftermath
  classified as location. Coverage passes on these because their words survive.
- The cached full loop took28.01s excluding upstream parsing/input loading. No new
  GPU, model request, sentence rewrite or media call. Larger native throughput
  remains unmeasured; the earlier long-protest timeout is not solved by this round.

## Freeze and reproduction

Final compiler sources were frozen before fresh output inspection. Development
found a name-expansion regression that shortened existing complete names; it was
fixed and tested before the freeze. Numeric operator lexicalizations prevent
straightforward false alerts. No compiler change follows the fresh/alert reviews.

From the project root or an independently extracted source archive, install the
archived requirements and NLTK WordNet, then run:

```bash
PYTHONPATH=scripts python scripts/replay_scope_coverage.py
python scripts/analyze_scope_coverage.py
PYTHONPATH=scripts python -m pytest tests/test_scope_coverage.py tests/test_reviewed_srl.py tests/test_scoped_srl.py tests/test_compilation_followup.py tests/test_semantic_srl.py tests/test_srl_graph.py tests/test_logical_form_v2.py tests/test_logical_form.py tests/test_predicate_compilation.py tests/test_semantic_compiler.py tests/test_multimodal_verification.py tests/test_probabilistic_verification.py -q
python scripts/build_scope_coverage_report.py
```

The new source bundle overlays the preserved previous bundle. Earlier frozen source
copies and original published ZIPs remain unchanged. The optional callback changes
one current source file, so old source-hash assertions should be run from their
original archived sources. The new replay checks the current freeze and exactly
reproduces every new and previous record, including all diagnostics and programs.

Proposed next steps: repair recurring apposition/numeric/nominal alert families to
recover coverage; handle opaque clauses and source/label boundaries to catch
structural errors; resolve local references and profile larger programs before
expanding media experiments. These next steps are not implemented in this round.
