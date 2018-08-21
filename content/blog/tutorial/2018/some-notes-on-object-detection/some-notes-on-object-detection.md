Title: Some notes on Object Detection
Slug: some-notes-on-object-detection
Date: 2018-08-21 17:17:38
Tags: Object Detection, Pytorch, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no


In this post, I’m going to note what I have learnt about Object Detection. I hope that it will be useful for my later reference as well as to some people who have the same interest.

# Object Detection Utils
## Drawing the bounding boxes
1. Using PIL package:
```python
from PIL import Image, ImageDraw

def draw_bboxes(img, bboxes):
    '''
    img - shape [h, w, channels] with values of `0-255` range.
    bboxes - shape [N, 4] with the order of [N, [xmin, ymin, xmax, ymax]]
    '''
    # convert `numpy array` format `img` into `PIL` format `img`
    img = Image.fromarray(img)

    # draw the image with its bounding boxes
    draw = ImageDraw.Draw(img)
    for box in bboxes:
        draw.rectangle(list(box), outline='red')
    img.show()
```

2. Using matplotlib package:
```python
import matplotlib.pyplot as plt

def draw_bboxes(img, bboxes, labels=None, scores=None):
    '''
    img - shape [h, w, channels] with values of `0-255` range.
    bboxes - shape [N, 4] with the order of [N, [xmin, ymin, xmax, ymax]]
    '''
    current_axis = plt.gca()

    plt.figure(figsize=(20, 12))
    plt.imshow(img)
    for idx in range(len(bboxes)):
        box = bboxes[idx]
        conf = scores[idx]
        label = labels[idx]

        xmin, ymin = box[0], box[1]
        xmax, ymax = box[2], box[3]
        # Draw box
        current_axis.add_patch(plt.Rectangle((xmin, ymin), 
            xmax-xmin, ymax-ymin, color='green', fill=False, linewidth=2))  
        # Add confidence score
        current_axis.text(xmin, ymin, f"{conf:.2f}", size='x-large', 
            color='white', bbox={'facecolor':color, 'alpha':1.0})
    
    plt.show()
```

# Pytorch format for image input in preprocessing

## Mean and std for images

1. All pre-trained models expect input images normalized in the same way, i.e. mini-batches of 3-channel **RGB** images of shape (3 x H x W), where `H` and `W` are expected to be at least `224`.

2. The images have to be loaded in to a range of [0, 1] and then normalized using `mean` = [0.485, 0.456, 0.406] and `std` =[0.229, 0.224, 0.225] with respect to [R,G,B] of scale 0-1.

Attributes    | Representation
--------------|-----------------------
scale range   | 0 - 1
Channel order | R-G-B
mean          | [0.485, 0.456, 0.406]
std           | [0.229, 0.224, 0.225]


## Encode the original image to normalized array
* First, we need to normalize the image data into values of the range 0-1, divided 255 if the `original_img` is in range of 0-255:

```python
normalized_img = original_img / 255
```

* Then later, we substract `mean` from the `original_img` and divide it by `std`:

```python
new_img =  (normalized_img - mean) / std
```

* `new_img` can be obtained from the `Dataloader` and will be used in training phase.


## Decode into the original image
In order to decode into the original images, we use the below formula:

```python
normalized_img = (std * new_img) + mean
```

**Notes:** If we use Normalize with mean and std as below:

```python
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize((0.5,0.5,0.5), (0.5,0.5,0.5))
])
normalized_img = transform(img)
```

Then, the image will be normalized to the the scale of `-1` and `1`.

To convert back, we use the script below:

```python
img = (normalized_img * std) + mean 
original_img = transforms.ToPILImage()(img)
```

## `transforms` methods in Pytorch

1. `transforms.ToPILImage` or `F.to_pil_image`:
    
    Convert a `tensor` or an `ndarray` to `PIL.Image`. Converts a `torch.*Tensor` of shape C x H x W or a numpy `ndarray` of shape (H x W x C) to a `PIL.Image` while preserving the value range.

2. `transforms.ToTensor`:
    
    Convert a `PIL.Image` or `np.ndarray` to `tensor`.
    
    Converts a `PIL.Image` or numpy `ndarray` shape of (H x W x C) in the range [0, 255] to a `torch.FloatTensor` of shape (C x H x W) in the range [0.0, 1.0]. The channel order is still `RGB`.

## Reading images with different packages

1. With `opencv`:

When we read an image using opencv, the input usually in format [H, W, C] where C = 3 for color images. However, the order of R, G, B channel is BGR. First, we need to transpose the image into [C, H, W]. Then, we exchange the order of channels into RGB:

```python
import cv2
import numpy as np

img = cv2.imread(file_name)
# Transpose
img = np.transpose(img, (2,0,1))

# Swap the channels
img = img[[2, 1, 0], : , : ]
skimage.io:
```

When we read an image using skimage.io, the input usually in format [H, W, C]


# Load pretrained weights in Pytorch
After model_dict.update(pretrained_dict), the model_dict may still have keys that pretrained_model doesn’t have, which will cause a error.

Assum following situation:

```python
pretrained_dict: ['A', 'B', 'C', 'D']
model_dict: ['A', 'B', 'C', 'E']
```

After we perform:
```python
pretrained_dict = {k: v for k, v in pretrained_dict.items() 
                   if k in model_dict} 

model_dict.update(pretrained_dict)
```

They become:
```python
pretrained_dict: ['A', 'B', 'C']
model_dict: ['A', 'B', 'C', 'E']
```

So when performing:

```
model.load_state_dict(pretrained_dict)
```

Then `model_dict` still has key `E` that `pretrained_dict` doesn’t have.
So how about using:
```python
model.load_state_dict(model_dict)
```
The complete snippet is therefore as follow:

```python
def update_weights(net, pretrained_net):
	pretrained_dict = pretrained_net.state_dict()
	model_dict = net.state_dict()
	pretrained_dict = {k: v for k, v in pretrained_dict.items() if k in model_dict}
	model_dict.update(pretrained_dict)
	net.load_state_dict(model_dict)

class Model(nn.Module):

    def __init__(self):
        # Load pretrained_net from some sources...
        pretrained_net = ...
        update_weights(self, pretrained_net)

```
