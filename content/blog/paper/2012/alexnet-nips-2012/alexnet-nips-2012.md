Title: Alexnet NIPS 2012
Slug: alexnet-nips-2012
Date: 2018-08-15 18:06:40
Tags: Image Recognition, Alexnet, CNN, ImageNet, 2012, PAPER
Author: Quang Nguyen
Category: paper
TopPost: no


# Abstract
----------
- Published on NIPS 2012. 
- Pdf version can be found in dropbox here. 
- SOTA in ImageNet 2012 with top-5 error rate 15.3%.
- Use `dropout`, `relu`.
# Introduction
----------
1. CNN: `conv` layers have much fewer connections & params, and so easier to train.
2. Dataset: Imagenet contains enough labeled examples → can train without severe overfitting.
3. Train Alexnet takes 5-6 days with 2 GPUs 3GB. 
Dataset
----------
- ImageNet 1.2 million high-resolution images with 1000 classes.
- Two error rates:
  - Top-5 error rate
  - Top-1 error rate
- The size of the images to be trained: smaller size → 256, then crop the center patch: 256x256.
Architecture
----------
- 60 million params with 650,000 neurons.
- 5 `conv` layers, 3 `fc` layers.


![Error rate w.r.t epochs on CIFAR10. The dash line is of tanh while the solid line is of relu.](https://d2mxuefqeaa7sj.cloudfront.net/s_6EF601BE07E17A98BF97AB239E543B35D29C3B4B9D1871E11707DB6D0C2C3533_1533070511862_image.png)


Relu

- non-saturating nonlinearity → converge faster
- easy to train - no exponential computations.
- one of the best choice of activation function.


Local Reponse Normalization





# Specific notes
----------



# TLDR: Code
Below are two version implemented in Pytorch and Tensorflow.

## The Pytorch code of AlexNet.

> The dropout_rate = 0.5, it’s the default value in Pytorch implementation of `dropout`


    class AlexNet(nn.Module):
    
        def __init__(self, num_classes=1000):
            super(AlexNet, self).__init__()
            self.features = nn.Sequential(
                nn.Conv2d(3, 64, kernel_size=11, stride=4, padding=2),
                nn.ReLU(inplace=True),
                nn.MaxPool2d(kernel_size=3, stride=2),
                nn.Conv2d(64, 192, kernel_size=5, padding=2),
                nn.ReLU(inplace=True),
                nn.MaxPool2d(kernel_size=3, stride=2),
                nn.Conv2d(192, 384, kernel_size=3, padding=1),
                nn.ReLU(inplace=True),
                nn.Conv2d(384, 256, kernel_size=3, padding=1),
                nn.ReLU(inplace=True),
                nn.Conv2d(256, 256, kernel_size=3, padding=1),
                nn.ReLU(inplace=True),
                nn.MaxPool2d(kernel_size=3, stride=2),
            )
            self.classifier = nn.Sequential(
                nn.Dropout(),
                nn.Linear(256 * 6 * 6, 4096),
                nn.ReLU(inplace=True),
                nn.Dropout(),
                nn.Linear(4096, 4096),
                nn.ReLU(inplace=True),
                nn.Linear(4096, num_classes),
            )
    
        def forward(self, x):
            x = self.features(x)
            x = x.view(x.size(0), 256 * 6 * 6)
            x = self.classifier(x)
            return x

## Tensorflow Implementation with slim

<DIV class="alert alert-success" role="alert" markdown="1">

* All the fully connected layers have been transformed to conv2d layers

* To use in classification mode, resize input to `224x224` or set `global_pool = True`.

* LRN layers have been removed 

* Change the initializers from `random_normal_initializer` to `xavier_initializer`.

</DIV>


```python
import tensorflow as tf

slim = tf.contrib.slim
trunc_normal = lambda stddev: tf.truncated_normal_initializer(0.0, stddev)


def alexnet_v2_arg_scope(weight_decay=0.0005):
    with slim.arg_scope([slim.conv2d, slim.fully_connected],
                        activation_fn=tf.nn.relu,
                        biases_initializer=tf.constant_initializer(0.1),
                        weights_regularizer=slim.l2_regularizer(weight_decay)):
    with slim.arg_scope([slim.conv2d], padding='SAME'):
        with slim.arg_scope([slim.max_pool2d], padding='VALID') as arg_sc:
        return arg_sc


def alexnet_v2(inputs,
                num_classes=1000,
                is_training=True,
                dropout_keep_prob=0.5,
                spatial_squeeze=True,
                scope='alexnet_v2',
                global_pool=False):
    """AlexNet version 2.
    Described in: http://arxiv.org/pdf/1404.5997v2.pdf
    Parameters from:
    github.com/akrizhevsky/cuda-convnet2/blob/master/layers/
    layers-imagenet-1gpu.cfg
    Note: All the fully_connected layers have been transformed to conv2d layers.
        To use in classification mode, resize input to 224x224 or set
        global_pool=True. To use in fully convolutional mode, set
        spatial_squeeze to false.
        The LRN layers have been removed and change the initializers from
        random_normal_initializer to xavier_initializer.
    Args:
    inputs: a tensor of size [batch_size, height, width, channels].
    num_classes: the number of predicted classes. If 0 or None, the logits layer
    is omitted and the input features to the logits layer are returned instead.
    is_training: whether or not the model is being trained.
    dropout_keep_prob: the probability that activations are kept in the dropout
        layers during training.
    spatial_squeeze: whether or not should squeeze the spatial dimensions of the
        logits. Useful to remove unnecessary dimensions for classification.
    scope: Optional scope for the variables.
    global_pool: Optional boolean flag. If True, the input to the classification
        layer is avgpooled to size 1x1, for any input size. (This is not part
        of the original AlexNet.)
    Returns:
    net: the output of the logits layer (if num_classes is a non-zero integer),
        or the non-dropped-out input to the logits layer (if num_classes is 0
        or None).
    end_points: a dict of tensors with intermediate activations.
    """
    with tf.variable_scope(scope, 'alexnet_v2', [inputs]) as sc:
    end_points_collection = sc.original_name_scope + '_end_points'
    # Collect outputs for conv2d, fully_connected and max_pool2d.
    with slim.arg_scope([slim.conv2d, slim.fully_connected, slim.max_pool2d],
                        outputs_collections=[end_points_collection]):
        net = slim.conv2d(inputs, 64, [11, 11], 4, padding='VALID',
                        scope='conv1')
        net = slim.max_pool2d(net, [3, 3], 2, scope='pool1')
        net = slim.conv2d(net, 192, [5, 5], scope='conv2')
        net = slim.max_pool2d(net, [3, 3], 2, scope='pool2')
        net = slim.conv2d(net, 384, [3, 3], scope='conv3')
        net = slim.conv2d(net, 384, [3, 3], scope='conv4')
        net = slim.conv2d(net, 256, [3, 3], scope='conv5')
        net = slim.max_pool2d(net, [3, 3], 2, scope='pool5')

        # Use conv2d instead of fully_connected layers.
        with slim.arg_scope([slim.conv2d],
                            weights_initializer=trunc_normal(0.005),
                            biases_initializer=tf.constant_initializer(0.1)):
        net = slim.conv2d(net, 4096, [5, 5], padding='VALID',
                            scope='fc6')
        net = slim.dropout(net, dropout_keep_prob, is_training=is_training,
                            scope='dropout6')
        net = slim.conv2d(net, 4096, [1, 1], scope='fc7')
        # Convert end_points_collection into a end_point dict.
        end_points = slim.utils.convert_collection_to_dict(
            end_points_collection)
        if global_pool:
            net = tf.reduce_mean(net, [1, 2], keep_dims=True, name='global_pool')
            end_points['global_pool'] = net
        if num_classes:
            net = slim.dropout(net, dropout_keep_prob, is_training=is_training,
                                scope='dropout7')
            net = slim.conv2d(net, num_classes, [1, 1],
                            activation_fn=None,
                            normalizer_fn=None,
                            biases_initializer=tf.zeros_initializer(),
                            scope='fc8')
            if spatial_squeeze:
            net = tf.squeeze(net, [1, 2], name='fc8/squeezed')
            end_points[sc.name + '/fc8'] = net
        return net, end_points
alexnet_v2.default_image_size = 224
```