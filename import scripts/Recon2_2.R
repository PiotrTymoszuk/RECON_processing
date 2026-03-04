# Import and extraction of reaction, gene, and subsystem annotation data
# for the Recon2.2 model

  insert_head()

# container --------

  recon2_2_sbml <- list()

# raw SBML model --------

  insert_msg("Reading the raw Recon2.2 model")

  recon2_2_sbml$model_data <- recon_models %>%
    filter(model_name == "Recon2.2")

  recon2_2_sbml$raw <-
    read_sbml(url = recon2_2_sbml$model_data$url[[1]],
              local_path = recon2_2_sbml$model_data$local_path[[1]])

# Extraction of reaction IDs, names, subsystems, and gene association rules -------

  insert_msg("Extraction of the reaction features from Recon2.2 model")

  ## reaction data

  recon2_2_sbml$reaction_data <-
    recon2_2_sbml$raw$sbml$model$listOfReactions %>%
    map(attributes) %>%
    map_dfr(~as_tibble(.x[c("id", "metaid", "sboTerm", "name")]))

  ## reaction notes

  recon2_2_sbml$reaction_notes <-
    recon2_2_sbml$raw$sbml$model$listOfReactions %>%
    map(~.x$notes$body) %>%
    map_dfr(process_recon2_2)

  ## clearing the reaction notes

  recon2_2_sbml$reaction_notes <- recon2_2_sbml$reaction_notes %>%
    map_dfc(stri_replace,
            regex = "^.+:\\s{1}",
            replacement = "") %>%
    map_dfc(~ifelse(.x == "", NA, .x)) %>%
    transmute(gene_association = GENE_ASSOCIATION,
              subsystem = SUBSYSTEM,
              confidence_level = as.numeric(CONFIDENCE_LEVEL)) %>%
    ### conversion of HGNC identifiers to EntrezIDs
    mutate(gene_association = map_chr(gene_association,
                                      hgnc2entrez,
                                      conversion_df = hgnc_dataset))

  ## merging of the reaction information

  recon2_2_sbml$reaction_data <-
    cbind(recon2_2_sbml$reaction_data,
          recon2_2_sbml$reaction_notes) %>%
    as_tibble

# END --------

  recon2_2_sbml <- recon2_2_sbml[c("model_data", "raw", "reaction_data")]

  insert_tail()
