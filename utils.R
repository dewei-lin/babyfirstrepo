#setwd("../BIOS611-A3")
library(rmarkdown)
library(ggplot2)
library(readr)
library(tidyverse)

simplify_strings <- function(s){
  s <- str_to_lower(s);
  s <- str_trim(s);
  s <- str_replace_all(s,"[^a-z]+","_")
  s
}

ensure_directory <- function(directory){
  if(!dir.exists(directory)){
    dir.create(directory);
  }
}

make_logger <- function(filename, sep="\n"){
  if(file.exists(filename)){
    file.remove(filename);
  }
  function(...){
    text <- sprintf(...);
    cat(text, file=filename, sep=sep, append=T);
  }
}
