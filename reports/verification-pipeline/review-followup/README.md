# Compiler revision after the twenty-case review

The user reports completing all twenty reviews and authorized one focused compiler
revision followed by a full-corpus run and a fresh review. The JSON export has not
yet reached the shared project. The form stores it in the user's browser; the user
must select **Download my review** and return that file. Their review need not be
repeated. Agent suggestions are not a substitute for the returned answers.

Preparation is saved in `exp/probabilistic_verification/review_followup_20261104/`.
Twenty fresh cases are reserved before code changes. Actual source-video IDs are
disjoint from the sources recorded in earlier reviews and from each other. Earlier
review IDs and normalized duplicate texts are excluded. Selection does not use
output judgments. All corpus claims have been processed before, so this is a fresh
review sample rather than a fully held-out corpus. Preserve the reservation and
avoid inspecting its meanings while developing fixes.

When the export arrives, run from the project root:

```bash
PYTHONPATH=scripts envs/probabilistic-verification/bin/python scripts/import_claim_review.py /path/to/returned-review.json
PYTHONPATH=scripts envs/probabilistic-verification/bin/python scripts/analyze_claim_review.py /path/to/returned-review.json --output-dir exp/probabilistic_verification/review_followup_20261104/human_analysis
```

The analyzer validates packet and claim identities, reveals the per-case A/B
mapping, preserves the user's reasons and compares their answers with the agent's
suggestions. It counts refusals separately. Uncertainty and conflicting judgments
of identical outputs cannot become evidence of a semantic improvement. Unconfirmed
working drafts are not counted. Analysis does not itself import answers or change
the received-human-review status.

For each confirmed failure, inspect the original dependency/SRL input and emitted
logical form. Assign its cause to upstream parsing, conversion into predicates,
insufficient context, or an inappropriate refusal, with a concrete example. The
initial failure ledger leaves those causes unassigned; no keyword heuristic invents
them. Choose at most three recurring patterns for one revision.

Use reviewed cases and small contrasting examples as development checks. Keep
uncertain interpretations explicit. Then rerun all 2,375 original claims, report
acceptance changes and meaning judgments separately, and review the frozen fresh
sample. Compare against its saved current-compiler outputs. Use those results to
decide whether to proceed to a small binding-verification experiment or revisit
parsing. No media verification, relation training or sentence rewriting starts in
this preparation stage.

The preparation can be verified again without reselecting cases:

```bash
envs/probabilistic-verification/bin/python scripts/prepare_review_followup.py
PYTHONPATH=scripts envs/probabilistic-verification/bin/python -m unittest discover -s tests -p test_review_followup.py -v
```
