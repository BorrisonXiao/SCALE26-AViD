# Literature review — claim-to-logic compilation

DRS means Discourse Representation Structure: a scoped logical representation of referents and conditions. An abstract syntax tree (AST) represents the structure of a logical expression.

Date: 2026-11-13. Focused review of 17 verified primary works; recent work plus essential older foundations.

The practical question is how to preserve a claim’s meaning while producing executable logic with little new training. Compute estimates below are proposals, not measured results. The paper direction and frozen perception models remain unchanged.

The literature separates formal validity from semantic fidelity. Constrained decoding and AST checks address the first; source-conditioned ranking, consistent contrasts and structured supervision address the second. A probabilistic parser can expose ambiguity, but probabilities over plausible mistranslations do not repair them.

P3 is direct prior work for combining uncertain language and uncertain environments. Neural/probabilistic parsing itself should be infrastructure, not our novelty claim. A claim-level verification label can reward a wrong parse that happens to produce the right verdict.

## p1: PICARD: Parsing Incrementally for Constrained Auto-Regressive Decoding from Language Models

Torsten Scholak; Nathan Schucher; Dzmitry Bahdanau (2021); EMNLP. Verified [primary source](https://aclanthology.org/2021.emnlp-main.779/).

Problem: Invalid generated SQL. Method: Reject inadmissible next tokens through incremental parsing. Result reported: Improves Spider/CoSQL performance in the paper. Our interpretation: Validity constraints are useful infrastructure; they do not certify source meaning.

## p2: Synchromesh: Reliable code generation from pre-trained language models

Gabriel Poesia; Oleksandr Polozov; Vu Le; Ashish Tiwari; Gustavo Soares; Christopher Meek; Sumit Gulwani (2022); arXiv preprint; venue not asserted. Verified [primary source](https://arxiv.org/abs/2201.11227).

Problem: Generated programs violate language or contextual constraints. Method: Constrain partial completions with syntax, scope and type checks; retrieve similar program examples. Result reported: Reports complementary improvements from constraints and retrieval on three program languages. Our interpretation: A general completion checker is more systematic than adding isolated output-string rules.

## p3: Grammar-Constrained Decoding Makes Large Language Models Better Logical Parsers

Federico Raspanti; Tanir Ozcelebi; Mike Holenderski (2025); ACL Industry. Verified [primary source](https://aclanthology.org/2025.acl-industry.34/).

Problem: Logical parsing yields ill-formed expressions. Method: Apply output grammar constraints to LLM logical parsing. Result reported: Reports improved syntactic correctness and semantic accuracy on its tasks. Our interpretation: Relevant comparison; a grammar does not supply a faithful reference interpretation for our claims.

## p4: CRANE: Reasoning with constrained LLM generation

Debangshu Banerjee; Tarun Suresh; Shubham Ugare; Sasa Misailovic; Gagandeep Singh (2025); ICML. Verified [primary source](https://proceedings.mlr.press/v267/banerjee25a.html).

Problem: Restricting every token to a final-answer grammar can inhibit reasoning. Method: Augment the grammar to permit reasoning while constraining the final structured answer. Result reported: Provides a theoretical analysis and task evaluations. Our interpretation: A concise semantic analysis before JSON is worth comparing; this is not a faithfulness guarantee.

## p5: Grammar-Aligned Decoding

Kanghee Park; Jiayu Wang; Taylor Berg-Kirkpatrick; Nadia Polikarpova; Loris D'Antoni (2024); NeurIPS. Verified [primary source](https://proceedings.nips.cc/paper_files/paper/2024/hash/2bdc2267c3d7d01523e2e17ac0a754f3-Abstract-Conference.html).

Problem: Token-local constraints distort the sampled sequence distribution. Method: Approximate grammar-conditioned generation with adaptive sampling. Result reported: Shows improved likelihoods on structured generation tasks. Our interpretation: Decoder scores are not automatically a calibrated posterior over meanings.

## p6: Semantic Parsing to Probabilistic Programs for Situated Question Answering

Jayant Krishnamurthy; Oyvind Tafjord; Aniruddha Kembhavi (2016); EMNLP. Verified [primary source](https://aclanthology.org/D16-1016/).

Problem: Question interpretation and environment interpretation are uncertain. Method: Parse questions into probabilistic programs and infer over language/environment choices. Result reported: Evaluates situated question answering with approximate structured inference. Our interpretation: Direct prior work for uncertain parsing plus uncertain perception. This combination alone is not a novel contribution.

## p7: Weakly-Supervised Neural Semantic Parsing with a Generative Ranker

Jianpeng Cheng; Mirella Lapata (2018); CoNLL. Verified [primary source](https://aclanthology.org/K18-1035/).

Problem: Weak denotation supervision permits spurious logical forms. Method: Rank generated tree-structured programs using execution and utterance agreement. Result reported: Reports competitive results on three Freebase datasets. Our interpretation: A source-conditioned neural ranker is plausible; a correct verdict alone cannot identify the correct parse.

## p8: Enforcing Consistency in Weakly Supervised Semantic Parsing

Nitish Gupta; Sameer Singh; Matt Gardner (2021); ACL-IJCNLP. Verified [primary source](https://aclanthology.org/2021.acl-short.22/).

Problem: Programs can produce the right answer for the wrong reason. Method: Enforce consistent phrase-to-program mappings across related inputs. Result reported: Reports a ten-point absolute improvement over its prior best NLVR comparison. Our interpretation: Controlled role/scope contrasts can constrain parsing without using media truth to choose a convenient reading.

## p9: One SPRING to Rule Them Both: Symmetric AMR Semantic Parsing and Generation without a Complex Pipeline

Michele Bevilacqua; Rexhina Blloshmi; Roberto Navigli (2021); AAAI. Verified [primary source](https://github.com/SapienzaNLP/spring).

Problem: Complex separate pipelines for AMR parsing and generation. Method: Use one pretrained encoder-decoder architecture with graph linearization for both directions. Result reported: Provides models and implementation for AMR parsing/generation. Our interpretation: A reusable neural frontend; AMR-to-logic still requires correct scope and source alignment.

## p10: Neural Semantic Parsing with Extremely Rich Symbolic Meaning Representations

Xiao Zhang; Gosse Bouma; Johan Bos (2025); Computational Linguistics. Verified [primary source](https://aclanthology.org/2025.cl-1.7/).

Problem: Lexical copying and frequent-sense defaults weaken symbolic predicates. Method: Train neural DRS parsers with taxonomical concept representations. Result reported: Improves out-of-vocabulary concept handling; not superior on all standard metrics. Our interpretation: DRS is an alternative logic-oriented frontend. The linked repository documents training/results; a ready inference checkpoint was not confirmed.

## p11: Modeling Quantification and Scope in Abstract Meaning Representations

James Pustejovsky; Ken Lai; Nianwen Xue (2019); DMR. Verified [primary source](https://aclanthology.org/W19-3303/).

Problem: Basic AMR has gaps in quantification and scope. Method: Extend the predicative graph with scope structure. Result reported: A representation proposal rather than evidence for our corpus. Our interpretation: Replacing SRL with AMR alone does not remove scope design or conversion work.

## p12: ChopChop: A Programmable Framework for Semantically Constraining the Output of Language Models

Shaan Nagy; Timothy Zhou; Nadia Polikarpova; Loris D'Antoni (2026); POPL / PACMPL. Verified [primary source](https://arxiv.org/abs/2509.00360).

Problem: String-level constraints make program semantics difficult to enforce. Method: Prune possible abstract syntax trees using explicit semantic properties. Result reported: Demonstrates type safety and program-equivalence constraints. Our interpretation: Elegant general framework for checkable AST properties. It does not turn an uncertain sentence interpretation into a formal equivalence oracle.

## Gaps and constraints

- Formal validity and faithful claim meaning need separate supervision and evaluation. Evidence: p1-p3,p7,p12; our 61 complete/9 retained development result.
- Language uncertainty must remain distinct from evidence uncertainty and unrepresented meaning. Evidence: p5-p8; probabilistic parsing and spurious programs are established.
- A broad neural frontend still needs source spans, scope and an implementable conversion to the existing logic. Evidence: p9-p11; local AMR experiments already exist.
- Parser annotations can be wrong; hard agreement with one annotation is not semantic gold. Evidence: Our Robot sweep-kick example; p10 discusses predicate/sense weaknesses.
- Limited checked program labels favor small diagnostic comparisons before new parser training. Evidence: Only 63 unique reviewed final programs in the latest pool; p7-p8 require more structured learning signals.

The 2025 DRS repository documents training and saved results; a reusable checkpoint was not confirmed. Full AMR-to-logic replacement and broad SRL retraining are not the immediate implementation plan.

## p13: Divide and Translate: Compositional First-Order Logic Translation and Verification for Complex Logical Reasoning

Hyun Ryu, Gyeongman Kim, Hyemin S. Lee, Eunho Yang (2025), ICLR. [Verified primary source](https://arxiv.org/abs/2410.08047). Parse component/dependency structures, translate progressively, and compare alternative formulas using a solver. Our interpretation: Clause-by-clause translation is a stronger next experiment than expanding one monolithic prompt. Solver agreement is not proof of faithfulness to a media claim.

## p14: Few-Shot Natural Language to First-Order Logic Translation via Code Generation

Junnan Liu (2025), NAACL. [Verified primary source](https://aclanthology.org/2025.naacl-long.547/). Use in-context learning and progressive code generation as an intermediate representation. Our interpretation: Supports testing a short structured construction interface; never execute arbitrary model-generated Python in our compiler.

## p15: A Continuation Semantics for Abstract Meaning Representation

Kenneth Lai; Lucia Donatelli; James Pustejovsky (2020), DMR. [Verified primary source](https://aclanthology.org/2020.dmr-1.1/). Translate AMR to first-order logic with continuation semantics. Our interpretation: A principled AMR-to-logic converter is an alternative to matching SRL noun heads. Its semantics still depend on faithful input graphs.

## p16: Squib: Expressive Power of Abstract Meaning Representations

Johan Bos (2016), Computational Linguistics. [Verified primary source](https://aclanthology.org/J16-3006/). Give recursive translations to first-order logic and analyze negation/quantification. Our interpretation: The graph-to-logic stage can follow established formal semantics, while neural parse correctness remains a separate empirical question.

## Additional software and negative evidence

The [older Neural_DRS repository](https://github.com/RikVN/Neural_DRS) exposes reusable parser pipelines but has a documented Python3.6-era setup, so it is not an immediate replacement in this environment. A [2026 author blog](https://1npc.github.io/blog/2026/some-failed-ideas-in-semantic-parsing/) reports that well-formed DRSs and logical comparison did not reliably detect small MT meaning errors. This is preliminary adjacent-task evidence; it supports checking source fidelity separately, not abandoning neural parsing.

Our cached BART AMR graphs already express the missing wind-speed causer and the Sheinbaum attribution. The robot graph fixes the kick participants but introduces a separate sweep relation, and the charger graph misattaches portable. These four selected examples support testing one neural frontend; they do not establish full-corpus accuracy or justify selecting the best parser separately for each claim.

## p17: NL2LOGIC: AST-Guided Translation of Natural Language into First-Order Logic with Large Language Models

Rizky Ramadhana Putra, Raihan Sultan Pasha Basuki, Yutong Cheng, Peng Gao (2026), Findings of EACL. [Verified venue source](https://aclanthology.org/2026.findings-eacl.317/). Recursively parse clauses into an abstract syntax tree; deterministically generate solver code. The author-hosted PDF timed out; the ACL page and arXiv metadata verify the work. Recursive semantic parsing plus deterministic AST compilation is established infrastructure.
