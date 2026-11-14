# Review status

An external GPT-5.5 review was requested under the idea-review skill, but automatic approval rejected sending unpublished project artifacts and results. It did not run. No external scores or ranking are available.

The following is the implementing assistant’s local assessment, not an independent review.

- Typed grammar and AST constraints are useful immediate infrastructure; they do not establish faithfulness.
- A small source-conditioned neural ranker is a plausible semantic improvement, but the current 63 development judgments are too few and too biased for a credible generalization claim. New video-disjoint references are needed.
- A categorical distribution over logical forms fits the probabilistic backend. It represents genuine ambiguity only if candidate meanings and weights are checked; otherwise it merely spreads probability over mistranslations.
- A pretrained DRS parser is worth investigating only after confirming a usable checkpoint and conversion path. The inspected repository documents training and results rather than a confirmed drop-in model.

These are proposals within the accepted paper direction, not new experiments or independent recommendations.
