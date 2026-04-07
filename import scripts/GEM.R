# Import and extraction of reaction, gene, and subsystem annotation data
# for the Human GEM models (https://github.com/SysBioChalmers/Human-GEM,
# currently 2.0.0).
# Source file available at:
# https://github.com/SysBioChalmers/Human-GEM/blob/main/model/Human-GEM.txt

  insert_head()

# container --------

  gem2_sbml <- list()

# raw model data --------

  insert_msg("Reading the raw GEM model data")

  gem2_sbml$model_data <- recon_models %>%
    filter(model_name == "Human-GEM2.0.0")

  gem2_sbml$raw <-
    try(read_xlsx(gem2_sbml$model_data$url), silent = TRUE)

  if(inherits(gem2_sbml$raw, "try-error")) {

    warning("Download of the GEM model failed, resorting to a local copy",
         call. = FALSE)

    gem2_sbml$raw <-
      read_xlsx(gem2_sbml$model_data$local_path)

  }

# Wrangling: reaction IDs, gene - reaction association, subsystems ---------

  insert_msg("Extraction of the reaction annotation")

  gem2_sbml$reaction_data <- gem2_sbml$raw %>%
    transmute(id = ID,
              name = NAME,
              ec_number = `EC-NUMBER`,
              gene_association = map_chr(`GENE ASSOCIATION`, ensembl2entrez),
              subsystem = SUBSYSTEM,
              confidence_level = `CONFIDENCE SCORE`,
              reference = REFERENCE,
              miriam = MIRIAM) %>%
    ## manual correction of subsystem errors
    mutate(subsystem = stri_replace(subsystem,
                                    fixed = "Pentose Phosphate Pathway",
                                    replacement = "Pentose phosphate pathway"))

# END --------

  gem2_sbml <- gem2_sbml[c("model_data", "raw", "reaction_data")]

  insert_tail()
