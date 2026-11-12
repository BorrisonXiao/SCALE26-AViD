# Failure-only rewriting and request inspection —12 November2026

The requested pipeline compiles the original claim first. A direct result with status compiled is retained unchanged, without initializing or querying the rewriter. Only unsupported results are eligible. This includes generated diagnostic candidates rejected by the strict word/clause/list checks; generating a program alone is not a direct pass. A later semantic concern about an otherwise passing original does not automatically trigger rewriting.

The full-corpus replacement code already excluded direct passes. The standalone generation runner previously accepted every supplied pilot input, including diagnostic controls. It now runs direct compilation and filters passes before importing the model runtime. Unknown statuses and mismatched claim IDs fail validation rather than silently triggering a model request. An all-passing input returns without loading a model, even without the plan-only flag.

CPU routing on the same40 historical pilot inputs:31 failures eligible,9 passes skipped. The nine are eight passing controls plus one passing ambiguous guard. A separate invocation on the eight controls, without plan-only, selects zero model requests and skips all eight. Both save model_called=false; no new model/GPU/media/training/inference job is run.17 rewrite/routing tests pass. Underlying38 compiler source hashes and all historical results/review annotations remain unchanged.

The historical80 requests and reviews remain evidence of the11November diagnostic experiment. Passing-control regressions are not runtime fallback regressions. Among31 actual fallback cases the initial condition has1 reviewed recovery/30 rejections and the revised condition3/28. The revised three are2/24 target recoveries plus one exact-quotation guard. No old judgment or experimental count is changed. The pilot still fails its recovery criterion, and automatic corpus-wide expansion remains disabled.

The report now defaults to directly failed cases, identifies the original error, offers a rejected-fallback filter, and labels skipped historical probes. Five short examples explain invented participants, wrong compiled actors, a speed range represented as counts, unchanged text and wrong negation scope. Each links to its full case. Both exact system/user messages and raw responses are displayed without folding, with a selector for the historical prompt condition. The model/settings are copied from saved metadata: Qwen3-30B-A3B-Instruct-2507, frozen text only, float16, temperature0, seed42, maximum768 output tokens, vLLM0.18.0 and constrained JSON decoding. A model's explanation is not treated as evidence of a successful repair.

Reproduce routing and tests without a model call:

```sh
PYTHONPATH=scripts envs/probabilistic-verification/bin/python -m pytest -q tests/test_claim_rewrite.py
envs/probabilistic-verification/bin/python scripts/run_claim_rewrite_model.py --input exp/probabilistic_verification/claim_rewrite_20261111/pilot_inputs.jsonl --output /tmp/rewrite-routing.jsonl --plan-only
envs/probabilistic-verification/bin/python scripts/build_compiler_demos.py
envs/probabilistic-verification/bin/python scripts/package_rewrite_inspection.py
```

The dated source overlay follows the11November compiler/audit/rewrite source bundles; earlier ZIPs remain byte-identical. The new bundle includes updated generation filtering, report generation, tests, exact-request data and routing evidence. It does not replace the earlier model-generation source snapshots. Browser checking uses scripts/check_rewrite_inspection_browser.py with the existing Playwright browser installation.

Next steps: inspect the linked failed cases and their prompts to validate the diagnoses; then choose a bounded change addressing the observed semantic failures before any further rewriting/model experiment. No quantity/negation compiler change is made in this report/routing update.
