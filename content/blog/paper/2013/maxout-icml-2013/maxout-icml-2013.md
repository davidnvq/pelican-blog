Title: Maxout ICML 2013
Slug: maxout-icml-2013
Date: 2018-08-15 22:48:34
Tags: Maxout, ICML, Dropout, 2013, PAPER
Author: Quang Nguyen
Category: paper
TopPost: no



Abstract
----------
1. Link to paper, which appears on ICML 2013.
2. Maxout network (maxout - its output is the max of a set of inputs)
3. Design to both facilitate optimization by dropout and improve the accuracy.
4. SOTA on MNIST, CIFAR-10, CIFAR-100, SVHN.


Introduction
----------

Dropout - an inexpensive and simple means for:

1. training a large ensemble of models that share params.
2. approximately averaging together these models’ predictions.

Dropout is applied in MLP, CNN and get the SOTA.

This paper argues that: 

- The best  performance may be obtained by directly designing a model that enhances dropout’s abilities as a model averaging technique.
- They introduce `maxout` layer with that purpose.


Review of dropout
----------

Dropout is a technique applied in deterministic feedforward networks: predict output `y` given vector `x` with a series of hidden layers $\textbf{h} = \{h^{(1)},...,h^{(L)}\}$.
 
 Dropout trains an ensemble of models consisting of the set of all models that contain a subset of the variables in both `v` and h. 

- The same set of parameters $\theta$ is used to parameterize a family of distributions $p(y|v; \theta, \mu)$ where $\mu \in M$ is a binary mask determining which variables to include in the model.
- On each presentation of a training example, we train a different sub-model by following the gradient of $logp(y|v;\theta, \mu)$ for a different randomly sampled $\mu$.
- For many parameterization of $p$, the initiation of different sub-models $p(y|v; \theta, \mu)$ can be obtained by elem-wise multiplication of v and h with the mask $\mu$. 

Dropout and bagging:

- Similar: Dropout training is similar to bagging where many different models are trained on different subsets of the data.


- Different: In dropout 
  - Each model is trained for only 1 step
  - All the models share parameters.

This training procedure behave as if: 

- It is training an ensemble rather than a single model (an ensemble with bagging under `parameter sharing constraint`).
- Each update must have a large effect (unlike SGD makes a steady progress with small steps), so that it makes the sub-model induced by that $\mu$ fit the current input v well.
- Each update step is considered as an update to different model on a different subset of training set.

In prediction phase

- Bagging averages with the arithmetic mean ← impossible with exponentially many models using dropout.
- Fortunately, some model families (such as deep non-linear network) yield an inexpensive geometric mean.
- If $p(y|v;\theta) = softmax(v^TW + b)$, then the geometric mean of $p(y|v; \theta, \mu)$ where $\mu \in M$ over $M$ is simply $softmax(v^TW/2 + b)$. 
- The average prediction of exponentially many sub-models can be computed simply by running the full model with the weights divided by 2.


Description of Maxout
----------

The maxout model is simply uses a new type of activation function: the maxout unit.

Given the input $x \in R^d$ (x may be a vector v, or may be a hidden layer’s state), a maxout hidden layer implements the function:

$h_i(x) = max_{j \in [1,k]}z_{i,j}$

where $z_{ij} = x^TW_{..ij} + b_{ij}$ and $W \in R^{d \times m\times k}$ and $b\in R^{m \times k}$.

In CNN, a maxout feature map can be constructed by taking the maximum across k affine feature maps (pool across channels). 


- When training with dropout, we perform the elem-wise multiplication with the dropout mask immediately before the multiplication by the weights in all cases.
- A single maxout unit can be interpreted as making a piecewise linear approx to an arbitrary convex function (see Fig.1).


![](https://d2mxuefqeaa7sj.cloudfront.net/s_181B4C9A1CF08268454C195FA358E6ED2E4EEEFD261BA3D2C40C18FCCF458838_1531408560500_image.png)


Characteristics of maxout:

1. The representation it produces is not sparse though the gradient is highly sparse and dropout will artificially sparsify the effective representation during training.
2. maxout is locally linear almost everywhere while the other activation functions have significant cuvature.

→ They are very robust and easy to train with dropout.


Maxout is a universal approximator
----------
1. A standard MLP with enough hidden units is a universal approximator. 


![](https://d2mxuefqeaa7sj.cloudfront.net/s_181B4C9A1CF08268454C195FA358E6ED2E4EEEFD261BA3D2C40C18FCCF458838_1531410910906_image.png)

2. maxout networks are universal approximators as well.
![](https://d2mxuefqeaa7sj.cloudfront.net/s_181B4C9A1CF08268454C195FA358E6ED2E4EEEFD261BA3D2C40C18FCCF458838_1531411300798_image.png)


Example, they show that a  maxout model with just 2 hidden units can approx any continous function of $v \in R^n$ if each maxout unit may have many affine components.




Experimental Results
----------
* MNIST
* CIFAR-10
* CIFAR-100
* SVHN

Model Averaging
----------


Notes
----------

Deterministic algorithm is an algorithm which, given a particular input, will always produce the same output, with the underlying machine always passing through the same sequence of states.

Deterministic model: model xác định (tất định).

* [Visualization](http://www.simon-hohberg.de/)
* [Explained](http://cs231n.github.io/neural-networks-1/)
* [Code in Pytorch](https://github.com/Duncanswilson/maxout-pytorch/blob/master/maxout_pytorch.ipynb)