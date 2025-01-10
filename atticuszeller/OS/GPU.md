# GPU

## Ubuntu

### Install [GPU Driver](https://www.nvidia.com/en-us/drivers/unix/)![assets/Pasted_image_20240412154259.png](assets/Pasted_image_20240412154259.png)

### Install `cudatoolkit` and `cudnn`

```yaml
name: your env
channels:
  - conda-forge
  - nvidia
  - defaults
dependencies:
  - python=3.10
  - cudatoolkit=11.8
  - cudnn=8.9.2.26
```

### GPU Monitor

```bash
conda install -c conda-forge nvitop
```
