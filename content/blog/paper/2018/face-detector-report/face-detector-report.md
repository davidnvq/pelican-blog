Title: Face Detector Report
Slug: face-detector-report
Date: 2018-08-23 08:26:00
Tags: Face Detection, 2018, PAPER
Author: Quang Nguyen
Category: paper
TopPost: no
# Dataset
http://www.face-rec.org/databases/

# Timer and speed
https://github.com/ShuangXieIrene/ssds.pytorch/blob/master/lib/utils/timer.py
https://github.com/ShuangXieIrene/ssds.pytorch/blob/master/lib/ssds.py
# Write clean code like
https://github.com/DavexPro/pytorch-pose-estimation/blob/master/pose_estimation.py
# The incredible pytorch
https://www.ritchieng.com/the-incredible-pytorch/
Face problems
https://www.adrianbulat.com/
FERA 2017 - Addressing Head Pose in the Third Facial Expression
Recognition and Analysis Challenge - 2017 Dataset
https://arxiv.org/pdf/1702.04174.pdf

consecutively 

competitive results over the compared baseline methods.

earlier works/ efforts
the subsequent layer
these models usually heavily relied on
laborious feature engineering

Recent advances in deep neural networks and
representation learning have substantially improved
the performance of text classification tasks.
The dominant approaches are recurrent neural net


# How to train
https://www.youtube.com/watch?v=Rgpfk6eYxJA

## Combined Result
### Methods
**SSH**: Like HR, a four level image pyramid is deployed. To form the pyramid, the image is first scaled
to have a shortest side of up to 800 pixels and the longest side less than 1200 pixels. Then, we scale the image to have min sizes of 500, 800, 1200, and 1600 pixels in the pyramid. All modules detect faces on all pyramid levels, except M3
which is not applied to the largest level.

Methods                                | easy  | medium | hard  | AFW   | Pascal | FDDB
---------------------------------------|-------|--------|-------|-------|--------|-----
Scale Face Val                         | 86.8  | 86.7   | 77.2  | _     | _      | 96.0
SSH (Pyramid) Val                      | 93.1  | 92.1   | 84.5  | _     | 98.27  | 98.1
HR Val(Tiny Face Detector)             | 91.9  | 90.8   | 82.3  | _     | _      |
Face R-CNN Val                         | 93.8  | 92.2   | 82.9  | _     | _      |
Face R-FCN Val                         | 94.7  | 93.5   | 87.4  | _     | _      |
Seeing Small Faces Val                 | 94.9  | 93.3   | 86.1  | 99.85 | 99.23  | 97.5
SFD Val                                | 93.7  | 92.4   | 85.2  | 99.85 | 98.49  | 98.3
wf_scale1 (Remove tiny boxes min < 18) | 94.2  | 92.8   | 86.1  | _     | _      | _
OURS Val without  FPC                  | 93.7  | 92.2   | 84.6  | 99.91 | 99.28  | 98.4
Our Val with FPC                       | 94.3  | 93.2   | 84.8  | 99.89 | 99.28  | 98.4
Retinanet with Correction              | 95.2  | 93.6   | 85.9  | 99.91 | 99.37  | 98.8

Retinanet with Correction CNN


## Post Processing
Methods                                | easy  | medium | hard  | AFW   | Pascal
---------------------------------------|-------|--------|-------|-------|-------
Scale Face Val                         | 86.8  | 86.7   | 77.2  | _     | _
SSH (Pyramid) Val                      | 93.1  | 92.1   | 84.5  | _     | 98.27
HR Val                                 | 91.9  | 90.8   | 82.3  | _     | _
Face R-CNN Val                         | 93.8  | 92.2   | 82.9  | _     | _
Face R-FCN Val                         | 94.7  | 93.5   | 87.4  | _     | _
Seeing Small Faces Val                 | 94.9  | 93.3   | 86.1  | 99.85 | 99.23
SFD Val                                | 93.7  | 92.4   | 85.2  | 99.85 | 98.49
OURS Val                               | 93.7  | 92.2   | 84.6  | 99.89 | 99.37
OURS Val                               | 93.7  | 92.2   | 84.6  | 99.91 | 99.37
wf_scale1 (Remove tiny boxes min < 18) | 94.2% | 92.8%  | 53.4% | _     | _
remove_low_iou < 0.5 (a)               | 81.9% | 86.1%  | 82.3% | 99.89 | 99.37
remove_low_iou < 0.5 (b)               | 81.8% | 86.0%  | 82.1% | 99.89 | 99.37
remove_low_iou < 0.5 (c)               | 81.7% | 86.0%  | 82.3% | 99.89 | 99.37
remove_low_iou < 0.5 (d)               | _%    | _%     | _%    | 99.89 | 99.37

(a) set iou > 0.5 = 1, iou < 0.5 = np.sqrt(01.*score)
(b) set iou > 0.5 = 1, iou < 0.5 = 0.0
(c) set iou > 0.5 = 1, iou < 0.5 = score
(d) set iou > 0.5 = score, iou < 0.5 = 0.1

(b) Set iou > 0.5 -> np.sqrt(0.99*score), iou < 0.5 -> np.sqrt(0.01*score)

Model             | Num_layers | Notes
------------------|------------|-----------------------------------------------------
Resnet101         | 4          | Loss ratio (4:1), IoU Thresholds: 0.3, 0.1, topN = 5
Resnet101_New     | 2          | Loss ratio (4:1), IoU Thresholds: 0.5, 0.3, topN = 4
Resnet101_Newer   | 3          | Loss ratio (4:1), IoU Thresholds: 0.5, 0.3, topN = 4
Resnet101_Neweest | 4          | Loss ratio (4:1), IoU Thresholds: 0.5, 0.1, topN = 4

# Current work
ssh amazon_server; chạy predict_Resnet101_New, with 2 layers, 


### Table of deepresnet
Ket qua quen khong ghi chep? Maybe model `Resnet101/best_val_model.pkl`
Predict on VAL with Resnet101/best_val_model.pkl (num_layers=4); 
File     | Easy  | Medium | Hard
---------|-------|--------|-------
min_500  | 89.9% | 87.4%  | 64.2%
min_640  | 91.1% | 88.1%  | 75.0%
min_800  | 91.0% | 89.1%  | 79.6%
min_1200 | 89.9% | 88.8%  | 82.4%
min_1600 | 89.9% | 87.4%  | 81.7%
original | 92.1% | 89.6%  | 78.6%

# What I'm doing now?
* Prediction on Wider_val, test with old method: 
	* The result saved at `Dropbox/Resnet101`
	* The screen session: `wf_prediction_final`
	* On `dais`
	* Used file `widerface_pred/wider_benchmark.sh`, `widerface_pred/benchmark_eval.py`.

* Prediction on Wider_val, test with `new` method: 
	* The result saved at `Dropbox/WIDER_test`, `Dropbox/WIDER_val`, 
	* The screen session: `wf`
	* Use file `prediction/wf_prediction_multi_scale.sh`
	* `max_scale = (1980 * 1980/ (w * h)) ** (0.5)`
	* On `dais`

* Prediction on Wider_val with :
	* On `amazon_server`
	* Use file `prediction/wf_prediction_multi_scale.sh`
	* `max_scale = (2400 * 2400/ (w * h)) ** (0.5)`


### Table of results Resnet101 layers
Update on 25-Sept
Predict on VAL with Resnet101/best_val_loss_model.pkl (num_layers=4); 
score_thresh=0.1;
nms_thresh=0.3;

File                                     | Easy  | Medium | Hard
-----------------------------------------|-------|--------|------
min_500                                  | 87.6% | 82.6%  | 65.7%
min_640                                  | 91.5% | 88.6%  | 76.3%
min_800                                  | 91.5% | 89.7%  | 80.6%
min_1200                                 | 89.9% | 88.8%  | 82.4%
min_1600                                 | 89.9% | 87.9%  | 82.8%
original                                 | 92.5% | 90.1%  | 79.7%
wf_scale0                                | 92.7% | 91.3%  | 83.6%
wf_scale1                                | 92.9% | 91.7%  | 86.0%
wf_scale1 (Remove tiny boxes max < 8)    | 92.9% | 91.7%  | 86.1%
wf_scale1 (Remove tiny boxes max < 10)   | 93.1% | 91.9%  | 86.0%
wf_scale1 (Remove tiny boxes min < 10)   | 93.3% | 92.2%  | 81.6%
wf_scale1 (Remove tiny boxes min < 12)   | 93.6% | 92.5%  | 72.9%
wf_scale1 (Remove tiny boxes min < 15)   | 93.9% | 92.8%  | 62.3%
wf_scale1 (Remove tiny boxes min < 18)   | 94.2% | 92.8%  | 53.4%
wf_scale2                                | 92.2% | 91.7%  | 86.0%
wf_scale0.45 (nms_thresh=0.45)           | 92.7% | 91.6%  | 85.7%
wf_scale3_2400x2400_0.3                  | 92.8% | 91.7%  | 86.0%
wf_scale3_2400x2400_0.45                 | 92.7% | 91.6%  | 85.9%
WIDER_Val_0.3 (nms_thresh=0.3)           | 92.3% | 91.1%  | 83.0%
WIDER_Val_0.45 (nms_thresh=0.45)         | 92.1% | 90,7%  | 83.1%
(1) merge500_640                         | 91.5% | 88.2%  | 71.0%
(2) merge500_640_800_1200                | 91.8% | 90.7%  | 81.5%
(3) merge500_640_800_1200_1600           | 91.8% | 90.4%  | 83.2%
(1) mix_640_800 (filter)                 | 91.5% | 89.3%  | 75.0%
(2) mix_640_800_...1600_original(filter) | 91.8% | 91.0%  | 84.0%
(3) mix_640_800_...1600_original(filter) | 91.7% | 90.9%  | 83.9%
(3) mix_640_800_...1600_original(filter) | 91.7% | 90.9%  | 83.9%
(4) mix_640_800_...1600_original(filter) | 90.6% | 90.4%  | 83.7%
(5) mix_640_800_...1600_original(filter) | 91.8% | 91.0%  | 83.9%
(6) mix_640_800_...1600_original(filter) | 91.8% | 91.0%  | 84.0%
(7) mix_640_800_...1600_original(filter) | 92.0% | 91.1%  | 84.1%
(7) mix_640_800_...1920_original(filter) | 91.6% | 90.9%  | 84.4%

> ## The best is wf_scale1: 
> * wf_scale1: 
> 	* score_thresh=0.1, 
> 	* nms_thresh=0.3; 
> 	* scale: 0.5 -> 0.5 -> 1 -> 2. -> max_scale (including max_scale)
> * remove tiny_faces min(w, h) < 15: for detection big faces
> * keep the same for small faces.

Update on 26-Sept
* wf_scale0: score_thresh=0.1, nms_thresh=0.3; scale: 0.5 -> 0.5 -> 1 -> 2. -> max_scale (except max_scale)
* wf_scale1: score_thresh=0.1, nms_thresh=0.3; scale: 0.5 -> 0.5 -> 1 -> 2. -> max_scale (including max_scale)	
The code from predict_wf_multi_scale.py
```python
for i, img_path in enumerate(img_paths[:]):
	print('predict image index', i)
	img = load_img(img_path)

	img_name = img_path.split("/")[-1]
	event_name = img_path.split("/")[-2]
	w, h = img.size
	max_scale = (1980 * 1980 / (w * h))**(0.5)
	scale = 0.25
	img_boxes, img_scores = [], []
	b, s = flip_test(img, net, device=args.device, score_thresh=0.1,
	                              nms_thresh=0.3)
	img_boxes.append(b)
	img_scores.append(s)

	while scale < max_scale:
		scale *= 2
		scale = max_scale if scale > max_scale else scale
		b, s = scale_predict(img, net, device=args.device,
	                              scale=scale, score_thresh=0.1,
	                              nms_thresh=0.3)
		img_boxes.append(b)
		img_scores.append(s)
```
The code from scale_predict function 
```python 
	if scale <= 0.75:
		# shrink only to detect big faces
		keep_big = np.maximum(boxes[:, 2] - boxes[:, 0] + 1,
		                      boxes[:, 3] - boxes[:, 1] + 1) > 30
		index = np.where(keep_big)[0]

	if scale >= 1.5:
		# enlarge only to detect small faces
		keep_small = np.minimum(boxes[:, 2] - boxes[:, 0] + 1,
		                        boxes[:, 3] - boxes[:, 1] + 1) < 120

		index = np.where(keep_small)[0]

```
* wf_scale2: score_thresh=0.1, nms_thresh=0.3; scale: 0.25 -> 0.5 -> 1 -> 2. -> max_scale (including max_scale)

* merge (1), (2), (3) simply just concat all and then perform box_vote
* (1) mix_640_800(filter):
* (2) mix_640_800_..._original(filter):  
* mix (1) and (2) use the script below:
```python
if ratio <= 0.75:
	# shrink only to detect big faces
	if np.maximum(w, h) < 30:
		continue
if ratio >= 1.5:
	if np.minimum(w, h) > 120:
		continue
```
* (3) mix_640_800_..._original(filter): Change the ratio > 2.0 and the result reduce
```python
if ratio <= 0.75:
	# shrink only to detect big faces
	if np.maximum(w, h) < 30:
		continue
if ratio >= 2.0:
	if np.minimum(w, h) > 120:
		continue
```
* (4) mix_640_800_..._original(filter): Change the upper ratio > 1.0 and the result reduce.

* (5) mix_640_800_..._original(filter): keep upper ratio = 1.5, np.minimum > 100
```python
if ratio <= 0.75:
	# shrink only to detect big faces
	if np.maximum(w, h) < 30:
		continue
if ratio > 1.5:
	if np.minimum(w, h) > 100:
		continue
```
* (6) mix_640_800_..._original(filter): keep upper ratio = 1.5, np.minimum > 100, remove all boxes np.maximum(w, h) < 6
```python
if ratio <= 0.75:
	# shrink only to detect big faces
	if np.maximum(w, h) < 30:
		continue
if ratio > 1.5:
	if np.minimum(w, h) > 100:
		continue
if np.maximum(w, h) < 6:
	continue
```
* (6) mix_640_800_..._original(filter): The same as mix (1), mix(2) but add iou_thresh=0.45 for box_vote()
```python
for img_name in img_names:
	b, s = box_vote(merged_boxes[img_name],
	                merged_scores[img_name],
	                iou_thresh=0.45)
```

### Table of results Resnet101_New 2 layers
File     | Easy  | Medium | Hard
---------|-------|--------|-------
min_500  | 89.9% | 87.4%  | 64.2%
min_640  | 91.1% | 88.1%  | 75.0%
min_800  | 91.0% | 89.1%  | 79.6%
min_1200 | 89.6% | 89.0%  | 83.0%
min_1600 | 89.9% | 87.4%  | 81.7%
original | 92.0% | 89.5%  | 78.6%

## Resnet101_newer 3 layers
Ket qua khong ghi chep - nhung xac nhan la dung
Update 26-Sept
File     | Easy  | Medium | Hard
---------|-------|--------|-------
min_400  | 87.9% | 80.7%  | 52.9%
min_640  | 90.3% | 87.0%  | 72.0%
min_1280 | 89.9% | 87.5%  | 81.2%
min_1600 | 86.4% | 86.0%  | 80.3%
min_1920 | 82.0% | 83.0%  | 77.6%
original | 82.6% | 83.0%  | 77.6%

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


File     | Easy  | Medium | Hard
---------|-------|--------|-------
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


## Resnet_maxout

File     | Easy  | Medium | Hard
---------|-------|--------|-------
min_640  | 90.2% | 86.5%  | 69.4
min_1280 | 89.1% | 87.5%  | 80.5%
min_1600 | 87.8% |  86.4% | 79.8%
min_1920 | 82.0% | 83.0%  | 77.6%
original | 83.4% | 82.6%  | 76.1%


## FDDB Dataset

File     | Easy  
---------|-------
min_640  | 96.6%
original | 93.5%
SFD      | 98.3%
CVPR2018 | 97.5%
max_640  | 97.5%
Deepresnet max_640 | 97.9%

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

Model                             | Type       | num_layers | AFW Accuracy
----------------------------------|------------|------------|---------
Resnet101/best_val_loss_model.pkl | DeepResnet | 4          | 99.89%
Resnet101/best_val_model.pkl      | DeepResnet | 4          | 99.92%

# Deep Resnet with Maxout
```python 

import torch
import torch.nn as nn
from torchcv.models.deep_fpnresnet.fpn import DeepLabFPN101
import torch.nn.functional as F

class PredictBlock(nn.Module):
	def __init__(self, num_anchors, num_classes, dropout=0.0):
		super(PredictBlock, self).__init__()
		self.num_anchors = num_anchors
		self.num_classes = num_classes

		self.loc_head = self._make_head(self.num_anchors * 4)
		self.cls_head = self._make_head(self.num_anchors * self.num_classes)


	def _make_head(self, out_planes):
		layers = []
		'''
		Change back to previous DeepResnet model, 
		num_layers = 4
		'''
		num_layers = 3
		for _ in range(num_layers):
			layers.append(
					nn.Conv2d(256, 256, kernel_size=3, stride=1, padding=1))
			layers.append(nn.ReLU(True))
		layers.append(
				nn.Conv2d(256, out_planes, kernel_size=3, stride=1, padding=1))
		return nn.Sequential(*layers)

	def forward(self, x):
		loc_pred = self.loc_head(x)
		cls_pred = self.cls_head(x)

		loc_pred = loc_pred.permute(0, 2, 3, 1).contiguous()
		cls_pred = cls_pred.permute(0, 2, 3, 1).contiguous()
		loc_pred = loc_pred.view(loc_pred.size(0), -1, 4)
		cls_pred = cls_pred.view(cls_pred.size(0), -1, self.num_classes)
		return loc_pred, cls_pred


class DeepFPNResnet(nn.Module):
	def __init__(self, num_classes, fpn, dropout=0.0):
		super(DeepFPNResnet, self).__init__()
		self.num_anchors = [1] * 6
		self.extractor = fpn
		self.dropout = dropout

		# Freezing those layers
		frozen_layer_names = ['conv1', 'bn1']
		for frozen_layer_name in frozen_layer_names:
			frozen_layer = getattr(self.extractor, frozen_layer_name)
			for param in frozen_layer.parameters():
				param.requies_grad = False

		self.num_classes = num_classes

		self.pred_layers = nn.ModuleList()

		for i, num_anchor in enumerate(self.num_anchors):
			self.pred_layers += [PredictBlock(num_anchor, self.num_classes,
					dropout=self.dropout)]

	def forward(self, x, fm_sizes_return=False):
		loc_preds = []
		cls_preds = []
		h1, h2, h3, h4, h5, h6 = self.extractor(x)
		# print("h1.shape", h1.shape)
		# print("h2.shape", h2.shape)
		# print("h3.shape", h3.shape)
		# print("h4.shape", h4.shape)
		# print("h5.shape", h5.shape)
		# print("h6.shape", h6.shape)

		loc_pred1, cls_pred1 = self.pred_layers[0](h1)
		loc_preds.append(loc_pred1)
		cls_preds.append(cls_pred1)

		loc_pred2, cls_pred2 = self.pred_layers[1](h2)
		loc_preds.append(loc_pred2)
		cls_preds.append(cls_pred2)

		loc_pred3, cls_pred3 = self.pred_layers[2](h3)
		loc_preds.append(loc_pred3)
		cls_preds.append(cls_pred3)

		loc_pred4, cls_pred4 = self.pred_layers[3](h4)
		loc_preds.append(loc_pred4)
		cls_preds.append(cls_pred4)

		loc_pred5, cls_pred5 = self.pred_layers[4](h5)
		loc_preds.append(loc_pred5)
		cls_preds.append(cls_pred5)

		loc_pred6, cls_pred6 = self.pred_layers[5](h6)
		loc_preds.append(loc_pred6)
		cls_preds.append(cls_pred6)

		loc_preds = torch.cat(loc_preds, 1)  # []
		cls_preds = torch.cat(cls_preds, 1)  # []

		# print("loc_preds", loc_preds.size())
		# print("cls_preds", cls_preds.size())

		if fm_sizes_return == True:
			fm_sizes = [h1.size()[-2:], h2.size()[-2:], h3.size()[-2:],
			            h4.size()[-2:], h5.size()[-2:], h6.size()[-2:]]
			return loc_preds, cls_preds, fm_sizes

		return loc_preds, cls_preds


class WrapModel(nn.Module):
	def __init__(self, num_classes, fpn):
		super(WrapModel, self).__init__()
		self.module = DeepFPNResnet(num_classes=num_classes, fpn=fpn)

	def forward(self, x, fm_sizes_return=False):
		return self.module(x, fm_sizes_return=fm_sizes_return)


def get_model(model_path=None, device='cuda', parallel=False):

	fpn = DeepLabFPN101()

	if parallel:
		net = DeepFPNResnet(num_classes=2, fpn=fpn)
		net = torch.nn.DataParallel(net)
	else:
		net = WrapModel(num_classes=2, fpn=fpn)

	net = net.to(device)


	if model_path is None or model_path == "":
		start_epoch = 0
		return net, start_epoch

	else:
		state_dict = torch.load(model_path, map_location={'cuda:0' : device})
		start_epoch = state_dict['epoch']
		params_tensors = state_dict['net']
		net.load_state_dict(params_tensors)
		print(f"[INFO] --load pretrained model: {model_path}", end=" | ")
		print(f"train_loss: {state_dict['loss']:.2f}", end=" | ")
		print(f"epoch: {start_epoch}")
		return net, start_epoch


class Rectifier(nn.Module):

	def __init__(self):
		super(Rectifier, self).__init__()
		# 28 -> 14 -> 7 -> 3 -> 1
		self.conv1 = nn.Conv2d(3, 16, kernel_size=7, stride=1, padding=1)
		self.conv2 = nn.Conv2d(16, 32, kernel_size=3, stride=1, padding=1)
		self.conv3 = nn.Conv2d(32, 16, kernel_size=3, stride=1, padding=1)
		self.conv4 = nn.Conv2d(16, 2, kernel_size=3, stride=1, padding=1)

	def forward(self, x):
		h = self.conv1(x)
		h = F.max_pool2d(F.relu(h), kernel_size=2, stride=2)
		h = self.conv2(h)
		h = F.max_pool2d(F.relu(h), kernel_size=2, stride=2)
		h = self.conv3(h)
		print("conv3", h.size())
		h = F.max_pool2d(F.relu(h), kernel_size=2, stride=2)
		h = self.conv4(h)
		print("conv4", h.size())
		h = F.max_pool2d(F.relu(h), kernel_size=2, stride=2)
		return h
```

