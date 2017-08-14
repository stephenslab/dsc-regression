scenarios:
  exec: R(rep('datamaker.R', 4))
  .alias: sim1, sim2, sim3, sim4
  seed: R(1:50)
  params:
    mybeta: (3, 1.5, 0, 0, 2, 0, 0, 0)
    Ntrain: 20
    Ntestt: 200
    Nvalid: 20
    design: deccorr
    resstd: 3
    exec[2]:
      mybeta: Asis(rep(0.85, 8))
    exec[3]:
      mybeta: Asis(rep(rep(c(0,2), each=10), 2))
      Ntrain: 100
      Ntestt: 400
      Nvalid: 100
      design: eqlcorr
      resstd: 15
    exec[4]:
      mybeta: Asis(c(rep(3, 15), rep(0, 25)))
      Ntrain: 50
      Ntestt: 400
      Nvalid: 50
      design: grouped
      resstd: 15
    .alias: args = List()
  return: meta = output$meta, input = output$input

methods:
  exec: lasso.cv.wrapper.R, lasso.glmnet.wrapper.R, lasso.wrapper.R, ridge.wrapper.R,
        elasticnet.cv.wrapper.R, elasticnet.glmnet.wrapper.R, elasticnet.wrapper.R,
        naive.elasticnet.cv.wrapper.R, naive.elasticnet.wrapper.R, mr-ash.wrapper.R
  .alias: lasso_cv, lasso_glmnet, lasso, ridge, elasticnet_cv, elasticnet_glmnet, elasticnet,
         naive_elasticnet_cv, naive_elasticnet, mr_ash
  params:
    input: $input
    Mytune: 10 
    exec[3,7,9]:
      Mytune: NULL
    .alias: args = List()
  return: output, coefest = output$coefest

score:
  exec: score.R
  params:
    meta: $meta
    input: $output
  return: prediction_mse = output$prediction_mse, estimation_mse = output$estimation_mse

DSC:
  run:
    all: scenarios * methods * score
  output: dsc_regression
  R_libs: glmnet, elasticnet, MASS
  exec_path: src
