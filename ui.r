fluidPage(
  titlePanel("ATOMIC: plausible future 2030"),
  
  sidebarPanel( 
    radioButtons("var", label = h3("Models"),choices = list("Gini Index" = "Gini_Index","Average Taxable Income" = "Average_Taxable_Income"),
                 selected = "Gini_Index"),
     checkboxInput(inputId = "checkbox", label = "Metro vs Rural", value = FALSE ),
                    
     conditionalPanel(condition = "input.checkbox == true",
                                     
                      sliderInput("slider", label = h3("Forecast Years"), min = 2015, 
                                  max = 2030, value = 2015,step = 1,sep=NULL)
  )),
  mainPanel(textOutput("text1"),plotOutput("main_plot"))
)

