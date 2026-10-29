# Logical form and component interfaces

Status: experimental implementation, 2026-10-28. This is compilation of the original
claim; sentence rewriting is explicitly reserved for later and is not implemented.

## Representation means structured claim meaning

Here, a representation means a **logical form**: the predicates, their arguments,
shared referents, logical operators and evidence-source scopes. It is not a neural
embedding. For “Alice hugs Bob and waves,” the essential meaning is two events
joined by AND, with one Alice shared between them and Bob in the hug.

JSON is a format for writing this structure; it is not the semantic representation
itself. PENMAN is another notation used by the AMR baseline. The graph notation
alone does not define negation, evidence-source scope or temporal interpretation.

## Interface means agreed inputs, outputs and meanings

An interface is the specification connecting two components. The current
parser/compiler interface accepts the original text, its cached token/auxiliary
analysis, and the JSON logical form described below. The compiler returns the
existing `CompiledClaim` structure (atoms, variables and an expression) or an
explicit refusal with a reason. Different parsers can supply that logical form.

The future evidence-scoring interface is separate: a scorer will receive a
specified relation, candidate entities/events, source scope, evidence route and
features. It will return supported/refuted/unknown probabilities with those
meanings and a defined order. A deterministic rule and a neural classifier can
satisfy that interface. This iteration does not train or evaluate media scorers.

## JSON logical form, version logical-form-v1

```json
{
  "version": "logical-form-v1",
  "entities": [
    {"id": "a", "text": "Alice", "concept": "person", "detail": "decomposed"},
    {"id": "b", "text": "Bob", "concept": "person", "detail": "decomposed"}
  ],
  "formula": {
    "op": "and",
    "children": [
      {"op": "event", "id": "h", "predicate": "hug", "anchor": "hugs",
       "arguments": {"ARG0": "a", "ARG1": "b"}},
      {"op": "event", "id": "w", "predicate": "wave", "anchor": "waves",
       "arguments": {"ARG0": "a"}}
    ]
  }
}
```

Entity IDs identify shared referents; event IDs identify distinct events. Argument
roles use predicate-specific PropBank labels or declared adjunct names such as
location. ARG0 is not universally an agent. A known frame sense is stored separately
in `sense` and enters the executable observation key. The SRL baseline generally
has no predicted sense; it does not invent one.

An entity can have properties such as `{"role":"mod","value":"gray"}` and
relations such as `{"role":"part-of","target":"another_entity_id"}`. A noun phrase
that is retained without full internal analysis is marked `detail:"phrase"`.
The resulting `uses_phrase_arguments` flag records this explicitly; its absence
is not a certificate that the parser preserved the complete meaning.

AND and OR have `children`; NOT has `child`. This version supports local event
negation. An `entity` node with a `ref` describes a nominal source complement,
such as a photo of a green bus. Counting, unresolved pronouns and unhandled
modal/intensional scope are refused. This is not a general English-to-FOL system.

## Recursive source content

A source event has a `content` formula and a `route`: `speech_assertion`,
`ocr_assertion` or `visual_depiction`. The compiler places every content condition
under the source-event variable. For “the narrator says the craft has not landed,”
land and its negation remain in speech-content scope. The narrator's saying event
is not negated. Content is not conjoined into unqualified world assertions.

A source clause and its content share source identity through an event variable.
Thus, changing the speaker/photo cannot silently reuse a content score. This is
an executable structural condition; it is not a claim that candidate alignment or
media verification has been solved. Source-relative references still need care.

## Temporal conditions and anchors

`anchor` is the original predicate word. The compiler aligns it to the original
analysis and reads the full auxiliary sequence. Unique lemma/stem matching assists
alignment when the cached lemma is wrong; the cached tree is not semantic ground
truth. Multiple matching occurrences remain unresolved rather than guessed.

Each temporal condition has tense, aspect, a discourse reference context and a
completion field. Its five core arguments are event, tense, aspect, context and
completion; standard scope/route arguments follow. The same temporal metadata
format is used in every front end. The existing temporal adapter reads those
fields; no video times are inferred. Unknown anchors and reference contexts are
not silently filled from the wall clock. Generated redundant tense/aspect fields
are checked against source auxiliaries before being omitted.

## Deterministic compiler output

The output still uses `Variable`, `Atom` and `Expression`. The backend does not
need to know whether the parse came from SRL, AMR or a text model. EXISTS introduces
a candidate assignment. Shared variables are bound where their uses meet;
disjunction has local witnesses. Local negative event existence stays under NOT,
while participant conditions remain outside that local negation.

Atom arguments include scope and route. Inverse entity relations are canonicalized,
and repeated canonical atoms reuse the same ID. Senses, role labels, reference time
and source scope affect observation identity. This prevents accidental reuse of a
probability for a different relation, sense, context or speaker/photo.

## Validation and limits

The 46 assistant-authored development references specify roles, modifiers, source
scope, polarity, identity and time. Five have explicitly uncertain lexical/noun-phrase
readings and are excluded from definite diagnostic counts. Passing these checks
is not full semantic equivalence or independent human accuracy.

This is an opt-in implementation. Historical compiler modules, results and source
archives remain unchanged. SRL noun-phrase decomposition is deliberately limited;
AMR can misclassify lexical content and does not contain complete English temporal
semantics. The current finite frame checks are not a complete PropBank validator.
Source-relative temporal interpretation and reference are not solved in general.
The code does not call an LLM to simplify or rewrite difficult claims.


## Frozen-check outcome and remaining work

The first 20 source-disjoint cases informed structural fixes and are now development
examples. Ten further source-disjoint cases were evaluated after a new freeze.
The fixed selection policy compiled eight, but review still found wrong scope,
missing controlled participants, nominal media ambiguity and context-dependent labels.
Keep this interface/compiler opt-in; do not treat development checks as accuracy.

Entity IDs are shared within an evidence scope. Cross-source reference interpretation
is currently refused, rather than silently treating two mentions as independent
individuals. Bare labels and underspecified fragments need a defined claim context;
rewriting cannot provide missing information without making additional assumptions.

CPU replay needs the NLTK WordNet lexical corpus, in addition to the Python packages:
`python -m nltk.downloader wordnet`. This is lexical preprocessing, not model training.
