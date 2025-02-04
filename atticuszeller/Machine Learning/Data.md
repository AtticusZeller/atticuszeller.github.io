# Data

For machine learning tasks, high-quality, uniformly distributed data is essential, as it indicates the need to identify the location of the target subspace within the high-dimensional input data encoding space

## Preparation

Preparing our dataset by __ingesting__ and __splitting__ it.[^1]

### Ingestion

#### IO

1. `pandas` -> `.csv`
2. `opencv`,`PIL`, [`kornia.image`](https://kornia.readthedocs.io/en/stable/image.html) -> `.jpg`,`.png`

#### Data Loader

inherit `VisionDataset` and pass it to `DataLoader`

```python
from torchvision.datasets import VisionDataset
class TestDataset(VisionDataset):
	pass
train_dataset = TestDataset(...)
from torch.utils.data import DataLoader
train_loader = DataLoader(
	train_dataset,
	batch_size=batch_size,
	shuffle=True,
	num_workers=4,
	pin_memory=True,
)
```

finally,dataset is able to get into `trainer.fit()`[^2]

```python
import lightning as L
from your_module import MyLightningModule
model = MyLightningModule()
trainer = L.Trainer()
trainer.fit(model, train_dataloader, val_dataloader)
```



### Splitting

### Collect Data

### Preprocessing

#### Vectorization

[^1]: https://madewithml.com/courses/mlops/preparation/

[^2]: https://lightning.ai/docs/pytorch/stable/common/trainer.html#basic-use
