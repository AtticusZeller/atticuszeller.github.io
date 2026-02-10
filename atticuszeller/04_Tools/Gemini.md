# Gemini CLI

## Obsidian Integration SOP

This guide details the configuration for integrating Gemini CLI with the Obsidian vault.
__Philosophy:__ Keep the context file (`GEMINI.md`) in the root for stability, and move configuration (`.gemini`) folder into a visible system directory (`99_system`) while maintaining CLI functionality via symbolic links.

### 1. Context File (Memory)

__Action:__ Keep `GEMINI.md` in the __Vault Root__.
- __Path:__ `./GEMINI.md`
- __Reasoning:__ This is the primary instruction file. Keeping it as a physical file in the root ensures maximum compatibility with Obsidian Sync, Git, and cross-platform usage without symlink risks.

### 2. Agent Configuration (Skills & Settings)

__Action:__ Move the hidden `.gemini` folder to `99_system` and symlink it.
- __Reasoning:__ Obsidian cannot display dot-folders (like `.gemini`). Moving the physical folder to `99_system` makes it visible and editable within Obsidian.

#### Windows (PowerShell Administrator)

```powershell
# 1. Create the visible agent directory
New-Item -ItemType Directory -Force -Path "99_system\agents"

# 2. Move the hidden .gemini folder to the visible location
# (Ensure you are not inside the folder when moving)
Move-Item -Path ".\.gemini" -Destination ".\99_system\agents\gemini"

# 3. Create the Symbolic Link (The CLI looks for .gemini in root)
New-Item -ItemType SymbolicLink -Path ".\.gemini" -Value ".\99_system\agents\gemini"
```

#### Linux / Dual-Boot Repair Script

Since Windows symlinks don't work in Linux, use this script to fix the `.gemini` link when switching OS. `GEMINI.md` needs no fix as it is a real file.

__File:__ `fix_agent_config.sh` (in root)

```bash
#!/bin/bash
echo "Linking Agent Configuration…"

# 1. Remove the broken Windows link
rm -rf .gemini

# 2. Create Linux link for the config folder
ln -s 99_system/agents/gemini .gemini

echo "Done. Skills are now editable in Obsidian."
```

### Reference

- __Target Structure:__
	- `99_system/context/GEMINI.md`: Long-term memory.
	- `99_system/agents/gemini/`: Agent skills and settings.
- __Root Links:__
	- `./GEMINI.md` -> `99_system/context/GEMINI.md`
	- `./.gemini` -> `99_system/agents/gemini`
[^1]

### Skills Configuration Strategy

[^2][^3]
We adopt a __Hybrid Strategy__ for managing agent capabilities. This ensures a clean separation between generic tools (Global) and project-specific logic (Workspace).

#### 1. Global Skills (Public/Generic Tools)

__Use Case:__ Generic utilities that apply to _any_ vault or project (e.g., Web Search, generic Markdown formatting, DALL-E image generation). These are installed at the __User level__ and do not clutter the Obsidian vault.

__Installation Command:__ Use the CLI command to install directly from GitHub.

```PowerShell
# Syntax: gemini skills install <git-url> --scope user
# Example: Installing the official Obsidian markdown skill globally
gemini skills install https://github.com/kepano/obsidian-skills.git --path skills/obsidian-markdown --scope user
```

- __Note:__ These skills are stored in `~/.gemini/skills` (System User Directory) and are not synced with the Obsidian Vault.

#### 2. Workspace Skills (Private/Project Logic)

__Use Case:__ Logic specific to _this_ project/vault (e.g., "Obsidian Tasks" formatting rules, specific project SOPs, custom scripts). These are stored __inside the Vault__ and synced across devices.

__Location:__ Due to the symbolic link configuration (`./.gemini` -> `./99_system/agents/gemini`), any skill created in the visible system folder is automatically recognized by the CLI.

__Path:__ `99_system/agents/gemini/skills/`

1. __Create Directory:__ `99_system/agents/gemini/skills/<skill_name>/`
2. __Create Definition:__ Inside that folder, create `SKILL.md`.
3. __Structure:__
	- `SKILL.md`: Contains the system instructions.
	- (Optional) `script.py` / `script.js` in `scripts/`: Executable logic.

skill template

```Markdown
---
name: my-custom-skill
description: A short description of what this skill does (visible in /skills list).
version: 1.0.0
---

# Skill System Prompt

[Write the detailed instructions, formatting rules, or persona definition here.]
```

#### 3. Verification

After installing global skills or creating local workspace skills, always refresh the CLI to load them.

```Bash
# In Gemini CLI
/skills refresh
/skills list
```

- __Expected Result:__
	- Global skills will appear (Scope: User/Global).
	- Local skills in `99_system` will appear (Scope: Workspace).

[^1]: [My Obsidian And Gemini CLI Workflow - YouTube](https://www.youtube.com/watch?v=JGwFsyyewYc)
[^2]: [Agent Skills \| Gemini CLI](https://geminicli.com/docs/cli/skills/)
[^3]: [Creating Agent Skills \| Gemini CLI](https://geminicli.com/docs/cli/creating-skills/)
