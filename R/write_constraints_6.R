##  This code writes the list of constraints (6) of the ILP problem for all the
## conditions.
##
## Enio Gjerga, 2020

write_constraints_6 <- function(variables=variables,
                                dataMatrix=dataMatrix,
                                inputs = inputs,
                                pknList = pknList) {

  ## ##library(igraph)
  ## ## requireNamespace("igraph")
  ## constraints6 <- c()
  ## 
  ## for(ii in seq_len(length(variables))){
  ## 
  ##   source <- unique(variables[[ii]]$reactionSource)
  ##   target <- unique(variables[[ii]]$reactionTarget)
  ## 
  ##   gg <- igraph::graph_from_data_frame(d = pknList[, c(3, 1)])
  ##   adj <- igraph::get.adjacency(gg)
  ##   adj <- as.matrix(adj)
  ## 
  ##   idx1 <- which(rowSums(adj)==0)
  ##   idx2 <- setdiff(seq_len(nrow(adj)), idx1)
  ## 
  ##   if(length(idx1)>0){
  ## 
  ##     constraints6 <-
  ##       c(constraints6,
  ##         paste0(variables[[ii]]$variables[which(
  ##           variables[[ii]]$exp%in%paste0(
  ##             "SpeciesUP ",
  ##             rownames(adj)[idx1],
  ##             " in experiment ", ii))], " <= 0"))
  ## 
  ##   }
  ## 
  ##   for(i in seq_len(length(idx2))){
  ## 
  ##     cc <- paste0(
  ##       variables[[ii]]$variables[which(
  ##         variables[[ii]]$exp==paste0(
  ##           "SpeciesUP ",
  ##           rownames(adj)[idx2[i]],
  ##           " in experiment ", ii))],
  ##                  paste(
  ##                    paste0(
  ##                      " - ",
  ##                      variables[[ii]]$variables[which(
  ##                        variables[[ii]]$exp%in%paste0(
  ##                          "ReactionUp ",
  ##                          colnames(adj)[which(adj[idx2[i], ]>0)],
  ##                          "=",
  ##                          rownames(adj)[idx2[i]],
  ##                          " in experiment ", ii))]), collapse = ""), " <= 0")
  ## 
  ##     constraints6 <- c(constraints6, cc)
  ## 
  ##   }
  ## 
  ## }
  
  ##
  ii=1
  source <- unique(variables[[ii]]$reactionSource)
  target <- unique(variables[[ii]]$reactionTarget)
  
  gg <- igraph::graph_from_data_frame(d = pknList[, c(3, 1)])
  adj <- igraph::get.adjacency(gg)
  adj <- as.matrix(adj)
  
  idx1 <- which(rowSums(adj)==0)
  idx2 <- setdiff(seq_len(nrow(adj)), idx1)
  
  if(length(idx1)>0){
    
    cc1 <-
      paste0(variables[[ii]]$variables[which(
          variables[[ii]]$exp%in%paste0(
            "SpeciesUP ",
            rownames(adj)[idx1],
            " in experiment ", ii))], " <= 0")
    
  }
  
  cc2 <- rep("", length(idx2))
  for(i in seq_len(length(idx2))){
    
    cc2[i] <- paste0(
      variables[[ii]]$variables[which(
        variables[[ii]]$exp==paste0(
          "SpeciesUP ",
          rownames(adj)[idx2[i]],
          " in experiment ", ii))],
      paste(
        paste0(
          " - ",
          variables[[ii]]$variables[which(
            variables[[ii]]$exp%in%paste0(
              "ReactionUp ",
              colnames(adj)[which(adj[idx2[i], ]>0)],
              "=",
              rownames(adj)[idx2[i]],
              " in experiment ", ii))]), collapse = ""), " <= 0")
    
    ## cc2 <- c(cc2, cc)
    
  }

  return(c(cc1, cc2))
}
