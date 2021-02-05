#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



# TH Fright night
prizes <- data.frame(relic = numeric(15), bunnies = numeric(15))
prizes$relic <- c(60, 120, 150, 120, 60, 170, 250, 250, 170, 340, 530, 340, 560, 560, 1000)
prizes$bunnies <- c(0, 15, 30, 15, 0,10, 65 ,65, 10, 85, 130, 85, 160, 160, 320)
prizes$id <- seq(1,15)


# STS: Treatsylvania
price_per_sweet <- 400
price_per_royal <- 10
max_sweets <- 42
max_royal <- 18

# # STS: Treatsylvania
# price_per_sweet <- 300
# price_per_royal <- 7
# max_sweets <- 58
# max_royal <- 24

library(shiny)
library(shinyTree)


# Define UI for application that draws a histogram
ui <- fluidPage(
    tags$head(includeHTML(("google-analytics.html"))),
    
    # Application title
    img(src='Yani.png',height=50, align ="right"),
    titlePanel("The Sims Mobile: Event Calculator"),
    helpText("This is an interactive app to check your progress in the The Sims Mobile's events. "),
    
    
    tabsetPanel(
        #
        # Another tab: 
        tabPanel("Sweet Treat Showdown: Charming Gardens", fluid = TRUE, 
                 helpText("During this Sweet Treat Showdown event you need to collect 16800 sweet treats (42 boxes) and 180 royal cookies (18 boxes) over 11 days. 
                  Therefore you need to collect on average  1527.27 sweet treats a day and 16.36 royal cookies a day to get the grand prize.
                  Fill out the information in the grey box to compute the daily average number of tokens based on your progress in the event.  
                  "),
                 sidebarLayout(
                     # Show a plot of the generated distribution
                     
                     sidebarPanel(
                         helpText("Enter how much time is left for you to get the tokens:"),
                         fluidRow(column(5, numericInput(inputId="day_left_sts", 
                                                         label= "Days left:", 
                                                         value=11,min=0,max = 11,step=1,width = "70px")) ,
                                  column(5, offset=1, numericInput(inputId="hour_left_sts", 
                                                                   label= "Hours left:", 
                                                                   value=0, 
                                                                   min=0,
                                                                   max=23,
                                                                   step=1,
                                                                   width = "70px") )), 
                         br(),
                         helpText("Select the number of boxes you have left to open:"),
                         fluidRow(column(5, numericInput(inputId="sweet_boxes", 
                                                         label= "Sweet Boxes:", 
                                                         value=max_sweets, 
                                                         min=0,
                                                         max = max_sweets,
                                                         step=1,
                                                         width = "70px")) ,
                                  column(5, offset=1, numericInput(inputId="royal_boxes", 
                                                                   label= "Royal Boxes:", 
                                                                   value=max_royal, 
                                                                   min=0,
                                                                   max=max_royal,
                                                                   step=1,
                                                                   width = "70px") )),
                         br(),
                         
                         helpText("Enter how many sweet treats and royal cookies you currently have:"),
                         fluidRow(column(5,
                                         numericInput(inputId = "sweet_treats", 
                                                      label = "Sweet Treats:", 
                                                      value = 0,
                                                      min = 0,
                                                      max = max_sweets*price_per_sweet,
                                                      width = "70px") ),
                                  
                                  column(5, offset=1, numericInput(inputId="royal_cookies", 
                                                                   label= "Royal Cookies:", 
                                                                   value=0, 
                                                                   min=0,
                                                                   max=max_royal*price_per_royal,
                                                                   width = "70px")))#,
                         
                     ), 
                     
                     mainPanel(
                         helpText("The numbers below will change according to your entered information."),
                         br(),
                         textOutput("tokens_needed_sts"),
                         br(),
                         textOutput("rate_sts"),
                         #helpText("At the beginning of the event the average rates you needed to collect the tokens were 1418.18 sweet treats a day and 19.09 royal cookies a day. 
                         #        If your average rates above are lower than 1418.18 sweet treats a day and 19.09 royal cookies a day, then you are on a good track to finish the event. 
                         #        If your average rates above are higher than these numbers, then you probably need to focus on collecting these tokens."),
                         br(),
                         helpText("Here is more information about the event:"),
                         #helpText("Below you can see the pictures of the prizes as well as the pyramid structure of the event."),
                         img(src='STS_Charming_Crafts.jpg', height=600), 
                         br(),
                         tagList("Infographic Source:", a("simmerdownMAL's Twitter", href="https://twitter.com/simmerdownMAL/"),"."),
                         br(), 
                         #helpText("This app was created by Yani. If you have any questions or comments, you can contact me on Twitter: "),
                         tagList("This app was created by Yani. If you have any questions or comments, you can find me on ", a("Twitter", href="https://twitter.com/yani_tsm"),", ", a("Reddit", href="https://www.reddit.com/r/SimsMobile/"), "or most of the Sims Mobile Discord servers. Any feedback is appreciated.")
                     )
                 )
        )
        ,
        #
        #New Panel: 
        tabPanel("Treasure Hunt: Royal Romance", fluid = TRUE , 
                 helpText("During this Treasure Hunt event you need to collect 4680 relics and 1150 bunnies over 11 days. 
                  Therefore you need to collect on average 425.45 relics a day and 104.55 bunnies a day to get the grand prize.
                  Fill out the information in the grey box to compute the daily average number of tokens.  
                  "),
                 
                 # Sidebar with a slider input for number of bins 
                 sidebarLayout(
                     # Show a plot of the generated distribution
                     
                     sidebarPanel(
                         helpText("Select the prizes you own/unlocked:"),
                         checkboxInput("code1", "Row 1: Captain Rodrigo de Pablo Dining Chair"), 
                         checkboxInput("code2", "Row 1: Victorian Over-Indulgence Curtains"), 
                         checkboxInput("code3","Row 1: Large Decorative Urn"),
                         checkboxInput("code4","Row 1: Party to the Max"),
                         checkboxInput("code5","Row 1: Regal Reflections Mirror"), 
                         checkboxInput("code6","Row 2: Punchinello Theater Chandelier"), 
                         checkboxInput("code7","Row 2: Gilded Floor Shelf"), 
                         checkboxInput("code8","Row 2: Undersea Traditional Dining Table"),
                         checkboxInput("code9","Row 2: Gilded Floor Shelf"), 
                         checkboxInput("code10","Row 3: Ornate Ventana di Longing"), 
                         checkboxInput("code11","Row 3: Absolutely Marble-ous Estate Gate"), 
                         checkboxInput("code12","Row 3: Oracular Ornate Fence"),
                         checkboxInput("code13","Row 4: Brushed Over Fringe"), 
                         checkboxInput("code14","Row 4: Giotto Queen Bed"),
                         
                         #checkboxInput("code15","Grand Prize"),
                         br(),
                         helpText("Enter how much time is left for you to get the tokens:"),
                         fluidRow(column(5, numericInput(inputId="day_left", 
                                                         label= "Days left:", 
                                                         value=11, 
                                                         min=0,
                                                         max = 11,
                                                         step=1,
                                                         width = "70px")) ,
                                  column(5, offset=1, numericInput(inputId="hour_left", 
                                                                   label= "Hours left:", 
                                                                   value=0, 
                                                                   min=0,
                                                                   max=23,
                                                                   step=1,
                                                                   width = "70px") )), 
                         br(),
                         helpText("Enter how many relics and bunnies you currently have:"),
                         fluidRow(column(5,
                                         numericInput(inputId = "relics", 
                                                      label = "Relics:", 
                                                      value = 0,
                                                      min = 0,
                                                      max = 4680,
                                                      width = "70px") ),
                                  
                                  column(5, offset=1, numericInput(inputId="bunnies", 
                                                                   label= "Bunnies:", 
                                                                   value=0, 
                                                                   min=0,
                                                                   max=1150,
                                                                   width = "70px")))#,
                         #helpText("Note: the maximum value for relics and bunnies is 4680 and 1150 respectively.")
                         
                         
                     ), 
                     
                     mainPanel(
                         helpText("The numbers below will change according to your entered information."),
                         br(),
                         textOutput("tokens_needed"),
                         br(),
                         textOutput("rate"),
                         br(),
                         helpText("Below you can see the pictures of the prizes as well as the pyramid structure of the event."),
                         img(src='TH_-_Royal_Romance.jpg', height=600), 
                         br(),
                         tagList("Infographic Source:", a("simmerdownMAL's Twitter", href="https://twitter.com/simmerdownMAL"),"."),
                         br(), 
                         #helpText("This app was created by Yani. If you have any questions or comments, you can contact me on Twitter: "),
                         tagList("This app was created by Yani. If you have any questions or comments, you can find me on ", a("Twitter", href="https://twitter.com/yani_tsm"),", ", a("Reddit", href="https://www.reddit.com/r/SimsMobile/"), "or most of the Sims Mobile Discord servers. Any feedback is appreciated.")
                     )
                 )
        ) 
        
        
        
        )
    )



# Define server logic:
server <- function(input, output) {
    
    output$check <- renderText({ 
        "You have selected this"
    })
    
    output$tokens_needed_sts <- renderText({
        total_relics <- input$sweet_boxes*price_per_sweet - input$sweet_treats
        total_bunnies <- input$royal_boxes*price_per_royal - input$royal_cookies
        total_relics <- ifelse( total_relics < 0, "ERROR",  total_relics)
        total_bunnies  <- ifelse( total_bunnies < 0, "ERROR",  total_bunnies )
        paste("You still need to collect ", total_relics, " sweet treats and ", total_bunnies , " royal cookies.")
    })
    
    output$rate_sts <- renderText({
        
        time_left <- input$day_left_sts + input$hour_left_sts/24
        
        relics_a_day <- round((input$sweet_boxes*price_per_sweet - input$sweet_treats)/ time_left, 2)
        bunnies_a_day <- round((input$royal_boxes*price_per_royal - input$royal_cookies)/ time_left, 2)
        
        relics_a_day <- ifelse(relics_a_day < 0, "ERROR", relics_a_day)
        bunnies_a_day   <- ifelse(bunnies_a_day < 0, "ERROR", bunnies_a_day)
        paste("To get the Grand prize you need to collect on average ", relics_a_day, " sweet treats a day and ", bunnies_a_day, " royal cookies a day." )
    })
    
    
    output$tokens_needed <- renderText({
        codes <- !(c(input$code1,input$code2, input$code3, input$code4, input$code5, 
                     input$code6,input$code7, input$code8, input$code9, input$code10, 
                     input$code11,input$code12, input$code13, input$code14, FALSE))
        total_relics <- sum(codes*prizes$relic) - input$relics
        total_bunnies <- sum(codes*prizes$bunnies) - input$bunnies
        total_relics <- ifelse( total_relics < 0, "ERROR",  total_relics)
        total_bunnies  <- ifelse( total_bunnies < 0, "ERROR",  total_bunnies )
        paste("You still need to collect ", total_relics, " relics and ", total_bunnies , " bunnies.")
    })
    
    output$rate <- renderText({
        codes <- !(c(input$code1,input$code2, input$code3, input$code4, input$code5, 
                     input$code6,input$code7, input$code8, input$code9, input$code10, 
                     input$code11,input$code12, input$code13, input$code14, FALSE))
        
        time_left <- input$day_left + input$hour_left/24
        
        relics_a_day <- round((sum(codes * prizes$relic)- input$relics)/ time_left, 2)
        bunnies_a_day <- round((sum(codes * prizes$bunnies)- input$bunnies)/ time_left, 2)
        
        relics_a_day <- ifelse(relics_a_day < 0, "ERROR", relics_a_day)
        bunnies_a_day   <- ifelse(bunnies_a_day < 0, "ERROR", bunnies_a_day)
        paste("To get the Grand prize you need to collect on average ", relics_a_day, " relics a day and ", bunnies_a_day, " bunnies a day." )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
