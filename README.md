# dsc2-regression
Application of DSC2 framework to a range of regression models.

The first version of this benchmark was adapted from [1] and [2], both of which are developed under [DSCR](https://github.com/stephens999/dscr) framework. To run this benchmark you can try to install DSC2 via:

```
pip3 install dsc
```
If you run into issues with the installation please find more information on the DSC2 [installation guide](https://stephenslab.github.io/dsc-wiki/installation.html). 

## Running the benchmark
```
$ dsc -x regression.dsc -j8
INFO: DSC script exported to regression.html
INFO: Constructing DSC from regression.dsc ...
DSC: 100%|██████████████████████████████████████████████████████████████████████| 36/36 [03:53<00:00,  8.34s/it]
INFO: Building output database dsc_regression.rds ...█████████████████████████████| 3/3 [00:08<00:00,  2.26s/it]
INFO: DSC complete!
INFO: Elapsed time 240.166 seconds.
$ dsc -a regression.ann 
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
INFO: Elapsed time 0.339 seconds.
```

[1] https://github.com/xiangzhu/dscr_en
[2] https://github.com/mengyin/dscr-example
