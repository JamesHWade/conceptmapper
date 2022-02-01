#' build_nodes UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_build_nodes_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' build_nodes Server Functions
#'
#' @noRd 
mod_build_nodes_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_build_nodes_ui("build_nodes_ui_1")
    
## To be copied in the server
# mod_build_nodes_server("build_nodes_ui_1")
