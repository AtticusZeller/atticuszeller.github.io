# Pytorch

## Bincount

```python
(function) def bincount(
    input: Tensor,
    weights: Tensor | None = None,
    minlength: int | SymInt = 0
) -> Tensor

Example:

    >>> input = torch.randint(0, 8, (5,), dtype=torch.int64)
    >>> weights = torch.linspace(0, 1, steps=5)
    >>> input, weights
    (tensor([4, 3, 6, 3, 4]),
     tensor([ 0.0000,  0.2500,  0.5000,  0.7500,  1.0000])

    >>> torch.bincount(input)
    tensor([0, 0, 0, 2, 2, 0, 1])

    >>> input.bincount(weights)
    tensor([0.0000, 0.0000, 0.0000, 1.0000, 1.0000, 0.0000, 0.5000])
```

不加权重就是计算类别出现的次数，用于计算 labels
加权重就是，对原来位置的标签计算次数时候加上这个权重即
`torch.bincount(labels, weights)` 的规则是：

> 对于每个 i：
> `out[labels[i]] += weights[i]`

### torch.argmax(logits, dim=1)

`torch.argmax(array)` 就是获得 array 里面最大值的 idx

特别的当 torch.argmax(logits, dim=1) 之所以对概率为 0.5 的二分类任务等价于「阈值 0.5 硬分类」，本质来自 softmax + cross entropy 的数学性质。
