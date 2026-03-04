# Import and extraction of reaction, gene, and subsystem annotation data
# for the Recon2 model

  insert_head()

# container --------

  recon2_sbml <- list()

# raw SBML model --------

  insert_msg("Reading the raw Recon2 model")

  recon2_sbml$model_data <- recon_models %>%
    filter(model_name == "Recon2")

  recon2_sbml$raw <-
    read_sbml(url = recon2_sbml$model_data$url[[1]],
              local_path = recon2_sbml$model_data$local_path[[1]])

# Extraction of reaction IDs, names, subsystems, and gene association rules -------

  insert_msg("Extraction of the reaction features from Recon2 model")

  ## reaction data

  recon2_sbml$reaction_data <- recon2_sbml$raw$sbml$model$listOfReactions %>%
    map(attributes) %>%
    map_dfr(~as_tibble(.x[c("id", "metaid", "sboTerm", "name")]))

  ## reaction notes

  recon2_sbml$reaction_notes <- recon2_sbml$raw$sbml$model$listOfReactions %>%
    map(~.x$notes$body) %>%
    map(set_names,
        c("gene_association",
          "subsystem",
          "ec_number",
          "confidence_level",
          "reference",
          "notes")) %>%
    map(as_tibble) %>%
    map_dfr(map_dfc, unlist)

  ## clearing of the reaction notes, simplifying the EntrezIDs
  ## by removal of the version information

  recon2_sbml$reaction_notes <- recon2_sbml$reaction_notes %>%
    map_dfc(stri_replace,
            regex = "^.+:\\s{1}",
            replacement = "") %>%
    map_dfc(~ifelse(.x == "", NA, .x)) %>%
    mutate(confidence_level = as.integer(confidence_level),
           gene_association = map_chr(gene_association, entrez_rm_version))

  ## merging of the reaction information

  recon2_sbml$reaction_data <-
    cbind(recon2_sbml$reaction_data,
          recon2_sbml$reaction_notes) %>%
    as_tibble

# END --------

  recon2_sbml <- recon2_sbml[c("model_data", "raw", "reaction_data")]

  insert_tail()
