library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Superstore Performance analysis"),
  
  # Inputs
  sidebarPanel(
    selectInput("variable", "Select parameter 1",
                list("Order priority" = "Order.Priority", 
                     "Ship mode" = "Ship.Mode", 
                     "Province" = "Province",
                     "Region" = "Region",
                     "Customer Segment" = "Customer.Segment",
                     "Product Category" = "Product.Category",
                     "Product Container" = "Product.Container")),
    
    selectInput("variable2", "Select parameter 2",
                list("Order priority" = "Order.Priority", 
                     "Ship mode" = "Ship.Mode", 
                     "Province" = "Province",
                     "Region" = "Region",
                     "Customer Segment" = "Customer.Segment",
                     "Product Category" = "Product.Category",
                     "Product Container" = "Product.Container")),
    
    h5('Select order year:'),
    
    checkboxInput("a2009", "2009", TRUE),
    checkboxInput("a2010", "2010", TRUE),
    checkboxInput("a2011", "2011", TRUE),
    checkboxInput("a2012", "2012", TRUE),
    sliderInput("sample_size","Sample size %",min = 0,max = 100,value = 100,step=1),
    h5('Number of observations:'),
    h5(textOutput("nobs"))
  ),
  
  # Outputs
  mainPanel(
    h4('Documentation'),
    h5('Overview'),
    h6('This application is developed to analyse the performance of a superstore. Performance of a superstore is measured in terms of profit. Profit in turn is driven by revenue and cost. Thus it is critical for a superstore to identify drivers of profit and those of revenue and cost. This app assists in identification of potential drivers of profit, revenue and cost in 3 separate tabs.'),
    h6('There are 3 charts on each tab. In the Profitability analysis tab the 1st chart visualises the distribution of profit among different categories of a selected parameter (Parameter 1). Profit distribution can be seen on the vertical axis with the selected parameter in the horizontal axis. For a given value of a selected parameter (parameter 1), the distribution of profit can also be broken down by another parameter (parameter 2) with different colours distinguishing the different values of the 2nd parameter. Using this chart one may get some idea of what is driving (which paramter or combination of parameters) high profitability.'),
    h6('The 2nd chart on the Profitability analysis tab shows the distribution of average profit for each value of the selected parameter. If profit values are quite spread out and the 1st chart fails to distinguish in identifyng how the parameter is impacting profitability on an average, the 2nd chart visualises profit per item (average profit) for each value of the selected parameter (parameter 1). While the 1st graph gives an idea of the variance of profit for different values of the selected parameter, the 2nd graph identifies the average impact by the parameter on profitability.'),
    h6('The 3rd chart shows the number of observations for each value of the selected parameter. While some value of the parameter may appear to significantly impact profitability, if the number of items sold for that value of the parameter may be too low, then that value of the parameter becomes insignificant even if it seems to drive profitability. Thus, if some value of the selected parameter is identified to drive profitability, the 3rd chart is used to check if there are significant number of observations for that value of the selected parameter.'),
    h6('Charts similar to those present on the Profitability analysis tab as explained above are also present on the Revenue analysis and Cost analysis tabs'),
    h5('User Inputs'),
    h6('The user has to first select the performance measure that is required to be analysed. This can be done by clicking on one of the three performance measure tabs (Profitability analysis, Revenue analysis or Cost analysis). Aftter selecting the measure to be analysed, the user has to select 2 parameters (in the sidebar panel) on which the measure will be profiled to identify potential drivers of the performance measure. The user can also select the years for which the performance measure has to be analysed in the sidebar panel. The sample size for the analysis can also be selected from the sidebar panel.'),
    tabsetPanel(
    tabPanel("Profitability analysis",h3('Distribution of Profit'),plotOutput("mpgPlot"),h3('Distribution of average Profit'),plotOutput("mpgPlot2"),h3('Number of observations'),plotOutput("mpgPlot3")),
    tabPanel("Revenue analysis",h3('Distribution of Revenue'),plotOutput("mpgPlot4"),h3('Distribution of average Revenue'),plotOutput("mpgPlot5"),h3('Number of observations'),plotOutput("mpgPlot6")),
    tabPanel("Cost analysis",h3('Distribution of Cost'),plotOutput("mpgPlot7"),h3('Distribution of average Cost'),plotOutput("mpgPlot8"),h3('Number of observations'),plotOutput("mpgPlot9"))
    )
  )
))
