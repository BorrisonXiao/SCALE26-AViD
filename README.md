# SCALE 2026 · AViD — project site

Static site for **AViD** (Audio-Visual claim Disentanglement), SCALE 2026.

The chosen paper direction (2026-10-14, ADR-023) is **probabilistic parsing for
multimodal claim verification**: compile NLP-derived claims into probabilistic logic,
keep visual/audio models frozen, and learn small relation classifiers. The framework
permits predefined and learned functions and alternative evidence assignments.
The tree-CRF reports describe the earlier implementation and remain comparisons.

**🌐 Live site: [borrisonxiao.github.io/SCALE26-AViD](https://borrisonxiao.github.io/SCALE26-AViD/)**
&nbsp;·&nbsp; [Tree-CRF method note](https://borrisonxiao.github.io/SCALE26-AViD/reports/tree-crf.html)

## Pages

- `index.html` — project home.
- `reports/verification-pilot.html` — completed 15 October local-model generation,
  prompt revisions, assistant sample inspection, full-resolution checks, and
  initial baselines. Development labels are not independent human gold. Build
  with `python scripts/build_verification_pilot_report.py` from the AViD root.
- `proposals/probabilistic-verification.html` — current paper direction and design:
  claim compilation, evidence interface, MLP/BERT/decoder comparisons, learning,
  temporal constraints, evaluation, first-week preparation, and LLM-assisted
  data/baseline workflows. The opt-in prompt drafts are in
  scripts/prompts_phase2.py (three preserved free-form versions and specified-fact
  realization). Section 17 reports the first pilot; section 18 shows five selected
  generated examples with source frames, seed/edited claims, and review notes.
  Generate the page with
  `python scripts/build_probabilistic_verification_proposal.py` from the AViD root.
- `proposals/index.html` — current and earlier proposals.
- `reports/tree-crf.html` — **method note**: the tree-structured CRF definition, its emissions and
  transitions, exact belief-propagation inference, the existence-vs-binding veto, and an analysis of
  what the structure buys (perturbation faithfulness, modality attribution).

Pages are static HTML with shared styling in `assets/site.css`. The current proposal
has a reproducible Python generator; it uses MathJax from a CDN for equations.

## Viewing locally

```bash
python3 -m http.server -d . 8000   # then open http://localhost:8000
```

## Publishing (GitHub Pages)

Serve from `main` at the repository root: **Settings → Pages → Build and deployment →
Source: Deploy from a branch → Branch: `main` / `/ (root)`**. The live site is then at
<https://borrisonxiao.github.io/SCALE26-AViD/>. `.nojekyll` disables Jekyll so files are served as-is.
