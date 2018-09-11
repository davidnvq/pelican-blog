Title: Tensorflow notes
Slug: tensorflow-notes
Date: 2018-09-11 11:34:55
Tags: Tensorflow, Keras, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no

# Some useful links 

* https://towardsdatascience.com/@yufengg
* googlecloud series on Youtube

{% youtube t3Uuk8edSzs 640 480 %}

* https://pair-code.github.io/facets/ Visualize your data

# Some common operations
## Tensorflow Debugging, Keras Debugging

* https://wookayin.github.io/tensorflow-talk-debugging/

* using tf.Print()

```python
loss = ...
# we want to print the loss value to the console, 
# pass the tf.Print operation

loss = tf.Print(loss, [loss, tf.shape(loss)], "loss")
```


## Convert a scalar number to tensorflow float 
```python
num = 10.0
tf.to_float(num)
```
## Condition in Tensorflow

```python
def f1():
    pass
def f2():
    pass

tf.cond(tf.equal(n_neg_losses, tf.constant(0)), f1, f2)
```

## Calculate the sum along the specific axis
```python
tf.reduce_sum(array, axis=-1)
```

## Expand the dim in Tensorflow 

```python
tf.expand_dims(indices, axis=1)

```
## Create zeros, ones array 

```python

tf.ones_like(indices, dtype=tf.int32)
tf.zeros_like(indices, dtype=tf.int32)
tf.ones(10)
tf.zeros((10, 10))
```
## Shape and Reshape

```python
x = tf.constant([1,2,3, 4])
shape_x = tf.shape(x)
new_x = tf.reshape(x, [shape_x, 1, 1, 1])
# output
```
array([[[[1]]],
       [[[2]]],
       [[[3]]],
       [[[4]]]], dtype=int32)
```

## Get top value of tensor
```python
x = tf.constant([10, 2, 3, 1, 9, 8])
values, indices = tf.nn.top_k(
                    input=x,
                    k=3,
                    sorted=True)
# output
TopKV2(values=array([10,  9,  8], dtype=int32), indices=array([0, 4, 5], dtype=int32))
```

## Get the max value of the tensor

Computes the maximum of elements across dimensions of a tensor. (deprecated arguments)

```python
tf.reduce_max(
    input_tensor,
    axis=None,
    keepdims=None,
    name=None,
    reduction_indices=None,
    keep_dims=None
)
```

## Get the max value between 2 tensors
Returns the max of x and y (i.e. x > y ? x : y) element-wise.
https://www.tensorflow.org/api_docs/python/tf/maximum

```python
tf.maximum(
    x,
    y,
    name=None
)
```

## Get the sum, mean, max, min of a tensor

```python
tf.reduce_mean # Computes the mean of elements across dimensions of a tensor.
tf.reduce_sum
tf.reduce_max
tf.reduce_min
tf.reduce_prod # Computes the product of elements across dimensions of a tensor
tf.reduce_logsumexp
tf.reduce_any # Computes the "logical or" 
tf.reduce_all # Computes the "logical and"
```

## Make constants or random tensors

```python
tf.constant(3)
tf.constant([3,4,5])
tf.to_float(10.0)
tf.random_uniform(
    shape,
    minval=0,
    maxval=None,
    dtype=tf.float32,
    seed=None,
    name=None
)
tf.random_normal(
    shape,
    mean=0.0,
    stddev=1.0,
    dtype=tf.float32,
    seed=None,
    name=None
)
```

## Join the values in a `string` tensor
```python
tf.reduce_join(
    inputs,
    axis=None,
    keep_dims=False,
    separator='',
    name=None,
    reduction_indices=None
)
# tensor `a` is [["a", "b"], ["c", "d"]]
tf.reduce_join(a, 0) ==> ["ac", "bd"]
tf.reduce_join(a, 1) ==> ["ab", "cd"]
tf.reduce_join(a, -2) = tf.reduce_join(a, 0) ==> ["ac", "bd"]
tf.reduce_join(a, -1) = tf.reduce_join(a, 1) ==> ["ab", "cd"]
tf.reduce_join(a, 0, keep_dims=True) ==> [["ac", "bd"]]
tf.reduce_join(a, 1, keep_dims=True) ==> [["ab"], ["cd"]]
tf.reduce_join(a, 0, separator=".") ==> ["a.c", "b.d"]
tf.reduce_join(a, [0, 1]) ==> "acbd"
tf.reduce_join(a, [1, 0]) ==> "abcd"
tf.reduce_join(a, []) ==> [["a", "b"], ["c", "d"]]
tf.reduce_join(a) = tf.reduce_join(a, [1, 0]) ==> "abcd"
```

## Split a tensor into sub tensors

```python
tf.split(
    value,
    num_or_size_splits,
    axis=0,
    num=None,
    name='split'
)
# 'value' is a tensor with shape [5, 30]
# Split 'value' into 3 tensors with sizes [4, 15, 11] along dimension 1
split0, split1, split2 = tf.split(value, [4, 15, 11], 1)
tf.shape(split0)  # [5, 4]
tf.shape(split1)  # [5, 15]
tf.shape(split2)  # [5, 11]
# Split 'value' into 3 tensors along dimension 1
split0, split1, split2 = tf.split(value, num_or_size_splits=3, axis=1)
tf.shape(split0)  # [5, 10]
```

## square, sqrt

```python
tf.square(x) # x*x
tf.sqrt(x) # x^1/2
```

## Removes dimensions of size 1 from the shape of a tensor.
```python
tf.squeeze(
    input,
    axis=None,
    name=None,
    squeeze_dims=None
)

# 't' is a tensor of shape [1, 2, 1, 3, 1, 1]
tf.shape(tf.squeeze(t))  # [2, 3]
tf.shape(tf.squeeze(t, [2, 4]))  # [1, 2, 3, 1]
```

# Tensor Transformations

## Casting

TensorFlow provides several operations that you can use to cast tensor data types in your graph.

* `tf.string_to_number`
* `tf.to_double`
* `tf.to_float`
* `tf.to_bfloat16`
* `tf.to_int32`
* `tf.to_int64`
* `tf.cast`
* `tf.bitcast`
* `tf.saturate_cast`

## Shapes and Shaping
TensorFlow provides several operations that you can use to determine the shape of a tensor and change the shape of a tensor.

* `tf.broadcast_dynamic_shape`
* `tf.broadcast_static_shape`
* `tf.shape`
* `tf.shape_n`
* `tf.size`
* `tf.rank`
* `tf.reshape`
* `tf.squeeze`
* `tf.expand_dims`
* `tf.meshgrid`

## Slicing and Joining
TensorFlow provides several operations to slice or extract parts of a tensor, or join multiple tensors together.
```python
tf.slice
tf.strided_slice
tf.split
tf.tile
tf.pad
tf.concat
tf.stack
tf.parallel_stack
tf.unstack
tf.reverse_sequence
tf.reverse
tf.reverse_v2
tf.transpose
tf.extract_image_patches
tf.space_to_batch_nd
tf.space_to_batch
tf.required_space_to_batch_paddings
tf.batch_to_space_nd
tf.batch_to_space
tf.space_to_depth
tf.depth_to_space
tf.gather
tf.gather_nd
tf.unique_with_counts
tf.scatter_nd
tf.dynamic_partition
tf.dynamic_stitch
tf.boolean_mask
tf.one_hot
tf.sequence_mask
tf.dequantize
tf.quantize_v2
tf.quantized_concat
tf.setdiff1d
```

# Math 
https://www.tensorflow.org/versions/r1.9/api_guides/python/

> Note: Elementwise binary operations in TensorFlow follow numpy-style broadcasting.
> Note: Functions taking Tensor arguments can also take anything accepted by tf.convert_to_tensor.

## Arithmetic Operators
TensorFlow provides several operations that you can use to add basic arithmetic operators to your graph.
```python
tf.add
tf.subtract
tf.multiply
tf.scalar_mul
tf.div
tf.divide
tf.truediv
tf.floordiv
tf.realdiv
tf.truncatediv
tf.floor_div
tf.truncatemod
tf.floormod
tf.mod
tf.cross
```

## Basic Math Functions
TensorFlow provides several operations that you can use to add basic mathematical functions to your graph.
```python
tf.add_n
tf.abs
tf.negative
tf.sign
tf.reciprocal
tf.square
tf.round
tf.sqrt
tf.rsqrt
tf.pow
tf.exp
tf.expm1
tf.log
tf.log1p
tf.ceil
tf.floor
tf.maximum
tf.minimum
tf.cos
tf.sin
tf.lbeta
tf.tan
tf.acos
tf.asin
tf.atan
tf.cosh
tf.sinh
tf.asinh
tf.acosh
tf.atanh
tf.lgamma
tf.digamma
tf.erf
tf.erfc
tf.squared_difference
tf.igamma
tf.igammac
tf.zeta
tf.polygamma
tf.betainc
tf.rint
```

## Matrix Math Functions
TensorFlow provides several operations that you can use to add linear algebra functions on matrices to your graph.
```python
tf.diag
tf.diag_part
tf.trace
tf.transpose
tf.eye
tf.matrix_diag
tf.matrix_diag_part
tf.matrix_band_part
tf.matrix_set_diag
tf.matrix_transpose
tf.matmul
tf.norm
tf.matrix_determinant
tf.matrix_inverse
tf.cholesky
tf.cholesky_solve
tf.matrix_solve
tf.matrix_triangular_solve
tf.matrix_solve_ls
tf.qr
tf.self_adjoint_eig
tf.self_adjoint_eigvals
tf.svd
```
## Tensor Math Function
TensorFlow provides operations that you can use to add tensor functions to your graph.
```python
tf.tensordot
```

## Complex Number Functions
TensorFlow provides several operations that you can use to add complex number functions to your graph.
```python
tf.complex
tf.conj
tf.imag
tf.angle
tf.real
```

## Reduction
TensorFlow provides several operations that you can use to perform common math computations that reduce various dimensions of a tensor.
```python
tf.reduce_sum
tf.reduce_prod
tf.reduce_min
tf.reduce_max
tf.reduce_mean
tf.reduce_all
tf.reduce_any
tf.reduce_logsumexp
tf.count_nonzero
tf.accumulate_n
tf.einsum
```
## Scan
TensorFlow provides several operations that you can use to perform scans (running totals) across one axis of a tensor.
```python
tf.cumsum
tf.cumprod
```
## Segmentation
TensorFlow provides several operations that you can use to perform common math computations on tensor segments. Here a segmentation is a partitioning of a tensor along the first dimension, i.e. it defines a mapping from the first dimension onto segment_ids. The segment_ids tensor should be the size of the first dimension, d0, with consecutive IDs in the range 0 to k, where k < d0. In particular, a segmentation of a matrix tensor is a mapping of rows to segments.

For example:
```python
c = tf.constant([[1,2,3,4], [-1,-2,-3,-4], [5,6,7,8]])
tf.segment_sum(c, tf.constant([0, 0, 1]))
  ==>  [[0 0 0 0]
        [5 6 7 8]]
tf.segment_sum
tf.segment_prod
tf.segment_min
tf.segment_max
tf.segment_mean
tf.unsorted_segment_sum
tf.sparse_segment_sum
tf.sparse_segment_mean
tf.sparse_segment_sqrt_n
```
## Sequence Comparison and Indexing
TensorFlow provides several operations that you can use to add sequence comparison and index extraction to your graph. You can use these operations to determine sequence differences and determine the indexes of specific values in a tensor.
```python
tf.argmin
tf.argmax
tf.setdiff1d
tf.where
tf.unique
tf.edit_distance
tf.invert_permutation
```

# String

## Hashing

String hashing ops take a string input tensor and map each element to an integer.
```python
tf.string_to_hash_bucket_fast
tf.string_to_hash_bucket_strong
tf.string_to_hash_bucket
```
## Joining
String joining ops concatenate elements of input string tensors to produce a new string tensor.
```python
tf.reduce_join
tf.string_join
Splitting
tf.string_split
tf.substr
```
## Conversion
```python
tf.as_string
tf.string_to_number
tf.decode_raw
tf.decode_csv
tf.encode_base64
tf.decode_base64
python
```

# Control Flow

## Control Flow Operations
TensorFlow provides several operations and classes that you can use to control the execution of operations and add conditional dependencies to your graph.

```
tf.identity
tf.tuple
tf.group
tf.no_op
tf.count_up_to
tf.cond
tf.case
tf.while_loop
```

## Logical Operators
TensorFlow provides several operations that you can use to add logical operators to your graph.
```
tf.logical_and
tf.logical_not
tf.logical_or
tf.logical_xor
```
## Comparison Operators
TensorFlow provides several operations that you can use to add comparison operators to your graph.
```
tf.equal
tf.not_equal
tf.less
tf.less_equal
tf.greater
tf.greater_equal
tf.where
```

## Debugging Operations
TensorFlow provides several operations that you can use to validate values and debug your graph.
```
tf.is_finite
tf.is_inf
tf.is_nan
tf.verify_tensor_all_finite
tf.check_numerics
tf.add_check_numerics_ops
tf.Assert
tf.Print
```


# Asserts and boolean checks

```
tf.assert_negative
tf.assert_positive
tf.assert_proper_iterable
tf.assert_non_negative
tf.assert_non_positive
tf.assert_equal
tf.assert_integer
tf.assert_less
tf.assert_less_equal
tf.assert_greater
tf.assert_greater_equal
tf.assert_rank
tf.assert_rank_at_least
tf.assert_type
tf.is_non_decreasing
tf.is_numeric_tensor
tf.is_strictly_increasing
```
Example:
```python
tf.assert_equal(
    x,
    y,
    data=None,
    summarize=None,
    message=None,
    name=None
)
# Assert the condition x == y holds element-wise
with tf.control_dependencies([tf.assert_equal(x, y)]):
  output = tf.reduce_sum(x)
```


