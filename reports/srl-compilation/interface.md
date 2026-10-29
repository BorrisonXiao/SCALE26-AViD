# SRL compilation and parse editing, 29 October 2026

This experiment replaces per-claim selection between SRL and freely generated
logical forms with independently evaluated, single-path conditions. It does not
change ADR-023, the probabilistic backend, frozen perception models or the planned
small relation classifiers. No sentence rewrite or media verification is run.

## One compiler input

The input is the unchanged sentence, its cached dependency parse and its trained
semantic role labeling (SRL). A predicate frame lists the predicate position and
argument spans with PropBank roles. These numbered roles are predicate-specific;
ARG0 must not be converted to a universal agent label.

`srl_graph_form` connects these frames using ordinary dependency relations:
clausal complements (`ccomp`, `xcomp`), adverbial clauses (`advcl`), relative
clauses and coordination. It preserves nominal modifiers, possessors, noun-phrase
relations, group members, quantities, measurements and modal/negative operators.
It also supplies dependency-licensed copular frames that a verbal SRL model omits.

A source head identifies a referent. Repeated references share a variable. A
coordinated group remains one event participant and has separate member relations;
member modifiers are not assigned to every other member.

## Clause meaning and the backend

The graph translates to the existing recursive logical form and deterministic
DeepProbLog program generator. `relative` is an additional context for a noun's
relative description. `complement` retains an embedded clause as an argument of
the parent predicate without asserting its content independently. Known reporting,
depiction, purpose, belief, temporal and conditional constructions retain their
more specific contexts. The exact parent predicate and role remain available.

These context labels are contracts for evidence functions, not a full theorem
prover for modal or quantified English. In particular, a generic complement does
not establish a verb's factivity or solve control/raising. Missing new evidence
functions return unknown. No new visual/audio classifier is trained here.

An explicit source lexical clause predicate without a linked frame is refused.
This is a check on source token positions. If the dependency parser itself labels
the word incorrectly, the check can miss it or reject a valid description.
Compilation acceptance and diagnostic word coverage do not certify equivalence.

## Optional LLM post-editing

The editor reads the original words, dependency rows, trained SRL and, in one
condition, a pretrained AMR graph. It outputs only:

```json
{
  "edits": [{"predicate": 3, "argument": 0, "span": [0, 2]}],
  "remove_predicates": [],
  "add_frames": []
}
```

All indices start at zero; span ends are inclusive. `predicate` identifies an
existing frame by its source predicate position. `argument` identifies a position
in that frame's argument list. A span edit inherits its original role. A removed
frame must already exist; an added frame must use a supplied syntactic predicate
candidate. Added arguments use ordinary PropBank labels.

The source sentence and existing role labels cannot be rewritten by this interface.
Empty edit lists preserve the exact original SRL record, including reference-role
annotations. These are narrow guarantees. An edited span can be wrong, a new frame
can assign the wrong controller, or a true frame can be removed. Existing wrong
role labels cannot be corrected. Such errors are measured rather than assumed away.

JSON Schema constrains output syntax and source-token bounds. Reference validation
and the deterministic compiler run afterward. No model-facing version field is
needed: Python attaches protocol metadata to saved requests outside the messages.
All prompts remain in `scripts/prompts_phase2.py`.

## Experimental design

The deterministic SRL conditions run on all 2,375 original claims. The editor
conditions run on the same fixed 48 IDs: 24 development-pilot cases and 24 IDs
sampled before generation. The latter 24 receive paired assistant judgments.
The same assistant checks all outputs without media or truth labels. All source
text is authorized development input; this is not source-disjoint generalization
or independent human gold.

An initial complete-SRL-regeneration pilot was stopped after 12 saved outputs:
it changed correct roles and invented a predicate for a bare label. That condition
is preserved separately. The constrained edit interface was introduced afterward.
The deterministic SRL graph was frozen before the 24 random outputs were reviewed;
later editor changes are separate modules. The exact source snapshots and requests
are archived. No output selector or automatic fallback chooses among conditions.

## Remaining limitations and recommendation

Source scope for nominal objects and participial modifiers is still incomplete.
Copular class descriptions can lose their identity relationship; some location
complements become opaque text values. Idioms, controller selection, malformed
source text and nested nominal descriptions remain difficult. Generic no-NP
negative existentials and some modal readings are explicitly refused.

Use one SRL/dependency compiler as the main baseline and evaluate post-editing
separately. The next changes should address those general semantic constructions,
with complete reference logical forms. Enhanced dependencies are an existing way
to express otherwise implicit control/raising and shared-argument links; their
predictions would still require evaluation. Do not treat more accepted programs
as faithful training data or make prompt engineering the paper's methods claim.

Run `PYTHONPATH=scripts python scripts/replay_srl_compilation.py` to reproduce the
cached compilation outcomes and program hashes. This needs the compilation Python
requirements and NLTK WordNet, but no GPU or model download. The HTML report is
`site/reports/srl-compilation.html`.
