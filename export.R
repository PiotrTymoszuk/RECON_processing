# Export of data frames with gene - reaction association rules.
#
# The data frames are saved as .RData files and subsequently used by
# the biggrExtra package (https://github.com/PiotrTymoszuk/biggrExtra).

  library(tidyverse)

  library(soucer)

  insert_head()

  c("./tools/globals.R",
    "./tools/functions.R") %>%
    source_all(message = TRUE, crash = TRUE)

# export scripts -------

  insert_msg("Export scripts")

  c("./export scripts/data_save.R") %>%
    source_all(message = TRUE, crash = TRUE)

# END ------

  insert_tail()
