# UV

## [Installation](https://docs.astral.sh/uv/getting-started/installation/)

- download

```shell
curl -LsSf https://astral.sh/uv/install.sh | sh
```

- apply

```zsh
source $HOME/.cargo/env
```

- update

```shell
uv self update
```

- auto auto completion

```shell
# Determine your shell (e.g., with `echo $SHELL`), then run one of:
echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc
echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
echo 'uv generate-shell-completion fish | source' >> ~/.config/fish/config.fish
echo 'eval (uv generate-shell-completion elvish | slurp)' >> ~/.elvish/rc.elv
```

```bash
# Determine your shell (e.g., with `echo $SHELL`), then run one of:
echo 'eval "$(uvx --generate-shell-completion bash)"' >> ~/.bashrc
echo 'eval "$(uvx --generate-shell-completion zsh)"' >> ~/.zshrc
echo 'uvx --generate-shell-completion fish | source' >> ~/.config/fish/config.fish
echo 'eval (uvx --generate-shell-completion elvish | slurp)' >> ~/.elvish/rc.elv
```

- Uninstallation

```shell
uv cache clean
rm -r "$(uv python dir)"
rm -r "$(uv tool dir)"
rm ~/.cargo/bin/uv ~/.cargo/bin/uvx
```

## [python](https://docs.astral.sh/uv/concepts/python-versions/#installing-a-python-version)

- `uv` will [automatically fetch Python versions](https://docs.astral.sh/uv/guides/install-python/#automatic-python-downloads) as needed — you don't need to install Python to get started.
- also it can manage your python envs
- Once Python is installed, it will be used by `uv` commands automatically.
- [activate venv](https://docs.astral.sh/uv/guides/projects/#running-commands:~:text=uv%20sync%0A%24%20source%20.venv/bin/activate)

```shell
uv sync
source .venv/bin/activate
```

- [Finding a Python executable](https://docs.astral.sh/uv/concepts/python-versions/#finding-a-python-executable:~:text=To%20find%20a%20Python%20executable%2C%20use%20the%20uv%20python%20find%20command%3A)

```shell
uv python find
```

## Tool

package installed as tool would be manage in a special isolated environment

`uvx` == `uv tool run`

```bash
uvx ruff check
```

## Dependencies

### Scripts

[Running scripts | uv](https://docs.astral.sh/uv/guides/scripts/)

we can add dependencies that are automatically managed by `uv` on calling:

```bash
uv add --script <your_script.py> "<package_a>" "<package_b>"
```

then we would find some the declaration of dependencies in your `your_script.py`

### Project

[Projects | uv](https://docs.astral.sh/uv/concepts/projects/)

we use `pyproject.toml` to manage python projects' dependencies.

#### Sync

sync all dependencies from `pyproject.toml`

```
uv sync --all-extras --dev
```

`sync` ->`dependencies`, `--all-extras` -> `--optional`, `--dev` -> `dev-dependencies`

#### Add

Package name and version would be added into `pyproject.toml` while calling:

```bash
uv add requests
```

Specify a version constraint

```bash
uv add 'requests==2.31.0'
```

Add a `git` dependency

```bash
uv add requests --git https://github.com/psf/requests
```

There ate _three_ sort of groups in `pyproject.toml`

1. we add package to `dependencies` of `[project]` normally
2. `dev-dependencies` of `[tool.uv]` contains developments needed
3. `optional_group` of `[project.optional-dependencies]` contains special group needed

```bash
uv add pytest --dev
```

```bash
uv add mkdocs-material pymdown-extensions mkdocs-glightbox mkdocs-git-revision-date-localized-plugin mkdocs-obsidian-bridge mkdocs-publisher --optional mkdocs
```

#### Update

update all

```bash
uv lock --upgrade
```

update specified

```bash
uv lock --upgrade-package requests
```

remove

```bash
uv remove requests
```
