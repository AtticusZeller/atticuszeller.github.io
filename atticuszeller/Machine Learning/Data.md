# Data

For machine learning tasks, high-quality, uniformly distributed data is essential, as it indicates the need to identify the location of the target subspace within the high-dimensional input data encoding space

## Preparation

Preparing our dataset by __ingesting__ and __splitting__ it.[^1]

### Ingestion

#### IO

1. `pandas` -> `.csv`
2. `opencv`,`PIL`, [`kornia.image`](https://kornia.readthedocs.io/en/stable/image.html) -> `.jpg`,`.png`

#### Data Loader

inherit `VisionDataset` and pass it to `DataLoader`[^2]

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

finally,dataset is able to get into `trainer.fit()`[^3]

```python
import lightning as L
from your_module import MyLightningModule
model = MyLightningModule()
trainer = L.Trainer()
trainer.fit(model, train_dataloader, val_dataloader)
```

### Splitting

[DataModule](https://lightning.ai/docs/pytorch/stable/data/datamodule.html#lightningdatamodule)

> [!cite]
> we need to split our training dataset into `train` and `val` data splits.
>
> 1. Use the `train` split to train the model.
> > Here the model will have access to both inputs (features) and outputs (labels) to optimize its internal weights.
>
> 1. After each iteration (epoch) through the training split, we will use the `val` split to determine the model's performance.
> > Here the model will not use the labels to optimize its weights but instead, we will use the validation performance to optimize training hyperparameters such as the learning rate, etc.
>
> 1. Finally, we will use a separate holdout [`test` dataset](https://github.com/GokuMohandas/Made-With-ML/blob/main/datasets/holdout.csv) to determine the model's performance after training.
> > This is our best measure of how the model may behave on new, unseen data that is from a similar distribution to our training dataset.[^1]

### Collect Data

### Preprocessing

torchvision transform [^4]

#### Vectorization

[^1]: https://madewithml.com/courses/mlops/preparation/
[^2]: https://pytorch.org/tutorials/beginner/basics/data_tutorial.html#loading-a-dataset
[^3]: https://lightning.ai/docs/pytorch/stable/common/trainer.html#basic-use
[^4]: https://pytorch.org/vision/main/auto_examples/transforms/plot_transforms_e2e.html#sphx-glr-auto-examples-transforms-plot-transforms-e2e-py
