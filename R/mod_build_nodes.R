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
    uiOutput(ns("node_prompt")),
    textInput(inputId = ns("new_node"), label = "Node"),
    actionButton(inputId = ns("add_node"), label = "Add Node"),
    uiOutput(ns("node_from")),
    uiOutput(ns("node_to")),
    tableOutput(ns("edge_table"))
  )
}

#' build_nodes Server Functions
#'
#' @noRd 
mod_build_nodes_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    r$nodes <- NULL 
    r$graph_tbl <- tibble::tibble()
    output$node_prompt <- renderUI({
      if (length(r$nodes) < 2) p("Add more nodes.")
    })
    observeEvent(input$add_node,
                 r$nodes <- unique(c(r$nodes, input$new_node)))
    output$nodes <- renderPrint(r$nodes)
    
    output$node_from <- renderUI({
      req(length(r$nodes) > 1)
      selectInput(inputId = ns("from"), label = "From", 
                  choices = r$nodes)
    })
    
    output$node_to <- renderUI({
      req(input$from)
      to_choices <- r$nodes[-which(r$nodes == input$from)]
      list(
        selectInput(inputId = ns("to"), label = "To", 
                    choices = to_choices),
        textInput(ns("link_name"), label = "Describe Link"),
        actionButton(inputId = ns("add_edge"), label = "Make Connection")
      )
    })
    
    iv <- shinyvalidate::InputValidator$new()
    iv$add_rule("name", shinyvalidate::sv_required())
    iv$add_rule("email", shinyvalidate::sv_required())
    iv$add_rule("email", shinyvalidate::sv_email())
    iv$enable()
    
    observeEvent(input$add_edge,{
      req(iv$is_valid)
      new_connection <- tibble::tibble(from = input$from,
                                       to = input$to,
                                       label = input$link_name)
      r$graph_tbl <- dplyr::bind_rows(r$graph_tbl, new_connection)
      output$graph_tbl <- renderTable(r$graph_tbl)
    })
    
    
  })
  
}

## To be copied in the UI
# mod_build_nodes_ui("build_nodes_ui_1")

## To be copied in the server
# mod_build_nodes_server("build_nodes_ui_1", r = r)
