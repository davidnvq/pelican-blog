Title: How to use models in slim
Slug: how-to-use-models-in-slim
Date: 2018-08-15 22:13:53
Tags: Tensorflow, Slim, Fine-tuning, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no


# Introduction

This guide to use `slim` for Image Classification and Image Annotation and Segmentation. Find this tutorial here.


- `slim` library was released with a set of standard models like ResNet-v1, VGG, Inception-Resnet-v2, Resnet-v2, Inception and so on.


- The pretrained models are supported by Google → much better. 
- `slim` is very clean and lightweight wrapper around Tensorflow. 
# Setup

## Clone the slim
```bash    
git clone https://github.com/tensorflow/models
```
## Add the path to the slim library in order to use `datasets` or some modules.

```python
import sys
import os.path as osp
sys.path.append('path/to/models/research/slim/')
```

# Download the models

Download the pretrained models from here. 
```python
import tensorflow as tf
from datasets import dataset_utils
url = "http://download.tensorflow.org/models/vgg_16_2016_08_28.tar.gz"

checkpoints_dir = '/content/pretrained_models/'
if not osp.exists(checkpoints_dir):
    os.makedirs(checkpoint_dir)

dataset_utils.download_and_uncompress_tarball(url, checkpoints_dir)
```

# Preprocess the image

- Subtract image by mean
- expand 1 image into a batch of 1.

```python
from matplotlib import pyplot as plt
import tensorflow as tf
import numpy as np
import os

image_path = 'url/image.jpg'

def get_img(img_path, width=320, height=320, offline=False):
    if not offline:
    img_raw = requests.get(img_path, stream=True).raw
    img = Image.open(img_raw)
    if offline:
    img = Image.open(img_path)
    img = img.resize((WIDTH, HEIGHT))
    img = np.array(img)
    img = img - np.array([_R_MEAN, _G_MEAN, _B_MEAN])
    img = np.expand_dims(img, axis=0)
    return img
```

# Define the model and get the prediction
## Create the graph
```python
HOME_PATH = osp.expanduser("~/")
IMG_PATH = osp.join(HOME_PATH, 'Pictures/Hien.jpg')
RESNET_50_PATH = osp.join(HOME_PATH, 'Result/pretrained-Resnet-Tensorflow/resnet_v1_50.ckpt')

inputs = tf.placeholder(tf.float32, shape=[None, None, None, 3])
with slim.arg_scope(resnet_v1.resnet_arg_scope()):
    logits, end_points = resnet_v1.resnet_v1_50(inputs, num_classes=1000,
                        global_pool=True,
                        is_training=False)
    probabilities = tf.nn.softmax(logits)
```

## Load the pretrained weights
```python
sess = tf.Session()
saver = tf.train.Saver()
saver.restore(sess, RESNET_50_PATH)
```
## Make a prediction

```python
def predict(sess, img):
    prob = sess.run(probabilities, {'Placeholder:0': img})
    prob = prob[0, 0, 0, 0:]
    sorted_indices = [i[0] for i in sorted(enumerate(-prob),
                    key=lambda x: x[1])]
    return prob, sorted_indices
```

## Decode the name of the labels in 1000 classes
```python
# Decode the labels name
def decode_result(probabilities, sorted_idx):
    names = imagenet.create_readable_names_for_imagenet_labels()
    for i in range(5):
    index = sorted_idx[i]
    print('Probability %0.2f => [%s]' % (probabilities[index], names[index+1]))
```
  
# Test with an example image
```python
img_path = '/Users/quanguet/Pictures/cat.jpg'
img = get_img(img_path, offline='True')
prob, idx = predict(sess, img)
decode_result(prob, idx)
```

# All in one program
The full code is below.

```python
import sys
import os.path as osp
sys.path.append('path/to/models/research/slim/')

import tensorflow as tf
from datasets import dataset_utils
url = "http://download.tensorflow.org/models/vgg_16_2016_08_28.tar.gz"

# Download the model
checkpoints_dir = '/content/pretrained_models/'
if not osp.exists(checkpoints_dir):
    os.makedirs(checkpoint_dir)

dataset_utils.download_and_uncompress_tarball(url, checkpoints_dir)

# Preprocess the images
from matplotlib import pyplot as plt
import tensorflow as tf
import numpy as np
import os

image_path = 'url/image.jpg'

def get_img(img_path, width=320, height=320, offline=False):
    if not offline:
    img_raw = requests.get(img_path, stream=True).raw
    img = Image.open(img_raw)
    if offline:
    img = Image.open(img_path)
    img = img.resize((WIDTH, HEIGHT))
    img = np.array(img)
    img = img - np.array([_R_MEAN, _G_MEAN, _B_MEAN])
    img = np.expand_dims(img, axis=0)
    return img

# Create the graph
HOME_PATH = osp.expanduser("~/")
IMG_PATH = osp.join(HOME_PATH, 'Pictures/Hien.jpg')
RESNET_50_PATH = osp.join(HOME_PATH, 'Result/pretrained-Resnet-Tensorflow/resnet_v1_50.ckpt')

inputs = tf.placeholder(tf.float32, shape=[None, None, None, 3])
with slim.arg_scope(resnet_v1.resnet_arg_scope()):
    logits, end_points = resnet_v1.resnet_v1_50(inputs, num_classes=1000,
                        global_pool=True,
                        is_training=False)
    probabilities = tf.nn.softmax(logits)

# Load the pretrained weights
sess = tf.Session()
saver = tf.train.Saver()
saver.restore(sess, RESNET_50_PATH)

# Make a prediction
def predict(sess, img):
    prob = sess.run(probabilities, {'Placeholder:0': img})
    prob = prob[0, 0, 0, 0:]
    sorted_indices = [i[0] for i in sorted(enumerate(-prob),
                    key=lambda x: x[1])]
    return prob, sorted_indices


# Decode the labels name
def decode_result(probabilities, sorted_idx):
    names = imagenet.create_readable_names_for_imagenet_labels()
    for i in range(5):
    index = sorted_idx[i]
    print('Probability %0.2f => [%s]' % (probabilities[index], names[index+1]))
```