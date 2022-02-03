#' upload_concept_map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_upload_concept_map_ui <- function(id){
  ns <- NS(id)
  tagList(
    h3("Upload / Download"),
    fileInput(ns("concept_map"), label = "Upload Saved Concept Map",
              accept = "text", multiple = FALSE),
    uiOutput(ns("download_bttn"))
  )
}

#' upload_concept_map Server Functions
#'
#' @noRd 
mod_upload_concept_map_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    observe({
      map <- readr::read_csv(input$concept_map$datapath)
      r$graph_tbl <- map
    })
    
    output$download_bttn <- renderUI({
      req(nrow(r$graph_tbl) >  0)
      downloadButton(ns("download_map"), "Download Concept Map Data")
    })
    
    output$download_map <- downloadHandler(
      filename = function() {
        paste(Sys.Date(), "concept-map.csv", sep = "_")
      },
      content = function(file) {
        tbl_to_download <- r$graph_tbl
        print(tbl_to_download)
        readr::write_csv(x = tbl_to_download, file = file)
      }
    )
  })
}

## To be copied in the UI
# mod_upload_concept_map_ui("upload_concept_map_ui_1")

## To be copied in the server
# mod_upload_concept_map_server("upload_concept_map_ui_1", r  = r)
