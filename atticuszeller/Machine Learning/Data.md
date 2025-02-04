# Data

For machine learning tasks, high-quality, uniformly distributed data is essential, as it indicates the need to identify the location of the target subspace within the high-dimensional input data encoding space

## Preparation

Preparing our dataset by __ingesting__ and __splitting__ it.[^1]

### Ingestion

#### IO

1. `pandas` -> `.csv`
2. `opencv`,`PIL`, [`kornia.image`](https://kornia.readthedocs.io/en/stable/image.html) -> `.jpg`,`.png`

#### dataloader

```python
from torchvision.datasets import VisionDataset
class TestDataset(VisionDataset):
	pass


```
### Splitting

### Collect Data

### Preprocessing

#### Vectorization

[^1]: https://madewithml.com/courses/mlops/preparation/
