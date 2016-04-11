# Function that takes a string and converts it in to "proper case" (i.e.
# the first letter is capitalised, all remaining letters are lower case)
# N.b. for multi-word strings, only the first word will be affected
toproper <- function(x) { 
  first <- touppersubstring(x, 1, 1))
  rest <- tolower(substring(x, 2))
  whole <- paste0(first, rest)
  return(whole)
}
