library(shiny)
library(bslib)
library(tidyverse)
library(igraph)

ui <- fluidPage(
    theme = bs_theme(bootswatch = "yeti"),
    titlePanel("Concept Map Creator"),
    sidebarLayout(
        sidebarPanel(
            textInput(inputId = "new_node", label = "Node"),
            actionButton(inputId = "add_node", label = "Add Node"),
            uiOutput("connect_nodes")
        ),
        mainPanel(
            uiOutput("concept_map") 
        )
    )
)

server <- function(input, output) {
    nodes <- reactiveValues()
    nodes$df <- tibble()
    
    observeEvent(input$add_node,{
        new_node <- tibble(node = input$new_node)
        nodes$df <- rbind(nodes$df, new_node) %>% distinct()
        print(nodes$df)
    })
    
    output$connect_nodes <- renderUI({
        if (nrow(nodes$df) > 0) {
            from_choices <- nodes$df
            list(
                selectInput(inputId = "from", label = "From", 
                            choices = nodes$df$node),
                selectInput(inputId = "to", label = "To", 
                            choices = nodes$df$node),
                actionButton(inputId = "add_vertex", label = "Connect Nodes")
            )
        }
    })
    
    vertices <- reactiveValues()
    vertices$df <- tibble()
    observeEvent(input$add_vertex,{
        new_vertex <- tibble(from = input$from, to = input$to)
        vertices$df <- rbind(vertices$df, new_vertex) %>% distinct()
    })
    
    
     observeEvent(
        input$add_vertex, {
        output$concept_map <- renderUI({
            list(
                h2("Concept Map Plotted with {igraph}"),
                renderPlot(plot(graph_from_data_frame(vertices$df), vertex.label.cex = 2)),
                h2("Edges Table"),
                renderTable(vertices$df)
            )
        # ggraph() +
        #     geom_edge_link() +
        #     geom_node_point()
    })
    })
}

shinyApp(ui = ui, server = server)
