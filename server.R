library(shiny)
library(datasets)
library(ggplot2)

#Downloading data file
library(XLConnect)
if(!file.exists("store_data.xls")){
  download.file("http://community.tableau.com/servlet/JiveServlet/downloadBody/1236-102-1-1149/Sample%20-%20Superstore%20Sales%20(Excel).xls","ala.xls")
}
storeData <- readWorksheetFromFile("store_data.xls",sheet=1)
storeData$order_year<-format(storeData$Order.Date,format="%Y")
storeData$Count<-1

# Defining server logic
shinyServer(function(input, output) {
  
  #Finding number of observations for analysis
  obs<-reactive({
    if(!input$a2009){storeData<-storeData[which(storeData$order_year!=2009),]}
    if(!input$a2010){storeData<-storeData[which(storeData$order_year!=2010),]}
    if(!input$a2011){storeData<-storeData[which(storeData$order_year!=2011),]}
    if(!input$a2012){storeData<-storeData[which(storeData$order_year!=2012),]}
    s0<-storeData[sample(1:nrow(storeData),(nrow(storeData)*input$sample_size)/100,replace=FALSE),]
    paste(nrow(s0))
  })
  
  output$nobs<-renderText({obs()})
  
  # Generating plots of the analysis
  output$mpgPlot <- renderPlot({
    
    if(!input$a2009){storeData<-storeData[which(storeData$order_year!=2009),]}
    if(!input$a2010){storeData<-storeData[which(storeData$order_year!=2010),]}
    if(!input$a2011){storeData<-storeData[which(storeData$order_year!=2011),]}
    if(!input$a2012){storeData<-storeData[which(storeData$order_year!=2012),]}
    s1<-storeData[sample(1:nrow(storeData),(nrow(storeData)*input$sample_size)/100,replace=FALSE),]
    s1$d<-s1[[input$variable]]
    s1$d2<-s1[[input$variable2]]
    ggplot(s1,aes(x=d,y=Profit,color=d2))+geom_point()+labs(x=input$variable)+scale_color_discrete(name=input$variable2)+theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  
  output$mpgPlot2 <- renderPlot({
    
    if(!input$a2009){storeData<-storeData[which(storeData$order_year!=2009),]}
    if(!input$a2010){storeData<-storeData[which(storeData$order_year!=2010),]}
    if(!input$a2011){storeData<-storeData[which(storeData$order_year!=2011),]}
    if(!input$a2012){storeData<-storeData[which(storeData$order_year!=2012),]}
    s2<-storeData[sample(1:nrow(storeData),(nrow(storeData)*input$sample_size)/100,replace=FALSE),]
    aggdata<-aggregate(list(Profit=s2$Profit),by=list(s2[[input$variable]]),FUN=mean,na.rm=TRUE)
    bp<-barplot(aggdata$Profit,col="darkgreen",names.arg = aggdata$Group.1,xlab=input$variable,las=2)
    barplot(aggdata$Profit,col="darkgreen",names.arg = aggdata$Group.1,xlab=input$variable,las=2)
    text(bp, 0, round(aggdata$Profit, 1),cex=1,pos=3) 
    
  })
  
  output$mpgPlot3 <- renderPlot({
    
    if(!input$a2009){storeData<-storeData[which(storeData$order_year!=2009),]}
    if(!input$a2010){storeData<-storeData[which(storeData$order_year!=2010),]}
    if(!input$a2011){storeData<-storeData[which(storeData$order_year!=2011),]}
    if(!input$a2012){storeData<-storeData[which(storeData$order_year!=2012),]}
    s3<-storeData[sample(1:nrow(storeData),(nrow(storeData)*input$sample_size)/100,replace=FALSE),]
    aggdata2<-aggregate(list(Observations=s3$Count),by=list(s3[[input$variable]]),FUN=sum,na.rm=TRUE)
    bp2<-barplot(aggdata2$Observations,col="lightgrey",names.arg = aggdata2$Group.1,xlab=input$variable,las=2)
    barplot(aggdata2$Observations,col="lightgrey",names.arg = aggdata2$Group.1,xlab=input$variable,las=2)
    text(bp2, 0, round(aggdata2$Observations, 1),cex=1,pos=3)
  })
  
  
  output$mpgPlot4 <- renderPlot({
    
    if(!input$a2009){storeData<-storeData[which(storeData$order_year!=2009),]}
    if(!input$a2010){storeData<-storeData[which(storeData$order_year!=2010),]}
    if(!input$a2011){storeData<-storeData[which(storeData$order_year!=2011),]}
    if(!input$a2012){storeData<-storeData[which(storeData$order_year!=2012),]}
    s1<-storeData[sample(1:nrow(storeData),(nrow(storeData)*input$sample_size)/100,replace=FALSE),]
    s1$d<-s1[[input$variable]]
    s1$d2<-s1[[input$variable2]]
    ggplot(s1,aes(x=d,y=Sales,color=d2))+geom_point()+labs(x=input$variable)+scale_color_discrete(name=input$variable2)+theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  
  output$mpgPlot5 <- renderPlot({
    
    if(!input$a2009){storeData<-storeData[which(storeData$order_year!=2009),]}
    if(!input$a2010){storeData<-storeData[which(storeData$order_year!=2010),]}
    if(!input$a2011){storeData<-storeData[which(storeData$order_year!=2011),]}
    if(!input$a2012){storeData<-storeData[which(storeData$order_year!=2012),]}
    s2<-storeData[sample(1:nrow(storeData),(nrow(storeData)*input$sample_size)/100,replace=FALSE),]
    aggdata<-aggregate(list(Sales=s2$Sales),by=list(s2[[input$variable]]),FUN=mean,na.rm=TRUE)
    bp<-barplot(aggdata$Sales,col="darkgreen",names.arg = aggdata$Group.1,xlab=input$variable,las=2)
    barplot(aggdata$Sales,col="darkgreen",names.arg = aggdata$Group.1,xlab=input$variable,las=2)
    text(bp, 0, round(aggdata$Sales, 1),cex=1,pos=3) 
    
  })
  
  output$mpgPlot6 <- renderPlot({
    
    if(!input$a2009){storeData<-storeData[which(storeData$order_year!=2009),]}
    if(!input$a2010){storeData<-storeData[which(storeData$order_year!=2010),]}
    if(!input$a2011){storeData<-storeData[which(storeData$order_year!=2011),]}
    if(!input$a2012){storeData<-storeData[which(storeData$order_year!=2012),]}
    s3<-storeData[sample(1:nrow(storeData),(nrow(storeData)*input$sample_size)/100,replace=FALSE),]
    aggdata2<-aggregate(list(Observations=s3$Count),by=list(s3[[input$variable]]),FUN=sum,na.rm=TRUE)
    bp2<-barplot(aggdata2$Observations,col="lightgrey",names.arg = aggdata2$Group.1,xlab=input$variable,las=2)
    barplot(aggdata2$Observations,col="lightgrey",names.arg = aggdata2$Group.1,xlab=input$variable,las=2)
    text(bp2, 0, round(aggdata2$Observations, 1),cex=1,pos=3)
  })
  
  output$mpgPlot7 <- renderPlot({
    
    if(!input$a2009){storeData<-storeData[which(storeData$order_year!=2009),]}
    if(!input$a2010){storeData<-storeData[which(storeData$order_year!=2010),]}
    if(!input$a2011){storeData<-storeData[which(storeData$order_year!=2011),]}
    if(!input$a2012){storeData<-storeData[which(storeData$order_year!=2012),]}
    s1<-storeData[sample(1:nrow(storeData),(nrow(storeData)*input$sample_size)/100,replace=FALSE),]
    s1$d<-s1[[input$variable]]
    s1$d2<-s1[[input$variable2]]
    ggplot(s1,aes(x=d,y=Shipping.Cost,color=d2))+geom_point()+labs(x=input$variable)+scale_color_discrete(name=input$variable2)+theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  
  output$mpgPlot8 <- renderPlot({
    
    if(!input$a2009){storeData<-storeData[which(storeData$order_year!=2009),]}
    if(!input$a2010){storeData<-storeData[which(storeData$order_year!=2010),]}
    if(!input$a2011){storeData<-storeData[which(storeData$order_year!=2011),]}
    if(!input$a2012){storeData<-storeData[which(storeData$order_year!=2012),]}
    s2<-storeData[sample(1:nrow(storeData),(nrow(storeData)*input$sample_size)/100,replace=FALSE),]
    aggdata<-aggregate(list(Shipping.Cost=s2$Shipping.Cost),by=list(s2[[input$variable]]),FUN=mean,na.rm=TRUE)
    bp<-barplot(aggdata$Shipping.Cost,col="darkgreen",names.arg = aggdata$Group.1,xlab=input$variable,las=2)
    barplot(aggdata$Shipping.Cost,col="darkgreen",names.arg = aggdata$Group.1,xlab=input$variable,las=2)
    text(bp, 0, round(aggdata$Shipping.Cost, 1),cex=1,pos=3) 
    
  })
  
  output$mpgPlot9 <- renderPlot({
    
    if(!input$a2009){storeData<-storeData[which(storeData$order_year!=2009),]}
    if(!input$a2010){storeData<-storeData[which(storeData$order_year!=2010),]}
    if(!input$a2011){storeData<-storeData[which(storeData$order_year!=2011),]}
    if(!input$a2012){storeData<-storeData[which(storeData$order_year!=2012),]}
    s3<-storeData[sample(1:nrow(storeData),(nrow(storeData)*input$sample_size)/100,replace=FALSE),]
    aggdata2<-aggregate(list(Observations=s3$Count),by=list(s3[[input$variable]]),FUN=sum,na.rm=TRUE)
    bp2<-barplot(aggdata2$Observations,col="lightgrey",names.arg = aggdata2$Group.1,xlab=input$variable,las=2)
    barplot(aggdata2$Observations,col="lightgrey",names.arg = aggdata2$Group.1,xlab=input$variable,las=2)
    text(bp2, 0, round(aggdata2$Observations, 1),cex=1,pos=3)
  })
  
  
})

