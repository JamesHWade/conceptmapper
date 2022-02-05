#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    navbarPage(
      title = "Concept Mapper",
      theme = bslib::bs_theme(version = 5, bootswatch = "cosmo"),
      tabPanel(
        title = "Build Concept Map",
        sidebarLayout(
          sidebarPanel(
            mod_build_nodes_ui("build_nodes_ui_1"),
            hr(),
            mod_upload_concept_map_ui("upload_concept_map_ui_1")
          ),
          mainPanel(
            mod_build_igraph_ui("build_igraph_ui_1")
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'conceptmapper'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

