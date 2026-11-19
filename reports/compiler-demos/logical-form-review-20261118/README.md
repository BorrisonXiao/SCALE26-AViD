# Logical-form benchmark review

The review checks whether cached compiler outputs preserve the source claim. The 60 claims are development material for the compiler benchmark. The five earlier frame-based binding pairs are development material for evidence evaluation. Reserve both for evaluation. No feature extraction, classifier fitting, model judging or parser routing changes were made.

## Sample and review

The selector excludes earlier reviewed IDs and duplicate claim text. It favors unused source groups and topics, then breaks ties with a fixed hash. It takes 36 strict SRL passes across six groups (names, quantities, qualification, source, coordination and general) and 24 provisional programs (14 with advisory issues, five unresolved complements, four reentrancies and one annotated coordination). Reentrancy means that multiple parts of an AMR graph share a node. The 60 distinct texts span 64 source videos and 23 topics. The groups and quotas support diagnosis of selected constructions.

The implementing assistant compared every candidate with the source text and recorded an intended reading and a reason. Full matches preserve required conditions. Partial forms leave a required condition under-specified or missing. Incorrect forms materially change the meaning. Context-needed cases depend on information beyond the sentence. The recorded reference readings are in prose and the stored logical forms and Prolog programs are the exact candidates under review. There are no media or factuality labels. Independent review and a source-held-out evaluation remain open.

| Saved program | Reviewed | Full match | Partial | Incorrect | Needs context |
| --- | ---: | ---: | ---: | ---: | ---: |
| Strict SRL pass | 36 | 19 | 10 | 5 | 2 |
| Provisional | 24 | 3 | 10 | 11 | 0 |
| Total | 60 | 22 | 20 | 16 | 2 |

Eight primary issues concern numeric bindings or units, six participant bindings and five qualifications. These are counts from the sampled cases. For example, one strict output represents 384 mph as a count of mph entities and another records a future event while leaving its likelihood as plain text. One provisional output uses miles for 100m. The report shows all 60 findings with their exact programs.

## Advisory warnings

The rules flag missing parts of multiword names and handles, missing or untyped measurements and linked range bounds, missing OR for explicit alternatives, and missing scope for selected qualifiers. They were designed during the audit and applied to the exact saved forms. Seven sampled forms were flagged. Inspection confirmed the named issue in every flagged case, including six strict SRL passes. This development count does not establish accuracy on unseen claims. The checks can still miss ways of attaching valid names, values or scopes to the wrong participant.

The screening run flags 106 of 2,358 saved programs. These cases are review leads. The complete evaluation inventory still counts all 2,375 inputs, including 17 with dependency analyses alone. No candidate was changed, rerouted or accepted based on these warnings or review judgments. The previously retained set contains 1,981 forms.

## Proposed next work

- Add a separate-source reference review for risky constructions and a sample of unflagged programs. Goal is to measure what the checks catch and miss.
- Specify candidate evidence and test selection with a fixed budget per clip. Start with uniform frames, then compare keyframe selection for long clips and model attention scores if available. For sound and speech, compare short aligned audio windows and speaker-timed transcript spans. Choose once per pair and use the same evidence for both assignments. Goal is to test whether more focused features improve binding independently of evidence access.
- Specify a separate, source-disjoint training data and labeling plan before fitting a relation model. Goal is to keep the current material available for benchmark development and avoid learning from evaluation sources.

## Reproduction

The source archive contains the cached selector and screening inputs and does not require parser or media model calls. From an extracted root, run the following with the AViD evaluation environment (Python 3.12 and pytest for the focused controls).

```sh
export PYTHONHASHSEED=0
python scripts/sample_logical_form_review.py
python scripts/review_logical_forms.py
PYTHONPATH=scripts python -m pytest -q tests/test_benchmark_warnings.py
```

Compare `sample.json`, `summary.json`, `benchmark.json` and `warning_queue.json` under `exp/probabilistic_verification/logical_form_review_20261118/` with `REPLAY_SHA256.json`. The cached sample warnings and their code digest are checked during replay. The project suite logged 655 passing tests in `tests.xml`.
