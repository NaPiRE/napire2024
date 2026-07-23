# Installation Guide

To utilize the artifacts in this repository, follow the installation guides below.
To view `.md` Markdown files contained in this repository, consider a Markdown viewer like the one [integrated into Visual Studio Code](https://code.visualstudio.com/docs/languages/markdown).

## R for Bayesian Data Analysis

In order to run the `.R` scripts and `.Rmd` notebooks, ensure that you have [R](https://ftp.acc.umu.se/mirror/CRAN/) (version > 4.0) and an appropriate IDE like [RStudio](https://posit.co/download/rstudio-desktop/#download) installed on your machine.
Then, ensure the following steps:

1. Install the C toolchain by following the instructions for [Windows](https://github.com/stan-dev/rstan/wiki/Configuring-C---Toolchain-for-Windows#r40), [Mac OS](https://github.com/stan-dev/rstan/wiki/Configuring-C---Toolchain-for-Mac), or [Linux](https://github.com/stan-dev/rstan/wiki/Configuring-C-Toolchain-for-Linux) respectively.
2. Restart RStudio and follow the instructions starting with the [Installation of RStan](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started#installation-of-rstan)
3. Install the `devtools` and the latest version of `stan` by running the following commands
```R
    install.packages("devtools")
    devtools::install_github("stan-dev/cmdstanr")
    cmdstanr::install_cmdstan()
```
4. Install all required packages via `install.packages(c("tidyverse", "ggdag", "brms", "marginaleffects", "patchwork"))`.
5. Create a folder called *fits* within *src/* such that `brms` has a location to place all Bayesian models.
6. Open the `.Rproj` file with RStudio which will setup the environment correctly.
