library(shiny)
library(ggplot2)
library(readxl)
DF <- read_excel("DF.xlsx")

function(input,output){
  output$main_plot <- renderPlot({
    
    aggmean<-aggregate(DF[-c(1,2,3)], by=list(DF$Year,DF$Net_Migration_Rate),FUN=mean)
    aggmeanMR<-aggregate(DF[-c(1,2,3)], by=list(DF$Year,DF$Net_Migration_Rate,DF$Locality),FUN=mean)

    aggmean$var <- switch(input$var,
                          "Average_Taxable_Income" = aggmean$Average_Taxable_Income,
                          "Gini_Index" = aggmean$Gini_Index)
    aggmeanMR$var <- switch(input$var,
                            "Average_Taxable_Income" = aggmeanMR$Average_Taxable_Income,
                            "Gini_Index" = aggmeanMR$Gini_Index)
    
    if(input$checkbox == "TRUE"){
      p<-ggplot(aggmeanMR[aggmeanMR$Group.1<=input$slider,],aes(x=Group.1,y=var,colour=Group.2,shape=Group.3,interaction(Group.2,Group.3)
      ))+geom_point(size=3)+geom_line()+xlim(2005,2030)+ylab(input$var)+xlab("Year")+labs(colour="Net Migration Assumption",shape="Locality")
    } else {
      p<-ggplot(aggmean,aes(x=Group.1,y=var,colour=Group.2))+geom_point(size=3)+geom_line()+xlim(2005,2030)+
        ylab(input$var)+xlab("Year")+labs(colour="Net Migration Assumption")
    }
    p
  })
  
  output$text1 <- renderText({ 
    gsub("_"," ",paste("You have selected", input$var))
  })
}
