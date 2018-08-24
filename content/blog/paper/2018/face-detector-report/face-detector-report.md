Title: Face Detector Report
Slug: face-detector-report
Date: 2018-08-23 08:26:00
Tags: Face Detection, 2018, PAPER
Author: Quang Nguyen
Category: paper
TopPost: no

# To-do list
## Data analysis
* Data analysis on WiderFace Validation, Test
    * Make a ipython notebook file for Validation and Test
* Data analysis on AFW Face
* Data analysis on Pascal Face

## Test with different scales
* Make a python script to run on AFW Face.
* Go to school to run it? May be.

# Result on Face Dataset

## AFW Dataset

File                               | DeepResnet | Resnet101
-----------------------------------|------------|--------
afw_deepresnet_1 (0.5, 1, -1)      | 99.32%     | -
afw_deepresnet_2 (0.25)            | -          | -
afw_deepresnet_3 (0.5)             | -          | -
afw_deepresnet_4 (1)               | -          | -
afw_deepresnet_5 (2)               | -          | -
afw_deepresnet_6 (max)             | -          | -
afw_deepresnet_7 (640-640)         | -          | -
afw_deepresnet_8 (0.5, 1)          | -          | -
afw_deepresnet_9 (0.5, 1, 2)       | -          | -
afw_deepresnet_10 (0.5, 1, 2, max) | -          | -

1. afw_deepresnet_1
    * Pyramid prediction: 
        * 0.5, 
        * 1, 
        * 1 - flip

2. afw_deepresnet_2
    * Pyramid prediction:
        * 0.5
        * 1
        * 1 - flip

2. afw_deepresnet_2
    * Pyramid prediction:
        * 0.5
        * 1
        * 1 - flip
        

**Some comments here:**
- Use pyramid prediction `afw_deepresnet_1` gives a lot of false positives, predicting the areas including bàn tay, đùi, ngực, bụng, tường as `face`. Thường thì những trường hợp False positives này có sizes lớn (> 300).

- Conduct post-processing to filter the false positives:
    * Set `confidence score` of all boxes of IoU with `IoUwith(gt_boxes) < 0.5` to `0.1` then: `mAP = 99.92`.   
    * Set `confidence score` of all boxes of IoU with `IoUwith(gt_boxes) < 0.3` to `0.1` then: `mAP = 99.99`.
    * Set `confidence score` of all boxes of IoU with `IoUwith(gt_boxes) < 0.5` to `0.0` then: `mAP = 95.58`.
    * Set `confidence score` of all boxes of IoU with `IoUwith(gt_boxes) < 0.3` to `0.0` then: `mAP = 99.99`.
    * Set `confidence score` of all boxes of IoU with `IoUwith(gt_boxes) < 0.2` to `0.0` then: `mAP = 99.99`.


    * Remove the `false positive` boxes then: `mAP = 99.33`?.  
## Pascal Dataset


## WiderFace Dataset





# Charts and Graphs

## False positive in different ranges. 

Fig 1.a Number of false positives

Fig 1.b Confidence of False positive samples

Fig. 1: (a) Comparison of the number of false positives in different ranges. (b)
Comparison of the mAP gains by progressively removing false positives; from
right to left, the detector is performing better as false positives are removed
according to their confidence scores

## FPN models

## AFW & Pascal Face, Wider Face




