#' build_links UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_build_igraph_ui <- function(id) {
  ns <- NS(id)
  tagList(
    h3("Concept Map"),
    visNetwork::visNetworkOutput(ns("concept_map")),
    uiOutput(ns("table_heading")),
    DT::dataTableOutput(ns("graph_tbl"))
  )
}

#' build_links Server Functions
#'
#' @noRd
mod_build_igraph_server <- function(id, r, parent) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # create concept map to plot
    output$concept_map <- visNetwork::renderVisNetwork({
      # check that r$graph_tbl has data
      req(nrow(r$graph_tbl) > 0)
      # plot visNetwork
      plot_cleaned_visnetwork(r$graph_tbl)
    })
    
    # create datatable from r$graph_tbl
    output$graph_tbl <- DT::renderDataTable({
      # check that r$graph_tbl has data
      req(nrow(r$graph_tbl) > 0)
      DT::datatable(
        r$graph_tbl,
        options = list(dom = "t",
                       buttons = "csv",
                       ordering = FALSE,
                       pageLength = 20),
        editable = T
      )
    })
    
    output$table_heading <- renderUI({
      req(nrow(r$graph_tbl) > 0)
      list(
        h3("Concept Map Table"),
        p("Note: This table is editable.")
      )
    })
    
    observeEvent(input$graph_tbl_cell_edit, {
      r$graph_tbl <- DT::editData(data = r$graph_tbl,
                                  info = input$graph_tbl_cell_edit)
    })
  })
}


## To be copied in the UI
# mod_build_igraph_ui("build_links_ui_1")

## To be copied in the server
# mod_build_igraph_server("build_links_ui_1", r = r)
