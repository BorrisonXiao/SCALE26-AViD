# Context, noun interpretation and compiler-count audit — 18 November 2026

The SRL compiler has not dropped from 2,099 to 1,785. The headline switched to an experimental AMR frontend and mixed measurements. This run repairs context/noun conversion, audits the saved counts, and evaluates fresh external texts. It does not replace SRL, promote AMR outputs, or start media/relation training. ADR-023 is unchanged.

## Counts on the same 2,375 original claims

Saved program inventories in `count_history.json` verify identical claim IDs/texts and SHA256 hashes.

- Earlier SRL syntax/schema checks: **2,099 generated**, including 1,926 clauses and 173 nominal descriptions; not semantic accuracy.
- Same SRL plus source-word checks: **2,099 generated; 1,839 pass**, 260 flagged, 276 no program.
- Later SRL content/relationship revision: **2,103 generated; 1,924 pass**.
- Current SRL direct path: **2,146 generated; 1,983 pass**. All original 2,099 candidate IDs remain; 47 were added, zero lost.
- Previous retained pool with reviewed fallback: **1,981**, unchanged. This includes mixed provenance and has not been fully re-reviewed. It is not the current SRL automatic-pass total.
- AMR before this revision: **1,785 generated; 1,559 pass**.
- AMR after this revision: **1,808 generated; 1,578 pass**. There are 21 new automatic passes, two newly flagged old passes, no lost generated cases, and 170 changed program strings.

The AMR path has genuinely lower coverage. SRL/AMR paired old generation: both 1,662, SRL-only 484, AMR-only 123, neither 106. These are coverage counts, not evidence to pool methods or rank their meaning quality. A program being generated, passing necessary checks, and matching the full source reading are three separate outcomes.

## Implementation

One cached BART-large AMR path plus source-normalized conversion, not an ensemble. `amr_contexts.py` is opt-in; optional hooks leave existing defaults unchanged.

- Definition content, requested actions and a mission's landing purpose stay in embedded contexts. Source-aligned terms and grammatical constructions determine the rule, not the claim ID.
- Source infinitives marked by `to`, attached to appropriate work/use predicates, can indicate purpose. `only to` is excluded. Existing purpose relations remain supported.
- WordNet derives candidate noun/adjective forms. Source dependencies and explicit nominal heads constrain interpretation. Physical objects, group nouns, compounds, agent roles and event nouns must remain distinct.
- A lexicalized pneumatic-drill compound is a tool. A ruling may be a result noun. A first responder is a person with a role, not automatically a new response event.
- Copular noun predicates use the actual UD subject, not a universal assumption that ARG0 is subject/agent. A copula alone does not imply an object reading: an interview can retain its participants.
- Source nominal `of`/`to` links are normalized literal preposition relations, not standard gold AMR roles. All altered triples are recorded. Unresolved compound roles are flagged rather than silently removed.
- Relational adjectives such as economic/economy can help noun alignment without triggering the separate adjective-as-participant check.

The [AMR guidelines](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#nouns-that-invoke-predicates) already support predicate nouns and participant readings. These conversion defects do not establish a general limitation of AMR. Word form does not establish factuality.

## Meaning review

Implementing-assistant review, no GPT/model judge, new human approval or independent gold.

- Earlier 92 development readings: **31→34** whole-reading matches.
- Existing follow-up 24: **2→3** matches.
- Previously selected additional 16: **5→7** matches; these have original wording/prior judgments, not separate frozen references.
- All 132: **38→44** matches. Fifteen changed cases freshly inspected; 88 judgments reused only when conditions, variable types and sharing match; 29 have no complete program.

Definition and tool/purpose examples improve. The lunar mission remains partial because the upstream parser calls it an organization. Request content improves but a tram-location attachment remains wrong. The two newly flagged old passes both turn tear gas into a gas action with a tear participant. Automatic flags do not alone prove an error or supply a repair.

## External text-only diagnostic

All existing MicroVENT manifests contain the same 190 videos and 2,375 unique texts, so no untouched-video claim set was available. Twenty 6–38-word AVeriTeC development claims were selected in fixed SHA256 order, one per source URL, excluding exact overlaps. Only claim texts/source URLs/IDs were saved, not truth labels or evidence.

Official data: [AVeriTeC](https://fever.ai/dataset/averitec.html), [repository](https://github.com/MichSchli/AVeriTeC), commit `7c62d1ec8df3fb560d6efe2b85fa191135636f81`, CC-BY-NC-4.0, Schlichtkrull et al. See `external_manifest.json`. References were frozen before source parsing. Stanza provides source dependencies; the same cached amrlib BART-large model generates one AMR per text, beam 4/batch 8, CPU, offline. Three model batches took 43.0, 46.3 and 23.3 seconds, excluding loading. No rewrite or judge model was called.

Both before and after versions give **10/20 generated, 6/20 automatic passes, 3/20 whole-reading matches, 3 partial, 4 incorrect, 10 no program**. Of six check passes, only two match the whole reading. The third whole match is falsely flagged for a possessive name token. This result does not show generalization gains or support replacing SRL.

Evaluation chronology matters: unread preflight outputs are preserved in `development_before_role_nouns/` and excluded. The first inspected compiler/source/results are saved in `frozen_external_evaluation/`. After that inspection, two validator corrections were developed using old corpus cases: relational-adjective alignment and a copular event noun. **All 20 external programs and statuses remain identical**; no external error was repaired. `external_equivalence.json` verifies this. The final result is an external diagnostic, not pristine held-out accuracy. The references/reviews are assistant-authored; we cannot establish absence from parser pretraining. Assertions are evaluated for text fidelity, not truth.

## Remaining problems

**797 automatic failures: 567 no program and 230 flagged programs.** First graph refusal is an unhandled complement in 399 cases; other stops include coordination (49), negative-argument scope (40), duplicate roles (20), event-scope reentry (19), sentence mode (14). These are software stops, not a complete semantic taxonomy.

False passes remain for quoted content, call/request content, hypothetical `would`, and generic causal statements. The neural parser can alter names and amounts; necessary source checks catch some but cannot reconstruct the meaning. Some checks are overstrict, including possessive names/demonyms. Noun interpretation remains ambiguous. A larger generated count does not resolve these issues.

## Validation and reproduction

**607 full tests**, including 26 new context/noun tests. Default typed AMR outputs on all 2,375 claims reproduce exactly. Default original AMR and earlier SRL 2,375/449 replay also remain exact. Eleven native DeepProbLog controls on four actual programs use constructed observations and placeholder candidates; mixed/unknown controls match analytic results. Outer-only support with embedded content unknown cannot support the whole definition/purpose. These are engineering controls, not real evidence, trained probabilities or a media experiment.

From the source overlay, with the existing environment and WordNet installed:

```bash
PYTHONPATH=scripts:tests python -m pytest -q tests
python scripts/audit_compiler_counts.py
python scripts/run_amr_contexts.py
python scripts/run_amr_contexts.py --external
python scripts/analyze_amr_contexts.py
python scripts/analyze_amr_contexts.py --summarize
python scripts/profile_amr_contexts.py
python scripts/replay_amr_contexts_defaults.py
```

All experiment replay uses saved AMRs; it requires no model call, network or GPU. The original external AMR generation is separately reproducible from the saved config but is not part of this cached replay. Input/source hashes, original references, judgments, errors, raw external AMRs, first-inspected outputs and traces are included. Earlier 35 source ZIPs and 26 original viewer files remain immutable. The report keeps five views and two Reports cards.

## Proposed next steps and goals

1. Compare SRL and AMR meanings on one fixed set: choose the main frontend by fidelity rather than headline counts or per-claim pooling.
2. Address quoted/conditional/generic content and false source checks: reduce incorrect automatic passes and unjustified refusals.
3. Freeze checked logical forms and explicit exclusions before relation training: prevent compiler errors from contaminating the learning experiment.
