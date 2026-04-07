# RECON_processing

_Processing of RECON models of human metabolism: uniform gene - reaction association rules_

## Description

This small pipeline executes R code for import and wrangling of Recon models of 
human metabolism, and saves data frames with harmonized reaction identifiers, names, 
subsystems, and gene - reaction association rules as `.RData` files. 
These objects are subsequently used by R package biggrExtra (https://github.com/PiotrTymoszuk/biggrExtra) 
in modeling of reaction activity with transcriptome data. 

## Usage

Sourcing of `exec.R` launches the whole import, wrangling and export pipeline: 

```r
  
  source("exec.R")

```

Cleared data frames with reaction identifiers, subsystem assignment, and gene - reaction 
association rules for 
[Recon 2](https://www.ebi.ac.uk/biomodels/MODEL1109130000), 
[Recon2.2](https://www.ebi.ac.uk/biomodels/MODEL1603150001), 
and [Human-GEM 2.0.0](https://github.com/SysBioChalmers/Human-GEM)
models are available in the [downloads folder](https://github.com/PiotrTymoszuk/RECON_processing/tree/main/downloads).

## Terms of use

The package is available under a
[GPL-3 license](https://github.com/PiotrTymoszuk/RECON_processing/blob/main/LICENSE).

## Contact

The package maintainer is [Piotr Tymoszuk](mailto:piotr.s.tymoszuk@gmail.com).
