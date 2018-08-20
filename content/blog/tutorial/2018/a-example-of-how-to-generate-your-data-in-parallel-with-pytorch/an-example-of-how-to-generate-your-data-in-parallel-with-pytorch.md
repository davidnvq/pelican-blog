Title: An example of how to generate your data in parallel with PyTorch
Slug: an-example-of-how-to-generate-your-data-in-parallel-with-pytorch
Date: 2018-08-21 00:02:01
Tags: Data Parallel, Data Loader, Pytorch, TUTORIAL
Author: Shervine
Category: tutorial
TopPost: no


# Motivation
Have you ever had to load a dataset that was so memory consuming that you wished a magic trick could seamlessly take care of that? Large datasets are increasingly becoming part of our lives, as we are able to harness an ever-growing quantity of data.

We have to keep in mind that in some cases, even the most state-of-the-art configuration won't have enough memory space to process the data the way we used to do it. That is the reason why we need to find other ways to do that task efficiently. In this blog post, we are going to show you **how to generate your data on multiple cores in real time** and feed it right away to your deep learning model.

This tutorial will show you how to do so on the GPU-friendly framework PyTorch, where **an efficient data generation scheme** is crucial to leverage the full potential of your GPU during the training process.

# Tutorial

## Previous situation
Before reading this article, your PyTorch script probably looked like this:

```python
# Load entire dataset
X, y = torch.load('some_training_set_with_labels.pt')

# Train model
for epoch in range(max_epochs):
    for i in range(n_batches):
        # Local batches and labels
        local_X, local_y = X[i*n_batches:(i+1)*n_batches,], y[i*n_batches:(i+1)*n_batches,]

        # Your model
        [...]
```

or even this:

```python
# Unoptimized generator
training_generator = SomeSingleCoreGenerator('some_training_set_with_labels.pt')

# Train model

for epoch in range(max_epochs):
    for local_X, local_y in training_generator:
        # Your model
        [...]
```

This article is about optimizing the entire data generation process, so that it does not become a bottleneck in the training procedure.

In order to do so, let's dive into a step by step recipe that builds a parallelizable data generator suited for this situation. By the way, the following code is a good skeleton to use for your own project; you can copy/paste the following pieces of code and fill the blanks accordingly.

# Notations
Before getting started, let's go through a few organizational tips that are particularly useful when dealing with large datasets.

Let `ID` be the Python string that identifies a given sample of the dataset. A good way to keep track of samples and their labels is to adopt the following framework:

1. Create a dictionary called `partition` where you gather:

    * in `partition['train']` a list of training IDs
    * in `partition['validation']` a list of validation IDs

2. Create a dictionary called `labels` where for each `ID` of the dataset, the associated label is given by `labels[ID]`

For example, let's say that our training set contains `id-1`, `id-2` and `id-3` with respective labels `0`, `1` and `2`, with a validation set containing `id-4` with label `1`. In that case, the Python variables partition and labels look like

```bash
>>> partition
{'train': ['id-1', 'id-2', 'id-3'], 'validation': ['id-4']}
```
and

```bash
>>> labels
{'id-1': 0, 'id-2': 1, 'id-3': 2, 'id-4': 1}
```

Also, for the sake of modularity, we will write PyTorch code and customized classes in separate files, so that your folder looks like
```bash
folder/
├── my_classes.py
├── pytorch_script.py
└── data/
```

where `data/` is assumed to be the folder containing your dataset.

Finally, it is good to note that the code in this tutorial is aimed at being general and minimal, so that you can easily adapt it for your own dataset.

# Dataset
Now, let's go through the details of how to set the Python class `Dataset`, which will characterize the key features of the dataset you want to generate.

First, let's write the initialization function of the class. We make the latter inherit the properties of `torch.utils.data.Dataset` so that we can later leverage nice functionalities such as multiprocessing.

```python
def __init__(self, list_IDs, labels):
    'Initialization'
    self.labels = labels
    self.list_IDs = list_IDs
```

There, we store important information such as labels and the list of IDs that we wish to generate at each pass.

Each call requests a sample index for which the upperbound is specified in the `__len__` method.
```python
def __len__(self):
    'Denotes the total number of samples'
    return len(self.list_IDs)
```

Now, when the sample corresponding to a given index is called, the generator executes the `__getitem__` method to generate it.

```python
def __getitem__(self, index):
    'Generates one sample of data'
    # Select sample
    ID = self.list_IDs[index]

    # Load data and get label
    X = torch.load('data/' + ID + '.pt')
    y = self.labels[ID]

    return X, y
```

During data generation, this method reads the Torch tensor of a given example from its corresponding file ID.pt. Since our code is designed to be multicore-friendly, note that you can do more complex operations instead (e.g. computations from source files) without worrying that data generation becomes a bottleneck in the training process.

The complete code corresponding to the steps that we described in this section is shown below.

```python
import torch
from torch.utils import data

class Dataset(data.Dataset):
  'Characterizes a dataset for PyTorch'
  def __init__(self, list_IDs, labels):
        'Initialization'
        self.labels = labels
        self.list_IDs = list_IDs

  def __len__(self):
        'Denotes the total number of samples'
        return len(self.list_IDs)

  def __getitem__(self, index):
        'Generates one sample of data'
        # Select sample
        ID = self.list_IDs[index]

        # Load data and get label
        X = torch.load('data/' + ID + '.pt')
        y = self.labels[ID]

        return X, y
```
# PyTorch script
Now, we have to modify our PyTorch script accordingly so that it accepts the generator that we just created. In order to do so, we use PyTorch's `DataLoader` class, which in addition to our `Dataset` class, also takes in the following important arguments:

    * `batch_size`, which denotes the number of samples contained in each generated batch.
    * `shuffle`. If set to `True`, we will get a new order of exploration at each pass (or just keep a linear exploration scheme otherwise). Shuffling the order in which examples are fed to the classifier is helpful so that batches between epochs do not look alike. Doing so will eventually make our model more robust.
    * `num_workers`, which denotes the number of processes that generate batches in parallel. A high enough number of workers assures that CPU computations are efficiently managed, i.e. that the bottleneck is indeed the neural network's forward and backward operations on the GPU (and not data generation).

A proposition of code template that you can write in your script is shown below.

```python
import torch
from torch.utils import data

from my_classes import Dataset


# Parameters
params = {'batch_size': 64,
          'shuffle': True,
          'num_workers': 6}
max_epochs = 100

# Datasets
partition = # IDs
labels = # Labels

# Generators
training_set, validation_set = Dataset(partition['train'], labels), Dataset(partition['validation'], labels)
training_generator = data.DataLoader(training_set, **params)
validation_generator = data.DataLoader(validation_set, **params)

# Training process
for epoch in range(max_epochs):
    for local_batch, local_labels in training_generator:
        # Your model
        [...]

        # Validation process
        for local_batch, local_labels in validation_generator:
            # Your model
            [...]
```


# Conclusion
This is it! You can now run your PyTorch script with the command
```bash
python3 pytorch_script.py

```
and you will see that during the training phase, **data is generated in parallel by the CPU**, which can then be **fed to the GPU** for neural network computations.

# Disclaimer

This article is written by Shervine which you can find the original blog post [here](https://stanford.edu/~shervine/blog/pytorch-how-to-generate-data-parallel.html).


