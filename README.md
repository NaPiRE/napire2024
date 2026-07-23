<p align="center">
  <img src="http://napire.org/assets/napire-Logo.jpg" alt="NaPiRe Logo">
</p>

# Naming the Pain in Requirements Engineering: 2024 Edition

This repository contains the files, data, and analysis of the 2024 edition of the **Naming the Pain in Requirements Engineering** (NaPiRE) survey.
It marks the fourth official and third global survey of the state of practice in requirements engineering, this time with a focus on human factors and communication.

## Description of Artifacts

This repository contains the following files:

```
├── data: data collected during the 2024 NaPiRE run
│   ├── codebook.pdf: explanation of variables and values
│   ├── data_raw.csv: raw data from the run
│   ├── propositions.md: propositions from the 2018 status quo theory
│   └── quick-overview.zip: simple visualization of the collected data
├── figures: directory for all generated figures
│   ├── descriptive: directory of all descriptive statistics
│   └── variance: figures used to illustrate the analysis of variance
├── organisation: supplementary files for the coordination of the study
│   ├── NaPiRE Flyer: promotional material for participating in NaPiRE
│   ├── NaPiRE-Survey.pdf: list of questions asked in the NaPiRE questionnaire
│   └── NaPiRE2024 Invitation Text.txt: template for inviting practitioners
├── presenations: slide decks and presentation material
│   └── 2025-12-10-analysis-sync.pptx: presentation of early results from the analysis of hypotheses
├── src: source code used in this study
│   ├── html: directory with all precompiled source files
│   ├── patterns: reusable data analysis patterns
│   ├── util: auxiliary R scripts and supporting files
│   │   ├── dropout.Rmd: notebook visualizing the dropout patterns from the survey
│   │   └── data-loader.R: script to load, cast, and prepare the raw data for the analysis
│   ├── variance: analyses of variance of the response variables
│   └── descriptive-statistics.Rmd: visualization of quantitative data from the 2024 data set
├── INSTALL.md : system requirements for this artifact
└── LICENSE.md : license file clarifying reuse of this material
```

## System Requirements

To interact with the data analyses in this repository, you have two options:

1. Self-compile: To run the data analysis files yourself, first ensure that all system requirements are met as specified in the [INSTALL.md](INSTALL.md) file. Then, open the `.Rmd` files in an IDE supporting R (e.g., RStudio) and execute them cell by cell.
2. Pre-compiled: To simply read the pre-compiled data analyses, find an already processed `.html` version of each analysis in the *src/html* folder.

## Usage

The following subsections detail how to utilize the material compiled in this repository.

### Analysis of Variance

The folder *src/variance* contains all notebooks analyzing, how the responses to the main survey questions vary by the demographic factors. 
This has two purposes:

1. Via the use of Bayesian data analysis, these analyses produce **credibility intervals**, i.e., intervals of likelihood responding to a question with a specific response. Responses with intervals consistently above 20% likelihood can be considered *common*.
2. Via marginal effects of the individual demographic factors, these analyses reveal effects of individual variables.

To process these analyses, first consult the overview file [napire-24-variance.xlsx](src/variance/napire-24-variance.xlsx) consisting of the following columns:

- Code: the identifier of the variable in the NaPiRE data set
- Question: the raw question text to which respondents answered
- Two columns per demographic factor (country, project size, way-of-working, sector, external, and distributed):
  - The first column ("Common Response") lists all levels of the response that have a likelihood above 20%
  - The second column ("Effects") lists all variance induced by the respective demographic factor

The complete analysis of each question can be found in the *src/variance* directory, identified by the variable code.

## Citing

When citing the NaPiRE initiative in general, please use: 

> D. Mendez, S. Wagner, M. Kalinowski, M.T. Baldassarre et al.. NaPiRE: Naming the Pain in Requirements Engineering, http://napire.org".

Specific data sets can be cited by adding the dates from the respective NaPiRE runs to the citation (e.g. 2024 for the one primarily used in context of this repository).
When referring to the data set in this repository (NaPiRE 2024), please respect all authors' attribution as described in the respective file.
Exemplary publications that describe the initiative and which can be also used to refer to the data set are:

- D. Mendez Fernandez, S. Wagner. Naming the Pain in Requirements Engineering: A Design for a Global Family of Surveys and First Results from Germany. In: Information and Software Technology, Elsevier, 2014
- D. Mendez Fernandez, S. Wagner, M. Kalinowski, M. Felderer, P. Mafra, A. Vetrò, T. Conte, M.-T. Christiansson, D. Greer, C. Lassenius, T. Männistö, M. Nayebi, M. Oivo, B. Penzenstadler, D. Pfahl, R. Prikladnicki, G. Ruhe, A. Schekelmann, S. Sen, R. Spinola, J.L. de la Vara, A. Tuzcu, R. Wieringa. Naming the Pain in Requirements Engineering: Contemporary Problems, Causes, and Effects in Practice. In: Empirical Software Engineering Journal, Springer, 2016
- S. Wagner, D. Mendez Fernandez, M. Kalinowski, M. Felderer, P. Mafra, A. Vetrò, T. Conte, M.-T. Christiansson, D. Greer, C. Lassenius, T. Männistö, M. Nayebi, M. Oivo, B. Penzenstadler, D. Pfahl, R. Prikladnicki, G. Ruhe, A. Schekelmann, S. Sen, R. Spinola, J.L. de la Vara, A. Tuzcu, R. Wieringa, and D. Winkler. Status Quo in Requirements Engineering: A Theory and a Global Family of Surveys. In: Transactions on Software Engineering and Methodology, 2019

The authors' preprint versions of the manuscripts can be found on the [initiative's website](https://napire.org).

## License

Copyright © 2026 Daniel Mendez, Stefan Wagner, and Julian Frattini.
This work is licensed under the [CC-BY 4.0](./LICENSE).
