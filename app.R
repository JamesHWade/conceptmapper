library(shiny)
library(bslib)
library(tidyverse)
library(igraph)

ui <- fluidPage(
    theme = bs_theme(bootswatch = "yeti"),
    titlePanel("Concept Map Creator"),
    sidebarLayout(
        sidebarPanel(
            width = 5,
            textInput(inputId = "new_node", label = "Node"),
            actionButton(inputId = "add_node", label = "Add Node"),
            uiOutput("connect_nodes"),
            uiOutput("edge_relations")
        ),
        mainPanel(
            width = 7,
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
    
    edges <- reactiveValues()
    edges$df <- tibble()
    observeEvent(input$add_vertex,{
        new_vertex <- tibble(from = input$from, to = input$to, relation = "")
        edges$df <- rbind(edges$df, new_vertex) %>% distinct()
    })
    
    observeEvent(
        input$create_relation, {
            output$concept_map <- renderUI({
                list(
                    h2("Concept Map Plotted with {igraph}"),
                    renderPlot(plot(graph_from_data_frame(edges$df), vertex.label.cex = 2)),
                    h2("Edges Table"),
                    renderTable(edges$df)
                )
                # ggraph() +
                #     geom_edge_link() +
                #     geom_node_point()
            })
        })
    
    output$edge_relations <- renderUI({
        if(nrow(edges$df > 0)) {
            connections <- edges$df %>% 
                unite(col = "vertex", from, to, sep = "  ->  ") %>% 
                pull(vertex)
            list(
                h3("Add Edge Relationships"),
                selectInput(inputId = "edge", label = "Select Edge", choices = connections),
                textInput(inputId = "relation", label = "Add Relation"),
                actionButton(inputId = "create_relation", label = "Create Relation")
            )
        }
    })
    
    edges <- reactiveValues()
    edges$df <- tibble()
    observeEvent(input$create_relation,{
        edges$df <- edges$df %>% 
            unite(col = "vertex", from, to, sep = "  ->  ", remove = FALSE) %>% 
            mutate(relation = case_when(vertex == input$edge ~ input$relation,
                                        TRUE ~ relation )) %>% 
            select(-vertex) %>%
            force()
    })
}

shinyApp(ui = ui, server = server)
