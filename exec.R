# The script launches the whole import, wrangling, and export
# pipeline

  library(soucer)

  print( source_all(c("import.R", "export.R"),
                    message = TRUE,
                    crash = TRUE))
