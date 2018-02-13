sim1: datamaker.R
  seed: R(1:50)
  mybeta: (3, 1.5, 0, 0, 2, 0, 0, 0)
  Ntrain: 20
  Ntestt: 200
  Nvalid: 20
  design: deccorr
  resstd: 3
  @ALIAS: args = List()
  $meta: output$meta
  $input: output$input

sim2(sim1): datamaker.R
  mybeta: (R(rep(0.85, 8)))

sim3(sim1): datamaker.R
  mybeta: (R(rep(rep(c(0,2), each=10), 2)))
  Ntrain: 100
  Ntestt: 400
  Nvalid: 100
  design: eqlcorr
  resstd: 15

sim4(sim3): datamaker.R
  mybeta: (R(c(rep(3, 15), rep(0, 25))))
  Ntrain: 50
  Nvalid: 50
  design: grouped

ridge: ridge.wrapper.R
  input: $input
  Mytune: 10
  @ALIAS: args = List()
  $output: output
  $coefest: output$coefest

lasso(ridge): lasso.wrapper.R
  Mytune: NULL

lasso_cv(ridge): lasso.cv.wrapper.R
lasso_glmnet(ridge): lasso.glmnet.wrapper.R
elasticnet_cv(ridge): elasticnet.cv.wrapper.R
elasticnet_glmnet(ridge): elasticnet.glmnet.wrapper.R
elasticnet(lasso): elasticnet.wrapper.R
naive_elasticnet_cv(ridge): naive.elasticnet.cv.wrapper.R
naive_elasticnet(lasso): naive.elasticnet.wrapper.R
mr_ash(ridge): mr-ash.wrapper.R

score: score.R
  meta: $meta
  input: $output
  $prediction_mse: output$prediction_mse
  $estimation_mse: output$estimation_mse

DSC:
  define:
    scenarios: sim1, sim2, sim3, sim4
    methods: lasso_cv, lasso_glmnet, lasso, ridge, elasticnet_cv, elasticnet_glmnet, elasticnet,
         naive_elasticnet_cv, naive_elasticnet, mr_ash
  run: scenarios * methods * score
  output: dsc_regression
  R_libs: glmnet, elasticnet, MASS, varbvs@pcarbo/varbvs/varbvs-r
  exec_path: src