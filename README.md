# dsc2-regression
Application of DSC2 framework to a range of regression models.

The first version of this benchmark was adapted from [[1]](https://github.com/xiangzhu/dscr_en) and [[2]](https://github.com/mengyin/dscr-example), both of which are developed under [DSCR](https://github.com/stephens999/dscr) framework. To run this benchmark you can try to install DSC2 via:

```
pip3 install dsc
```
If you run into issues with the installation please find more information on the DSC2 [installation guide](https://stephenslab.github.io/dsc-wiki/installation.html). 

## Running the benchmark
```
[GW] dsc -x regression.dsc -j16
INFO: DSC script exported to regression.html
INFO: Constructing DSC from regression.dsc ...
DSC: 100%|████████████████████████████| 36/36 [03:53<00:00,  8.34s/it]
INFO: Building output database dsc_regression.rds ...
INFO: DSC complete!
INFO: Elapsed time 240.166 seconds.
```
