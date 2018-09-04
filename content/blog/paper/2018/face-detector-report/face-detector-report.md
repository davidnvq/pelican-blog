Title: Face Detector Report
Slug: face-detector-report
Date: 2018-08-23 08:26:00
Tags: Face Detection, 2018, PAPER
Author: Quang Nguyen
Category: paper
TopPost: no

## Combined Result
### Methods
**SSH**: Like HR, a four level image pyramid is deployed. To form the pyramid, the image is first scaled
to have a shortest side of up to 800 pixels and the longest side less than 1200 pixels. Then, we scale the image to have min sizes of 500, 800, 1200, and 1600 pixels in the pyramid. All modules detect faces on all pyramid levels, except M3
which is not applied to the largest level.

Methods                | easy  | medium | hard  | AFW   | Pascal
-----------------------|-------|--------|-------|-------|--------
Scale Face Val         | 86.8  | 86.7   | 77.2  | _     | _
SSH (Pyramid) Val      | 93.1  | 92.1   | 84.5  | _     | 98.27
HR Val                 | 91.9  | 90.8   | 82.3  | _     | _
Face R-CNN Val         | 93.8  | 92.2   | 82.9  | _     | _
Face R-FCN Val         | 94.7  | 93.5   | 87.4  | _     | _
Seeing Small Faces Val | 94.9  | 93.3   | 86.1  | 99.85 | 99.23
SFD Val                | 93.7  | 92.4   | 85.2  | 99.85 | 98.49
OURS Val               | 93.7  | 92.2   | 84.6  | 99.91 | 99.16
OURS Val               | 93.7  | 92.2   | 84.6  | 99.89 | 99.37
remove_low_iou < 0.5 (b)| 95.0% | 93.5%  | 85.1% | 99.89 | 99.37

## Post Processing
Methods                  | easy  | medium | hard  | AFW   | Pascal
-------------------------|-------|--------|-------|-------|--------
Scale Face Val           | 86.8  | 86.7   | 77.2  | _     | _
SSH (Pyramid) Val        | 93.1  | 92.1   | 84.5  | _     | 98.27
HR Val                   | 91.9  | 90.8   | 82.3  | _     | _
Face R-CNN Val           | 93.8  | 92.2   | 82.9  | _     | _
Face R-FCN Val           | 94.7  | 93.5   | 87.4  | _     | _
Seeing Small Faces Val   | 94.9  | 93.3   | 86.1  | 99.85 | 99.23
SFD Val                  | 93.7  | 92.4   | 85.2  | 99.85 | 98.49
OURS Val                 | 93.7  | 92.2   | 84.6  | 99.89 | 99.37
remove_low_iou < 0.5 (a) | 81.9% | 86.1%  | 82.3% | 99.89 | 99.37
remove_low_iou < 0.5 (b) | 81.8% | 86.0%  | 82.1% | 99.89 | 99.37
remove_low_iou < 0.5 (c) | 81.7% | 86.0%  | 82.3% | 99.89 | 99.37
remove_low_iou < 0.5 (d) | _% | _%  | _% | 99.89 | 99.37

(a) set iou > 0.5 = 1, iou < 0.5 = np.sqrt(01.*score)
(b) set iou > 0.5 = 1, iou < 0.5 = 0.0
(c) set iou > 0.5 = 1, iou < 0.5 = score
(d) set iou > 0.5 = score, iou < 0.5 = 0.1

(b) Set iou > 0.5 -> np.sqrt(0.99*score), iou < 0.5 -> np.sqrt(0.01*score)

Model           | Num_layers | Notes
----------------|------------|-------------------------
Resnet101       | 4          | Loss ratio (4:1), IoU Thresholds: 0.3, 0.1, topN = 5
Resnet101_New   | 2          | Loss ratio (4:1), IoU Thresholds: 0.5, 0.3, topN = 4
Resnet101_Newer | 3          | Loss ratio (4:1), IoU Thresholds: 0.5, 0.3, topN = 4
Resnet101_Neweest | 4          | Loss ratio (4:1), IoU Thresholds: 0.5, 0.1, topN = 4

# To-do list
## Data analysis


Done


* Data analysis on WiderFace Validation, Test
    * Make a ipython notebook file for Validation and Test:
    * Height, width of dataset
    * Size of bounding boxes
    * Number of bboxes
    * Number per images

* Data analysis on AFW Face

* Data analysis on Pascal Face

## Test with different scales
Done

* Make a python script to run on AFW Face.
* Go to school to run it? May be.

## Train with lower anchors
Not yet

## Train with lower connection
Not yet 

## Train with focal_loss
Not yet

## Train with lower topN
Not yet

* topN = 4

## Build Tensorflow

## NOTES
In order to use previous DeepResnet101, just change the number of CNN layers in prediction block to `4`.

# Result on Face Dataset
## WiderFace Dataset

* Việc cần làm:

1. Retrain lại model with better accuracy!
    * IOU Threshold <0.3, 0.1>

2. Build CNN 

4. Write the paper.



### Table of results

File     | Easy  | Medium | Hard
---------|-------|--------|-------
min_640  | 91.1% | 88.1%  | 75.0%
min_500  | 89.9% | 87.4%  | 64.2%
min_800  | 91.0% | 89.1%  | 79.6%
min_1200 | 89.9% | 88.8%  | 82.4%
min_1600 | 89.9% | 87.4%  | 81.7%
original | 92.1% | 89.6%  | 78.6%
mix1     | 93.4% | 91.8%  | 84.1%
mix2     | 93.7% | 92.2%  | 80.1%
remove_low_iou < 0.3|93.8% | 92.4% | 83.9%
remove_low_iou < 0.5|95.0% | 93.3% | 84.4%

1. min_640
    just rescale the smaller size to 640 and keep the ratio unchanged
2. original
    just keep the same size and pass it to the network
3. mix1
    all the sizes with
4. mix2
    the same as mix1, but remove the tiny boxes < 8

## Resnet_newer
File     | Easy  | Medium | Hard
---------|-------|--------|-------
min_400  | 87.9% | 80.7%  | 52.9%
min_640  | 90.3% | 87.0%  | 72.0%
min_1280 | 89.9% | 87.5%  | 81.2%
min_1600 | 86.4% | 86.0%  | 80.3%
min_1920 | 82.0% | 83.0%  | 77.6%
original | 82.6% | 83.0%  | 77.6%
mix1     | 93.4% | 91.8%  | 84.1%
mix2     | 93.7% | 92.2%  | 80.1%


## AFW Dataset


File                               | DeepResnet | Resnet101
-----------------------------------|------------|-----------
afw_deepresnet_1 (0.5, 1, -1)      | 99.32%     | -
afw_deepresnet_2 (0.25)            | -          | -
afw_deepresnet_3 (0.5)             | -          | -
afw_deepresnet_4 (1)               | -          | -
afw_deepresnet_5 (2)               | -          | -
afw_deepresnet_6 (max)             | -          | -
afw_deepresnet_7 (min_size=640)    | 99.91%     | -
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
        
```python
from torchvision import transforms

def predict(img, net):
    transform = transforms.Compose([
        transforms.ToTensor(),
        transforms.Normalize((0.485, 0.456, 0.406), (0.229, 0.224, 0.225))
        ])

    with torch.no_grad():
        x = transform(img)
        x = x.cuda()
        loc_preds, cls_preds, fm_sizes = net(x.unsqueeze(0))
        loc_preds = loc_preds.squeeze().cpu()
        cls_preds = torch.nn.functional.softmax(cls_preds.squeeze(), dim=1).cpu()
        box_coder = get_box_coder(fm_sizes, img.size)
        boxes, labels, scores = box_coder.decode(loc_preds, cls_preds,
                                                 score_thresh=0.1,
                                                 nms_thresh=0.3)
    return boxes.detach().numpy(), scores.detach().numpy()
```

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

File                   | DeepResnet | Resnet101
-----------------------|------------|-----------
max_640_deepresnet101  | 99.16%     | -
min_640_deepresnet101  | 98.43%     | -
original_deepresnet101 | 98.25      | -


* max_640_deepresnet101: resize the larger size to 640, and keep the ratios w:h unchanged.
* min_640_deepresnet101: resize the smaller size to 640, and keep the ratios w:h unchanged.
* original_deepresnet101: keep the original size.


    File not in dataset 2008_000210.jpg 1.0 139 94 325 267


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




