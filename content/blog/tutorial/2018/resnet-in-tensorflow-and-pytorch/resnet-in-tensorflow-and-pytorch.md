Title: Resnet in Tensorflow and Pytorch
Slug: resnet-in-tensorflow-and-pytorch
Date: 2018-08-22 15:47:37
Tags: Resnet, Tensorflow, Pytorch, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no

The Resnet paper can be found at [arxiv](https://arxiv.org/pdf/1512.03385.pdf).

# Resnet in different frameworks

Framework   | Pytorch                                | Pytorch Stride | Tensorflow                             | Tensorflow Stride
------------|----------------------------------------|----------------|----------------------------------------|------------------
Input shape | [batch, channels, height_in, width_in] |                | [batch, height_in, width_in, channels] |
Input       | (1, 3, 640, 640)                       |                | (1, 640, 640, 3)                       |
Block 1     | (1, 256, 160, 160)                     | 1              | (1, 80, 80, 256)                       | 2
Block 2     | (1, 512, 80, 80)                       | 2              | (1, 40, 40, 512)                       | 2
Block 3     | (1, 1024, 40, 40)                      | 2              | (1, 20, 20, 1024)                      | 2
Block 4     | (1, 2048, 20, 20)                      | 2              | (1, 20, 20, 2048)                      | 1

# Resnet Architecture

Block   | Base depth | Resnet50 | Resnet101 | Output Depth
--------|------------|----------|-----------|--------------
Block 1 | 64         | 3        | 3         | 256
Block 2 | 128        | 4        | 4         | 512
Block 3 | 256        | 6        | 23        | 1024
Block 4 | 512        | 3        | 3         | 2048

# Tensorflow Architecture
## Prepare the image inputs

```python
import numpy as np
import os.path as osp
from PIL import Image

import tensorflow as tf
import resnet as resnet_v1
from tensorflow.contrib import layers
import tensorflow.contrib.slim as slim


home_path = osp.expanduser("~/")
WIDTH, HEIGHT =  640, 640
IMG_PATH = osp.join(home_path, 'Pictures/Hien.jpg')


def get_img(img_path):
	img = Image.open(img_path)
	img = img.resize((WIDTH, HEIGHT))
	img = np.array(img)
	img = np.expand_dims(img, axis=0)
	return img
img = get_img(IMG_PATH)
```
## Create and Restore the Graph
```python

# Create resnet graph
inputs = tf.placeholder(tf.float32, shape=[None, HEIGHT, WIDTH, 3])
with slim.arg_scope(resnet_v1.resnet_arg_scope()):
	net, end_points = resnet_v1.resnet_v1_...(inputs, num_classes=1000, is_training=False)

# Load the resnet graph to the session
saver = tf.train.Saver()
sess = tf.Session()

RESNET_..._PATH = 'path/to/resnet/weights.ckpt'
saver.restore(sess, RESNET_..._PATH)
```

## The output of `resnet_v1`




```python
net, end_points = resnet_v1.resnet_v1_50(inputs, num_classes=1000, is_training=False)
```
* `net` is the final `logits` values.
* `end_points` is a dictionary of `key_name` and `feature_maps` at each layer.

If we run the lines:
```python
# Run the graph session
features = sess.run(end_points, {'Placeholder:0': img})
keys = features.keys()
for key in keys:
	print(f"{key:60}", features[key].shape)
```
Then we get the output like below:
```bash
# end_points

resnet_v1_50/conv1                                           (1, 320, 320, 64)
resnet_v1_50/block1/unit_1/bottleneck_v1/shortcut            (1, 160, 160, 256)
resnet_v1_50/block1/unit_1/bottleneck_v1/conv1               (1, 160, 160, 64)
resnet_v1_50/block1/unit_1/bottleneck_v1/conv2               (1, 160, 160, 64)
resnet_v1_50/block1/unit_1/bottleneck_v1/conv3               (1, 160, 160, 256)
resnet_v1_50/block1/unit_1/bottleneck_v1                     (1, 160, 160, 256)
resnet_v1_50/block1/unit_2/bottleneck_v1/conv1               (1, 160, 160, 64)
resnet_v1_50/block1/unit_2/bottleneck_v1/conv2               (1, 160, 160, 64)
resnet_v1_50/block1/unit_2/bottleneck_v1/conv3               (1, 160, 160, 256)
resnet_v1_50/block1/unit_2/bottleneck_v1                     (1, 160, 160, 256)
resnet_v1_50/block1/unit_3/bottleneck_v1/conv1               (1, 160, 160, 64)
resnet_v1_50/block1/unit_3/bottleneck_v1/conv2               (1, 80, 80, 64)
resnet_v1_50/block1/unit_3/bottleneck_v1/conv3               (1, 80, 80, 256)
resnet_v1_50/block1/unit_3/bottleneck_v1                     (1, 80, 80, 256)
resnet_v1_50/block1                                          (1, 80, 80, 256)
resnet_v1_50/block2/unit_1/bottleneck_v1/shortcut            (1, 80, 80, 512)
resnet_v1_50/block2/unit_1/bottleneck_v1/conv1               (1, 80, 80, 128)
resnet_v1_50/block2/unit_1/bottleneck_v1/conv2               (1, 80, 80, 128)
resnet_v1_50/block2/unit_1/bottleneck_v1/conv3               (1, 80, 80, 512)
resnet_v1_50/block2/unit_1/bottleneck_v1                     (1, 80, 80, 512)
resnet_v1_50/block2/unit_2/bottleneck_v1/conv1               (1, 80, 80, 128)
resnet_v1_50/block2/unit_2/bottleneck_v1/conv2               (1, 80, 80, 128)
resnet_v1_50/block2/unit_2/bottleneck_v1/conv3               (1, 80, 80, 512)
resnet_v1_50/block2/unit_2/bottleneck_v1                     (1, 80, 80, 512)
resnet_v1_50/block2/unit_3/bottleneck_v1/conv1               (1, 80, 80, 128)
resnet_v1_50/block2/unit_3/bottleneck_v1/conv2               (1, 80, 80, 128)
resnet_v1_50/block2/unit_3/bottleneck_v1/conv3               (1, 80, 80, 512)
resnet_v1_50/block2/unit_3/bottleneck_v1                     (1, 80, 80, 512)
resnet_v1_50/block2/unit_4/bottleneck_v1/conv1               (1, 80, 80, 128)
resnet_v1_50/block2/unit_4/bottleneck_v1/conv2               (1, 40, 40, 128)
resnet_v1_50/block2/unit_4/bottleneck_v1/conv3               (1, 40, 40, 512)
resnet_v1_50/block2/unit_4/bottleneck_v1                     (1, 40, 40, 512)
resnet_v1_50/block2                                          (1, 40, 40, 512)
resnet_v1_50/block3/unit_1/bottleneck_v1/shortcut            (1, 40, 40, 1024)
resnet_v1_50/block3/unit_1/bottleneck_v1/conv1               (1, 40, 40, 256)
resnet_v1_50/block3/unit_1/bottleneck_v1/conv2               (1, 40, 40, 256)
resnet_v1_50/block3/unit_1/bottleneck_v1/conv3               (1, 40, 40, 1024)
resnet_v1_50/block3/unit_1/bottleneck_v1                     (1, 40, 40, 1024)
resnet_v1_50/block3/unit_2/bottleneck_v1/conv1               (1, 40, 40, 256)
resnet_v1_50/block3/unit_2/bottleneck_v1/conv2               (1, 40, 40, 256)
resnet_v1_50/block3/unit_2/bottleneck_v1/conv3               (1, 40, 40, 1024)
resnet_v1_50/block3/unit_2/bottleneck_v1                     (1, 40, 40, 1024)
resnet_v1_50/block3/unit_3/bottleneck_v1/conv1               (1, 40, 40, 256)
resnet_v1_50/block3/unit_3/bottleneck_v1/conv2               (1, 40, 40, 256)
resnet_v1_50/block3/unit_3/bottleneck_v1/conv3               (1, 40, 40, 1024)
resnet_v1_50/block3/unit_3/bottleneck_v1                     (1, 40, 40, 1024)
resnet_v1_50/block3/unit_4/bottleneck_v1/conv1               (1, 40, 40, 256)
resnet_v1_50/block3/unit_4/bottleneck_v1/conv2               (1, 40, 40, 256)
resnet_v1_50/block3/unit_4/bottleneck_v1/conv3               (1, 40, 40, 1024)
resnet_v1_50/block3/unit_4/bottleneck_v1                     (1, 40, 40, 1024)
resnet_v1_50/block3/unit_5/bottleneck_v1/conv1               (1, 40, 40, 256)
resnet_v1_50/block3/unit_5/bottleneck_v1/conv2               (1, 40, 40, 256)
resnet_v1_50/block3/unit_5/bottleneck_v1/conv3               (1, 40, 40, 1024)
resnet_v1_50/block3/unit_5/bottleneck_v1                     (1, 40, 40, 1024)
resnet_v1_50/block3/unit_6/bottleneck_v1/conv1               (1, 40, 40, 256)
resnet_v1_50/block3/unit_6/bottleneck_v1/conv2               (1, 20, 20, 256)
resnet_v1_50/block3/unit_6/bottleneck_v1/conv3               (1, 20, 20, 1024)
resnet_v1_50/block3/unit_6/bottleneck_v1                     (1, 20, 20, 1024)
resnet_v1_50/block3                                          (1, 20, 20, 1024)
resnet_v1_50/block4/unit_1/bottleneck_v1/shortcut            (1, 20, 20, 2048)
resnet_v1_50/block4/unit_1/bottleneck_v1/conv1               (1, 20, 20, 512)
resnet_v1_50/block4/unit_1/bottleneck_v1/conv2               (1, 20, 20, 512)
resnet_v1_50/block4/unit_1/bottleneck_v1/conv3               (1, 20, 20, 2048)
resnet_v1_50/block4/unit_1/bottleneck_v1                     (1, 20, 20, 2048)
resnet_v1_50/block4/unit_2/bottleneck_v1/conv1               (1, 20, 20, 512)
resnet_v1_50/block4/unit_2/bottleneck_v1/conv2               (1, 20, 20, 512)
resnet_v1_50/block4/unit_2/bottleneck_v1/conv3               (1, 20, 20, 2048)
resnet_v1_50/block4/unit_2/bottleneck_v1                     (1, 20, 20, 2048)
resnet_v1_50/block4/unit_3/bottleneck_v1/conv1               (1, 20, 20, 512)
resnet_v1_50/block4/unit_3/bottleneck_v1/conv2               (1, 20, 20, 512)
resnet_v1_50/block4/unit_3/bottleneck_v1/conv3               (1, 20, 20, 2048)
resnet_v1_50/block4/unit_3/bottleneck_v1                     (1, 20, 20, 2048)
resnet_v1_50/block4                                          (1, 20, 20, 2048)
resnet_v1_50/logits                                          (1, 1, 1, 1000)
predictions                                                  (1, 1, 1, 1000)

```



## Resnet50 Feature Maps


```python
resnet50_fm_names = [
	"resnet_v1_50/block1/unit_2/bottleneck_v1",
	"resnet_v1_50/block2/unit_3/bottleneck_v1",
	"resnet_v1_50/block3/unit_4/bottleneck_v1",
	"resnet_v1_50/block4",
	]

resnet50_fm_fpn_sizes = [
	(1, 160, 160, 256),
	(1, 80, 80, 512),
	(1, 40, 40, 1024),
	(1, 20, 20, 2048),
	]
```


## Resnet for SSD


```python
def predictBlock(inputs, num_anchors, num_classes):

	loc_pred = slim.layers.conv2d(inputs, num_outputs=num_anchors*4,
																kernel_size=3, padding='SAME')
	cls_pred = slim.layers.conv2d(inputs, num_outputs=num_anchors*num_classes,
																kernel_size=3, padding='SAME')

	# loc_pred = [None, h, w, num_anchors*4]
	# -> reshape [None, h*w*num_anchors, 4]
	num_inputs = loc_pred.get_shape().as_list()
	h_w_num_anchors = num_inputs[1] * num_inputs[2] * num_anchors
	loc_pred = tf.reshape(loc_pred, [-1, h_w_num_anchors, 4])

	# loc_pred = [None, h, w, num_anchors*num_classes]
	# -> reshape [None, h*w*num_anchors, num_classes]
	cls_pred = tf.reshape(loc_pred, [-1, h_w_num_anchors, num_classes])
	return loc_pred, cls_pred
```

And the final `resnet` with `prediction block`.

```python
def resnet50():
	num_anchors = [1, 1, 1, 1]
	num_classes = 2

	# Create resnet50 graph
	inputs = tf.placeholder(tf.float32, shape=[None, HEIGHT, WIDTH, 3])
	with slim.arg_scope(resnet_v1.resnet_arg_scope()):
		net, end_points = resnet_v1.resnet_v1_50(inputs, num_classes=1000, is_training=False)

	resnet50_fm_names = [
		"resnet_v1_50/block1/unit_2/bottleneck_v1",
		"resnet_v1_50/block2/unit_3/bottleneck_v1",
		"resnet_v1_50/block3/unit_4/bottleneck_v1",
		"resnet_v1_50/block4",
		]
	fm_points = []
	for key in resnet50_fm_names:
		print(end_points[key])
		fm_points.append(end_points[key])

	loc_pred1, cls_pred1 = predictBlock(fm_points[0], num_anchors[0], num_classes)
	loc_pred2, cls_pred2 = predictBlock(fm_points[1], num_anchors[1], num_classes)
	loc_pred3, cls_pred3 = predictBlock(fm_points[2], num_anchors[2], num_classes)
	loc_pred4, cls_pred4 = predictBlock(fm_points[3], num_anchors[3], num_classes)

	loc_preds = [loc_pred1, loc_pred2, loc_pred3, loc_pred4]
	cls_preds = [cls_pred1, cls_pred2, cls_pred3, cls_pred4]

	for i in range(4):
		print("loc_pred", i, loc_preds[i])
		print("cls_pred", i, cls_preds[i])

	loc_preds = tf.concat(loc_preds, axis=1)
	cls_preds = tf.concat(cls_preds, axis=1)

	return loc_preds, cls_preds

resnet50()
```

