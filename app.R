#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(ggplot2)



prizes <- data.frame(name = character(15), relic = numeric(15), bunnies = numeric(15))
prizes$name <- c("Floral Wall Sconce", "Twisted Woods Mirror", 
                 "Lunar Phase Painting", "High Backed Dining Chair",
                 "Carved Curio Table", "Wise Wizard's Bookcase", 
                 "Carved Curio Drawers", "Art Nouveau Toilet",
                 "Future Sight Crystal Ball", "Apothacary's Cabinet", 
                 "Midweek Madness Dress", "Alchemist's Display Case",
                 "Pretty As A Peacock Basin", "Carved Curio Wardrobe",
                 "Grand Prize")
prizes$relic <- c(60, 120, 150, 120, 60, 170, 250, 250, 170, 340, 530, 340, 560, 560, 1000)
prizes$bunnies <- c(0, 15, 30, 15, 0,10, 65 ,65, 10, 85, 130, 85, 160, 160, 320)
prizes$id <- seq(1,15)



library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Treasure Hunt: Fright Night"),
    helpText("This is an interactive app to check your progress in the Treasure Hunt event. "),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            helpText("Select the prizes you own/unlocked:"),
            checkboxInput("code1", "Row 1: Floral Wall Sconce (60 relics)"), 
            checkboxInput("code2", "Row 1: Twisted Woods Mirror (120 relics, 15 bunnies)"), 
            checkboxInput("code3","Row 1: Lunar Phase Painting (150 relics, 30 bunnies)"),
            checkboxInput("code4","Row 1: High Backed Dining Chair (120 relics, 15 bunnies)"),
            checkboxInput("code5","Row 1: Carved Curio Table (60 relics)"), 
            checkboxInput("code6","Row 2: Wise Wizard's Bookcase (170 relics, 10 bunnies)"), 
            checkboxInput("code7","Row 2: Carved Curio Drawers (250 relics, 65 bunnies)"), 
            checkboxInput("code8","Row 2: Art Nouveau Toilet (250 relics, 65 bunnies)"),
            checkboxInput("code9","Row 2: Future Sight Crystal Ball (170 relics, 10 bunnies)"), 
            checkboxInput("code10","Row 3: Apothacary's Cabinet (340 relics, 85 bunnies)"), 
            checkboxInput("code11","Row 3: Midweek Madness Dress (530 relics, 130 bunnies)"), 
            checkboxInput("code12","Row 3: Alchemist's Display Case (340 relics, 85 bunnies)"),
            checkboxInput("code13","Row 4: Pretty As A Peacock Basin (560 relics, 160 bunnies)"), 
            checkboxInput("code14","Row 4: Carved Curio Wardrobe (560 relics, 160 bunnies)"),
            checkboxInput("code15","Grand Prize (1000 relics, 320 bunnies)"),
            br(),
            helpText("Enter how much time is left for you to get the tokens:"),
            fluidRow(column(5, numericInput(inputId="day_left", 
                      label= "Days left:", 
                      value=11, 
                      min=0,
                      max = 11,
                      step=1,
                      width = "100px")) ,
                     column(5, offset=1, numericInput(inputId="hour_left", 
                      label= "Hours left:", 
                      value=0, 
                      min=0,
                      max=23,
                      step=1,
                      width = "100px") )), 
            br(),
            helpText("Enter how many relics and bunnies you currently have:"),
            fluidRow(column(5,
            numericInput(inputId="relics", 
                      label= "Relics:", 
                      value=0,
                      min=0,
                      max=4680,
                      width = "100px") ),
            
            column(5, offset=1, numericInput(inputId="bunnies", 
                      label= "Bunnies:", 
                      value=0, 
                      min=0,
                      max=1150,
                      width = "100px"))),
            helpText("Note: the maximum value for relics and bunnies is 4680 and 1150 respectively.")
            
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           #plotOutput("progressPlot"), 
            
           textOutput("tokens_needed"),
           br(),
           textOutput("rate"),
           helpText("At the beginning of the event the average rates you needed to collect the tokens were 425.45 relics a day and 104.55 bunnies a day. 
                    If your average rates above are lower, then you are on a good track to finish the event. 
                    If your average rates above are higher, then you probably need to focus on collecting these tokens."),
           br(),
           img(src='TH_Fright_Night.jpg', height=500)
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$progressPlot <- renderPlot({
        codes <- !(c(input$code1,input$code2, input$code3, input$code4, input$code5, 
                     input$code6,input$code7, input$code8, input$code9, input$code10, 
                     input$code11,input$code12, input$code13, input$code14, input$code15))
        relics_to_collec <- sum(codes*prizes$relic) - input$relics
        bunnies_to_collect <- sum(codes*prizes$bunnies) - input$bunnies
        
 
    })
    output$tokens_needed <- renderText({
        codes <- !(c(input$code1,input$code2, input$code3, input$code4, input$code5, 
                   input$code6,input$code7, input$code8, input$code9, input$code10, 
                   input$code11,input$code12, input$code13, input$code14, input$code15))
        paste("You still need to collect ", sum(codes*prizes$relic) - input$relics, " relics and ", sum(codes*prizes$bunnies) - input$bunnies, " bunnies.")
    })
    
    output$rate <- renderText({
        codes <- !(c(input$code1,input$code2, input$code3, input$code4, input$code5, 
                     input$code6,input$code7, input$code8, input$code9, input$code10, 
                     input$code11,input$code12, input$code13, input$code14, input$code15))
        
        time_left <- input$day_left + input$hour_left/24
        
        relics_a_day <- (sum(codes * prizes$relic)- input$relics)/ time_left 
        bunnies_a_day <- (sum(codes * prizes$bunnies)- input$bunnies)/ time_left
        paste("To get the Grand prize you need to collect on average ", round(relics_a_day, 2), " relics a day and ", round(bunnies_a_day, 2), " bunnies a day." )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
