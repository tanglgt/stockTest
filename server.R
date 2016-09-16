# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {

  output$plot <- renderPlot({
#     data <- getSymbols(input$symb, src = "yahoo", 
#       from = input$dates[1],
#       to = input$dates[2],
#       auto.assign = FALSE)
    data<-dataInput2() 
    chartSeries(data, theme = chartTheme("white"), 
      type = "line", log.scale = input$log, TA = NULL)
  })
  dataInput2<-reactive({
    tt<-  dataInput()   
    if(input$adjust)
      tt<-adjust(tt)
    return(tt)
  })
  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
})