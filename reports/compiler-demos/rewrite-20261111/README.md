# Checked claim rewriting —11 November2026

## Completed results and decision

Do not enable automatic rewriting yet. The two fixed prompt conditions fail the predeclared development gates. Compiler-author judgments, not independent human gold:

| Condition | Actual edits /40 | Targets passing checks /24 | Faithful target recoveries /24 | Faithful guard recoveries /8 | Proposed control regressions /8 |
|---|---:|---:|---:|---:|---:|
| Initial clarity prompt |9|3|1|0|1|
| Revised prompt with compiler diagnostics |29|10|2|1|2|

The revised condition retains the police-officer help/clear bindings and apparent physical integrity of power lines, plus one guard whose exact sign quotation is preserved under OCR scope. Its ten automatically passing targets include wrong actors, rate/count confusion and added information. The initial condition recovers a different explicit three-judge group; that success is not added to the revised condition's headline. Four revised outputs still say rewrite while emitting unchanged text, versus seven initially. The revised condition contains11 assistant-identified critical proposal changes; none enters the reviewed corpus. Two proposed controls regress; the operational comparison retains their original structures.

All2375 original claims were recompiled with exact full-record equality. A second full rerun using only the three reviewed revised-prompt replacements gives2105 generated programs and1927 passing content checks, with448 strict refusals. The original baseline remains2103/1924. The1927 figure is not a faithful-training-corpus size: only the three replacements received this rewrite review, and earlier automatic passes can still be wrong. This diagnostic result is not an enabled automatic rewriting system.

## Prompt revision and failure patterns

The first run often kept failing inputs unchanged, made only punctuation edits, or claimed an edit that was absent. Its geographical spelling correction violated the preserve-name contract. We then froze one revised prompt supplying the original compiler error code/message as text context, with no truth labels, media or review judgments. It was motivated by initial proposals and baseline diagnostics; there is no held-out gain claim or per-claim prompt selection. Both conditions and all80 proposal/review pairs are preserved.

The diagnostic prompt sometimes adds unsupported information: a document Trump holds becomes one Trump signed; a goal acquires a mission; an unspecified comparison acquires previous years. Some faithful English rewrites still produce wrong logical forms: sweep is the kicking actor, a running track becomes a running actor, km/h becomes a counted object, and40meters per second becomes40meters plus a separate second entity. No audio→does not have any audio preserves English meaning but still introduces an audio referent outside the negated event, rather than putting existence under negation. Current surface checks are conservative: range-format and no→not changes can be flagged even when text-equivalent. Semantic review independently rejects the wrong compiled rate/negation scope.

The hyphenated three-judge output retains the compound as a coarse property; it is not counted as an explicit three-person cardinality binding. The initial panel of three judges output exposes that group and is retained in its own condition. This structural criterion is a declared pilot requirement, not a claim that the compound words themselves are absent.

## Next steps and intended goals

1. Review the three retained cases and representative rejections with the user—confirm assistant fidelity judgments before these become training structures.
2. Keep broad grammar development and both prompts frozen; make a bounded decision about quantity/negation contracts or a separately evaluated stronger rewriter—address the observed failures without more per-sentence rules.
3. Repeat bounded fidelity evaluation before any corpus-wide rewriting; only then prepare checked examples for new DeepProbLog learning/inference.

## What was compared

The underlying compiler is frozen at `content_relations_20261105`. All38 source hashes are unchanged. A fresh full rerun exactly reproduces all2375 original records:2103 generated programs and1924 passing current word/clause/list checks. These counts measure compilation, not semantic accuracy.

Before generation we saved40 original claims and intended readings:24 failed targets,8 passing controls and8 difficult guard cases. They are purposively selected development examples from earlier inspected claims, not independent human gold or an unseen test. Seven other original-video groups are reserved from prompt tuning. The original whole corpus remains untouched.

One local frozen Qwen3-30B-A3B-Instruct-2507 model receives each claim, dependency links and semantic-role spans. It does not receive truth labels, media observations, intended readings or semantic judgments. Neither prompt has a version index. It returns a minimal rewrite, unchanged text or refusal. The exact system/user messages, JSON output, decoding configuration, token counts and runtime are saved. Both jobs used one80GB A100 in sequence; the queued H100 request was canceled before running. No fine-tuning or multimodal input is used.

Changed text is reparsed using the same cached Stanza English dependency parser and AllenNLP BERT semantic-role labeler. A proposal must still be one sentence, including explicit coordination where appropriate, because the existing frontend takes one sentence. This experiment does not add a new logical-form grammar, parser selector or direct neural-to-predicate route.

## Review and acceptance

The original claim is the reference at both steps: original→rewrite and original→compiled structure. Review checks who does what to whom, shared participants, quantities and owners, dates, tense/aspect, negation, uncertainty/modality, exact quotations and source scope. Deliberately false claims must remain false claims with the same asserted content; rewriting is not fact correction.

Surface checks reject changed numeric strings, lost proper names, changed quotes and selected polarity/modal markers. They are conservative and incomplete. A subject/object swap can pass these checks; a unit test makes this limitation explicit. Semantic judgments remain compiler-author assistant diagnoses, not independent human labels. Reviews are bound by SHA256 to the exact original, proposal and compiler output. Only a rewrite with both steps judged faithful, a passing compiled result, no critical change and passing surface checks can replace an earlier failed result.

The eight passing controls also receive model proposals in this experiment so regressions cannot be hidden by skipping them. The candidate pipeline normally keeps previously passing originals unchanged. Ambiguous/unsupported guard cases are not forced through rewriting. Current automatic passes are not a clean training set.

Predeclared development gates: at least12/24 reviewed faithful recoveries, zero proposed-control regressions and zero accepted critical changes. The gates are small-set planning criteria, not a statistical reliability guarantee. Model-generated and reviewed counts are reported separately.

## Artifacts

`exp/probabilistic_verification/claim_rewrite_20261111/` contains frozen membership/readings, exact prompts/raw responses, parser provenance, diagnostic compilations, semantic reviews, full baseline replay and the corpus with reviewed replacements. No relation learning, media inference or new DeepProbLog inference experiment is performed. Compilation checks generate and parse ProbLog syntax; this is not a native evidence-inference benchmark.

The initial generation-source snapshot is retained. After the initial prompt freeze, acceptance validation gained a review hash; the initial prompt, schema and messages are preserved. The one later prompt revision and its diagnostics have their own frozen files. The analyzer verifies exact messages against original inputs and checks membership/baseline/compiler hashes.

## Reproduction

Use the existing isolated environments. No model calls are needed to replay saved compilations and analysis.

```sh
PYTHONPATH=scripts envs/probabilistic-verification/bin/python -m pytest -q tests/test_claim_rewrite.py
envs/probabilistic-verification/bin/python scripts/compile_claim_rewrite_pilot.py --census
envs/probabilistic-verification/bin/python scripts/compile_claim_rewrite_pilot.py
envs/probabilistic-verification/bin/python scripts/analyze_claim_rewrite_pilot.py
envs/probabilistic-verification/bin/python scripts/compile_claim_rewrite_pilot.py --reviewed-census
envs/probabilistic-verification/bin/python scripts/build_compiler_demos.py
envs/probabilistic-verification/bin/python scripts/package_claim_rewrite_pilot.py
```

To repeat generation in a separate output location, use the saved system prompt, diagnostics and input for that condition; the runner deliberately refuses to overwrite existing raw outputs. The observed scheduler command used `sbatch --gres=gpu:a100:1 --constraint=80gb scripts/run_claim_rewrite_model.slurm --input exp/probabilistic_verification/claim_rewrite_20261111/pilot_inputs.jsonl --output <new-output.jsonl> --system-prompt exp/probabilistic_verification/claim_rewrite_20261111/system_prompt.txt --diagnostics exp/probabilistic_verification/claim_rewrite_20261111/diagnostics.json`. Generation is followed by `parse_claim_rewrites.py` in probabilistic-verification and its `--srl` stage in srl-eval. Preserve each condition's raw/parsed outputs and reviews separately.

For isolated report replay extract the unchanged compiler source ZIP, the11November alert-review source overlay, and then the rewrite overlay in that order. These three downloads are in the compiler-demos report. In an extracted directory without historical ZIPs use `package_claim_rewrite_pilot.py --allow-missing-history`; existing historical files are always hash-checked. Model weights and the two pre-existing environments are not distributed. The source bundle includes saved parses, so replay does not load Stanza, BERT or Qwen. Browser checking uses `scripts/check_claim_rewrite_browser.py` and requires Playwright Chromium.
