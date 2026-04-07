# Launches the import scripts.
#
# At the moment RECON2, RECON2.2, and Human-GEM 2.0.0 models are processed.
# Work on the RECON3D is in progress: it takes additional wrangling steps,
# because its gene - reaction association rules come in another format
# (nested list instead of character strings as in RECON2 and RECON2.2).

  library(tidyverse)
  library(stringi)
  library(readxl)

  library(tidysbml)

  library(soucer)

  insert_head()

  c("./tools/globals.R",
    "./tools/functions.R") %>%
    source_all(message = TRUE, crash = TRUE)

# Import scripts -------

  c("./import scripts/Recon2.R",
    "./import scripts/Recon2_2.R",
    "./import scripts/GEM.R") %>%
    source_all(message = TRUE, crash = TRUE)

# END --------

  insert_tail()
