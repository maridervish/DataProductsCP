library(shiny)
library(ggplot2)
library(scales)
#reading data
impex <- read.csv("./top30.csv")
impex$Year<-as.factor(impex$Year)
impex$Month<-as.factor(impex$Month)
levels(impex$Month)<-c("January","February","March","April","May","June","July","August","September","October","November","December")
Sys.setlocale("LC_TIME", "English")
impex$date<-as.Date(impex$date,"%Y-%m-%d")

shinyServer(
        function(input, output) {
                output$newplot<-renderPlot({
                        ggplot(data=impex[impex$TradeFlow==input$napr
                                          & impex$Country==input$str
                                          & impex$Commodity==input$hs,], aes(x=date, y=Value, group=Year, colour=Year)) +
                                xlab("Month")+
                                ylab("Trade value, USD")+
                                geom_line()+
                                geom_point()+
                                scale_x_date(breaks = "1 month", labels=date_format("%B"),limits = as.Date(c('2014-01-01','2014-12-01')))+
                                theme(axis.text.x=element_text(angle = -90, hjust = 0))
                })
                output$about<-renderText({"This application uses the foreign trade statistics data of Russia between Jan2014 - June2015."})
                output$about2<-renderText({"To speed up application, data is limited for TOP-30 Russia's trade partners."})
                output$about3<-renderText({"From panel on the left you need to choose the direction of trade flow, name of country (trade partner) and category of traded goods."}) 
                output$about4<-renderText({"On the tab `Result` you will find plot of Russian trade statistics for the chosen parameters."})
                output$about5<-renderText({"Source of data is the open database of Russian Federal Customs Service"})
        }
)