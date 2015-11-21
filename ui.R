library(shiny)
options(scipen = 999)
impex <- read.csv("./top30.csv")
country<-as.character(unique(impex$Country))
goods<-as.character(unique(impex$Commodity))

shinyUI(pageWithSidebar(
        headerPanel("Russian foreign trade statistics"),
        sidebarPanel(
                radioButtons("napr", "Choose direction:",
                                   c("Import"="Imports",
                                     "Export"="Exports")),
                selectInput("str", "Choose country:", 
                            choices = country),
                selectInput("hs", "Choose product category:", 
                            choices = goods)
        ),
        mainPanel(
                tabsetPanel(
                        tabPanel("About App", textOutput("about"),
                                                textOutput("about2"),
                                                textOutput("about3"),
                                                textOutput("about4"),
                                                textOutput("about5")),
                        tabPanel("Result", plotOutput("newplot")))
        )
))