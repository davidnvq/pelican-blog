Title: Notes on Pytorch
Slug: notes-on-pytorch
Date: 2018-08-21 20:58:32
Tags: Pytorch, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no


# Find the device available: GPU or CPU
```python
# at beginning of the script
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
...

# then whenever you get a new Tensor or Module
# this won't copy if they are already on the desired device
input = data.to(device)
model = MyModule(...).to(device)
```
# Transpose and Permute in Pytorch

In order to perform the conversion from NHWC to NCHW in image processing we can use transpose and permute.

transpose only applies to 2 axis, while permute can be applied to all the axes at the same time. For example:
```python
a = torch.rand(1,2,3,4)
print(a.transpose(0,3).transpose(1,2).size())
print(a.permute(3,2,1,0).size())
```

If we want to use `transpose` for swapping multiple axes, we need to use `transpose` multiple times. Actually, `permute` internally calls `transpose` a number of times.

For `transpose`, indeed, it can be a shortcut to use:
```python
tensor.transpose_(0, 1)
```
instead of
```python
tensor = tensor.transpose(0, 1)
```
But note that the difference in performance is not significant, as `transpose` does not copy memory nor allocate new memory, and only swaps the strides.

# Optimize the part of the weights
There are some frozen weights in the network. We need to filter it.
```python
optimizer = torch.optim.RMSprop(filter(lambda p: p.requires_grad, vgg16.parameters()), lr=1e-5, weight_decay=0.0005, momentum=0.9)
```
# Load part of weights
```python
def update_weights(net, pretrained_net):
    pretrained_dict = pretrained_net.state_dict()
    model_dict = net.state_dict()
    pretrained_dict = {k: v for k,v in pretrained_dict.items() if k in model_dict}
    model_dict.update(pretrained_dict)
    net.load_state_dict(model_dict)
    return net
```
# Weight initialization
More in details can be found [here](https://stackoverflow.com/questions/49433936/how-to-initialize-weights-in-pytorch).

## Single layer
To initialize the weights of a single layer, use a function from `torch.nn.init`. For instance:
```python
conv1 = torch.nn.Conv2d(...)
torch.nn.init.xavier_uniform(conv1.weight)
```
Alternatively, you can modify the parameters by writing to `conv1.weight.data` (which is a `torch.Tensor`). Example:
```python
conv1.weight.data.fill_(0.01)
```
The same applies for biases:
```python
conv1.bias.data.fill_(0.01)
```
# `nn.Sequential` or custom `nn.Module`
Pass an initialization function to torch.nn.Module.apply. It will initialize the weights in the entire nn.Module recursively.

> `apply(fn)`: Applies fn recursively to every submodule (as returned by `.children()`) as well as self. Typical use includes initializing the parameters of a model (see also `torch.nn.init`).

Example:
```python
def init_weights(m):
    if type(m) == nn.Linear:
        torch.nn.init.xavier_uniform(m.weight)
        m.bias.data.fill_(0.01)

net = nn.Sequential(nn.Linear(2, 2), nn.Linear(2, 2))
net.apply(init_weights)
```
Iterate all the nn.Module
In this way, we can make sure to initialize for some parameters we we:
```python
from torch.nn import init
for m in model.modules():
  if isinstance(m, nn.Conv2d):
             init.normal_(m.weight.data)
             init.xavier_normal_(m.weight.data)
             init.kaiming_normal_(m.weight.data)
             m.bias.data.fill_(0)
  elif isinstance(m, nn.Linear):
             m.weight.data.normal_()
```

# Preprocessing the image
## Increasing the loading time using `pillow-simd`
```bash
pip uninstall pillow
pip install pillow-simd
```
## Training and Evaluate the model efficiently
Please refer to the code written for ImageNet [here](https://github.com/pytorch/examples/blob/master/imagenet/main.py).

## AverageMeter
Read more from [here.](https://github.com/pytorch/examples/blob/master/imagenet/main.py#L270-L285)
```python
class AverageMeter(object):
    """Computes and stores the average and current value"""
    def __init__(self):
        self.reset()

    def reset(self):
        self.val = 0
        self.avg = 0
        self.sum = 0
        self.count = 0

    def update(self, val, n=1):
        self.val = val
        self.sum += val * n
        self.count += n
        self.avg = self.sum / self.count
```

## Train procedure
Read the details here.
```python
def train(train_loader, model, criterion, optimizer, epoch):
    batch_time = AverageMeter()
    data_time = AverageMeter()
    losses = AverageMeter()
    top1 = AverageMeter()
    top5 = AverageMeter()

    # switch to train mode
    model.train()

    end = time.time()
    for i, (input, target) in enumerate(train_loader):
        # measure data loading time
        data_time.update(time.time() - end)

        target = target.cuda(non_blocking=True)

        # compute output
        output = model(input)
        loss = criterion(output, target)

        # measure accuracy and record loss
        prec1, prec5 = accuracy(output, target, topk=(1, 5))
        losses.update(loss.item(), input.size(0))
        top1.update(prec1[0], input.size(0))
        top5.update(prec5[0], input.size(0))

        # compute gradient and do SGD step
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

        # measure elapsed time
        batch_time.update(time.time() - end)
        end = time.time()

        if i % args.print_freq == 0:
            print('Epoch: [{0}][{1}/{2}]\t'
                  'Time {batch_time.val:.3f} ({batch_time.avg:.3f})\t'
                  'Data {data_time.val:.3f} ({data_time.avg:.3f})\t'
                  'Loss {loss.val:.4f} ({loss.avg:.4f})\t'
                  'Prec@1 {top1.val:.3f} ({top1.avg:.3f})\t'
                  'Prec@5 {top5.val:.3f} ({top5.avg:.3f})'.format(
                   epoch, i, len(train_loader), batch_time=batch_time,
                   data_time=data_time, loss=losses, top1=top1, top5=top5))
```

## Evaluate
Please read here.
```python
def validate(val_loader, model, criterion):
    batch_time = AverageMeter()
    losses = AverageMeter()
    top1 = AverageMeter()
    top5 = AverageMeter()

    # switch to evaluate mode
    model.eval()

    with torch.no_grad():
        end = time.time()
        for i, (input, target) in enumerate(val_loader):
            target = target.cuda(non_blocking=True)

            # compute output
            output = model(input)
            loss = criterion(output, target)

            # measure accuracy and record loss
            prec1, prec5 = accuracy(output, target, topk=(1, 5))
            losses.update(loss.item(), input.size(0))
            top1.update(prec1[0], input.size(0))
            top5.update(prec5[0], input.size(0))

            # measure elapsed time
            batch_time.update(time.time() - end)
            end = time.time()

            if i % args.print_freq == 0:
                print('Test: [{0}/{1}]\t'
                      'Time {batch_time.val:.3f} ({batch_time.avg:.3f})\t'
                      'Loss {loss.val:.4f} ({loss.avg:.4f})\t'
                      'Prec@1 {top1.val:.3f} ({top1.avg:.3f})\t'
                      'Prec@5 {top5.val:.3f} ({top5.avg:.3f})'.format(
                       i, len(val_loader), batch_time=batch_time, loss=losses,
                       top1=top1, top5=top5))

        print(' * Prec@1 {top1.avg:.3f} Prec@5 {top5.avg:.3f}'
              .format(top1=top1, top5=top5))

    return top1.avg
```
## Adjust the learning rate
```python
def adjust_learning_rate(optimizer, epoch):
    """Sets the learning rate to the initial LR decayed by 10 every 30 epochs"""
    lr = args.lr * (0.1 ** (epoch // 30))
    for param_group in optimizer.param_groups:
        param_group['lr'] = lr
```
## Save the checkpoint
```python
def save_checkpoint(state, is_best, filename='checkpoint.pth.tar'):
    torch.save(state, filename)
    if is_best:
        shutil.copyfile(filename, 'model_best.pth.tar')
```
## Train and evaluate
```python
    for epoch in range(args.start_epoch, args.epochs):
        if args.distributed:
            train_sampler.set_epoch(epoch)
        adjust_learning_rate(optimizer, epoch)

        # train for one epoch
        train(train_loader, model, criterion, optimizer, epoch)

        # evaluate on validation set
        prec1 = validate(val_loader, model, criterion)

        # remember best prec@1 and save checkpoint
        is_best = prec1 > best_prec1
        best_prec1 = max(prec1, best_prec1)
        save_checkpoint({
            'epoch': epoch + 1,
            'arch': args.arch,
            'state_dict': model.state_dict(),
            'best_prec1': best_prec1,
            'optimizer' : optimizer.state_dict(),
        }, is_best)
```
## Data loading code
```python
    # Data loading code
    traindir = os.path.join(args.data, 'train')
    valdir = os.path.join(args.data, 'val')
    normalize = transforms.Normalize(mean=[0.485, 0.456, 0.406],
                                     std=[0.229, 0.224, 0.225])

    train_dataset = datasets.ImageFolder(
        traindir,
        transforms.Compose([
            transforms.RandomResizedCrop(224),
            transforms.RandomHorizontalFlip(),
            transforms.ToTensor(),
            normalize,
        ]))

    if args.distributed:
        train_sampler = torch.utils.data.distributed.DistributedSampler(train_dataset)
    else:
        train_sampler = None

    train_loader = torch.utils.data.DataLoader(
        train_dataset, batch_size=args.batch_size, shuffle=(train_sampler is None),
        num_workers=args.workers, pin_memory=True, sampler=train_sampler)

    val_loader = torch.utils.data.DataLoader(
        datasets.ImageFolder(valdir, transforms.Compose([
            transforms.Resize(256),
            transforms.CenterCrop(224),
            transforms.ToTensor(),
            normalize,
        ])),
        batch_size=args.batch_size, shuffle=False,
        num_workers=args.workers, pin_memory=True)
```

## Save and load model’s parameters
```python
# save and load the whole model
torch.save(model_object, 'model.pkl')
model = torch.load('model.pkl')
# only save and load the parameters of the model(recommend)
torch.save(model_object.state_dict(), 'params.pkl')
model_object.load_state_dict(torch.load('params.pkl'))
```
## Different learning rates within a model
```python
lambda1 = lambda epoch: opts['trainLr'][epoch]
optimizer = torch.optim.SGD([
    {'params': net.conv1.weight},
    {'params': net.conv1.bias,'lr':2.0},
    {'params': net.conv2.weight},
    {'params': net.conv2.bias, 'lr':2.0},
    {'params': net.conv3.weight},
    {'params': net.conv3.bias, 'lr':2.0},
    {'params': net.conv4.weight},
    {'params': net.conv4.bias, 'lr':2.0},
    {'params':net.conv5.weight},
    {'params':net.conv5.bias,'lr':2.0},
    {'params':net.adjust.weight,'lr':0.0},
    {'params':net.adjust.bias}
],lr = 1.0, momentum=0.9,weight_decay=0.0)
scheduler = LambdaLR(optimizer,lambda1)
for epoch in range(num_epochs):
	scheduler.step()
	'''training code'''
	loss.backward()
	scheduler.optimizer.step()
```