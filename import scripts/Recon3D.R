# Import and extraction of reaction, gene, and subsystem annotation data
# for the Recon3D model.
# Work in progress: due to problems with unique syntax of
# gene - reaction association rules.

  insert_head()

# container --------

  recon3D_sbml <- list()

# raw SBML model --------

  insert_msg("Reading the raw Recon3D model")

  recon3D_sbml$model_data <- recon_models %>%
    filter(model_name == "Recon3D")

  recon3D_sbml$raw <-
    read_sbml(url = recon3D_sbml$model_data$url[[1]],
              local_path = recon3D_sbml$model_data$local_path[[1]])

# Extraction of reaction IDs, names, subsystems, and gene association rules -------

  insert_msg("Extraction of the reaction features from Recon3D model")

  ## reaction data

  recon3D_sbml$reaction_data <-
    recon3D_sbml$raw$sbml$model$listOfReactions %>%
    map(attributes) %>%
    map_dfr(~as_tibble(.x[c("id", "metaid", "name")]))


  ## gene association rules

  tst <- recon3D_sbml$raw$sbml$model$listOfReactions %>%
    map(~.x$geneProductAssociation)

# END --------
