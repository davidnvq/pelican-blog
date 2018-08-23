Title: CIFAR-10 with Resnet
Slug: cifar-10-with-resnet
Date: 2018-08-22 16:38:10
Tags: Resnet, Cifar10, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no

# Tensorflow
The [official tensorflow resnet cifar-10](https://github.com/tensorflow/models/tree/master/official/resnet), with --resnet_size=110, hits 93.96%, (beating the reference value of 93.39%).

Resnet for cifar10 and imagenet look a little different. You can see here that the convolution stride kernel is smaller. Maybe this is what you are doing wrong. Scaling CIFAR images to 224x224 is worse than using smaller kernel in conv1 with 32x32 images.

# Pytorch with several models
P.S. I have trained models using [this repo](https://github.com/kuangliu/pytorch-cifar) and got similar or better accuracy than written in the README with 95.16% on CIFAR10 with PyTorch.

I tried that repo, running 
```bash
python3 main.py
&& python3 main.py --lr 0.01 --resume
&& python3 main.py --lr 0.001 --resume
&& python3 main.py --lr 0.0001 --resume 
```
and got only 94.680% rather than 95.16%. And frankly this script is overfitting on the test set, because it just picks whatever works best on the test set, rather than validation.


Also, my main point was the difference in the conv1 layer for cifar and imagenet. Do check that.

Some discussion about the implementation at [reddit](https://www.reddit.com/r/MachineLearning/comments/7dtrfl/d_how_do_you_get_high_performance_with_resnet/).