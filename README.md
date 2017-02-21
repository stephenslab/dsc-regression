# dsc2-regression
Application of DSC2 framework to a range of regression models.

The first version of this benchmark was adapted from [[1]](https://github.com/xiangzhu/dscr_en) and [[2]](https://github.com/mengyin/dscr-example), both of which are developed under [DSCR](https://github.com/stephens999/dscr) framework. To run this benchmark you can try to install DSC2 via:

```
pip3 install dsc
```
If you run into issues with the installation please find more information on the DSC2 [installation guide](https://stephenslab.github.io/dsc-wiki/installation.html). 

## Running the benchmark
```
$ dsc -x regression.dsc -a regression.ann -j8
INFO: DSC script exported to regression.html
INFO: Constructing DSC from regression.dsc ...
DSC: 100%|██████████████████████████| 77/77 [00:42<00:00,  2.91it/s]
INFO: Building output database dsc_regression.rds ...
INFO: DSC complete!
INFO: 
+--------------------------------+-------------------------------------------------------+
|  Tag                           |  No. unique obj.                                      |
+--------------------------------+-------------------------------------------------------+
|  elastic_net               |  200 methods & 200 scenarios & 200 score  |
|  elastic_net10fold         |  200 methods & 200 scenarios & 200 score  |
|  elastic_net10fold_glmnet  |  200 methods & 200 scenarios & 200 score  |
|  lasso                     |  200 methods & 200 scenarios & 200 score  |
|  lasso10fold               |  200 methods & 200 scenarios & 200 score  |
|  lasso10fold_glmnet        |  200 methods & 200 scenarios & 200 score  |
|  naive_elastic_net         |  200 methods & 200 scenarios & 200 score  |
|  naive_elastic_net10fold   |  200 methods & 200 scenarios & 200 score  |
|  ridge10fold               |  200 methods & 200 scenarios & 200 score  |
|  sim1                      |  450 methods & 50 scenarios & 450 score   |
|  sim2                      |  450 methods & 50 scenarios & 450 score   |
|  sim3                      |  450 methods & 50 scenarios & 450 score   |
|  sim4                      |  450 methods & 50 scenarios & 450 score   |
+--------------------------------+-------------------------------------------------------+
INFO: Elapsed time 1183.625 seconds.
```
