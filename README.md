# var26-configurationsequences-replication

This repository contains the replication package for the paper _Order Matters - On configuration sequences in Feature Models_.
In the paper, we describe how to extend feature models with visibility constraints to support explicit configuration sequences in feature models. 

To do so, we first extend the syntax of the [Universal Variability Language](https://universal-variability-language.github.io/) with language elemetns to support expressing the visibility of a feature (as a precondition). 
Second, to study the feasibility of feature models containing visibility constraints, we contribute a FeatureIDE plugin extension that offers editor support for the extended UVL language. The editor allows for visualizing features dynamically based on the visibility of a feature and for reasoning on the validity of such a partial feature model.  

We evaluate the applicability of feature models with visibility constraints in two ways. 
First, we extend an existing set of case studies with visibility constraints based on the use case descriptions from which the existing feature models resulted. 
Second, we performed a user study with 8 experts in variability modeling. Our hypothesis is that visibility constraints (with non.visible features being hidden during configuration) reduces the complexity and eases the configuration process. The participants were tasked to derive two valid process configurations by using first the classical FeatureIDE feature configuration editor (without visibility constraints) and second our novel editor which dynamically visualizes features that become visible upon configuration. 

Integrating visibiltiy constraints into feature models reduces the number of available feature upon beginning the configuration by up to 
84% (in the chesspiece case study). Additionally, the participants complete the feature configuration process faster when visibility constraints are used. More importantly, they derive a semantically meanigful process sequence in all cases when visibility constraints guide their configuration process whereas only a (syntactically, but not semantically) valid feature configuration is derived when all features are displayed upfront to the users.  

## Contents

The repository is structured as follows:

- [UVL Parser]() contains the extended ANTLR grammar and the corrsponding parser  
- [FeatureIDE extension]() contains the FeatureIDE plugin extension that uses the UVL parsers and provides the adapted UVL feature model editor
- [evaluation]()
    - [case studies]() the feature models from a former [case study] enriched with visibiltiy constraints 
    - [user study]() the questionnaire and the task descriptions that we gave the study participants. We omit the resonsees due to GDPR regulations.
- [script]() to use the correct UVL parser with FeatureIDE

Descriptions of how to build and use the individual projects (e.g., the UVL Parser) are provided in the README files of the respetive folders. 