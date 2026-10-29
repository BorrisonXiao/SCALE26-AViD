# Original-claim compilation, 29 October 2026

The text parser reads the unchanged claim and produces a JSON **logical form**:
an explicit record of its entities, events, arguments, operators and clause
structure. `ScopedCompiler` in `logical_form_v2.py` translates that record into
the existing three-state DeepProbLog backend. It does not judge world truth or
the faithfulness of the parser. No sentence-rewriting function is implemented.
The historical compiler and its cached comparisons remain unchanged.

## Inputs and outputs

`ScopedCompiler.compile(claim_id, text, tokens, form)` takes the original text,
Stanza tokens with offsets/morphology, and a `version="logical-form-v2"` object.
The result contains logical variables, predicates, a compositional expression,
the original proposal, context requirements and warnings. A reference time is
supplied later; it is not today's date. The CLI is `compile_scoped_claim.py`.

Entities have unique IDs, exact source mentions, a type, optional properties,
relations to other entities, and optional quantity conditions. Events have
unique IDs, a predicate, a source anchor and a role-to-argument mapping. Arguments
are entity IDs or typed literals. A speed or a date is not an object candidate.
Relations inside noun phrases connect explicit referents. A collective group
can have named members without inventing one event for each member.

Formula nodes are `event`, `entity`, `and`, `or`, `not` and `qualified`.
An event or nominal source can have proposition arguments with a semantic role,
a kind, an evidence route and a recursive body. Source assertions, depictions,
questions, reasons, purposes, beliefs, conditions and temporal clauses retain
their own contexts. A clause inside a purpose or report is not an independent
world assertion. Future/possible/obligation/ability qualifications are explicit.

## What scope means in the generated predicates

Each predicate carries a `scope` value and an evidence `route`. A proposition
argument creates a new scope, links it to its parent event/referent, and passes
the parent's candidate identity into its conditions. A qualification similarly
creates a qualified context. Each local scope ID includes the claim ID so that different claims cannot share incompatible contextual observations. IDs are cache lookup identities, not neural features. This conservatively prevents cross-claim sharing even for equivalent contexts. Thus a landing reported by a narrator requires
support *inside that report*, not evidence of an actual world landing. Repeated
referents retain identity; mention modifiers are not automatically repeated in
a different context. Event negation includes event existence, with referent
conditions outside that local negation.

These are contracts for evidence functions, not a general modal theorem prover.
AND joins the conditions required to support a scoped description. It does not
license moving a scoped condition to the world. The existing backend handles
three-state composition and alternative candidate assignments; new predicates
still require appropriate evidence functions. Missing functions/observations
return **unknown**. The census uses artificial unknown observations solely to
check program construction and selected backend executions.

## Quantities, references and fragments

`group_quantity` retains the operator and value on a group candidate. It requires
a group-level counting/extent function; an ordinary object classifier is not
enough. This does not implement arbitrary universal/distributive quantification.
Pronouns create reference-resolution requirements. A bare label/name is a
`kind="mention"` request, reported separately from a complete asserted clause.
Compiling these structures does not supply missing discourse or media context.

## Checks and limits

The compiler checks IDs, source mentions, exact quotes, source anchors, argument
types, used entities and supported operators. It preserves known predicate
senses when supplied. Tense/aspect come from the source auxiliary sequence.
The diagnostic pass reports possible missing content words, context requirements,
standalone mentions and a small set of known frame issues. Word coverage cannot
detect wrong role attachment or prove semantic equivalence.

The full-corpus experiment uses all 2,375 original texts for development, as
authorized by the user. It does not use truth labels, media evidence or source
video annotations as targets. It is not a held-out generalization experiment.
Accepted programs, refusals and assistant semantic judgments must be reported
separately. The final report and artifacts are generated from the census.

## Full-corpus findings

The final SRL/neural selection compiles 1,934 of 2,375 claims, versus 1,544 under
the prior policy. Every selected program parses as ProbLog; cached CPU replay
reproduces all 2,375 outcomes and program hashes. The 134 regression checks pass.
Seventeen of nineteen bounded small native DeepProbLog checks complete with
unknown probability one; two exceed a 15-second end-to-end limit, including
startup overhead. Full-corpus inference throughput is not established.

These counts do not establish meaning preservation. A fresh twenty-case paired
assistant review finds four faithful outputs (one a standalone mention), seven
partial outputs, six incorrect outputs and three refusals. The prior policy's
counts are one, five, six and eight respectively. None of the six newly compiled
fresh cases is fully faithful. One hundred earlier sampled cases became
development diagnostics. Two post-review fixes preserve the judgments: quote
cleanup leaves all twenty program hashes unchanged; claim-specific scope IDs
change hashes but preserve every single-claim program after scope-ID renaming.
The latter also fixes cross-claim evidence-cache collisions. Complete equivalence
checks are included in the archive. The review uses no independent human gold and no
source-disjoint evaluation, so these are descriptive checks rather than corpus
accuracy estimates. The implementation remains opt-in.

The largest unresolved problems are natural-language interpretation: source and
modal scope, semantic roles, opaque noun phrases, scalar/identifier types,
quantifier attachment and event phases. Generic no-NP negative existentials are
refused because entity and event existence need joint negation. A predicate's
ordinary local negation is a different construction. Source licensing guards can
also over-refuse valid constructions such as some uses of once/would.

The next task is complete logical-form reference review and stronger semantic
parsing, followed by separate profiling of grounding/inference. More executable
outputs alone do not justify verifier training. Sentence rewriting is still not
implemented.
