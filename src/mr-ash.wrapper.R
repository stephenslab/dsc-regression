# the following are the function we need to source in for the wrapper funciton
library(varbvs)

initial_step = function(X,y,Z = NULL){
  P = dim(X)[2]
  output = matrix(0,nrow = P,ncol = 2)
  for(i in 1:P){
    if(is.null(Z)){
      g = summary(lm(y~X[,i]))
    }else{
      g = summary(lm(y~X[,i]+Z))
    }
    
    output[i,] = g$coefficients[2,1:2]
  }
  return(list(betahat = output[,1],sebetahat = output[,2]))
}


autoselect.mixsd = function(betahat,sebetahat,mult = sqrt(2)){
  sebetahat=sebetahat[sebetahat!=0] #To avoid exact measure causing (usually by mistake)
  sigmaamin = min(sebetahat)/10 #so that the minimum is small compared with measurement precision
  if(all(betahat^2<=sebetahat^2)){
    sigmaamax = 8*sigmaamin #to deal with the occassional odd case where this could happen; 8 is arbitrary
  }else{
    sigmaamax = 2*sqrt(max(betahat^2-sebetahat^2)) #this computes a rough largest value you'd want to use, based on idea that sigmaamax^2 + sebetahat^2 should be at least betahat^2   
  }
  if(mult==0){
    return(c(0,sigmaamax/2))
  }else{
    npoint = ceiling(log2(sigmaamax/sigmaamin)/log2(mult))
    return(mult^((-npoint):0) * sigmaamax)
  }
}


# to get the estimation
Mr.ash = function(X,y,Z = NULL){
  Z = NULL
  initial = initial_step(X,y,Z)
  mixsd = autoselect.mixsd(initial$betahat,initial$sebetahat)
  ## in this case, we choose the random starting point
  library("varbvs")
  # res = varbvsmix(X, NULL, y, sa = c(0,mixsd^2))
  # res_random is the result from a random starting point
  res_random = varbvsmix(X, NULL, y, sa = c(0,mixsd^2),verbose = FALSE)
  beta_random = rowSums(res_random$alpha * res_random$mu)
  return(list(beta = beta_random, intercept = res_random$mu.cov))
}




# dsc rapper function
# this function is following the similar structure of ridge.wrapper
Mr.ash.wrapper = function(input,args){
  
  Xvalid = input$Xvalid
  Yvalid = input$Yvalid
  Xtrain = input$Xtrain
  Ytrain = input$Ytrain
  # in this case, we don't need anything to tune 
  Mytune = args$Mytune
  
  # fit the model on training set
  Xmerge = rbind(Xvalid, Xtrain)
  Ymerge = c(Yvalid, Ytrain)
  myobj = Mr.ash(Xmerge,Ymerge,Z = NULL)
  # output prediction function and point estimate
  predict.func <- function(Xnew){
    Yhat = myobj$intercept + Xnew %*% myobj$beta
    return(Yhat)
  }
  
  coefest = myobj$beta
  
  return(list(predict=predict.func, coefest=coefest))
}
# again, in our approach there is no args for now.
# output = Mr.ash.wrapper(input, args)

# the following is try to test this function in dsc structure.
# Ntrain = 30
# Ntestt = 20
# Xtrain = X[1:Ntrain, ]
# Xtestt = X[(Ntrain+1):(Ntrain+Ntestt), ]
# Xvalid = X[(Ntrain+Ntestt+1):N, ]
# 
# Ytrain = Y[1:Ntrain]
# Ytestt = Y[(Ntrain+1):(Ntrain+Ntestt)]
# Yvalid = Y[(Ntrain+Ntestt+1):N] 
# 
# 
# input = list(Xtrain = Xtrain,Xvalid = Xvalid, Ytrain = Ytrain,Yvalid = Yvalid)
# args = NULL
# output = Mr.ash.wrapper(input, args)
# prediction = output$predict(Xtestt)
# output$coefest
output = Mr.ash.wrapper(input, args)
