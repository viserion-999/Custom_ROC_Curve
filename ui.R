## app.R ##
library(shiny)
library(shinydashboard)
library(ggplot2)
library(ggthemes)
library(ggmap)
library(devtools)
library(sp)
library(mapview)

register_google(key = "AIzaSyA_Lh0dPf2loqgG2nXekk50DiaqVEe6Rrk")
source("server.R")

ui <- dashboardPage(
  
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
  
)

#Dashboard header carrying the title of the dashboard
header <- dashboardHeader(title = "ROC Curve")  

#Sidebar content of the dashboard
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Custom ROC Curve", tabName = "roc", icon = icon("train", lib = "font-awesome")),
    menuItem("Get the code!", icon = icon("train",lib='font-awesome'), 
             href = "https://github.com/viserion-999/Custom_ROC_Curve"),
   
    
    menuItem("Pratisamvid", tabName = "Pratisamvid", icon = icon("train", lib = "font-awesome"))
    
  )

)
## Title Panel to display information about the project
frow1 <- fluidRow(
  column(12, valueBox(width=NULL,"ROC Curve", "Upload your csv containing columns as: (TEST VALUES, PREDICTED VALUES) only", icon = icon("chart-line")))
  
  
)


frow2 <- fluidRow( 
  
  box(
    title = "Upload files",
    status = "primary",
    solidHeader = TRUE,
    collapsible = TRUE,
    background = "aqua",
    fileInput("file1", "Choose CSV File",
              accept = c(
                "text/csv",
                "text/comma-separated-values,text/plain",
                ".csv")),
    # Horizontal line ----
    tags$hr(),
    
    # Input: Checkbox if file has header ----
    checkboxInput("header", "Header", TRUE),
    
    # Input: Select separator ----
    radioButtons("sep", "Separator",
                 choices = c(Comma = ",",
                             Semicolon = ";",
                             Tab = "\t"),
                 selected = ","),
    
    # Input: Select quotes ----
    radioButtons("quote", "Quote",
                 choices = c(None = "",
                             "Double Quote" = '"',
                             "Single Quote" = "'"),
                 selected = '"'),
    
    # Horizontal line ----
    tags$hr(),
    
    # Input: Select number of rows to display ----
    radioButtons("disp", "Display",
                 choices = c(Head = "head",
                             All = "all"),
                 selected = "head")
    
  ),
  
  box(
    title = "Dataframe:",
    status = "primary",
    solidHeader = TRUE,
    collapsible = FALSE,
    background = "aqua",
    #tableOutput("contents")
    
    div(style = 'overflow-x: scroll', tableOutput('contents'))
    
    
  )
)
frow3 <- fluidRow( 

  box(
    title = "ROC Curve"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE
    ,width = 12
    ,column(width = 12, plotOutput("custom_roc", height = "500px"))
  )
 

)

frow4 <- fluidRow(
  column(12, valueBox(width=NULL, "ROC from Scratch: Assignment", 
                      "Anagha Karanam - E19040 ", icon = icon("chart-line")))
  
  
)

frow5 <-   fluidPage(
  box(
  title = "A Unit of Infra Spares"
  ,status = "primary"
  ,solidHeader = TRUE 
  ,column(width = 12,
    imageOutput("Pratisamvid", height = "100px") 
  ) ) 
  
)
  
# combine the two fluid rows to make the body
body <- dashboardBody(


  tabItems(
 
    tabItem(tabName = "roc",
            #h2("Can add heading here if we want to"),
            frow1,
            frow2,
            frow3,
            frow4
            
    ),

    tabItem(tabName = "Pratisamvid",
           frow5
    )
  )
  
  
)


#completing the ui part with dashboardPage
ui <- dashboardPage(title = 'Generate Basic Graphs', header, sidebar, body, skin='yellow')

