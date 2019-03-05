Title: Training Models in Parallel with Keras
Slug: training-models-in-parallel-with-keras
Date: 2018-11-28 22:39:23
Tags: , TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no

If there is some problems with BatchNormalization, please refer to this [Tensorflow pull requests](https://www.bountysource.com/issues/33177171-does-keras-support-using-multiple-gpus)

## Sample code to check the speed

```python
import tensorflow as tf
from keras.applications import ResNet50
from keras.utils import multi_gpu_model
import numpy as np
num_samples = 1000
height = 224
width = 224
num_classes = 1000
with tf.device('/cpu:0'):
    model = ResNet50(weights=None,
                    input_shape=(height, width, 3),
                    classes=num_classes)
parallel_model = multi_gpu_model(model, 2)
parallel_model.compile(loss='categorical_crossentropy',
                        optimizer='rmsprop')
x = np.random.random((num_samples, height, width, 3))
y = np.random.random((num_samples, num_classes))
parallel_model.fit(x, y, epochs=20, batch_size=256)
```
