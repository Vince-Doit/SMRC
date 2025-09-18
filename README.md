# SMRC
Scalable Multi-View Regression Clustering for Large-Scale Data

This repository contains the code for the paper titled "Scalable Multi-View Regression Clustering for Large-Scale Data," published in TCSVT in 2025. The paper not only addresses the challenge of multi-view fast clustering but also tackles the issue of limited information from a single view, which often leads to unsatisfactory results.

The proposed method establishes a robust connection between multi-view regression clustering and anchor-based fast clustering. The core concept involves treating the weights of the bipartite graph as supplementary features of the samples. This approach allows for the direct integration of the local manifold structure of the samples at the feature level, thereby enhancing the clustering performance.

The repo also hosts some baseline systems as we compared in the paper. We would like to thank the authors of the baseline systems for their codes. If any baseline systems cannot be licensed freely here, please drop me an email, so we can remove it from the collection.

If you find this repo useful, please kindly cite the paper below.

@article{zhao2025scalable,
  title={Scalable multi-view regression clustering for large-scale data},
  author={Zhao, Xiaowei and Fan, Jie and Chang, Xiaojun and Nie, Feiping and Zhang, Qiang and Guo, Jun},
  journal={IEEE Transactions on Circuits and Systems for Video Technology},
  volumn = {35},
  number = {8},
  pages = {7439-7454},
  year={2025},
  publisher={IEEE}
}
