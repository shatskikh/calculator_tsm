#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



duration <- 11
duration_festival <- 50

# TH Fright night
prizes <- data.frame(relic = numeric(15), bunnies = numeric(15))
prizes$relic <- c(50, 120, 200, 120, 50, 150, 250, 250, 150, 360, 380, 360, 520, 520, 750)
prizes$bunnies <- c(0, 15, 30, 15, 0,35, 70 ,70, 35, 75, 150, 75, 140, 140, 300)
prizes$id <- seq(1,15)


# STS: Treatsylvania
#price_per_sweet <- 400
#price_per_royal <- 10
#max_sweets <- 42
#max_royal <- 18

# # STS: Treatsylvania
 price_per_sweet <- 300
 price_per_royal <- 7
 max_sweets <- 45
 max_royal <- 24
 
 
# Season Festival 
tier <- seq(1,60)
pink_tickets <- c(0,200,240,270,300,330,360,390,420,450,480,500,510,520,530,540,560,570,580,590,610,620,630,640,660,670,680,700,710,730,740,750,770,780,800,810,830, 840,860,870,890,900,920,930,940,950, 950,960, 970,970,970,980,980,980,990,990,990, 1000,1000,1000)

seasontasks<-c(3650, 0, 0,
               2000, 0, 0,
               1750, 0, 0,
               2000, 0, 0,
               1750, 0, 0,
               2000, 0, 0,
               1750, 0, 0,
               2000, 0, 0,
               1750, 0, 0,
               2000, 0, 0,
               1750, 0, 0,
               2000, 0, 0,
               1750, 0, 0,
               2000, 0, 0,
               1750, 0, 0,
               2000, 0, 0,
               0 , 0)
day <- c(49:0)[seasontasks != 0]

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
       
        #New Panel: 
        tabPanel("Treasure Hunt: Beatnik ", fluid = TRUE , 
                 helpText("During this Treasure Hunt event you need to collect 4230 relics and 1150 bunnies over 11 days. 
                  Therefore you need to collect on average  384.55 relics a day and 104.55  bunnies a day to get the grand prize.
                  Fill out the information in the grey box to compute the daily average number of tokens.  
                  "),
                 
                 # Sidebar with a slider input for number of bins 
                 sidebarLayout(
                     # Show a plot of the generated distribution
                     
                     sidebarPanel(
                         helpText("Select the prizes you own/unlocked:"),
                         checkboxInput("code1", "Row 1: Menorah of Memories"), 
                         checkboxInput("code2", "Row 1: Cropped to Go Pants"), 
                         checkboxInput("code3","Row 1: Too Hot to Handle Camisole"),
                         checkboxInput("code4","Row 1: True Auteur's Chair"),
                         checkboxInput("code5","Row 1: Hanging Out Plant Pot"), 
                         checkboxInput("code6","Row 2: Bass Drop Rug"), 
                         checkboxInput("code7","Row 2: Long Cat Knee High Tights"), 
                         checkboxInput("code8","Row 2: Yes Henny! Henley PJ Top"),
                         checkboxInput("code9","Row 2: Totally Triangles Window"), 
                         checkboxInput("code10","Row 3: Tufted Tucker-me-not Bed"), 
                         checkboxInput("code11","Row 3: Sweatproof Summer Hawk Hair"), 
                         checkboxInput("code12","Row 3: Abstract Comfort Couch"),
                         checkboxInput("code13","Row 4: Sumptuous Spring Gown"), 
                         checkboxInput("code14","Row 4: Too Pretty to be Dirty Shower"),
                         
                         #checkboxInput("code15","Grand Prize"),
                         br(),
                         helpText("Enter how much time is left for you to get the tokens:"),
                         fluidRow(column(5, numericInput(inputId="day_left_th", 
                                                         label= "Days left:", 
                                                         value=duration, 
                                                         min=0,
                                                         max = duration,
                                                         step=1,
                                                         width = "70px")) ,
                                  column(5, offset=1, numericInput(inputId="hour_left_th", 
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
                         textOutput("time_passed_th"),
                         br(),
                         textOutput("tokens_needed"),
                         br(),
                         textOutput("rate"),
                         br(),
                         textOutput("walkie_talkies_count"),
                         br(),
                         helpText("Below you can see the pictures of the prizes as well as the pyramid structure of the event."),
                         img(src='TH_Beatnik.png', width=400), 
                         br(),
                         #tagList("Infographic Source:", a("SimmerdownMal's Twitter", href="https://twitter.com/simmerdownMAL/"),"."),
                         tagList("Inforgraphic Source:", a("Salixcat's website", href="https://www.salixcat.com"),"."),
                         br(),
                         helpText("Resources table for Treasure Hunt to help you to plan ahead:"),
                         img(src='TH_-_table.png',  width=400), 
                         br(),
                         tagList("Source:", a("simmerdownMAL's Twitter", href="https://twitter.com/simmerdownMAL"),"."),
                         br(), 
                         #helpText("This app was created by Yani. If you have any questions or comments, you can contact me on Twitter: "),
                         tagList("This app was created by Yani. If you have any questions or comments, you can find me on ", a("Twitter", href="https://twitter.com/yani_tsm"),", ", a("Reddit", href="https://www.reddit.com/r/SimsMobile/"), "or most of the Sims Mobile Discord servers. Any feedback is appreciated.")
                     )
                 )
        )  # end of tabPanel
        
        
        
        , 
        
        # Another tab: 
        tabPanel("Sweet Treat Showdown: Catwalk Fabulous (Rerun)", fluid = TRUE, 
                 helpText("During this Sweet Treat Showdown event you need to collect 13500 sweet treats (45 boxes) and 168 royal cookies (24 boxes) over 11 days. 
                  Therefore you need to collect on average  1227.27 sweet treats a day and 15.27  royal cookies a day to get the grand prize.
                  Fill out the information in the grey box to compute the daily average number of tokens based on your progress in the event.  
                  "),
                 sidebarLayout(
                     # Show a plot of the generated distribution
                     
                     sidebarPanel(
                         helpText("Enter how much time is left for you to get the tokens:"),
                         fluidRow(column(5, numericInput(inputId="day_left_sts", 
                                                         label= "Days left:", 
                                                         value= duration, min=0,max = duration, step=1,width = "70px")) ,
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
                         textOutput("time_passed_sts"),
                         br(),
                         textOutput("tokens_needed_sts"),
                         br(),
                         textOutput("rate_sts"),
                         br(),
                         textOutput("challenges_count"),
                         #helpText("At the beginning of the event the average rates you needed to collect the tokens were 1418.18 sweet treats a day and 19.09 royal cookies a day. 
                         #        If your average rates above are lower than 1418.18 sweet treats a day and 19.09 royal cookies a day, then you are on a good track to finish the event. 
                         #        If your average rates above are higher than these numbers, then you probably need to focus on collecting these tokens."),
                         br(),
                         helpText("Here is more information about the event:"),
                         #helpText("Below you can see the pictures of the prizes as well as the pyramid structure of the event."),
                         img(src='STS_CatwalkFabulous.png', height=600), 
                         br(),
                         #tagList("Infographic Source:", a("SimmerdownMal's Twitter", href="https://twitter.com/simmerdownMAL/"),"."),
                         tagList("Infographic Source:", a("Salixcat's website", href="https://www.salixcat.com"),"."),
                         br(), 
                         #helpText("This app was created by Yani. If you have any questions or comments, you can contact me on Twitter: "),
                         tagList("This app was created by Yani. If you have any questions or comments, you can find me on ", a("Twitter", href="https://twitter.com/yani_tsm"),", ", a("Reddit", href="https://www.reddit.com/r/SimsMobile/"), "or most of the Sims Mobile Discord servers. Any feedback is appreciated.")
                     )
                 )
        )# end of tabPanel
        ,
        
        
        # #New Panel: 
         tabPanel("Season Festival", fluid = TRUE , 
                 helpText("To unlock all tiers a player needs to collect 42300 prize tickets. Therefore you need to collect on average  846 prize tickets a day to unlock all tiers in timely manner.
                 Below you can check your progress in the festival and plan out how many tickets a day you still need to collect.
                  "),

                 # Sidebar with a slider input for number of bins
                 sidebarLayout(
                     # Show a plot of the generated distribution

                     sidebarPanel(
                         helpText("Select the tier you are currently working towards and how many tickets you collected for this tier:"),


                     fluidRow(column(5,  numericInput(inputId="current_tier",
                                                               label= "Current Tier:",
                                                               value=1,
                                                               min=0,
                                                               max = 60,
                                                               step=1,
                                                               width = "70px")),
                              column(5,offset=1, numericInput(inputId = "current_prizeticket",
                                                  label = "Prize Tickets:",
                                                  value = 0,
                                                  min = 0,
                                                  max = 1000,
                                                  width = "70px") )),

                         #checkboxInput("code15","Grand Prize"),
                         br(),
                         helpText("Enter the time when Sim Festival ends in"),
                         fluidRow(column(5, numericInput(inputId="day_left_f",
                                                         label= "Days left:",
                                                         value= duration_festival,
                                                         min=0,
                                                         max = duration_festival,
                                                         step=1,
                                                         width = "70px")) ,
                                  column(5, offset=1, numericInput(inputId="hour_left_f",
                                                                   label= "Hours left:",
                                                                   value=0,
                                                                   min=0,
                                                                   max=23,
                                                                   step=1,
                                                                   width = "70px") ))


                         #helpText("Note: the maximum value for relics and bunnies is 4680 and 1150 respectively.")


                     ),

                     mainPanel(
                         helpText("The numbers below will change according to your entered information."),
                         br(),
                         textOutput("time_passed_fest"),
                         br(),
                         textOutput("prizetickets_needed"),
                         br(),
                         textOutput("predictions"),
                         br(),
                         #helpText("Remember that you receive 550 prize tickets for completing daily tasks and at least 500 for completing each seasonal task (you get 3 seasonal tasks every 3 days)
                         #         Additional prize tickets can be received by completing the season tasks which are being added every 3 days."),
                         img(src='y2x7trra2zg71.jpg', height=600), 
                         br(),
                         #tagList("Infographic Source:", a("SimmerdownMal's Twitter", href="https://twitter.com/simmerdownMAL/"),"."),
                         tagList("Infographic Source:", a("Salixcat's website", href="https://www.salixcat.com"),"."),
                         br(),
                         tagList("Huge THANKS to ", a("Game Changer SimmerdownMAL", href="https://twitter.com/simmerdownMAL")," for the provided numbers of prize tickets for the tiers."),
                         br(),
                         #helpText("This app was created by Yani. If you have any questions or comments, you can contact me on Twitter: "),
                         tagList("This app was created by Yani. If you have any questions or comments, you can find me on ", a("Twitter", href="https://twitter.com/yani_tsm"),", ", a("Reddit", href="https://www.reddit.com/r/SimsMobile/"), "or most of the Sims Mobile Discord servers. Any feedback is appreciated.")
                     )
                 )
        )  # end of tabPanel

        #

        #

        #
        
        
        
        
        
        
        )
    )



# Define server logic:
server <- function(input, output) {
    
    output$time_passed_sts <- renderText({
        time_left <- input$day_left_sts + input$hour_left_sts/24
        prop_left <- round(time_left/duration *100, 2)
        paste("Proportion of time left: ", prop_left , "%")
        
    })
    
    output$time_passed_th <- renderText({
        time_left <- input$day_left_th + input$hour_left_th/24
        prop_left <- round(time_left/duration *100, 2)
        paste("Proportion of time left: ", prop_left , "%")
        
    })
    
    output$time_passed_fest <- renderText({
        time_left <- input$day_left_f + input$hour_left_f/24
        prop_left <- round(time_left/duration_festival *100, 2)
        paste("Proportion of time left: ", prop_left , "%")
        
    })
    
    output$tokens_needed_sts <- renderText({
        total_relics <- input$sweet_boxes*price_per_sweet - input$sweet_treats
        total_bunnies <- input$royal_boxes*price_per_royal - input$royal_cookies
        total_relics <- ifelse( total_relics < 0, "ERROR",  total_relics)
        total_bunnies  <- ifelse( total_bunnies < 0, "ERROR",  total_bunnies )
        
        perc_relics <- round(total_relics/(max_sweets*price_per_sweet)*100, 2)
        perc_bunnies <- round(total_bunnies/(max_royal*price_per_royal)*100, 2)
        paste("You still need to collect ", total_relics, " sweet treats (",perc_relics,"% of all sweet treats) and ", total_bunnies , " royal cookies ( ",perc_bunnies ,"% of all royal cookies).")
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
        
        perc_relics <- round(total_relics/sum(prizes$relic)*100, 2)
        perc_bunnies <- round(total_bunnies/sum(prizes$bunnies)*100, 2)
        
        #paste("You still need to collect ", total_relics, " relics and ", total_bunnies , " bunnies.")
        paste("You still need to collect ", total_relics, " relics (",perc_relics,"% of all relics) and ", total_bunnies , " bunnies ( ",perc_bunnies ,"% of all bunnies).")
        
    })
    
    output$rate <- renderText({
        codes <- !(c(input$code1,input$code2, input$code3, input$code4, input$code5, 
                     input$code6,input$code7, input$code8, input$code9, input$code10, 
                     input$code11,input$code12, input$code13, input$code14, FALSE))
        
        time_left <- input$day_left_th + input$hour_left_th/24
        
        relics_a_day <- round((sum(codes * prizes$relic)- input$relics)/ time_left, 2)
        bunnies_a_day <- round((sum(codes * prizes$bunnies)- input$bunnies)/ time_left, 2)
        
        relics_a_day <- ifelse(relics_a_day < 0, "ERROR", relics_a_day)
        bunnies_a_day   <- ifelse(bunnies_a_day < 0, "ERROR", bunnies_a_day)
        paste("To get the Grand prize you need to collect on average ", relics_a_day, " relics a day and ", bunnies_a_day, " bunnies a day." )
    })
    

    
    output$prizetickets_needed <- renderText({
        time_left <- input$day_left_f + input$hour_left_f/24
        
        prizetickets_to_collect <- sum(pink_tickets[input$current_tier:60]) - input$current_prizeticket
        prizetickets_a_day <- round(prizetickets_to_collect/ time_left, 2)
        prop_prizetickets <- round((sum(pink_tickets)-prizetickets_to_collect)/sum(pink_tickets) *100,2)
        
        prizetickets_a_day <- ifelse(prizetickets_a_day < 0, "ERROR", prizetickets_a_day)
        
        paste("You have collected ", prop_prizetickets, "% of all prize tickets in this season. 
              To unlock all tiers you still need to collect ", prizetickets_to_collect , " prize tickets." )
        
    })
    
    output$predictions <- renderText({
        futuredailytickets <- 550 * input$day_left_f
        futureseason <- sum(seasontasks[(duration_festival - input$day_left_f):duration_festival])
        total <- futuredailytickets + futureseason
        paste("If you do all future assigned daily tasks, you will get ", futuredailytickets, " prize tickets. 
              If you do all future assigned season tasks, you will get ",  futureseason, "prize tickets. Therefore, the total is ", total, "prize tickets." )
    })
    
    output$walkie_talkies_count <- renderText({
        hours_left <- input$day_left_th*24 + input$hour_left_th
        
        number_left <- floor(hours_left/5)
        paste("You should expect additional ", number_left, "Walkie Talkies in the next ", input$day_left_th, "days and ", input$hour_left_th, " hours. Note: you can store up to 5 Walkie Talkies (or 10 Walkie Talkies if you purchase Treasure Hunt Explorer's Kit). You can also pay 30 simcash for additional Walkie Talkies. You will also get up to 10 Walkie Talkies upon buying the Treasure Hunt Explorer's Kit.")
    })
    
    output$challenges_count <- renderText({
        hours_left <- input$day_left_sts*24 + input$hour_left_sts
        
        number_left <- floor(hours_left/8)
        paste("You should expect additional ", number_left, "challenges in the next ", input$day_left_th, "days and ", input$hour_left_th, " hours. Note: you can store up to 3 challenges (or 6 challenges if you purchase Pro Ticket). You can also pay 30 simcash for additional challenge. You will also get up to 6 challenges upon buying the Pro Ticket.")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
