#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(elasticnet)

elasticnet.wrapper = function(input,args){

  Xvalid = input$Xvalid
  Yvalid = input$Yvalid
  Xtrain = input$Xtrain
  Ytrain = input$Ytrain
  Mytune = args$Mytune

  p = dim(Xtrain)[2]
  Myiter = length(seq(1, p, 0.05));
  
  # decide tuning parameter
  lambda_list = c(0, 0.01, 0.1, 1, 10, 100)
  num_list = length(lambda_list)
  valid_mse = matrix(0, nrow=num_list, ncol=Myiter)
  
    # K-fold CV
    cvmin_list = rep(0, num_list)
    ostep_list = rep(0, num_list)
    for (j in 1:num_list){
      Xmerge = rbind(Xvalid, Xtrain)
      Ymerge = c(Yvalid, Ytrain)
      cvobj = cv.enet(Xmerge, Ymerge, K=Mytune, lambda_list[j], s=seq(1,1+(Myiter-1)*0.05,length=Myiter), mode="step", plot.it=FALSE, se=FALSE)
      cvmin_list[j] = min(cvobj$cv)
      ostep_list[j] = (which.min(cvobj$cv)-1)*0.05+1
    }
    lambda = lambda_list[which.min(cvmin_list)] 
    optimS = ostep_list[which.min(cvmin_list)]
    
  # fit the model on training set
  myobj = enet(Xtrain, Ytrain, lambda)
  
  # output prediction function and point estimate
  predict <- function(Xnew){
    predict.enet(myobj, Xnew, s=optimS, type="fit", mode="step", naive=FALSE)$fit
  }
  
  coefest = predict.enet(myobj, s=optimS, type="coef", mode="step", naive=FALSE)$coefficients 

  return(list(predict=predict, coefest=coefest))
}
output = elasticnet.wrapper(input, args)
