# Active Contour Without Edges on Wavelet Features

This is a simple implementation of my paper:

<a href="https://arxiv.org/abs/1907.03591">Chen, Junyu, et al. "Feature-Based Image Clustering and Segmentation Using Wavelets." arXiv preprint arXiv:1907.03591, 2019.</a>

This method builds on the <a href="https://ieeexplore.ieee.org/document/902291">Active Contour Without Edges</a> (ACWE) to incorporate Wavelet features, with a tunable parameter 'q' to allow us to control the type of information (low-frequency or high-frequency info.) we want to segment.

#### Data required to run the MATLAB program can be found here: <a href="https://drive.google.com/open?id=1zAh4i4pZkzys8kj0zDQFvfKyN2XKlxQM"> required data</a>.

## Sample Results:
<img src="https://github.com/junyuchen245/Active-Contour-Wavelet-Seg/blob/master/sample_img/results.png" width="600"/>

### q = 0.75 (Bone Segmentation):
<img src="https://github.com/junyuchen245/Active-Contour-Wavelet-Seg/blob/master/sample_img/q%3D0.75.gif" width="400"/>

### q = 1.7 (Lesion Segmentation):
<img src="https://github.com/junyuchen245/Active-Contour-Wavelet-Seg/blob/master/sample_img/q%3D1.7.gif" width="400"/>
