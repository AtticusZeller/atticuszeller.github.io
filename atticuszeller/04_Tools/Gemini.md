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

### 3. Obsidian Native CLI Integration

> [!info] Native CLI Support
> Obsidian now provides a native Command Line Interface (CLI) for advanced vault management and automation. [Official Documentation](https://help.obsidian.md/cli).

#### Prerequisites

- __Installer Version__: 1.11.7 or higher.
- __Early Access Version__: 1.12.x or higher.
- __Catalyst Members (Windows)__: You must run the `.com` file provided in the Obsidian Discord to register the CLI handler.

#### Setup Steps

1. Open Obsidian __Settings__ → __General__.
2. Toggle __Enable Command line interface__.
3. Follow the prompt to register Obsidian CLI.

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

__Use Case:__ Generic utilities that apply to _any_ vault or project (e.g., Web Search, generic Markdown formatting). These are installed at the __User level__.

__Installation Commands:__

```PowerShell
# Obsidian Markdown formatting
gemini skills install https://github.com/kepano/obsidian-skills.git --path skills/obsidian-markdown --scope user

# Obsidian Native CLI Bridge
gemini skills install https://github.com/kepano/obsidian-skills.git --path skills/obsidian-cli --scope user
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

## Advanced Usage & Personalization

### 1. Memory Management

Gemini CLI offers two distinct ways to manage context and memory:

#### A. Simple Facts (`save_memory`)

For small, persistent details like preferences, specific IDs, or one-off facts.
- __Usage:__ "Remember that I prefer dark mode."
- __Mechanism:__ The agent uses the `save_memory` tool to store this in its long-term memory.

#### B. Context Management (`context-manager` skill)

For managing broader life phases, goals, and identity shifts within `GEMINI.md`.
- __Usage:__ "Activate context-manager to update my current focus to 'Winter Break'."
- __Mechanism:__ This skill systematically updates the `GEMINI.md` file, separating __Core Identity__ (long-term) from __Current Phase__ (short-term/quarterly goals).

```markdown
---
name: context-manager
description: Manage user context in GEMINI.md by splitting memory into 'Core Identity' (long-term) and 'Current Phase' (short-term). Use this skill when the user provides personal information, updates on current projects, or changes in focus.
version: 1.0.0
---

## Context Manager Protocol

You are the custodian of the user's personal context file (`GEMINI.md`). Your goal is to maintain a high-fidelity, up-to-date model of the user by categorizing information into two distinct layers: **Core Identity** (Static) and **Current Phase** (Dynamic).

### Operational Rules

When updating `GEMINI.md`, you must strictly adhere to the following structure for the **User Context** section. Do not mix long-term traits with short-term goals.

#### 1. 🧬 Core Identity & Tech Stack (Long-Term Memory)
*   **Definition**: Information that rarely changes (e.g., Name, Role, Research Focus, Tech Stack, Personality).
*   **Update Trigger**: Explicit user profile updates or major life changes (e.g., graduation, new job).
*   **Format**: Use clear bullet points or sub-headers.
    *   **User Identity**: Name, Role, Research Focus, Commercial Interests.
    *   **Technical Stack**: OS, Tools, Languages, Workflow preferences.
    *   **Communication**: Tone, Format preferences (e.g., "Direct", "LaTeX for math").
    *   **Personal Interests**: Hobbies, aesthetics, relationship status.

#### 2. 📅 Current Phase & Focus (Short-Term Memory)
*   **Definition**: Information relevant to the current specific timeframe (e.g., "Winter Break 2026", "Thesis Crunch", "Internship Hunt").
*   **Update Trigger**: Conversation context indicating a shift in focus, new projects, or changing daily habits.
*   **Format**:
    *   **Current Date/Phase**: Explicitly state the active time window (e.g., "Winter Break 2026: Feb 08 - Mar 02").
    *   **Active Constraints**: Temporary limitations (e.g., "Living at home", "Gym closed").
    *   **Key Goals**: Top 3-5 priorities for this specific phase.
    *   **Recent Shifts**: Changes in mindset or strategy (e.g., "SNR Principle", "Transitioning to Career Mindset").

### Examples

**Example 1: Updating Core Identity**
User: "I'm switching from PyTorch to JAX for my new research."
Agent Action: Update the **Technical Stack** section in `GEMINI.md` to reflect "JAX" as the primary framework, moving "PyTorch" to secondary or keeping it if still relevant.

**Example 2: Updating Current Phase**
User: "School starts next week. I need to focus on my thesis and stop the gaming."
Agent Action:
1.  Update **Current Phase** to "Spring Semester Start".
2.  Add **Active Constraint**: "Thesis focus, No gaming".
3.  Remove outdated "Winter Break" goals.

**Example 3: New Preference**
User: "Stop using emojis in your responses."
Agent Action: Update **Communication** in **Core Identity** with "No emojis".
```

### 2. Custom Commands

For repetitive, complex prompts (like daily planning or specific coding tasks), encapsulate them into custom commands.

- __Documentation:__ [Custom Commands | Gemini CLI](https://geminicli.com/docs/cli/custom-commands/)
- __Location:__ `99_system/agents/gemini/commands/` (symlinked to `.gemini/commands/`).

#### Example: The Private Secretary (`\daily`)

Create a file `99_system/agents/gemini/commands/daily.toml`:

```toml
description = "Acts as a private secretary to organize the daily note."
prompt = """
Activate skills: 'obsidian-markdown', 'obsidian-tasks', 'obsidian-cli'.

Role: Private Secretary managing LifeOS (Vault 1).

Context:
- Today is: {{date}}
- Template: @99_system/templates/daily notes.md
- User Input: {{args}}

Task:
1. **Resolve Date**: Determine the correct filename for today.
2. **Check/Create**: Check for daily note; create from template if missing.
3. **Analyze Input**: Parse user input for Physiological, Psychological, Wisdom, and Tasks.
4. **Update File**: Insert info into sections without deleting existing content.
5. **Report**: Summarize updates.
"""
```

__Usage:__

```bash
\daily "Woke up at 8am, feel good. Plan to study Gemini CLI."
```

[^1]: [My Obsidian And Gemini CLI Workflow - YouTube](https://www.youtube.com/watch?v=JGwFsyyewYc)
[^2]: [Agent Skills \| Gemini CLI](https://geminicli.com/docs/cli/skills/)
[^3]: [Creating Agent Skills \| Gemini CLI](https://geminicli.com/docs/cli/creating-skills/)
