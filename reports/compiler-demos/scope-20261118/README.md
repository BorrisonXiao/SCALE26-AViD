# Scope repairs, provisional review and binding preparation

The scope repair pass recovers 4 provisional programs and raises coverage to 2,358/2,375 (99.28%). The remaining 17 claims have dependency analyses. 2,183 programs pass the prior compiler checks. The other 175 semantic programs
need meaning review, including the four new ones.

## Scope repairs

The repair was applied to all 21 prior dependency-only records using the existing dependency
annotations and AMR graphs. Four outputs cover three different texts. The two identical
voting rows are counted separately in the corpus.

- The voting alternatives share one actor. The if clause belongs to the last, mail-in branch.
- The signing stays inside image depiction. The likely qualification concerns the type of the
  signed object. The same object variable is used by both conditions.
- The ruling is introduced once and reused inside the unless clause. A graph declaration move
  leaves every semantic edge intact and puts the overturn condition under the requirement.
  The explicit reference keeps its enclosing variable under negation. Future timing and the
  Administration identity still need review.

The signing example fully matches its source reading. The other three are partial. The
remaining 17 inputs include nested descriptions, scope over quantified groups, malformed
graph roles and ambiguous discourse references. See the examples and exact traces in the report.

## Provisional program review

The 32-program development sample spans 33 source videos. It contains one full match, 13 partial readings and 18 incorrect readings. All 15 sampled outputs without a warning have a meaning problem. An explicit OR warning flags four of the 171 provisional programs.

The sample uses fixed quotas by compiler path and prioritizes separate source clips and topics.
This development sample does not supply an accuracy estimate for the corpus. The exact
program hashes, case IDs and per-case reasons are recorded. The OR warning is advisory
and has reviewed examples of a missing disjunction. Many unflagged cases still have wrong
names, quantities, modality or attachment.

## Binding data

Five reviewed frame-based pairs supply ten examples. Three development clips and two reserved clips have disjoint source IDs and video hashes. Three pairs use visual attributes and two use OCR. Ten ProbLog checks with manual assignments return the expected labels. No frozen features were extracted for this protocol.

Each pair uses two hypotheses with the same lexical inventory and only the assignment changed.
The task supplies two candidate referents or regions and their exact frame times. A feature
model can receive the source frames and candidate descriptions without label or variant IDs.
The label concerns the supplied frame evidence. The prepared programs come from the declared
bindings and test predicate composition with those assignments.

A translated overlay is excluded from exact OCR supervision. Its Arabic pixels do not literally
contain the English claim. The robot's referenced number and the existing music labels still
need direct review. Several other candidates were held back when the required relationship
was not identifiable from the sampled frames. The local frame manifest records source hashes,
frame positions and image hashes. Raw source media stays local. There is no model inference
or empirical training result in this pilot.

## Reproduction

Run the following from the source bundle with the existing project dependencies. The cached
frame manifest suffices to reproduce the labeled data and logic controls. The raw videos
are needed to reproduce frame extraction and inspect the labels in the pixels.

```bash
python scripts/run_compiler_scope_repairs.py
python scripts/sample_compiler_scope_review.py
python scripts/review_compiler_scope.py
python scripts/prepare_binding_contrasts.py
python scripts/validate_compiler_scope.py
PYTHONPATH=scripts:tests python -m pytest -q tests/test_compiler_scope_repairs.py
```

## Next steps

1. Prepare a larger meaning-reviewed batch and improve checks for wrong entity, numeric
   and source-scope bindings. This will provide a valid compiler input for training.
2. Extract frozen features for both assignments with the same frames and candidate regions.
   This will make it possible to train on claim labels without leaking the answer.
3. Add reviewed speech and audio pairs from separate sources. Compare the binding model
   with a baseline that sees the same entities and attributes independently.
