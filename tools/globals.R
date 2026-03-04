# Globals for the project

  library(tidyverse)
  library(hgnc)

# RECON model identifiers, links, and paths --------

  recon_models <-
    tibble(

      model_id = c("MODEL1109130000",
                   "MODEL1603150001",
                   "Recon3D_301",
                   "Recon3D"),
      model_name = c("Recon2",
                     "Recon2.2",
                     "Recon3D_301",
                     "Recon3D"),
      local_path = c("./data/MODEL1109130000_url.xml",
                     "./data/MODEL1603150001_url.xml",
                     "./data/Recon3D_301.xml",
                     "./data/Recon3D.xml"),
      url = c("https://www.ebi.ac.uk/biomodels/services/download/get-files/MODEL1109130000/2/MODEL1109130000_url.xml",
              "https://www.biomodels.org/biomodels/services/download/get-files/MODEL1603150001/2/MODEL1603150001_url.xml",
              "https://github.com/VirtualMetabolicHuman/Recon/blob/master/Current_Version/Recon3D_301_Reconstruction/Recon3D_301.xml",
              "http://bigg.ucsd.edu/static/models/Recon3D.xml")

    )

# HGNC identifier conversion --------

  hgnc_dataset <- import_hgnc_dataset()

# END --------
