Title: Infer in_features for the linear layer in Pytorch
Slug: infer-in-features-for-the-linear-layer-in-pytorch
Date: 2018-08-21 20:32:34
Tags: Pytorch, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no

# Motivation
We may wonder how it is possible to infer the `in_features` for `self.fc1` when there is a transition from a `conv` layer to `linear` layer. How to obtain the value of `320` as the code of the network definition below?

```python
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.autograd import Variable

class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.conv1 = nn.Conv2d(1, 10, kernel_size=5)
        self.conv2 = nn.Conv2d(10, 20, kernel_size=5)
        self.conv2_drop = nn.Dropout2d()
        self.fc1 = nn.Linear(320, 50) # 320
        self.fc2 = nn.Linear(50, 10)

    def forward(self, x):
        x = F.relu(F.max_pool2d(self.conv1(x), 2))
        x = F.relu(F.max_pool2d(self.conv2_drop(self.conv2(x)), 2))
        x = x.view(x.size(0), -1)
        x = F.relu(self.fc1(x))
        x = F.dropout(x, training=self.training)
        x = F.relu(self.fc2(x))
        return F.log_softmax(x)
```

In the CNN model definition, the number of flatten features (`in_features` for the dense layer) depends on the input size of the image. The `in_features` = `320`, if the `input_shape` of the image is (3, 28, 28). Here is just an example of MNIST problem.

Then, there might be a solution of performing a forward pass on the network to get the value of `320` like:
```python
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.autograd import Variable

class Net(nn.Module):
    def __init__(self, input_shape=(1, 28, 28)):
        super(Net, self).__init__()
        self.conv1 = nn.Conv2d(1, 10, kernel_size=5)
        self.conv2 = nn.Conv2d(10, 20, kernel_size=5)
        self.conv2_drop = nn.Dropout2d()

        n_size = self._get_conv_output(input_shape)
        
        self.fc1 = nn.Linear(n_size, 50)
        self.fc2 = nn.Linear(50, 10)

    # generate input sample and forward to get shape
    def _get_conv_output(self, shape):
        bs = 1
        input = Variable(torch.rand(bs, *shape))
        output_feat = self._forward_features(input)
        n_size = output_feat.data.view(bs, -1).size(1)
        return n_size

    def _forward_features(self, x):
        x = F.relu(F.max_pool2d(self.conv1(x), 2))
        x = F.relu(F.max_pool2d(self.conv2_drop(self.conv2(x)), 2))
        return x

    def forward(self, x):
        x = self._forward_features(x)
        x = x.view(x.size(0), -1)       # x.size(0) - batch_size
        x = F.relu(self.fc1(x))
        x = F.dropout(x, training=self.training)
        x = F.relu(self.fc2(x))
        return F.log_softmax(x)
```
When you just want to write the clean code without doing a foward pass like the above solution, try the second solution:

```python
class Net(nn.Module):

    def __init__(self):
        super(Net, self).__init__()
        self.conv1 = nn.Conv2d(1, 10, kernel_size=5)
        self.conv2 = nn.Conv2d(10, 20, kernel_size=5)
        self.mp = nn.MaxPool2d(2)
        any_number = 20000
        self.fc1 = nn.Linear(any_number, 50) # first try
        self.fc2 = nn.Linear(50, 10)

    def forward(self, x):
        x = F.relu(self.mp(self.conv1(x)))
        x = F.relu(self.mp(self.conv2(x)))
        x = x.view(x.size(0), -1)    # flatten the tensor
        print(x.size())              # the last solution 
        x = F.relu(self.fc1(x))      
        x = F.dropout(x, training=self.training)
        x = F.relu(self.fc2(x))
        return F.log_softmax(x)

net = Net()
# generate an batch of 1 gray image
batch_imgs = torch.rand(1, 1, 28, 28)  
output = net(batch_imgs)
```

# Approach 1
Start with any random number any_number as line 8 and pass it to the `in_features` argument in line 9. Then you will get the RuntimeError, the value of 320 is replaced from the bug. After we figure out the right `in_features` = `320`, we can replace any_number by that value.

```
RuntimeError: size mismatch, m1: [1 x 320], m2: [100 x 50]
```
# Approach 2
The other way is putting the statement to know about the size after flattening (see the comment the last solution) as line 16:

```python
print(x.size())
```

# Advantages and Disadvantages of 2 above approaches

## Advantages:

1. Don’t need to write a forward pass function till the fc layers.
2. Clean code.

## Disadvantages:

1. We need to figure out the in_features of fc layers manually.
2. This is inconvenient in case we want to try with different input_shape.