# Human review and compiler revision — 5 November 2026

The original returned review is preserved byte-for-byte in
`exp/probabilistic_verification/review_followup_20261104/received_review/20261105-1a3a8fd47e72a50f4943.json`.
Its SHA256 is `1a3a8fd47e72a50f4943c10ae129608b8e6187d57547810921716509f02d2e20`.
All 20 readings and comparisons were confirmed and imported. This is human review
assisted by the earlier independent agent draft; it is not an unaided reference set.

The 30 October compiler received 11 faithful, 6 partial and 1 incorrect compiled
judgments, plus 2 refusals (1 appropriate, 1 not). The 1 November compiler received
11 faithful, 4 partial and 1 incorrect, plus 4 refusals (1 appropriate, 3 not).
Six of 40 ratings differ from the original agent suggestions. The 16 cases compiled
by both versions have tied judgments; two partial outputs became refusals judged
unnecessary. Preserve these user judgments, including their current tolerance for
the passive-progressive simplification and for a complete difficult noun phrase
remaining one verification argument.

## Implementation

The opt-in entry point is `compile_reviewed_srl(record)` in
`scripts/probabilistic_verification/reviewed_srl.py`. There is one deterministic
path through the existing SRL/dependency graph and scoped compiler. It refines
copied annotations, preserving the source sentence and input records. Earlier
compiler modules are unchanged. No LLM sentence rewriting, parser selection,
media inference, GPU allocation or new relation-training experiment is used.

Three families were addressed:

1. Retain argument details: complete marked quotations, next-to targets and their
   names/modifiers, and report topics separated from a background location.
2. Retain coordination and participant links: a verb lexicon plus an explicit
   shared subject can recover a participial conjunct; explicit relative-clause
   actors can control an embedded predicate; reciprocal arguments stay tied to
   the same event/group instead of becoming an unrelated entity called other.
3. Handle nominal alternatives: an unresolved phrase may remain one exact
   `noun_phrase` argument; a descriptive comma-or gloss can use an explicitly
   recorded appositive reading, sharing its described entity across modifiers.

A `reciprocal` literal means that the target is other members of the group supplied
to the same event. A relation verifier must score that complete tuple; ordinary
facing evidence or two unrelated events cannot substitute for it. The backend
supports the typed input and returns unknown without corresponding evidence. This
is a verifier-input contract, not a newly trained visual/audio model.

A coarse noun phrase deliberately leaves internal relationships unexposed. The
comma-or appositive interpretation is recorded as a context/review requirement,
not a general semantic-equivalence guarantee. Numbered roles remain predicate
specific. Named prepositional adjuncts can retain their grammatical relation when
the original manner classification is unsafe; no place classification is guessed.

## Measured outcomes and limits

Run: `exp/probabilistic_verification/compiler_revision_20261105/`.

- Full 2,375 original texts: **2,099 compiled**, comprising 1,926 claim structures
  and 173 nominal descriptions; 276 refused. The preceding compiler accepted 2,095.
- Four additions, no earlier accepts lost, and 29 changed programs. Three earlier
  false refusals identified by the user now compile. Three of the 15 accepts lost
  in the previous revision are restored; 12 remain refused. No unexpected Python
  exceptions occurred. Acceptance is not a correctness score.
- All 11 current programs the user rated faithful remain byte-identical. Targeted
  structural requirements pass; changed programs have not received new human ratings.
- 207 regression checks pass, including three reciprocal supported/refuted/unknown
  native checks, name/controller counterexamples and prior probability/gradient tests.
- The final cached full loop took about 25.98 seconds, excluding upstream parsing
  and input-file reading. No whole-corpus inference/training throughput is claimed.
- Four of five bounded native checks return unknown as expected with constructed
  missing evidence. The long protest/controller program times out at 25 seconds
  including process startup. Raw stages and timeouts are preserved.

The fresh sample was fixed before changes: 20 cases across 21 actual source videos,
with no overlap with 129 recorded review sources or between selected cases. There
were 273 eligible claims after ID/source/duplicate-text exclusions. All corpus
texts had been processed previously; this is not a fully held-out or uniform sample.

The compiler-author assistant saved intended readings before inspecting anonymous
outputs. Every fresh program is unchanged from the preceding version. Both receive
13 faithful, 4 partial and 3 incorrect assistant judgments, with no refusals. One
faithful rating uses the user's current passive-progressive tolerance; counting it
as partial yields 12/5/3. These are qualitative assistant judgments, not independent
human accuracy measurements, and they demonstrate no fresh gain.

The remaining errors include actual landing outside a preparation/video scope,
an alleged violation treated as an asserted relative description, dialogue question
content projected to a world event, a dropped creaking/dolly clause, and lost name
or identifier material. The compiler remains experimental.

## Freeze chronology and reproduction

The first compiler freeze and 204 passing checks preceded fresh output inspection.
The first full census and source snapshot remain in `first_frozen/`. A separate
changed-case audit exposed unsafe name and controller additions. Two safety
restrictions were then applied: controllers require a participial relative, and
names require adjacent apposition with guards against lists and relative subjects.
The final 207-test source was frozen again. All 20 fresh output hashes remain
identical to the first freeze and the 1 November baseline; readings and ratings
were not rewritten. See `fresh_preservation.json` and `safety_restrictions.json`.

Install the archived requirement files plus NLTK WordNet. From the project root or
extracted source archive:

```bash
PYTHONPATH=scripts python scripts/replay_reviewed_srl.py
python scripts/analyze_reviewed_srl_results.py
PYTHONPATH=scripts python -m pytest tests/test_reviewed_srl.py tests/test_scoped_srl.py tests/test_compilation_followup.py tests/test_semantic_srl.py tests/test_srl_graph.py tests/test_logical_form_v2.py tests/test_logical_form.py tests/test_predicate_compilation.py tests/test_semantic_compiler.py tests/test_multimodal_verification.py tests/test_probabilistic_verification.py -q
python scripts/build_reviewed_compilation_report.py
```

The source bundle includes original inputs, cached upstream parses, both compiler
outputs, the returned review, fresh claim-only readings and assessments, source
freezes and the report generator. The replay compares complete records, not only
acceptance counts. Archived earlier report ZIPs remain unchanged.

Next: address nonveridical nominal/question content, check original predicate and
identifier coverage, and establish a practical inference bound before expanding
media experiments. ADR-023 remains the paper direction.
