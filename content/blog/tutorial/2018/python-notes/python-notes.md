Title: Python notes
Slug: python-notes
Date: 2018-08-21 22:23:05
Tags: Python, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no


Some bug-and-solution and programming notes with Python
This note is the collection of bugs-and-solutions I have been going through during my work.

# Python

## Speed up Python code with Process Pools

## Handle with KeyboardInterrupt Exception.

This is really useful when training a network.
```python
import time
try:
    for i in range(100):
        print(i)
        time.sleep(1)

except KeyboardInterrupt:
    print("You stop at value: ", i)
```

## String format f-string in Python
In Python we can represent a string with different formats:
```python
# First format
string1 = "{} {}".format(value1, value2)

# Second format
string2 = "%r %r" % (value1, value2)

# Third format 
string3 = f"{value1} {value2}"
```

The third format, f-string is considered as the best one now according to this.

## Multiple loops within a nested list
```python
[(x, y) for x in list1 for y in list2]
```

## Print column-like in Python
The syntax with f-string:
```python
names = ["Quang", "A", "B", "Father"]
ages = [24, 10, 4, 60]

fixed_length = 20

for name, age in zip(names, ages):
    print(f"{name:{fixed_length}} {age}", )

# Output
Quang                24
A                    10
B                    4
Father               60
```

For Example:
```python
import torch
from torch import nn
from torch import Tensor
from torch.nn import Parameter

class Buggy(nn.Module):
    def __init__(self):
        super(Buggy, self).__init__()
        self.conv = nn.Conv2d(1, 32, 5)
        self.param = Parameter(Tensor(123, 456))
        self.add_module('ahhh_0', nn.Linear(542, 21))

print("[INFO] class Buggy")
model = Buggy()

print(f"{'Name':15} : {'Size'}")
for name, child in model.named_parameters():
    print(f"{name:15} : {child.size()}")

# Output
[INFO] class Buggy
Name            : Size
param           : torch.Size([123, 456])
conv.weight     : torch.Size([32, 1, 5, 5])
conv.bias       : torch.Size([32])
ahhh_0.weight   : torch.Size([21, 542])
ahhh_0.bias     : torch.Size([21])
```

##  Unresolved reference in Pycharm
Refer to the [answer](https://stackoverflow.com/questions/21236824/unresolved-reference-issue-in-pycharm) on stackoverflow.

## Run Python script in Jupyter notebook
```
%run the_script.py
```
## Print string representation of a numpy array with commas separating its elements

Using `repr` from [source](https://stackoverflow.com/questions/16423774/string-representation-of-a-numpy-array-with-commas-separating-its-elements)

```python
arr = np.arange(1001)
print(repr(arr))
```

