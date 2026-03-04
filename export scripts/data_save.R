# Saving data frames with reaction identifiers, names, and gene - reaction
# association rules as .RData objects.

  insert_head()

# saving the cleared reaction data --------

  insert_msg("Saving the reaction data")

  ## model's meta-data

  ReconInfo <- recon_models %>%
    filter(model_name %in% c("Recon2", "Recon2.2"))

  save(ReconInfo, file = "./downloads/ReconInfo.RData")

  ## cleared reaction data

  Recon2D <- recon2_sbml$reaction_data
  Recon2_2D <- recon2_2_sbml$reaction_data

  save(Recon2D, file = "./downloads/Recon2D.RData")
  save(Recon2_2D, file = "./downloads/Recon2_2D.RData")

# END -----

  insert_tail()
