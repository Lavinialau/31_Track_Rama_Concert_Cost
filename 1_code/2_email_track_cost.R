# print time for log ------------------------------

print("---------------------------------------------------------------------------")
Sys.time()


# setup -------------------------------------

library(tidyverse)
library(rmarkdown)
library(blastula)
library(glue)
library(DBI)
library(odbc)
library(keyring)
library(PostAnalysisPkg)


# path
setwd("C:\\Users\\Public\\Track_Rama_Concert_Cost")


# folder
folder_rmd <- "1_code"



# recipient -----------------------------------

recipients <- report.recipient("Rama concert cost - track updated artist fee")


# handle pandoc error -----------------------------------
# pandoc_path <- Sys.getenv("RSTUDIO_PANDOC")   # find the path for automation

# temp location
# PS: Because I have to run the previous script (not in automation environment) to get the default location of pandoc (would change everytime the Windows is updated)
# PS: When running in automation, the dafault root of R is different so need to tell R where is the pandoc for Rstudio
pandoc_path_temp <- "C:\\Users\\Public\\0_Environment"                                     # update!!
pandoc_path_temp <- read_lines(file.path(pandoc_path_temp, "pandoc_loc_temp.txt"))


# tell Rstudio where is the pandoc during automation
Sys.setenv(RSTUDIO_PANDOC = pandoc_path_temp)


# email -------------------------

# rmarkdown
email <- render_email(file.path(folder_rmd, "1_track_cost.Rmd"))


# send email
email %>%
  smtp_send(
    to = c(recipients$Email[recipients$To_Flag == "Y"]),
    from = "analytics@gatewaycasinos.com",
    subject = glue("Track Concert Cost"),
    credentials = creds_key("universal_cred")
  )


# end ----------------------------------------------------
