# [Installation](https://docs.astral.sh/uv/getting-started/installation/)

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

- enable Sudo

```bash
sudo ln -sf $(which uv) /usr/local/bin/
```

# [python](https://docs.astral.sh/uv/concepts/python-versions/#installing-a-python-version)

- `uv` will [automatically fetch Python versions](https://docs.astral.sh/uv/guides/install-python/#automatic-python-downloads) as needed — you don't need to install Python to get started.
- also it can manage your python envs
- Once Python is installed, it will be used by `uv` commands automatically.
- [activate venv](https://docs.astral.sh/uv/guides/projects/#running-commands:~:text=uv%20sync%0A%24%20source%20.venv/bin/activate)

```shell
uv sync
source .venv/bin/activate
```

activate in `zsh` automatically

```bash
if ! grep -q "auto_activate_venv" ~/.zshrc; then
    echo '
function auto_activate_venv() {
    # finding .venv
    local current_dir="$PWD"
    while [[ "$current_dir" != "/" ]]; do
        if [[ -d "$current_dir/.venv" ]]; then
            source "$current_dir/.venv/bin/activate"
            # echo "🐍 Virtual environment activated: $current_dir/.venv"
            return
        fi
        current_dir="$(dirname "$current_dir")"
    done
}

# Initial check when opening terminal
auto_activate_venv' >> ~/.zshrc
    echo "Added auto_activate_venv to .zshrc"
else
    echo "auto_activate_venv already exists in .zshrc"
fi
```

- [Finding a Python executable](https://docs.astral.sh/uv/concepts/python-versions/#finding-a-python-executable:~:text=To%20find%20a%20Python%20executable%2C%20use%20the%20uv%20python%20find%20command%3A)

```shell
uv python find
```

# Tool

package installed as tool would be manage in a special isolated environment

`uvx` == `uv tool run`

```bash
ruff check
```

# Dependencies

## [Scripts](https://docs.astral.sh/uv/guides/scripts)

we can add dependencies that are automatically managed by `uv` on calling:

```bash
uv add --script <your_script.py> "<package_a>" "<package_b>"
```

then we would find some the declaration of dependencies in your `your_script.py`

## [Project](https://docs.astral.sh/uv/concepts/projects)

we use `pyproject.toml` to manage python projects' dependencies.

### Add

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
2. `dependency-groups` of `[tool.uv]` contains developments needed
3. `optional_group` of `[project.optional-dependencies]` contains special group needed

```bash
# same to uv add --group dev pytest
uv add pytest --dev
```

```bash
uv add --group docs mkdocs
```

### Sync

sync all dependencies from `pyproject.toml`

```
uv sync --all-extras --all-groups
```

`sync` ->`dependencies`, `--all-extras` -> `--optional`, `--all-groups` -> `dependency-groups`

### Update

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
