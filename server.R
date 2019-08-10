
source("custom_ROC.R")

# create the server functions for the dashboard  
server <- function(input, output, session) { 
  
  
  
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    req(input$file1)
    
    df <- read.csv(input$file1$datapath,
                   header = input$header,
                   sep = input$sep,
                   quote = input$quote)
    
    makeReactiveBinding("df")
    
    if(input$disp == "head") {
      return(head(df))
    }
    else {
      return(df)
    }
    
  })
  
  
  data <- reactive({
    validate(
      need(input$file1 != "", 
          "

NOTE: UPLOAD YOUR CSV FILE CONTAINING VALUES IN THE FORMAT (TEST VALUE, PREDICTED VALUE) ONLY. NO OTHER FORMAT WILL BE ACCEPTED.
STEPS TO GENERATE ROC CURVE:

Any other format will not be accepted.
Then choose options using the check boxes for your uploaded csv(header,seperators etc).
You can see the uploaded csv above. (head or entire dataframe)
ROC Curve for the uploaded test vs predicted will appear in this box here.
ROC Curve dynamically changes as you adjust/correct/change your csv file.

SPECIALITY:

The ROC Curve function is written from scratch without using any package.
To view that function implementation, please refer to custom_roc.R file. 
Code can be accessed from get the code tab.
There is a sample file in the format to test this site in the same link. (pred_death.csv)
           ")
    )
    
    read.csv(input$file1$datapath,
             header = input$header,
             sep = input$sep,
             quote = input$quote)
  })
  
  output$custom_roc <-renderPlot(
    {
      df <- data()
      print("dataframe is:")
      print(head(df))
      custom_roc(df)
      
      
    }
  )
  


  
  output$Pratisamvid <- renderImage({
    width  <- session$clientData$output_Pratisamvid_width
    height <- session$clientData$output_Pratisamvid_height
    return(list(src = "Pratisamvid-Logo-TM.png",contentType = "image/png",alt = "Pratisamvid", width = width, height = height))
  }, deleteFile = FALSE) #where the src is wherever you have the picture
  

  
  
}