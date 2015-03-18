# set up working directory -----------------------------------------------------
  dir <- "your/directory/here"
  setwd(dir)

# install packages -------------------------------------------------------------
  packages <- grep(".zip",list.files(), value = T)
  install.packages(packages, repos = NULL)



