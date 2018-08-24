Title: Result on Face Detection
Slug: result-on-face-detection
Date: 2018-08-24 12:29:05
Tags: Face Detection, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no

# Benchmarks

## Validation
Methods     | easy | medium | hard | AFW | Pascal
------------|------|--------|------|-----|--------
SSH(VGG-16) | 93.1 | 92.1   | 84.5 | _   | 98.27
HR (Tiny Faces)| 


## Test 
Methods     | easy | medium | hard | AFW | Pascal
------------|------|--------|------|-----|--------
SSH(VGG-16) | 93.1 | 92.1   | 84.5 | _   | 98.27
HR (Tiny Faces)| 


# Methods
## HR - Finding Tiny Faces
Finding Tiny Faces. IEEE Conference on Computer Vision and 
Pattern Recognition (CVPR), 2017. 

Peiyun Hu, Deva Ramanan
Robotics Institute
Carnegie Mellon University

https://arxiv.org/pdf/1612.04402v1.pdf

### Result
Methods | easy | medium | hard | AFW | Pascal
--------|------|--------|------|-----|--------
HR Val  | 91.9 | 90.8   | 82.3 | _   | _
HR Test | 91.5 | 90.2   | 81.3 | _   | _

### Implementation

### Contribution
1. We provide an in-depth analysis of
image resolution, object scale, and spatial context for the purposes of finding small faces. 

2. We demonstrate stateof-the-art results on massively-benchmarked face datasets (FDDB and WIDER FACE). In particular, when compared to prior art on WIDER FACE, our results reduce error by a factor of 2 (our models produce an AP of 81% while prior art ranges from 29-64%).

## Face R-CNN
Hao Wang Zhifeng Li∗ Xing Ji Yitong Wang
Tencent AI Lab, China

Face R-CNN. arXiv preprint arXiv:1706.01061, 2017. 

Paper:  https://arxiv.org/pdf/1706.01061.pdf

### Result
Methods         | easy | medium | hard | AFW | Pascal
----------------|------|--------|------|-----|--------
Face R-CNN Val  | 93.8 | 92.2   | 82.9 | _   | 98.27
Face R-CNN Test | 93.2 | 91.6   | 82.7 | _   | 98.27

### Implementations
* VGG19 with ImageNet pretrained model
* Positive examples IoU > 0.5
* Negative examples 0.1 < IoU < 0.5 
* IoU of NMS = 0.7

### Contribution
The major contributions of this work are summarized as follows:

1. Considering the specific property of face detection, we propose a Faster R-CNN based approach
called Face R-CNN for face detection by integrating several newly developed techniques including
center loss, online hard example mining, and multi-scale training.
2. The proposed approach differs from the available Faster R-CNN based face detection methods.
First, this is the first attempt to use the center loss to reduce the large intra-class variations in face
detection. Second, the use of online hard example mining in our approach differs from the others.
By appropriately setting the ratio between positive hard samples and negative hard samples, the
combination of OHEM and center loss can lead to better performance.
3. The proposed approach consistently obtains superior performance over the state-of-the-arts on
two public-domain face detection benchmarks (WIDER FACE dataset [25] and FDDB dataset [28]).

## ScaleFace
Face Detection through Scale-Friendly Deep Convolutional Networks. arXiv preprint arXiv:1706.02863, 2017. 

### Result
Methods         | easy | medium | hard | AFW | Pascal
----------------|------|--------|------|-----|--------
Face R-CNN Val  | 93.8 | 92.2   | 82.9 | _   | 98.27
Face R-CNN Test | 93.2 | 91.6   | 82.7 | _   | 98.27

### Implementation

### Contribution


## SSH
SSH: Single Stage Headless Face Detector. IEEE International 
Conference on Computer Vision (ICCV), 2017. 

### Result
Methods         | easy | medium | hard | AFW | Pascal
----------------|------|--------|------|-----|--------
Face R-CNN Val  | 93.8 | 92.2   | 82.9 | _   | 98.27
Face R-CNN Test | 93.2 | 91.6   | 82.7 | _   | 98.27

### Implementation

### Contribution

## SFD
S³FD: Single Shot Scale-invariant Face Detector. IEEE International Conference on Computer Vision (ICCV), 2017. 
### Result
Methods         | easy | medium | hard | AFW | Pascal
----------------|------|--------|------|-----|--------
Face R-CNN Val  | 93.8 | 92.2   | 82.9 | _   | 98.27
Face R-CNN Test | 93.2 | 91.6   | 82.7 | _   | 98.27

### Implementation

### Contribution


## MSCNN
A Unified Multi-scale Deep Convolutional Neural Network for Fast Object Detection, European Conference on Computer Vision (ECCV), 2016. 
### Result
Methods         | easy | medium | hard | AFW | Pascal
----------------|------|--------|------|-----|--------
Face R-CNN Val  | 93.8 | 92.2   | 82.9 | _   | 98.27
Face R-CNN Test | 93.2 | 91.6   | 82.7 | _   | 98.27

### Implementation

### Contribution

## FAN 
Face Attention Network: An Effective Face Detector for the Occluded Faces. arXiv preprint arXiv:1711.07246, 2017. 
### Result
Methods         | easy | medium | hard | AFW | Pascal
----------------|------|--------|------|-----|--------
Face R-CNN Val  | 93.8 | 92.2   | 82.9 | _   | 98.27
Face R-CNN Test | 93.2 | 91.6   | 82.7 | _   | 98.27

### Implementation

### Contribution

## CVPR 2018
Seeing Small Faces from Robust Anchor's Perspective. IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2018. 
### Result
Methods         | easy | medium | hard | AFW | Pascal
----------------|------|--------|------|-----|--------
Face R-CNN Val  | 93.8 | 92.2   | 82.9 | _   | 98.27
Face R-CNN Test | 93.2 | 91.6   | 82.7 | _   | 98.27

### Implementation

### Contribution

## PyramidBox
PyramidBox: A Context-assisted Single Shot Face Detector. arXiv preprint arXiv:1803.07737, 2018. 
### Result
Methods         | easy | medium | hard | AFW | Pascal
----------------|------|--------|------|-----|--------
Face R-CNN Val  | 93.8 | 92.2   | 82.9 | _   | 98.27
Face R-CNN Test | 93.2 | 91.6   | 82.7 | _   | 98.27

### Implementation

### Contribution
