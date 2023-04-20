library(stringr)

count_vowel_clusters <- function(word){
  vowel_clusters <- str_extract_all(word, "[AEIOUYaeiouy][AEIOUYaeiouy]+")
  num_vowel_clusters <- length(vowel_clusters)
  paste0("The word '", word, "' has ", num_vowel_clusters, " vowel clusters: ", vowel_clusters)
}

count_vowel_clusters("eeero")
