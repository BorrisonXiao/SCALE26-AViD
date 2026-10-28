# Literature review: claim-to-DeepProbLog compilation

**Date:** 2026-10-28. **Scope:** foundational methods plus targeted 2024–2026 updates.

**Instruction:** Get claim-to-DeepProbLog compilation working. Compare syntax plus role labeling and rule/neural transformation, direct semantic parsing plus post-processing, and suitable alternatives. Research predicate/logical-form generation, run experiments, and update the plan/checklist before media verification.

## Recommendation

Compare front ends through one logical representation and one deterministic backend compiler. Use trained SRL as a low-cost span/role baseline, pretrained AMR for finer semantic structure, and a small clause-level logical-form generator as the next neural condition. Keep dependency analysis for alignment, tense and diagnostics. Do not make syntactic trees a required reasoning structure. This is an implementation recommendation, not a new paper-direction decision.

The first two neural conditions in our experiment generate complete PENMAN graphs. They are useful diagnostics, but they are not implementations of PICARD, CLOVER, Code4Logic or NL2LOGIC. The next condition should test their relevant design principle: a model builds a small structured meaning representation, while deterministic code handles syntax and compilation.

## Scope and search

Questions: What does syntax contribute?; What do trained SRL and AMR preserve?; How are logical scope and predicates generated?; How should a small frozen model generate a logical form?; How do we distinguish validity from meaning preservation?.

Search formulations included: semantic parsing predicates DeepProbLog; AMR to first-order logic scope; CCG Boxer logical forms; trained semantic role labeling predicate extraction; constrained semantic parsing grammar; 2024–2026 NL-to-FOL translation; clause-level AST semantic parsing. Sources were primary venue pages, author PDFs and official software documentation. Historical literature files are preserved.

## Landscape

Boxer and ccg2lambda show how syntax can support principled compositional semantics. Our previous local dependency transformations do not inherit those guarantees. Replacing the hand-built compiler with another collection of dependency exceptions would retain the underlying problem.

SRL identifies predicates and argument spans. AMR additionally represents semantic concepts and shared referents, often abstracting over active/passive wording. Neither is a ready-to-execute DeepProbLog program. Scope, source content, temporal distinctions and supported predicate signatures still require an explicit translation.

Recent NL-to-FOL work offers specialized translators, progressive construction and intermediate logical trees. These are relevant engineering options and important prior art. Their results on quantified text-reasoning datasets do not establish correctness on AViD event descriptions or typed media support.

## Verified papers

### Boxer: Wide-Coverage Semantic Analysis with Boxer

Johan Bos (2008), STEP. [Primary source](https://aclanthology.org/W08-2222/). **Verified.**

**Problem:** How to obtain broad-coverage formal meaning from syntax. **Method:** CCG parsing feeds compositional construction of discourse representation structures, which can be translated to first-order logic. **Reported result:** Describes an operational semantic-analysis pipeline. No result is transferred to AViD. **Relevance / limitation:** Syntax is useful when paired with a defined compositional semantics; a dependency edge is not itself a logical operator.

### ccg2lambda: ccg2lambda: A Compositional Semantics System

Pascual Martínez-Gómez, Koji Mineshima, Yusuke Miyao, Daisuke Bekki (2016), ACL System Demonstrations. [Primary source](https://aclanthology.org/P16-4015/). **Verified.**

**Problem:** How to compute logical forms from syntactic derivations. **Method:** Assign typed semantic templates to CCG categories and compose them with lambda-calculus operations. **Reported result:** Implements compositional semantics and theorem-proving applications. **Relevance / limitation:** A principled syntax-to-logic baseline is possible, but installing CCG and supplying lexical templates is additional work; it is not our current UD rules.

### AMR: Abstract Meaning Representation for Sembanking

Laura Banarescu et al. (2013), LAW. [Primary source](https://aclanthology.org/W13-2322/). **Verified.**

**Problem:** A sentence-level semantic representation less tied to surface syntax. **Method:** Represent concepts, semantic roles, names and shared referents as a rooted graph. **Reported result:** Introduces the representation and annotation effort. **Relevance / limitation:** Provides a standard intermediate representation and pretrained parsers; not a complete executable specification of all English meanings.

### AMR-FOL: Expressive Power of Abstract Meaning Representations

Johan Bos (2016), Computational Linguistics. [Primary source](https://www.let.rug.nl/bos/pubs/Bos2016CL.pdf). **Verified.**

**Problem:** What AMR means in formal logic, particularly with negation and shared variables. **Method:** Define a recursive translation to first-order logic and discuss extensions for scope and projection. **Reported result:** Gives formal results about expressiveness and a scope-aware translation. **Relevance / limitation:** Do not simply conjoin every AMR triple or assume every embedded event is asserted. Our restricted translation is not an implementation of the complete formal account.

### PredPatt: Universal Decompositional Semantics on Universal Dependencies

Aaron Steven White, Drew Reisinger, Keisuke Sakaguchi, Tim Vieira, Sheng Zhang, Rachel Rudinger, Kyle Rawlins, Benjamin Van Durme (2016), EMNLP. [Primary source](https://aclanthology.org/D16-1177/). **Verified.**

**Problem:** How to anchor predicate/argument structures and semantic annotations in dependencies. **Method:** Build a dependency-based predicate/argument layer for decompositional semantic annotation. **Reported result:** Introduces a representation and annotation framework. **Relevance / limitation:** An existing extraction baseline is preferable to repeatedly rebuilding local dependency heuristics. Extraction does not define source or quantifier scope.

### PredPatt-eval: An Evaluation of PredPatt and Open IE via Stage 1 Semantic Role Labeling

Sheng Zhang, Rachel Rudinger, Benjamin Van Durme (2017), IWCS Short Papers. [Primary source](https://aclanthology.org/W17-6944/). **Verified.**

**Problem:** How predicate/argument extraction compares with SRL-oriented evaluation. **Method:** Evaluate PredPatt and Open IE using a semantic-role-labeling framework. **Reported result:** Reports an extraction evaluation; no universal claim of logical completeness. **Relevance / limitation:** Useful as an inexpensive argument-span diagnostic; preserving phrases alone does not expose every learnable binding.

### AMR-time: Annotation of Tense and Aspect Semantics for Sentential AMR

Lucia Donatelli, Michael Regan, William Croft, Nathan Schneider (2018), LAW-MWE-CxG. [Primary source](https://aclanthology.org/W18-4912/). **Verified.**

**Problem:** Standard AMR omits temporal distinctions important for inference. **Method:** Augment finite predications with temporal and aspectual distinctions. **Reported result:** Defines a tense/aspect annotation extension. **Relevance / limitation:** Add source-aligned tense/aspect to AMR; landed and is landing must not collapse. This does not locate a video event.

### SPRING: One SPRING to Rule Them Both: Symmetric AMR Semantic Parsing and Generation without a Complex Pipeline

Michele Bevilacqua, Rexhina Blloshmi, Roberto Navigli (2021), AAAI. [Primary source](https://ojs.aaai.org/index.php/AAAI/article/view/17489). **Verified.**

**Problem:** How to parse/generate AMR without a complex pipeline. **Method:** Use a pretrained encoder-decoder model with a graph linearization and pointer tokens. **Reported result:** Shows strong AMR parsing/generation performance and examines distribution shift. **Relevance / limitation:** A task-trained encoder-decoder is a practical alternative to prompting a general decoder. Our amrlib BART checkpoint uses parse_xfm, not SPRING weights.

### Constrained-LM: Constrained Language Models Yield Few-Shot Semantic Parsers

Richard Shin et al. (2021), EMNLP. [Primary source](https://aclanthology.org/2021.emnlp-main.608/). **Verified.**

**Problem:** How to bootstrap semantic parsing with few examples. **Method:** Use constrained generation of an English-like controlled language with a deterministic mapping to logical forms. **Reported result:** Demonstrates effective few-shot parsing on several community tasks. **Relevance / limitation:** A small readable target language is an alternative to a large token-indexed JSON schema; its meaning still needs checking.

### PICARD: PICARD: Parsing Incrementally for Constrained Auto-Regressive Decoding from Language Models

Torsten Scholak, Nathan Schucher, Dzmitry Bahdanau (2021), EMNLP. [Primary source](https://aclanthology.org/2021.emnlp-main.779/). **Verified.**

**Problem:** Autoregressive decoders can generate invalid formal expressions. **Method:** Reject inadmissible next tokens using incremental parsing. **Reported result:** Improves constrained text-to-SQL generation. **Relevance / limitation:** Grammar-constrained decoding can address formatting, but cannot guarantee correct roles, polarity or source scope. We have not implemented it in this run.

### LogicLLaMA: Harnessing the Power of Large Language Models for Natural Language to First-Order Logic Translation

Yuan Yang, Siheng Xiong, Ali Payani, Ehsan Shareghi, Faramarz Fekri (2024), ACL. [Primary source](https://aclanthology.org/2024.acl-long.375/). **Verified.**

**Problem:** Reliable NL-to-FOL translation and suitable evaluation data. **Method:** Construct MALLS using generated pairs, parsing, human annotation and filtering; train specialized translators and correction models. **Reported result:** Presents 28K NL/FOL pairs and translation experiments. **Relevance / limitation:** Off-the-shelf logical translators exist. Their quantified-rule datasets and predicate vocabularies differ from AViD event descriptions; check transfer before adopting or fine-tuning.

### Binding-FOL: Learning Semantic Structure through First-Order-Logic Translation

Akshay Chaturvedi, Nicholas Asher (2024), Findings of EMNLP. [Primary source](https://aclanthology.org/2024.findings-emnlp.390/). **Verified.**

**Problem:** Whether language models attach predicates to the right objects. **Method:** Compare question answering and FOL translation using prompting and fine-tuning on synthetic examples. **Reported result:** Finds predicate/argument confusions and benefits from FOL-oriented supervision in its settings. **Relevance / limitation:** Directly supports testing role swaps and modifier attachment; valid formulas alone do not certify those bindings.

### CLOVER: Divide and Translate: Compositional First-Order Logic Translation and Verification for Complex Logical Reasoning

Hyun Ryu, Gyeongman Kim, Hyemin S. Lee, Eunho Yang (2025), ICLR. [Primary source](https://arxiv.org/abs/2410.08047). **Verified.**

**Problem:** Complex logical meaning is hard to translate in one generation. **Method:** Parse component/dependency structures, translate progressively, and compare alternative formulas using a solver. **Reported result:** Evaluates on seven logical-reasoning benchmarks. **Relevance / limitation:** Clause-by-clause translation is a stronger next experiment than expanding one monolithic prompt. Solver agreement is not proof of faithfulness to a media claim.

### Code4Logic: Few-Shot Natural Language to First-Order Logic Translation via Code Generation

Junnan Liu (2025), NAACL. [Primary source](https://aclanthology.org/2025.naacl-long.547/). **Verified.**

**Problem:** How to generate complex logical forms without task-specific fine-tuning. **Method:** Use in-context learning and progressive code generation as an intermediate representation. **Reported result:** Reports improvements over training-free translation baselines. **Relevance / limitation:** Supports testing a short structured construction interface; never execute arbitrary model-generated Python in our compiler.

### NL2LOGIC: NL2LOGIC: AST-Guided Translation of Natural Language into First-Order Logic with Large Language Models

Rizky Ramadhana Putra, Raihan Sultan Pasha Basuki, Yutong Cheng, Peng Gao (2026), Findings of EACL. [Primary source](https://people.cs.vt.edu/penggao/papers/nl2logic-eacl26findings.pdf). **Verified.**

**Problem:** Fragile syntax and low semantic faithfulness in text-to-logic translation. **Method:** Recursively parse clauses into an abstract syntax tree; deterministically generate solver code. **Reported result:** Evaluates syntax, semantics and downstream reasoning separately on FOLIO, LogicNLI and ProofWriter. **Relevance / limitation:** Very close precedent for separating semantic parsing from deterministic compilation. That separation alone cannot be our novelty; the future paper must establish the multimodal binding/evidence contribution.

### DeepProbLog: DeepProbLog: Neural Probabilistic Logic Programming

Robin Manhaeve, Sebastijan Dumančić, Angelika Kimmig, Thomas Demeester, Luc De Raedt (2018), NeurIPS. [Primary source](https://papers.nips.cc/paper/7632-deepproblog-neural-probabilistic-logic-programming.pdf). **Verified.**

**Problem:** How to combine neural predictions and probabilistic logic. **Method:** Neural predicates supply probabilities to ProbLog inference and differentiable learning. **Reported result:** Demonstrates neural/symbolic inference and learning tasks. **Relevance / limitation:** It is a backend, not an English semantic parser. A backend can faithfully execute a mistranslated claim.

## Synthesis: facts and interpretation

The themes below summarize the cited methods. The recommendations about our compiler are our interpretation, not claims made by the papers.

- Semantic parsing and deterministic code generation are separate stages; DeepProbLog does not supply the former.
- SRL supplies useful predicate/argument spans but not complete scope, coreference or noun-phrase semantics.
- AMR provides roles and shared referents; its conversion to executable logic requires scope rules and additional tense/aspect information.
- Constrained decoding improves validity. Semantic faithfulness needs separate reference judgments and contrastive checks.
- Recent clause/AST-based translation is directly relevant and already established in prior work.

## Open questions for this project

- Which front end preserves AViD source scope, roles, shared identities and tense with low development cost? Evidence: Our same-input comparison; none of the cited benchmark results answers this domain-specific question.
- Choose the level of decomposition explicitly: a source complement or noun phrase kept as one string is not a set of learned internal bindings. Evidence: PredPatt/SRL extraction versus AMR-FOL scope; source contents are still opaque in our current pilot.
- Use familiar parsing/compiler techniques as infrastructure; establish later novelty through multimodal evidence assignments and binding learning. Evidence: Boxer, ccg2lambda, CLOVER, Code4Logic and NL2LOGIC already separate meaning construction from formal execution.

## Practical alternatives not run here

A Boxer/DRS or ccg2lambda pipeline has a stronger formal-semantics basis for some scope phenomena, but requires a compatible syntactic parser, lexical resources and a new adapter. A pretrained NL-to-FOL translator is also worth a bounded transfer test; its vocabulary and rule-oriented training domain must be checked first. Neither is currently installed or measured in this comparison.

Official implementation references: [amrlib model interfaces](https://amrlib.readthedocs.io/en/latest/models/), [PredPatt](https://github.com/hltcoe/PredPatt), [DeepProbLog](https://github.com/ML-KULeuven/deepproblog). We used amrlib parse_xfm BART-large, not the SPRING checkpoint.
