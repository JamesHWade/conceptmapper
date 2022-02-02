#' build_links UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_build_igraph_ui <- function(id){
  ns <- NS(id)
  tagList(
    visNetwork::visNetworkOutput(ns("concept_map"))
  )
}

#' build_links Server Functions
#'
#' @noRd 
mod_build_igraph_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$concept_map <- visNetwork::renderVisNetwork({
      req(nrow(r$graph_tbl) > 0)
    map_igraph <- igraph::graph_from_data_frame(r$graph_tbl)
      visNetwork::visIgraph(map_igraph, physics = TRUE)
    })
  })
}

## To be copied in the UI
# mod_build_igraph_ui("build_links_ui_1")

## To be copied in the server
# mod_build_igraph_server("build_links_ui_1", r = r)
