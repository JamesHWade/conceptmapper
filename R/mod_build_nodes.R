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
    h3("1. Add nodes"),
    textInput(inputId = ns("new_node"), label = "Node"),
    actionButton(inputId = ns("add_node"), label = "Add Node"),
    uiOutput(ns("node_prompt")),
    uiOutput(ns("node_from")),
    uiOutput(ns("connect_nodes")),
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
      if (length(r$nodes) == 1) h3("Add another node.")
    })
    
    # add notes to r$notes and only keep unique ones, then sort them
    observeEvent(input$add_node, 
                 r$nodes <- sort(unique(c(r$nodes, input$new_node))))
    
    output$connect_nodes <- renderUI({
      req(length(r$nodes) > 1)
      list(
        hr(),
        h3("2. Link nodes"),
        selectInput(inputId = ns("from"), label = "From",
                    choices = r$nodes), 
        selectInput(inputId = ns("to"), label = "To", 
                    choices = r$nodes,
                    selected = r$nodes[2]),
        textInput(ns("link_name"), label = "Describe Link"),
        textInput(ns("link_group"), label = "Describe Group (Optional)"),
        actionButton(inputId = ns("add_edge"), label = "Link")
      )
    })
    
    iv <- shinyvalidate::InputValidator$new()
    iv$add_rule("name", shinyvalidate::sv_required())
    iv$add_rule("email", shinyvalidate::sv_required())
    iv$add_rule("email", shinyvalidate::sv_email())
    iv$enable()
    
    observeEvent(input$add_edge,{
      req(iv$is_valid)
      group <- ifelse(is.null(input$link_group), "", input$link_group)
      new_connection <- tibble::tibble(from = input$from,
                                       to = input$to,
                                       label = input$link_name,
                                       group = group)
      r$graph_tbl <- dplyr::bind_rows(r$graph_tbl, new_connection)
    })
    
    
  })
  
}

## To be copied in the UI
# mod_build_nodes_ui("build_nodes_ui_1")

## To be copied in the server
# mod_build_nodes_server("build_nodes_ui_1", r = r)
