# Parallel alternatives in claim compilation

The fixed SRL → AMR → rewrite sequence passes the automatic checks on 2,178 of 2,375 original claims. The previous sequence passed 2,177. Every earlier program is byte-identical. The new pass is the pier or terminal area claim. This comparison measures automatic compilation on saved inputs. The 35 IDs from the earlier explicit-OR audit account for 22 earlier passes and 23 after the repair.

## Direct AMR conversion

The original “The video takes place on a large, open paved pier or terminal area” already has a cached AMR with an OR in the location argument. The normalized AMR edges for “open” and “paved” point back to “pier.” The previous converter treated those incoming edges as references from outside the alternative. The revised fallback converter allows an incoming reference from a modifier declared in the operand's own AMR subtree when that subtree has no incoming references from outside the choice. A reference into the subtree from another branch or the surrounding graph still causes refusal. Earlier typed and standalone AMR comparisons retain their original default.

The emitted form uses one video and one location slot. That slot can be a large, open, paved pier or a terminal area. Each condition is attached to the matching branch. Exact DeepProbLog controls with fixed observations return supported for pier only, terminal only and both. They return unknown when the only possible alternative lacks evidence for “paved,” and refuted when both location descriptions are refuted.

## Failure-only rewriting

The structured rewrite prompt requests parallel sentences with an explicit operator and keeps branch-specific modifiers and counts on their original branch. The fallback compiler passes the explicit operator through to composition. It checks a bounded case consisting of two simple source-aligned alternatives. It compares the two branch descriptions and shared source participants and checks the governing predicate, argument role and modifier attachment for nominal alternatives. The guard leaves embedded alternatives and scope that needs interpretation for further work. It excludes hyphenated, quoted and numeric-bound uses of “or” from its coordinator search.

The saved legacy rewrite repeated “large, open, paved” on the terminal branch and supplied no OR formula. In the full rerun AMR succeeds first, so that rewrite is skipped. A separate control uses two manually written sentences parsed on CPU with Stanza and BERT-SRL. The actual fallback path compiles these clauses with explicit OR after controlled direct refusals. The same clauses with AND are refused. The legacy clauses with an explicit OR added are also refused because they copy those modifiers. Five existing abstentions now explain that the legacy model response omitted explicit OR. No rewrite model was queried in this run.

## Remaining work

- Review the five remaining cached rewrites that lack OR, including “Some people crouch or sit on the ground for stability.” Goal is to test fresh explicit rewrites on the remaining direct failures while preserving purpose and other scope.
- Extend the branch-level evaluation with reported alternatives, clear shared modifiers and explicit exclusion. Goal is to separate language interpretation from evidence aggregation before feature extraction.

## Reproduction

The archive includes the saved original claims, AMRs, rewrites, prior output signatures and the parsed control. With the existing AViD Python dependencies and WordNet data installed, run from an extracted root.

```sh
export PYTHONHASHSEED=0
export PYTHONPATH=scripts:tests
python scripts/run_compiler_fallback.py --output exp/probabilistic_verification/disjunction_repairs_20261119
python scripts/check_disjunction_repairs.py
python -m pytest -q tests/test_amr_operators.py tests/test_rewrite_disjunction.py
```

Compare `comparison.json` with the digest in `REPLAY_SHA256.json`. The full project suite logged 665 passing tests.
