Title: Add Parameters in Pytorch
Slug: add-parameters-in-pytorch
Date: 2018-08-21 20:10:40
Tags: Pytorch, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no


In this post, we will discuss about add `Paramter` to `Module` as the attributes which are listed in `Module.parameters` for further optimization steps.

# Some important notes about PyTorch 0.4

## Variable and Tensor class are merged in PyTorch 0.4

In previous version of PyTorch, Module’s inputs and outputs must be `Variables`. Data `Tensor`s should be wrapped before forwarding them into a `Module`.

But now, `Variable` class and `Tensor` class are merge into one. Therefore, we don’t need to wrap Tensor anymore in PyTorch version 0.4.

## Inputs to functions and modules from torch.nn

Functions and modules from `torch.nn` process only batches of inputs stored in a tensor with an additional first dimension to index them, and produce a corresponding tensor with an additional dimension.

E.g. a fully connected layer $R^C -> R^D$ expects as input a tensor of size N × C and compute a tensor of size N × D, where `N` is the number of samples (size of a batch).

**Tips**: For a sample input, we can turn it into a batch of size 1:

```python
batch_input = torch.unsqueeze(x, dim=0)
>>> x = torch.tensor([1, 2, 3, 4])
>>> torch.unsqueeze(x, 0)  # for input of modules and functions.
tensor([[ 1,  2,  3,  4]])
>>> torch.unsqueeze(x, 1)
tensor([[ 1],
        [ 2],
        [ 3],
        [ 4]])
```

# Parameters of a module
Please refer to this tutorial [document](https://documents.epfl.ch/users/f/fl/fleuret/www/dlc/dlc-handout-4b-modules-batch.pdf) for more information.

## Create a `module`
To create a Module, one has to inherit from the base class and implement the constructor `__init__(self, ...)` and forward pass `forward(self, x)`. Notice that `x` in `forward(self, x)` pass is a batch.

```python
class Net(nn.Module):
    def __init__(self) :
        super (Net , self ). __init__ ()
        self.conv1 = nn.Conv2d(1, 32, kernel_size=5)
        self.conv2 = nn.Conv2d(32, 64, kernel_size=5)
        self.fc1 = nn.Linear(256, 200)
        self.fc2 = nn.Linear(200, 10)

    def forward(self, x):
        x = F.relu(F.max_pool2d(self.conv1(x),kernel_size=3, stride=3))
        x = F.relu(F.max_pool2d(self.conv2(x),kernel_size=2, stride=2))
        x = x.view(-1, 256)
        x = F.relu(self.fc1(x))
        x = self.fc2(x)
        return x
```
As long as you use autograd-compliant operations, the backward pass is implemented automatically.

`Module`s added as attributes are seen by `Module.parameters()`, which returns an iterator over the model’s parameters for optimization.

```python
class Net(nn.Module):
    def __init__(self) :
        super (Net , self ). __init__ ()
        self.conv1 = nn.Conv2d(1, 32, kernel_size=5)
        self.conv2 = nn.Conv2d(32, 64, kernel_size=5)
        self.fc1 = nn.Linear(256, 200)
        self.fc2 = nn.Linear(200, 10)


model = Net()
for k in model.parameters():
    print(k.size())
```

Note: `nn.Conv2d` and `nn.Linear` actually are Modules.

Parameters added as attributes are also seen by `Module.parameters()`.

Parameters added in dictionaries or arrays are not seen.
```python
class Buggy(nn.Module):
    def __init__(self):
        super(Buggy, self).__init__()
        self.conv = nn.Conv2d(1, 32, 5)
        self.param = Parameter(Tensor(123, 456))
        self.ouch = {}
        self.ouch[0] = nn.Linear(542, 21)

model = Buggy()
for k in model.parameters():
    print(k.size())

# Output
torch . Size ([123 , 456])
torch . Size ([32 , 1 , 5 , 5])
torch . Size ([32])
```
The proper policy then is to use `Module.add_module(name, module)`.
```python
class Buggy(nn.Module):
    def __init__(self):
        super(Buggy, self).__init__()
        self.conv = nn.Conv2d(1, 32, 5)
        self.param = Parameter(Tensor(123, 456))
        self.add_module('ahhh_0', nn.Linear(542, 21))

model = Buggy()
for k in model.parameters():
    print(k.size())

# Output
torch . Size ([123 , 456])
torch . Size ([32 , 1 , 5 , 5])
torch . Size ([32])
torch . Size ([21 , 543])
torch . Size ([21])
```

These modules are added as attributes, and can be accessed with `getattr`.

`Module.register_parameter(name, parameter)` allows to similarly register `Parameter`s explicitly.

Another option is to add modules in a field of type `nn.ModuleList`, which is a list of modules properly dealt with by PyTorch’s machinery.

```python
class Model(nn.Module):
    def __init__(self):
        super(Model, self).__init__()
        self.conv = nn.Conv2d(1, 32, kernel_size=5)
        self.param = Parameter(Tensor(123, 456))
        self.module_list = nn.ModuleList()
        self.module_list.append(nn.Linear(50, 75))
        self.module_list.append(nn.Linear(125, 999))

net = Model()
for k in net.parameters():
    print(k.size())

# Output
torch . Size ([123 , 456])
torch . Size ([32 , 1 , 5 , 5])
torch . Size ([32])
torch . Size ([75 , 50])
torch . Size ([75])
torch . Size ([999 , 125])
torch . Size ([999])
```