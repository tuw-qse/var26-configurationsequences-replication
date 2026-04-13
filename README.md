# var26-configurationsequences-replication

This repository contains the replication package for the paper _Order Matters - On configuration sequences in Feature Models_.
In the paper, we describe how to extend feature models with visibility constraints to support explicit configuration sequences in feature models. 

To do so, we first extend the syntax of the [Universal Variability Language](https://universal-variability-language.github.io/) with the `\vif` operator that represents a `VisibleIf` language element to support expressing the visibility of a feature (as a precondition). 
Second, to study the feasibility of feature models containing visibility constraints, we extend the FeatureIDE plugin for feature modeling that offers editor support for the extended UVL language. The extension allows the definition of visibility constraints in the feature diagram editor both visually and in the UVL source code. Furthermore, the extended configuration editor allows for visualizing features dynamically based on the visibility constraints in a feature and for reasoning on the validity of such a partial feature model.  

We evaluate the applicability of feature models with visibility constraints in two ways.

First, we extend an existing set of case studies with visibility constraints based on the use case descriptions from which the existing feature models resulted. 
Integrating visibility constraints into feature models reduces the number of available feature upon beginning the configuration _by up to 84%_ (in the chess piece case study).

Second, we performed a user study with 8 experts in variability modeling. 
Our hypothesis is that visibility constraints (with non-visible features being hidden during configuration) reduces the complexity and eases the configuration process. 
The participants were tasked to derive two valid process configurations in two case studies by using first the classical FeatureIDE feature configuration editor (without visibility constraints) and second our novel editor, which dynamically visualizes features that become visible upon configuration. 
The participants complete the feature configuration process faster (_58%_ for the first task and _52%_ for the second task) when visibility constraints are used. 
More importantly, they derive a semantically meaningful process sequence in all cases when visibility constraints guide their configuration process whereas only a (syntactically, but not semantically) valid feature configuration is derived when all features are displayed upfront to the users.  

## Contents

The repository is structured as follows:

- [UVL Parser](/UVL%20Parser/) contains the extended ANTLR grammar and the corresponding parser  
- [FeatureIDE extension](/FeatureIDE/) contains the FeatureIDE plugin extension that uses the UVL parsers and provides the adapted UVL feature model editor
- [script](compile-featureide.sh) to build the extended UVL parser, push it into FeatureIDE, and build the extended FeatureIDE
- [evaluation](/evaluation/)
    - [case studies](/evaluation/case-studies/) the feature models from a former [case study](https://doi.org/10.1145/3461002.3473946) enriched with visibility constraints 
    - [user study](evaluation/user-study) the questionnaire and the task descriptions that we gave the study participants. We omit the responses due to GDPR regulations.

### Script

Use the following command to build the UVL parser and FeatureIDE.

```bash
chmod +x compile-featureide.sh
./compile-featureide.sh /path/to/source-repo /path/to/target-repo
```