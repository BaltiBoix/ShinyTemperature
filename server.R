library(shiny)


shinyServer(function(input, output) {

      # Filtering the data frame in a reactive sentence is only done once every time the user changes
      # station and/or year instead of 3 times (2 plots and the table)
      df <- reactive({
            filter(TData, year == input$year, id == input$station, !is.na(value))
      })
   
      output$dayPlot <- renderPlot({
    
        p<-ggplot()
        p<-p+geom_line(data = filter(df(), element == "TMAX"), 
                       aes(x=date, y=value), color = "red")
        p<-p+geom_line(data = filter(df(), element == "TMIN"), 
                       aes(x=date, y=value), color = "blue")
        p<-p+ylab("Temp °C x 10")
        p<-p + scale_x_date(breaks = date_breaks("month"), labels = date_format("%b-%y"))
        p<-p+ggtitle(paste(input$station, "-", input$year))
        p<-p+theme(axis.title.y=element_text(hjust = 0.5, size = 12), 
                   axis.title.x=element_blank(), 
                   plot.title = element_text(hjust = 0.5, size = 16),
                   axis.text.x = element_text(size=12, angle = 45, hjust = 1)) 
        print(p)
    
      })
      
      output$boxPlot <- renderPlot({
            
            g<-ggplot(df(), aes(x=month, y=value, fill=month))
            g<-g + geom_boxplot()
            g<-g+facet_wrap(~ element, ncol=1)
            g<-g+ylab("Temp °C x 10")
            g<-g+ggtitle(paste(input$station, "-", input$year, "- Boxplot"))
            g<-g+theme(axis.title.y=element_text(hjust = 0.5, size = 12), 
                       axis.title.x=element_blank(), 
                       plot.title = element_text(hjust = 0.5, size = 16),
                       axis.text.x = element_text(size=12, angle = 45, hjust = 1),
                       legend.position="none") 
            print(g)
            
      })

      output$ttable <- renderDataTable({

            # group by TMAX or TMIN and month. Make the mean and sd             
            pru_gby<-group_by(df(), element, month)
            pru<-summarize(pru_gby, mval=round(mean(value),0), sval=round(sd(value),1))
            pru1<-filter(pru, element == input$element)
            pru1<-pru1[,2:4]
            names(pru1)<-c("Month", paste(input$element,"(avg) °C x 10"), paste(input$element,"(sd) °C x 10"))
            pru1
      }, options = list(paging = FALSE, searching = FALSE))
      

})
