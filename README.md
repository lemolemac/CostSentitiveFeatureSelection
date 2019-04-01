# CostSentitiveFeatureSelection
A Matlab Implementation for paper Cost-Sensitive Feature Selection by Optimizing F-Measures.

Meng Liu, Chang Xu, Yong Luo, Chao Xu, Yonggang Wen, Dacheng Tao:</br>
Cost-Sensitive Feature Selection by Optimizing F-Measures. </br>
IEEE Trans. Image Processing 27(3): 1323-1335 (2018)</br>

which includes the two main functions:</br>
a) csfs_l21r21.m is the function which calculate the cost-sensitive feature selection;</br>
b) csfs_multi_run.m initializes different random seeds to get an average performance.</br>

This code is tested on Windows 8.1 with Matlab 2015. Should occur any problem, please do not hesitate to contact mengliu[at]pku.edu.cn

# Abstract:
Feature selection is beneficial for improving the performance of general machine learning tasks by extracting an informative subset from the high-dimensional features. Conventional feature selection methods usually ignore the class imbalance problem, thus the selected features will be biased towards the majority class. Considering that F-measure is a more reasonable performance measure than accuracy for imbalanced data, this paper presents an effective feature selection algorithm that explores the class imbalance issue by optimizing F-measures. Since F-measure optimization can be decomposed into a series of cost-sensitive classification problems, we investigate the cost-sensitive feature selection by generating and assigning different costs to each class with rigorous theory guidance. After solving a series of cost-sensitive feature selection problems, features corresponding to the best F-measure will be selected. In this way, the selected features will fully represent the properties of all classes. Experimental results on popular benchmarks and challenging real-world data sets demonstrate the significance of cost-sensitive feature selection for the imbalanced data setting and validate the effectiveness of the proposed method.


If you make use of the code found here, please cite the paper as follows.

@article{liu2018cost,</br>
  title={Cost-sensitive feature selection by optimizing f-measures},</br>
  author={Liu, Meng and Xu, Chang and Luo, Yong and Xu, Chao and Wen, Yonggang and Tao, Dacheng},</br>
  journal={IEEE Transactions on Image Processing},</br>
  volume={27},</br>
  number={3},</br>
  pages={1323--1335},</br>
  year={2018},</br>
  publisher={IEEE}</br>
}</br>
