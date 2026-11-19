# Evaluating OR in rewrites and compiled claims

## Five failure-only rewrites

The five original claims all failed the fixed SRL and AMR checks. Their legacy rewrites omitted an explicit OR. We froze one prompt per case before generating any responses. The inputs contain the claim, cached dependencies, semantic roles, AMR, and compiler errors. Each input gets one Qwen3-30B-A3B-Instruct-2507 response at temperature zero with constrained JSON output. The prompt asks for short sentences with an explicit AND/OR formula and asks the model to keep qualifiers, source, and branch-specific modifiers.

All five responses include an OR. None passes the fixed compilation checks. Three hit scope limits, one rewritten sentence loses source content during compilation, and one response uses the same sentence twice in its formula. The model also moves OR in the voter information page claim. Its formula puts OR over the features on the page and AND between the two actual search methods. In the majority-or-minority claim, it replaces one question with alternatives by two separate statements about the only question. In the strong-wind claim, it puts the spray description in a separate sentence with an AND outside the OR. That form leaves the identity of the wind implicit, and the current checker accepts only two simple parallel clauses.

This run measures the prompt and fixed compiler together on five selected failures. It provides no new corpus programs. The model job ran on one 80 GB A100 and allocated 310 seconds. The five-response generation batch took 14.0 seconds after loading and initialization. All experiment jobs completed.

## Twelve authored evaluation claims

We froze the texts and reference readings before parsing. Each category contains four texts. The exclusion category has three explicitly exclusive claims and one inclusive control. Stanza, BERT-SRL, and amrlib BART-large generated analyses on CPU. We ran the fixed SRL-then-AMR sequence, keeping both analyses for diagnosis. The author of the benchmark reviewed each selected logical form against its reading. These are development examples. The results measure the meaning of the text and the program, using supplied evidence for the inference controls.

| Category | Automatic passes | Full matches | Partial | Incorrect | No program |
| --- | ---: | ---: | ---: | ---: | ---: |
| Reported speech | 4 | 1 | 3 | 0 | 0 |
| Shared or branch-specific modifiers | 2 | 2 | 0 | 0 | 2 |
| Exclusion and the inclusive control | 2 | 1 | 0 | 1 | 2 |
| All | 8 | 4 | 3 | 1 | 4 |

The verbatim speech example preserves the full quote. For a paraphrased report of two alternatives, the compiler places OR inside the reported content. The test sets the enclosing report condition to supported, one content branch to supported, and a condition in the other branch to unknown. The saved program returns support. Checking whether the speaker expressed the entire disjunction is a missing evidence requirement.

Branch-specific colors stay with their respective vehicles. A simple shared time appears in both branches and blocks support when unknown. AMR still refuses a case with an after-noon condition on the coordination node, and SRL refuses a separate shared-red case. The two “but not both” claims abstain. “Exactly one of the front and rear doors was open” passes checks without a condition enforcing exclusion. The inclusive door control compiles faithfully.

## Exact inference controls

All 26 controls on reference logical forms matched expectations. Nine use inclusive OR and nine use explicit exclusion. The exclusion formula requires at least one supported branch and rules out the case where both are supported. With missing evidence for one side, it returns unknown. The three reported-speech controls use an explicit condition that the utterance expresses the full disjunction. Five modifier controls check that time applies to both branches and reject swapped colors. Two more controls execute the actual compiled programs for the guide's report and the noon standing claim. The former demonstrates the permissive reported-content result described above.

## Proposed next work

1. Add a source check for explicit exclusion and encode it over the correct alternatives. Goal is to catch the false pass on “exactly one” and recover the “but not both” cases without changing ordinary OR.
2. Extend composition to cases with evidence shared across alternatives. Use the strong-wind claim to test that the shared condition binds to the same wind as both branches. Goal is to improve coverage while preserving which predicate each modifier qualifies.
3. Specify a reported-content evidence condition for the full disjunction. Test a transcript expressing both choices, a complete utterance making one assertion, and a partial transcript. Goal is to test the speaker's content separately from whether the described events happened.

## Reproduction

The archive includes the 12 frozen references, saved dependency and SRL analyses, AMRs, five requests and responses, manual readings and resource records. Replay uses those saved inputs and requires the existing AViD Python environment and WordNet data.

```sh
export PYTHONHASHSEED=0
export PYTHONPATH=scripts
python scripts/evaluate_disjunction_cases.py benchmark
python scripts/evaluate_disjunction_cases.py rewrite
python scripts/evaluate_disjunction_cases.py native
python scripts/evaluate_disjunction_cases.py compiled
python scripts/summarize_disjunction_evaluation.py
```

The files listed in `REPLAY_SHA256.json` are the replay targets. The project suite logged 665 passing tests.
