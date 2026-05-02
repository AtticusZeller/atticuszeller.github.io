# Mypy

## [numpy](https://numpy.org/doc/2.1/reference/typing.html#examples)

type stubs will be included in `numpy` since `1.20`

```toml
[tool.mypy]
plugins = ["numpy.typing.mypy_plugin"]
```

### [scipy](https://github.com/jorenham/scipy-stubs)

```bash
uv add scipy-stubs
```
