# Functions

# packages -------

  library(tidyverse)
  library(stringi)
  library(trafo)

  library(hgnc)

  library(tidysbml)

# reading of SBML files --------

  read_sbml <- function(url, local_path) {

    ## reads the model from an internet repository or a local copy

    ## trying the download

    model <- try(sbml_as_list(url), silent = TRUE)

    if(inherits(model, "try-error")) {

      warning("Download of the model failed. Resorting to a local copy.",
              call. = FALSE)

      model <- try(sbml_as_list(local_path), silent = TRUE)

      if(inherits(model, "try-error")) {

        stop("The local copy of the model is not readable.",
             call. = FALSE)

      } else {

        message("Success: model read from the local path.")

      }

    } else {

      message("Success: model downloaded.")

    }

    return(model)

  }

# wrangling -------

  process_recon2_2 <- function(reaction_note) {

    ## extracts reaction note contents for the Recon 2.2 subsystem

    reaction_note <- unlist(reaction_note)

    note_heads <- stri_extract(reaction_note, regex = "^.*:\\s+")

    note_heads <- stri_replace(note_heads,
                               regex = ":\\s+$",
                               replacement = "")

    reaction_note <-
      as_tibble(as.list(set_names(reaction_note, note_heads)))

    reaction_note[, names(reaction_note) %in% c("GENE_ASSOCIATION",
                                                "CONFIDENCE_LEVEL",
                                                "SUBSYSTEM")]

  }

  entrez_rm_version <- function(x) {

    ## simplifies Entrez IDs by removal of the version (number after the dot)

    stri_replace_all(x, regex = "\\.\\d+", replacement = "")

  }

  hgnc2entrez <- function(x, conversion_df = hgnc_dataset) {

    ## converts HGNC identifiers to EntrezIDs
    ## in a character string with a conversion data frame with
    ## obligatory columns "hgnc_id" and "entrez_id"

    ## extraction

    hgnc_txt <-
      sort(stri_extract_all(x, regex = "HGNC:\\d+")[[1]],
           decreasing = TRUE)

    entrez_txt <- exchange(hgnc_txt,
                           conversion_df,
                           key = "hgnc_id",
                           value = "entrez_id")

    for(i in names(entrez_txt)) {

      x <- stri_replace(x,
                        fixed = i,
                        replacement = entrez_txt[[i]])

    }

    return(x)

  }

# END ------
