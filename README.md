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
[Recon 2](https://www.ebi.ac.uk/biomodels/services/download/get-files/MODEL1109130000/2/MODEL1109130000_url.xml) 
and [Recon2.2](https://www.biomodels.org/biomodels/services/download/get-files/MODEL1603150001/2/MODEL1603150001_url.xml) 
models are available in the downloads folder.

## Terms of use

The package is available under a
[GPL-3 license](https://github.com/PiotrTymoszuk/RECON_processing/blob/main/LICENSE).

## Contact

The package maintainer is [Piotr Tymoszuk](mailto:piotr.s.tymoszuk@gmail.com).
