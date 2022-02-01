#' build_links UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_build_links_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' build_links Server Functions
#'
#' @noRd 
mod_build_links_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_build_links_ui("build_links_ui_1")
    
## To be copied in the server
# mod_build_links_server("build_links_ui_1")
