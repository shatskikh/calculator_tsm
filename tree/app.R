#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    pageWithSidebar(
        # Application title
        headerPanel("shinyTree with checkbox controls"),
        
        sidebarPanel(
            helpText(HTML("An example of a shinyTree with the <code>checkbox</code> parameter enabled to allow users to more easily make multiple selections in the tree.
                  <hr>Created using <a href = \"http://github.com/trestletech/shinyTree\">shinyTree</a>."))
        ),
        mainPanel(
            # Show a simple table.
            shinyTree("tree", checkbox = TRUE)
        ))
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    log <- c(paste0(Sys.time(), ": Interact with the tree to see the logs here..."))
    
    output$tree <- renderTree({
        list(
            root1 = "123",
            root2 = list(
                SubListA = list(leaf1 = "", leaf2 = "", leaf3=""),
                SubListB = structure(list(leafA = "", leafB = ""), stselected=TRUE)
            )
        )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
