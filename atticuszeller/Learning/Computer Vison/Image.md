# Image

## Image Coordinate System

![[assets/Pasted image 20241117133910.png|300]]
图像坐标系中：

- __原点__（0, 0）位于图像的左上角。
- __X 轴 __ 的正方向是向右，表示图像的宽度（w) 方向。
- __Y 轴 __ 的正方向是向下，表示图像的高度（h）方向。
  _reason_
  这种坐标系统选择主要是基于图像数据在计算机内存中的存储方式。在大多数图像处理库和图形界面系统中，图像数据是按行存储的，每行从左到右，行从上到下排列。因此，图像的第一个像素（位于左上角）对应于坐标（0, 0）。

## Color

1. channel first and RGB(red, green, blue)->pytorch,etc

```python
image.shape = (RGB,Height,Weight)
```

1. channel not first and BGR(blue,green,red) for opencv,etc

```python
image.shape = (Height,Weight,BGR)
```

- __normalize__

```python
image/255.
[0,255] -> [0,1.0]
```

## Depth

1. raw depth data from `.png` with shape(h,w)

```python
depth_image = cv2.imread('depth_image.png', cv2.IMREAD_GRAYSCALE)
```

1. expand_dims for `pytorch`

```python
depth_tensor.unsqueeze(0)
shape->(1,h,w)
```
