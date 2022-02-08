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
    h3("Connect Concepts"),
    selectizeInput(inputId = ns("from"), label = "From",
                   choices = NULL,
                   options = list(create = TRUE,
                                  placeholder = "Add a concept")),
    textInput(ns("link_name"), label = "Describe Link"),
    selectizeInput(inputId = ns("to"), label = "To",
                   choices = NULL,
                   options = list(create = TRUE,
                                  placeholder = "Add a concept")),
    textInput(ns("link_group"), label = "Describe Group (Optional)"),
    actionButton(inputId = ns("add_edge"), label = "Link")
  )
}

#' build_nodes Server Functions
#'
#' @noRd 
mod_build_nodes_server <- function(id, r, parent){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    r$nodes <- NULL 
    r$graph_tbl <- tibble::tibble()
    
    node_inputs <- reactive(
      list(input$from, input$to)
    )
    
    observeEvent(input$from, {
      r$nodes <- sort(unique(c(r$nodes, input$from)))
      updateSelectizeInput(session = parent,
                           inputId = ns("to"),
                           choices = r$nodes,
                           selected = input$to)
    })
    
    observeEvent(input$to, {
      r$nodes <- sort(unique(c(r$nodes, input$to)))
      updateSelectizeInput(session = parent,
                           inputId = ns("from"),
                           choices = r$nodes,
                           selected = input$from)
    })
    
    iv <- shinyvalidate::InputValidator$new()
    iv$add_rule("from", shinyvalidate::sv_required())
    iv$add_rule("to", shinyvalidate::sv_required())
    iv$add_rule("link_name", shinyvalidate::sv_required())
    
    observeEvent(input$add_edge,{
      iv$enable()
      req(iv$is_valid())
      group <- ifelse(is.null(input$link_group), "", input$link_group)
      new_connection <- tibble::tibble(from = input$from,
                                       to = input$to,
                                       label = input$link_name,
                                       group = group)
      r$graph_tbl <- dplyr::bind_rows(r$graph_tbl, new_connection) %>% 
        dplyr::distinct()
    })
    
    
  })
  
}

## To be copied in the UI
# mod_build_nodes_ui("build_nodes_ui_1")

## To be copied in the server
# mod_build_nodes_server("build_nodes_ui_1", r = r, parent = session)
