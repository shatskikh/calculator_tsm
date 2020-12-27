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
        tabPanel("Sweet Treat Showdown: New Year's Gala", fluid = TRUE, 
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
                         img(src='STS_New_Years_Gala.jpg', height=600), 
                         br(),
                         tagList("Infographic Source:", a("simmerdownMAL's Twitter", href="https://twitter.com/simmerdownMAL/"),"."),
                         br(), 
                         #helpText("This app was created by Yani. If you have any questions or comments, you can contact me on Twitter: "),
                         tagList("This app was created by Yani. If you have any questions or comments, you can find me on ", a("Twitter", href="https://twitter.com/yani_tsm"),", ", a("Reddit", href="https://www.reddit.com/r/SimsMobile/"), "or most of the Sims Mobile Discord servers. Any feedback is appreciated.")
                     )
                 )
        ),
                 #
                 #
                 #New Panel: 
        tabPanel("Treasure Hunt: Season's Greetings", fluid = TRUE , 
                          helpText("During this Treasure Hunt event you need to collect 4680 relics and 1150 bunnies over 11 days. 
                  Therefore you need to collect on average 425.45 relics a day and 104.55 bunnies a day to get the grand prize.
                  Fill out the information in the grey box to compute the daily average number of tokens.  
                  "),
                          
                          # Sidebar with a slider input for number of bins 
                          sidebarLayout(
                              # Show a plot of the generated distribution
                              
                              sidebarPanel(
                                  helpText("Select the prizes you own/unlocked:"),
                                  checkboxInput("code1", "Row 1: What A Haul Gift Pile"), 
                                  checkboxInput("code2", "Row 1: Season's Greetings Garland"), 
                                  checkboxInput("code3","Row 1: Come Inside Lamp"),
                                  checkboxInput("code4","Row 1: Very Victorian Rug"),
                                  checkboxInput("code5","Row 1: Wicker Dining Chair"), 
                                  checkboxInput("code6","Row 2: Trulle Timber Cabinet"), 
                                  checkboxInput("code7","Row 2: Elegant Timber Dining Table"), 
                                  checkboxInput("code8","Row 2: Plush Leather Armchair"),
                                  checkboxInput("code9","Row 2: Hanging Girting Stockings"), 
                                  checkboxInput("code10","Row 3: Tree Trunk Coffee Table"), 
                                  checkboxInput("code11","Row 3: Pretty in Plaid Dress"), 
                                  checkboxInput("code12","Row 3: Plush Leather Sofa"),
                                  checkboxInput("code13","Row 4: Arcadian Log Bed"), 
                                  checkboxInput("code14","Row 4: Tied and True Holiday Tree"),
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
                                  img(src='1_TH_Seasons_Greetings.jpg', height=600), 
                                  br(),
                                  tagList("Infographic Source:", a("simmerdownMAL's Twitter", href="https://twitter.com/simmerdownMAL"),"."),
                                  br(), 
                                  #helpText("This app was created by Yani. If you have any questions or comments, you can contact me on Twitter: "),
                                  tagList("This app was created by Yani. If you have any questions or comments, you can find me on ", a("Twitter", href="https://twitter.com/yani_tsm"),", ", a("Reddit", href="https://www.reddit.com/r/SimsMobile/"), "or most of the Sims Mobile Discord servers. Any feedback is appreciated.")
                              )
                          )
                 ) 
                 # tabPanel("Treasure Hunt: Gamer's Paradise", fluid = TRUE , 
                 #          helpText("During this Treasure Hunt event you need to collect 4680 relics and 1150 bunnies over 11 days. 
                 #           Therefore you need to collect on average 425.45 relics a day and 104.55 bunnies a day to get the grand prize.
                 #           Fill out the information in the grey box to compute the daily average number of tokens.  
                 #           "),
                 #          
                 #          # Sidebar with a slider input for number of bins 
                 #          sidebarLayout(
                 #              # Show a plot of the generated distribution
                 #              
                 #              sidebarPanel(
                 #                  helpText("Select the prizes you own/unlocked:"),
                 #                  checkboxInput("code1", "Row 1: Cave Crystal Wall Light"), 
                 #                  checkboxInput("code2", "Row 1: Paint Stroke Rug"), 
                 #                  checkboxInput("code3","Row 1: On The Walls Skateboards"),
                 #                  checkboxInput("code4","Row 1: Cross Shelf"),
                 #                  checkboxInput("code5","Row 1: Angular Wireless Speaker"), 
                 #                  checkboxInput("code6","Row 2: Comfy And Cool Couch"), 
                 #                  checkboxInput("code7","Row 2: Ergonomic Desk Chair"), 
                 #                  checkboxInput("code8","Row 2: Cross Coffee Table"),
                 #                  checkboxInput("code9","Row 2: Football Fanatics Poster"), 
                 #                  checkboxInput("code10","Row 3: Skirting Board LED"), 
                 #                  checkboxInput("code11","Row 3: Comfortably Chill Outfit"), 
                 #                  checkboxInput("code12","Row 3: Scaled Up Dance Floor"),
                 #                  checkboxInput("code13","Row 4: Planetary Projector"), 
                 #                  checkboxInput("code14","Row 4: Asteroid Blaster Arcade Cbinet"),
                 #                  #checkboxInput("code15","Grand Prize"),
                 #                  br(),
                 #                  helpText("Enter how much time is left for you to get the tokens:"),
                 #                  fluidRow(column(5, numericInput(inputId="day_left", 
                 #                                                  label= "Days left:", 
                 #                                                  value=11, 
                 #                                                  min=0,
                 #                                                  max = 11,
                 #                                                  step=1,
                 #                                                  width = "70px")) ,
                 #                           column(5, offset=1, numericInput(inputId="hour_left", 
                 #                                                            label= "Hours left:", 
                 #                                                            value=0, 
                 #                                                            min=0,
                 #                                                            max=23,
                 #                                                            step=1,
                 #                                                            width = "70px") )), 
                 #                  br(),
                 #                  helpText("Enter how many relics and bunnies you currently have:"),
                 #                  fluidRow(column(5,
                 #                                  numericInput(inputId = "relics", 
                 #                                               label = "Relics:", 
                 #                                               value = 0,
                 #                                               min = 0,
                 #                                               max = 4680,
                 #                                               width = "70px") ),
                 #                           
                 #                           column(5, offset=1, numericInput(inputId="bunnies", 
                 #                                                            label= "Bunnies:", 
                 #                                                            value=0, 
                 #                                                            min=0,
                 #                                                            max=1150,
                 #                                                            width = "70px")))#,
                 #                  #helpText("Note: the maximum value for relics and bunnies is 4680 and 1150 respectively.")
                 #                  
                 #                  
                 #              ), 
                 #              
                 #              mainPanel(
                 #                  helpText("The numbers below will change according to your entered information."),
                 #                  br(),
                 #                  textOutput("tokens_needed"),
                 #                  br(),
                 #                  textOutput("rate"),
                 #                  br(),
                 #                  helpText("Below you can see the pictures of the prizes as well as the pyramid structure of the event."),
                 #                  img(src='TH_Gamers_Paradise.jpg', height=600), 
                 #                  br(),
                 #                  tagList("Infographic Source:", a("simmerdownMAL's Twitter post", href="https://twitter.com/simmerdownMAL/status/1330964346726473729?s=20"),"."),
                 #                  br(), 
                 #                  #helpText("This app was created by Yani. If you have any questions or comments, you can contact me on Twitter: "),
                 #                  tagList("This app was created by Yani. If you have any questions or comments, you can find me on ", a("Twitter", href="https://twitter.com/yani_tsm"),", ", a("Reddit", href="https://www.reddit.com/r/SimsMobile/"), "or most of the Sims Mobile Discord servers. Any feedback is appreciated.")
                 #              )
                 #          )
                 # ),
                 #
                 #
                 # New Panel:
                 #
                 #
                 
                 # # New Panel:
                 # #
                 # #
                 # tabPanel("Sweet Treat Showdown: Treatsylvania Haunt Rerun", fluid = TRUE, 
                 #          helpText("During this Sweet Treat Showdown event you need to collect  sweet treats (58 boxes) and 168 royal cookies (24 boxes) over 11 days. 
                 #           Therefore you need to collect on average  1581.82 sweet treats a day and 15.27 royal cookies a day to get the grand prize.
                 #           Fill out the information in the grey box to compute the daily average number of tokens based on your progress in the event.  
                 #           "),
                 #          sidebarLayout(
                 #              # Show a plot of the generated distribution
                 #              
                 #              sidebarPanel(
                 #                  helpText("Enter how much time is left for you to get the tokens:"),
                 #                  fluidRow(column(5, numericInput(inputId="day_left", 
                 #                                                  label= "Days left:", 
                 #                                                  value=11, 
                 #                                                  min=0,
                 #                                                  max = 11,
                 #                                                  step=1,
                 #                                                  width = "70px")) ,
                 #                           column(5, offset=1, numericInput(inputId="hour_left", 
                 #                                                            label= "Hours left:", 
                 #                                                            value=0, 
                 #                                                            min=0,
                 #                                                            max=23,
                 #                                                            step=1,
                 #                                                            width = "70px") )), 
                 #                  br(),
                 #                  helpText("Select the number of boxes you have left to open:"),
                 #                  fluidRow(column(5, numericInput(inputId="sweet_boxes", 
                 #                                                  label= "Sweet Boxes:", 
                 #                                                  value=max_sweets, 
                 #                                                  min=0,
                 #                                                  max = max_sweets,
                 #                                                  step=1,
                 #                                                  width = "70px")) ,
                 #                           column(5, offset=1, numericInput(inputId="royal_boxes", 
                 #                                                            label= "Royal Boxes:", 
                 #                                                            value=max_royal, 
                 #                                                            min=0,
                 #                                                            max=max_royal,
                 #                                                            step=1,
                 #                                                            width = "70px") )),
                 #                  br(),
                 #                  
                 #                  helpText("Enter how many sweet treats and royal cookies you currently have:"),
                 #                  fluidRow(column(5,
                 #                                  numericInput(inputId = "sweet_treats", 
                 #                                               label = "Sweet Treats:", 
                 #                                               value = 0,
                 #                                               min = 0,
                 #                                               max = max_sweets*price_per_sweet,
                 #                                               width = "70px") ),
                 #                           
                 #                           column(5, offset=1, numericInput(inputId="royal_cookies", 
                 #                                                            label= "Royal Cookies:", 
                 #                                                            value=0, 
                 #                                                            min=0,
                 #                                                            max=max_royal*price_per_royal,
                 #                                                            width = "70px")))#,
                 #                  
                 #              ), 
                 #              
                 #              mainPanel(
                 #                  helpText("The numbers below will change according to your entered information."),
                 #                  br(),
                 #                  textOutput("tokens_needed_sts"),
                 #                  br(),
                 #                  textOutput("rate_sts"),
                 #                  #helpText("At the beginning of the event the average rates you needed to collect the tokens were 1418.18 sweet treats a day and 19.09 royal cookies a day. 
                 #                  #        If your average rates above are lower than 1418.18 sweet treats a day and 19.09 royal cookies a day, then you are on a good track to finish the event. 
                 #                  #        If your average rates above are higher than these numbers, then you probably need to focus on collecting these tokens."),
                 #                  br(),
                 #                  helpText("Here is more information about the event:"),
                 #                  #helpText("Below you can see the pictures of the prizes as well as the pyramid structure of the event."),
                 #                  img(src='STS_Treatsylvania_Haunt.jpg', height=600), 
                 #                  br(),
                 #                  tagList("Infographic Source:", a("simmerdownMAL's Reddit post", href="https://www.reddit.com/r/SimsMobile/comments/jhfkye/update_240_coming_soon_treasure_hunt_fright_night/"),"."),
                 #                  br(), 
                 #                  #helpText("This app was created by Yani. If you have any questions or comments, you can contact me on Twitter: "),
                 #                  tagList("This app was created by Yani. If you have any questions or comments, you can find me on ", a("Twitter", href="https://twitter.com/yani_tsm"),", ", a("Reddit", href="https://www.reddit.com/r/SimsMobile/"), "or most of the Sims Mobile Discord servers. Any feedback is appreciated.")
                 #              )
                 #          )
        #
        # # New Panel
        # tabPanel("Treasure Hunt: Fright Night", fluid = TRUE , 
        #          helpText("During this Treasure Hunt event you need to collect 4680 relics and 1150 bunnies over 11 days. 
        #           Therefore you need to collect on average 425.45 relics a day and 104.55 bunnies a day to get the grand prize.
        #           Fill out the information in the grey box to compute the daily average number of tokens.  
        #           "),
        #          
        #          # Sidebar with a slider input for number of bins 
        #          sidebarLayout(
        #              # Show a plot of the generated distribution
        #              
        #              sidebarPanel(
        #                  helpText("Select the prizes you own/unlocked:"),
        #                  # checkboxInput("code1", "Row 1: Floral Wall Sconce (60 relics)"), 
        #                  # checkboxInput("code2", "Row 1: Twisted Woods Mirror (120 relics, 15 bunnies)"), 
        #                  # checkboxInput("code3","Row 1: Lunar Phase Painting (150 relics, 30 bunnies)"),
        #                  # checkboxInput("code4","Row 1: High Backed Dining Chair (120 relics, 15 bunnies)"),
        #                  # checkboxInput("code5","Row 1: Carved Curio Table (60 relics)"), 
        #                  # checkboxInput("code6","Row 2: Wise Wizard's Bookcase (170 relics, 10 bunnies)"), 
        #                  # checkboxInput("code7","Row 2: Carved Curio Drawers (250 relics, 65 bunnies)"), 
        #                  # checkboxInput("code8","Row 2: Art Nouveau Toilet (250 relics, 65 bunnies)"),
        #                  # checkboxInput("code9","Row 2: Future Sight Crystal Ball (170 relics, 10 bunnies)"), 
        #                  # checkboxInput("code10","Row 3: Apothacary's Cabinet (340 relics, 85 bunnies)"), 
        #                  # checkboxInput("code11","Row 3: Midweek Madness Dress (530 relics, 130 bunnies)"), 
        #                  # checkboxInput("code12","Row 3: Alchemist's Display Case (340 relics, 85 bunnies)"),
        #                  # checkboxInput("code13","Row 4: Pretty As A Peacock Basin (560 relics, 160 bunnies)"), 
        #                  # checkboxInput("code14","Row 4: Carved Curio Wardrobe (560 relics, 160 bunnies)"),
        #                  # checkboxInput("code15","Grand Prize (1000 relics, 320 bunnies)"),
        #                  checkboxInput("code1", "Row 1: Floral Wall Sconce"), 
        #                  checkboxInput("code2", "Row 1: Twisted Woods Mirror"), 
        #                  checkboxInput("code3","Row 1: Lunar Phase Painting"),
        #                  checkboxInput("code4","Row 1: High Backed Dining Chair"),
        #                  checkboxInput("code5","Row 1: Carved Curio Table"), 
        #                  checkboxInput("code6","Row 2: Wise Wizard's Bookcase"), 
        #                  checkboxInput("code7","Row 2: Carved Curio Drawers"), 
        #                  checkboxInput("code8","Row 2: Art Nouveau Toilet"),
        #                  checkboxInput("code9","Row 2: Future Sight Crystal Ball"), 
        #                  checkboxInput("code10","Row 3: Apothacary's Cabinet"), 
        #                  checkboxInput("code11","Row 3: Midweek Madness Dress"), 
        #                  checkboxInput("code12","Row 3: Alchemist's Display Case"),
        #                  checkboxInput("code13","Row 4: Pretty As A Peacock Basin"), 
        #                  checkboxInput("code14","Row 4: Carved Curio Wardrobe"),
        #                  #checkboxInput("code15","Grand Prize"),
        #                  br(),
        #                  helpText("Enter how much time is left for you to get the tokens:"),
        #                  fluidRow(column(5, numericInput(inputId="day_left", 
        #                                                  label= "Days left:", 
        #                                                  value=11, 
        #                                                  min=0,
        #                                                  max = 11,
        #                                                  step=1,
        #                                                  width = "70px")) ,
        #                           column(5, offset=1, numericInput(inputId="hour_left", 
        #                                                            label= "Hours left:", 
        #                                                            value=0, 
        #                                                            min=0,
        #                                                            max=23,
        #                                                            step=1,
        #                                                            width = "70px") )), 
        #                  br(),
        #                  helpText("Enter how many relics and bunnies you currently have:"),
        #                  fluidRow(column(5,
        #                                  numericInput(inputId = "relics", 
        #                                               label = "Relics:", 
        #                                               value = 0,
        #                                               min = 0,
        #                                               max = 4680,
        #                                               width = "70px") ),
        #                           
        #                           column(5, offset=1, numericInput(inputId="bunnies", 
        #                                                            label= "Bunnies:", 
        #                                                            value=0, 
        #                                                            min=0,
        #                                                            max=1150,
        #                                                            width = "70px")))#,
        #                  #helpText("Note: the maximum value for relics and bunnies is 4680 and 1150 respectively.")
        #                  
        #                  
        #              ), 
        #              
        #              mainPanel(
        #                  helpText("The numbers below will change according to your entered information."),
        #                  br(),
        #                  textOutput("tokens_needed"),
        #                  br(),
        #                  textOutput("rate"),
        #                  #helpText("At the beginning of the event the average rates you needed to collect the tokens were 425.45 relics a day and 104.55 bunnies a day. 
        #                  #        If your average rates above are lower than 425.45 relics a day and 104.55 bunnies a day, then you are on a good track to finish the event. 
        #                  #        If your average rates above are higher than these numbers, then you probably need to focus on collecting these tokens."),
        #                  br(),
        #                  helpText("Below you can see the pictures of the prizes as well as the pyramid structure of the event."),
        #                  img(src='TH_Fright_Night.jpg', height=600), 
        #                  br(),
        #                  tagList("Infographic Source:", a("simmerdownMAL's Twitter post", href="https://twitter.com/simmerdownMAL/status/1320093413618929664?s=20"),"."),
        #                  br(), 
        #                  #helpText("This app was created by Yani. If you have any questions or comments, you can contact me on Twitter: "),
        #                  tagList("This app was created by Yani. If you have any questions or comments, you can find me on ", a("Twitter", href="https://twitter.com/yani_tsm"),", ", a("Reddit", href="https://www.reddit.com/r/SimsMobile/"), "or most of the Sims Mobile Discord servers. Any feedback is appreciated.")
        #              )
        #          )
        #)
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
