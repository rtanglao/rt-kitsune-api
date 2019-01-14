library(tidyverse)
args <- commandArgs(TRUE)
file_to_source <- args[1]
print(file_to_source)
source(file_to_source)
print(x)