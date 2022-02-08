#' Merge Duplicate Concept Map Edges
#'
#' @param data (dataframe) A table created from, to, & label columns
#'
#' @return
#' @export
merge_edges <- function(data) {
  edges_to_merge <- 
    data %>%
    dplyr::group_by(from, label) %>%
    dplyr::summarize(count = dplyr::n(), .groups = "drop") %>%
    dplyr::filter(count > 1) %>% 
    dplyr::left_join(data)
  
  untouched <- dplyr::anti_join(data, edges_to_merge)
  
  new_links1 <- edges_to_merge %>%
    dplyr::mutate(label = stringr::str_c(";;", from, ";;", label)) %>% 
    dplyr::select(-count) %>%
    dplyr::mutate(to = label)
  
  new_links2 <- edges_to_merge %>%
    dplyr::mutate(label = stringr::str_c(";;", from, ";;", label)) %>%
    dplyr::select(-c(from, count)) %>% 
    dplyr::rename(from = label)
  
  new_links <- dplyr::bind_rows(new_links1, new_links2)
  
  dplyr::bind_rows(untouched, new_links) %>% dplyr::distinct()
}


#' Plot visNetwork with Merged Edges
#'
#' @param data (dataframe) A table created from, to, & label columns
#' @param physics (boolean) Determines whether to use physics engine
#'
#' @return
#' @export
plot_cleaned_visnetwork <- function(data, physics = TRUE){
  
  edges <- merge_edges(data) %>%
    dplyr::distinct() %>% 
    dplyr::mutate(arrows = ifelse(to %in% label, NA, "to"))
  
  nodes <- tibble::tibble(id = unique(c(edges$from, edges$to))) %>% 
    dplyr::mutate(label = ifelse(id %in% edges$label, NA, id),
                  shape = ifelse(id %in% edges$label, "text", "ellipse"))
  
  edges <- edges %>% 
    dplyr::mutate(label = stringr::str_remove(label, ";;[:graph:]+;;"))
  
  visNetwork::visNetwork(nodes = nodes, edges = edges, physics = physics) %>% 
    visNetwork::visOptions(collapse = TRUE)
}