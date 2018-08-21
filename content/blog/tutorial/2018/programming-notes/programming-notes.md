Title: Programming notes
Slug: programming-notes
Date: 2018-08-21 22:23:05
Tags: Programming, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no


Some bug-and-solution and programming notes
This note is the collection of bugs-and-solutions I have been going through during my work.

# Bash Shell
##  Warning: remote port forwarding failed for listen port 52698
This bug happens when rmate from server can’t forward to Visual Code in client machine. The reason is some sshd sessions aren’t dettached correctly.

Solution
```bash
$ ps -u username
$ kill `PID_of_sshd`
```
Or we can do it as below: First, we need to install killall from psmisc package
```bash
$ sudo apt-get install psmisc
```
And then, start killing all sshd connection.
```bash
$ sudo killall -u YOURUSER -r sshd
$ sudo killall -u ubuntu -r sshd
```

##  Exit the ssh session in bash/shell script
Normally, we can use exit statement in terminal prompt to terminate the ssh session. However, this way doesn’t work properly when we perform exit in bash script file.sh.

Solution

In order to execute the bash script file.sh and terminate the ssh session later: Just put exit outside the script file.
```bash
$ bash `file.sh`; exit
```

##  Fail to load the interpreter of Python for virtual environment
Instead of running python from virtual environment, it calls python of base environment. We can check which version of python is running by using:
```bash
$ source activate VIRTUAL_ENV
$ which python
```
Solution

Don’t need to run source activate `VIRTUAL_ENV`, call directly `python` from that `VIRTUAL_ENV`
```bash
$ /path/to/anaconda/envs/VIRTUAL_ENV/bin/python filename.py
```

## zip and unzip files and folders.
```bash
zip -r myfiles.zip mydir
```

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

# Some outstanding contents from the other blogs and websites

* Chapter 2 about Linear Algebra Deep Learning Book with a PhD student from ENS, France, Hadrienj

* Introduction to Deep Learning course from CMU.

* Thor Pham - some notes on Computer Vision from Facebook or on Github.

* Some notes on Faster-RCNN in Vietnamese blog.

* SSD Tutorial in English from cv-tricks and Object Detection including (Faster R-CNN, YOLO, SSD) also from here.

* Fast.AI - Really need to read. Can be find here

* Bret Victor - an UX engineer from Apple with some interesting ideas.

* Image kernels visualization

* Andrej Karpathy blog - the Director of AI at Tesla/ a PhD student at Stanford working on Deep Learning

* Lil blog -  a young researcher the Robotics team @ OpenAI.

# Interesting theses and papers
* Doctor Thesis from Andrej Karpathy.