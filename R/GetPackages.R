# create a directory to store the pacakges
if (!file.exists("./packages")) {
  dir.create("./packages", showWarnings = F)
}

# set the list of packages required
packageList <- c("packages.go.here")

# create the function to find packages, and all dependances
GetPackages <- function (packageList) {
                avail <- available.packages()
                packages <- tools::package_dependencies(packageList,
                                                        db = avail,
                                                        recursive = T)
                depends <- unlist(packages, use.names = F)
                toGet <- unique(c(packageList, depends))
                return(toGet)
}

# use the function to find packages and their dependencies
toGet <- GetPackages(packageList)


# download all the required packages and there dependencies to the packages folder
print("Downloading packages and dependencies")
ptm <- proc.time()
download.packages(toGet, "./packages")
print("Download complete - time taken:")
proc.time() - ptm


