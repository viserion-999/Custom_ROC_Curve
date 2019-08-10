
#first read the csv file
#col 1: pred
#col 2: actual

custom_roc <- function(roc_file){
 
  
  df = roc_file
  
  #we get data in descending order
  newdata = df[order(-df[,2]), ]
  
  #keep track of the thresholds for the sensitivities and specificity
  thresholds <- sort(df[,2])
  #Sensitivity is TP/P and specificity is TN/N
 
  pos <- sum(df[,1])
  neg <- sum(!df[,1])
  
  #lets get our true negatives at each threshold. 
  #That is pretty easy, it is just the number of FALSE values 
  #at or below each the threshold. Since our data are in order by 
  #threshold, we can calculate that (and the specificity) using:
  
  tn <- cumsum(!df[,1])
  spec <- tn/neg
  
  tp <- pos - cumsum(df[,1])
  sens <- tp/pos
  
  ROCperf = plot(1 - spec, sens, type = "l", col = "blue", 
       ylab = "(True Positive Rate)Sensitivity", xlab = "False Positive Rate(1 - Specificity)",main = "ROC Curve")
  
  abline(c(0,0),c(1,1))
  
}



