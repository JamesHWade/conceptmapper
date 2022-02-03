#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  r <- reactiveValues()
  mod_build_nodes_server("build_nodes_ui_1", r = r)
  mod_build_igraph_server("build_links_ui_1", r = r)
  mod_upload_concept_map_server("upload_concept_map_ui_1", r  = r)
}
