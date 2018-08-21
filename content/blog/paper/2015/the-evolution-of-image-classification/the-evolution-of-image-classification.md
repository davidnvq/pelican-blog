Title: The evolution of image classification
Slug: the-evolution-of-image-classification
Date: 2018-08-21 11:14:24
Tags: Image Classification, CNN, 2015, PAPER
Author: Quang Nguyen
Category: paper
TopPost: no
Persional: yes

In this blog post, we will talk about the evolution of image classification from a high-level perspective. The goal here is to try to understand the key changes that were brought along the years, and why they succeeded in solving our problems.

# Introduction
## Why it matters
Recent research in deep learning has been largely inspired by the way our brain works. When you think of it, it is fascinating to know that with a given input, our brain processes features that say let us know of the world that surrounds us.

As a result, architectures are crucial for us, not only because many challenges rely on the tasks we can perform with them. In fact, the design of the networks themselves points us out to the representation that researchers were looking for, in order to better learn from the data.

# LeNet
## Pioneering work
Before starting, let's note that we would not have been successful if we simply used a raw multi-layer perceptron connected to each pixel of an image. On top of becoming quickly intractable, this direct operation is not very efficient as pixels are spatially correlated.

Therefore, we first need to extract

1. meaningful and
2. low-dimensional features that we can work on.

And that's where convolutional neural networks come in the game!

To tackle this issue, Yann Le Cun's idea proceeds in multiple steps.
![](https://stanford.edu/~shervine/images/LeNet.png)
Source: LeCun et al., 1998

First, an input image is fed to the network. Filters of a given size scan the image and perform convolutions. The obtained features then go through an activation function. Then, the output goes through a succession of pooling and other convolution operations.

As you can see, features are reduced in dimension as the network goes on.

At the end, high-level features are flattened and fed to fully connected layers, which will eventually yield class probabilities through a softmax layer.

During training time, the network learns how to recognize the features that make a sample belong to a given class through backpropagation.

To give an example of what such a network can 'see': let's say we have an image of a horse. The first filters may focus on the animal's overall shape. And then as we go deeper, we can reach a higher level of abstraction where details like eyes and ears can be captured.

That way, ConvNets appear as a way to construct features that we would have had to handcraft ourselves otherwise.

# AlexNet
Convolution's rise to fame
Then you could wonder, why have ConvNets not been trendy since 1998? The short answer is: we had not leveraged their full potential back then.
![](https://stanford.edu/~shervine/images/AlexNet.png)
Source: Krizhevsky et al., 2009

Here, AlexNet takes the same top-down approach, where successive filters are designed to capture more and more subtle features. But here, his work explored several crucial details.

1. First, Krizhevsky introduced better non-linearity in the network with the ReLU activation, whose derivative is 0 if the feature is below 0 and 1 for positive values. This proved to be efficient for gradient propagation.

2. Second, his paper introduced the concept of dropout as regularization. From a representation point of view, you force the network to forget things at random, so that it can see your next input data from a better perspective.

Just to give an example, after you finish reading this post, you will have most probably forgotten parts of it. And yet this is OK, because you will have only kept in mind what was essential.

Well, hopefully.

The same happens for neural networks, and leads the model to be more robust.

Also, it introduced data augmentation. When fed to the network, images are shown with random translation, rotation, crop. That way, it forces the network to be more aware of the attributes of the images, rather than the images themselves.
Finally, another trick used by AlexNet is to be deeper. You can see here that they stacked more convolutional layers before pooling operations. The representation captures consequently finer features that reveal to be useful for classification.

This network largely outperformed what was state-of-the-art back in 2012, with a 15.4% top-5 error on the ImageNet dataset.

# VGGNet
## Deeper is better
The next big milestone of image classification further explored the last point that I mentioned: going deeper.

And it works. This suggests that such networks can achieve a better hierarchical representation of visual data with more layers.
![](https://stanford.edu/~shervine/images/VGGNet.png)

Source: Simonyan et al., 2014
As you can see, something else is very special on this network. It contains almost exclusively 3 by 3 convolutions. This is curious, isn't?

In fact, the authors were driven by three main reasons to do so:

1. First, using small filters induces more non-linearity, which means more degrees of freedom for the network.
2. Second, the fact of stacking these layers together enables the network to see more things than it looks like. For example, with two of these, the network in fact sees a 5x5 receptive field. And when you stack 3 of these filters, you have in fact a 7x7 receptive field! Therefore, the same feature extraction capabilities as in the previous examples can be achieved on this architecture as well.
3. Third, using only small filters also limits the number of parameters, which is good when you want to go that deep.
Quantitatively speaking, this architecture achieved a 7.3% top-5 error on ImageNet.

# GoogLeNet
## Time for inception
Next, GoogLeNet came in the game. It bases its success on its inception modules.
![](https://stanford.edu/~shervine/images/GoogLeNet.png)
Source: Szegedy et al., 2015
As you can see, convolutions with different filter sizes are processed on the same input, and then concatenated together.

From a representation point of view, this allows the model to take advantage of multi-level feature extraction at each step. For example, general features can be extracted by the 5x5 filters at the same time that more local features are captured by the 3x3 convolutions.

But then, you could tell me. Well that's great. But isn't that insanely expensive to compute?

And I would say: very good remark! Actually, the Google team had a brilliant solution for this: 1x1 convolutions.

On the one hand, it reduces the dimensionality of your features.
On the other, it combines feature maps in a way that can be beneficial from a representation perspective.
Then you could ask, why is it called inception? Well, you can see all of those modules as being networks stacked one over another inside a bigger network.

And for the record, the best GoogLeNet ensemble achieved a 6.7% error on ImageNet.

# ResNet
## Connect the layers
So all these networks we talked about earlier followed the same trend: going deeper. But at some point, we realize that stacking more layers does not lead to better performance. In fact, the exact opposite occurs. But why is that?

In one word: the gradient, ladies and gentlemen.

But don't worry, researchers found a trick to counter this effect. Here, the key concept developed by ResNet is residual learning.
![](https://stanford.edu/~shervine/images/ResNet.png)
Source: He et al., 2015
As you can see, every two layers, there is an identity mapping via an element-wise addition. This proved to be very helpful for gradient propagation, as the error can be backpropagated through multiple paths.

Also, from a representation point of view, this helps to combine different levels of features at each step of the network, just like we saw it with the inception modules.

It is to this date one of the best performing network on ImageNet, with a 3.6% top-5 error rate.

# DenseNet
## Connect more!
An extension of this reasoning has been later proposed. DenseNet proposes entire blocks of layers connected to one another.
![](https://stanford.edu/~shervine/images/DenseNet.png)
Source: Huang et al., 2016
This contributes to **diversifying** a lot more the **features** within those blocks.

# Conclusion
## Global trends
A major pattern observed overall is that **networks** are designed to be **deeper and deeper**.

**Computational tricks** (ReLU, dropout, batch normalization) have been also introduced alongside them and had a significant impact in improving performance.

We have also seen the apparition of **modules** that are able to capture rich features at each step of the network.

Finally, another major point is the increasing use of **connections between the layers** of the network, which helps for producing diverse features and revealed to be useful for gradient propagation.

## Disclaimer
This article is written by Shervine, and the original post can be found [here](https://stanford.edu/~shervine/blog/evolution-image-classification-explained.html).