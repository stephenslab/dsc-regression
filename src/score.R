#This file should define your score function
library(elasticnet)
library(glmnet)
score = function(meta, output){
#insert calculations here; return a named list of results

  truevalue = meta$Xtestt %*% meta$mybeta

  prediction = output$predict(meta$Xtestt)
  
  prediction_mse = mean( (truevalue - prediction)^2 )
  
  estimation_mse = mean( (meta$mybeta - output$coefest)^2 )

  return(list(prediction_mse = prediction_mse, estimation_mse = estimation_mse))
}
output = score(meta, input)
