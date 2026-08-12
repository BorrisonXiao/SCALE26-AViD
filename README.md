# SCALE 2026 · AViD — project site

Static site for **AViD** (Audio-Visual claim Disentanglement), SCALE 2026.

AViD verifies a claim against a video-with-audio and **decomposes** the verdict: which part
of the claim is grounded, by which evidence channel (visible thing / on-screen text / speech /
non-speech sound), and where the composition breaks. The engine is a **conditional random field
over the claim's dependency parse tree**.

## Pages

- `index.html` — project home.
- `reports/tree-crf.html` — **method note**: the tree-structured CRF definition, its emissions and
  transitions, exact belief-propagation inference, the existence-vs-binding veto, and an analysis of
  what the structure buys (perturbation faithfulness, modality attribution).

No build step — plain HTML + one stylesheet (`assets/site.css`).

## Viewing locally

```bash
python3 -m http.server -d . 8000   # then open http://localhost:8000
```

## Publishing (GitHub Pages)

Serve from `main` at the repository root: **Settings → Pages → Build and deployment →
Source: Deploy from a branch → Branch: `main` / `/ (root)`**. The live site is then at
`https://borrisonxiao.github.io/SCALE26-AViD/`. `.nojekyll` disables Jekyll so files are served as-is.
