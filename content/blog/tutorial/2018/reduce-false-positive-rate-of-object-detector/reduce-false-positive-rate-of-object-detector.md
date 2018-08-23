Title: Reduce false positive rate of Object Detector
Slug: reduce-false-positive-rate-of-object-detector
Date: 2018-08-23 00:52:57
Tags: Ojbect Detection, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no


# What are the best methods for reducing false positives using tensorflow's object detection framework?

I am training a single object detector with mask rcnn and I have tried several methods for reducing false positives. I started with a few thousand examples of images of the object with bounding boxes and trained that, got decent results, but when running on images that don't contain that object, would often get false matches with high confidence (sometimes .99).

The first thing I tried was adding the hard example miner in the config file. I believe I did this correctly because I added a print statement to ensure the object gets created. However none of the configs for faster rcnn have hard example mining in them. So I am suspicious that the miner only works correctly for ssd. I would expect a noticeable improvement with a hard example miner but I did not see it

The second thing I tried was to add "background" images. I set the minimum number of negatives to a non-zero value in the hard example miner config and added tons of background images that previously got false detections as part of the training. I even added these images into the tfrecords file so that it would be balanced evenly with images that do have the object. This approach actually made things worse - and gave me more false detections

The last thing I tried was creating another category, called "object-background" and took all the false matches and assigned them to this new category. This approach worked pretty well, but I view it as a hack.

I guess to summarize my main question is - what is the best method for reducing false positives within the current tensorflow object detection framework? Would SSD be a better approach since that seems to have a hard example miner built into it by default in the configs?

thanks
## Answer
in the tensorflow github, they advise to ask questions on stackoverflow. There are well known methods for reducing false positives (such as the mentioned hard example mining - ohem) but there doesn't seem to be a lot of documentation on using it

## His finding
After some more investigation I actually was able to get the hard example miner with faster rcnn working. I had a bug where I wasn't actually inserting background images into the tf records file.

I think when training a single object detector (category with one model) it's most crucial to add background images if you want to have good precision/recall. If you just have a few thousand examples of the object, that won't be nearly enough images for the model to learn all the various background noise you will be sending when actually using the model for your application

# Object detection : hard negatives.

https://github.com/tensorflow/models/issues/2544

I am currently using object detection on my own dataset, for some of my classes, i have a lot of false positives with high scores (>0.99, so having a higher score threshold won't help).

I know there is already some hard negative mining implemented ,but would it be possible to have a feature where one could add hard negatives examples to the training ?

Let's say we want to detect object A, and we know that object A look a lot like object B, but we are not interested in detecting, object B , in that case we could add images of object B to training (without any bounding boxes) in order for the network to distinguish between A and B.

## Answer
Depends on what network you are using, I guess.

For example, Faster R-CNN considers as negative boxes those which have IoU under a certain threshold (0.3 by default, I think). And then it takes as many negative examples as positive ones (this is configurable, I think).
So basically, if you have your object B in images with A as well, and it is not labeled, it is some chance that it will be considered as a negative.

To be more certain, I guess you could use object classification (detecting both A and B) and then only keep the objects A.
This should work a bit better, because it tries to regress the class difference to be as big as possible.

## Answer
Hello, I guess I have a similar/same problem. Using the InceptionV2-SSD model, and the model gives me great precision and recall on test set that contains at least one of the classes that I am interested in. But as soon as I add some images which do not contain any of my classes, I start getting false positives. Tried training with these images and provided an empty array in place of the truth data boxes. This did not seem to help.

It would be nice to get answers to two questions (1) Is this an existing problem in the code, or am I doing something wrong here. (2) Is there a recommended solution other than adding another classifier? Would something like modifying the loss functions to take these examples into account work?

Thanks!

## Answer
@niyazpk Sorry, I should have been more specific. You need to set min_negatives_per_image to a non zero number in the config for the model to sample boxes from purely negative images: https://github.com/tensorflow/models/blob/master/research/object_detection/samples/configs/ssd_inception_v2_coco.config#L118 . Few 10s might be a good number to choose.

@OverFlow7 , You can have purely negative images and faster_rcnn models will sample from anchors from them. We use sampling in both stages with a certain ratio of positives to negatives. If the sampler can't achieve that ratio ( in purely negative images), it fills the batch with negatives. See https://github.com/tensorflow/models/blob/master/research/object_detection/core/balanced_positive_negative_sampler.py#L18

## Answer
I feel this discussion might benefit others if do it on stackoverflow. Can you please move the discussion there if my response does not sufficiently answer your question alreadt. I will close this issue for now.

But how do you create tfrecords with purely negative images? what do you put in the .xml?


# Some notes 
Hi !
For the scaling, the idea is try to scale such that all error terms (classification + position + size) have roughly the same scaling. Otherwise, the training would tend to over-optimise one component and not the others.

Exactly, the negative values are used to mark the anchors with no annotations. The idea comes from the KITTI dataset where some part of the dataset images are signaled as being not labelled : there may be a car/person/... in these parts, but it has not been segmented. If you don't keep track of these parts, you may end up with the SSD model detecting objects not annotated, and the loss function thinking it is False positive, and pushing for not detecting it. Which is not really what we want !
So basically, I set up a mask such that the loss function ignores the anchors which overlap too much with parts of images no-annotated.
Hope it is a bit more clear! I guess I should add a bit of documentation about that!


# Revisit Faster R-CNN

https://arxiv.org/pdf/1803.06799.pdf

## Abstract

In this paper, we analyze failure cases of state-ofthe-art detectors and observe that `most hard false positives` result from `classification` instead of localization.

**3 problems** :

1. Shared feature representation is not optimal due to the mismatched goals of feature learning for classification and localization.

2. Multi-task learning helps, yet optimization of the multi-task loss may result in sub-optimal for individual tasks.

3. Large receptive field for different scales leads to redundant context information for small objects.  

**Solution**: We demonstrate the potential of detector classification power by a simple, effective, and widely-applicable Decoupled Classification Refinement (DCR) network. DCR samples hard false positives from the base classifier in Faster RCNN and trains a RCNN-styled strong classifier.

## Introduction

![]({attach}fig1.png)
*Fig.1 (a) Comparison of the number of false positives in different ranges. (b) Comparison of the mAP gains by progressively removing false positives; from right to left, the detector is performing better as false positives are removed according to their confidence scores.*


To answer this question, in this paper, we begin with investigating the key
factors affecting the performance of Faster RCNN. 

