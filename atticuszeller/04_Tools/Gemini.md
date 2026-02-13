# Gemini CLI

## Part 1: General Configuration & Tools

This section covers universal configurations, extensions, and the skills ecosystem applicable to any Gemini CLI environment.

### 1. Extensions Configuration

#### GitHub MCP Extension
To resolve authentication errors (e.g., `Authorization header is badly formatted`), you must configure a Personal Access Token (PAT).

1.  **Generate Token**: Navigate to [GitHub Settings](https://github.com/settings/tokens) -> Developer Settings -> Personal access tokens (classic). Generate a token with `repo`, `read:org`, and `read:packages` scopes.
2.  **Configure Environment**: Gemini CLI expects the token in the `.gemini/.env` file.

    __Windows (PowerShell):__
    ```powershell
    "GITHUB_MCP_PAT=ghp_your_token_here" | Out-File -Encoding utf8 -Append .gemini/.env
    ```
    _Note: Replace `ghp_your_token_here` with your actual token._

3.  **Restart**: Restart the CLI to load the new configuration. [^4]

#### Context7 Extension (Documentation RAG)
The `context7` extension provides real-time access to up-to-date documentation and code examples for thousands of libraries (e.g., PyTorch, FastAPI, React).

*   **Benefits**:
    *   **Accuracy**: Prevents model hallucinations of API details by fetching ground-truth documentation.
    *   **Up-to-date**: Access latest versions of libraries that might be newer than the model's training data.
*   **Core Tools**:
    *   `resolve-library-id`: Search for a library and get its unique ID (e.g., `/pytorch/docs`).
    *   `query-docs`: Query the documentation for specific tasks or examples. [^5]

### 2. Skills Ecosystem

#### Claude Ecosystem Compatibility
Gemini CLI is largely compatible with the Claude skill ecosystem. You can leverage high-quality skills developed for Claude Code and Claude.ai.

**Key Resources:**
- [anthropics/skills](https://github.com/anthropics/skills): Official Anthropic skills for doc processing (PDF, PPTX, XLSX, etc.) and code testing. The gold standard for skill definitions.
- [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills): Practical skills for Atlassian MCP (Jira/Confluence), Agile management, and frontend component generation.
- [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills): A curated collection of 300+ skills from major providers (Vercel, Stripe, Cloudflare, Hugging Face), compatible with Claude Code, Cursor, and Gemini CLI.

#### Recommended Dev Skills
These are general-purpose development skills useful in any workspace.

**Modern Python Skill**
Useful for modern Python development standards.
```bash
gemini skills install https://github.com/trailofbits/skills.git --path plugins/modern-python/skills/modern-python --scope workspace
```

**Git Commit Skill**
Automates structured git commit messages.
```bash
gemini skills install https://github.com/fvadicamo/dev-agent-skills.git --path skills/git-commit --scope workspace
```

---

## Part 2: Obsidian Integration SOP

This section details the specific configuration for integrating Gemini CLI with the Obsidian vault, managing the `99_system` structure, and mobile deployment.

### 1. Architecture & Philosophy

__Philosophy:__ Keep the context file (`GEMINI.md`) in the root for stability, and move configuration (`.gemini`) folder into a visible system directory (`99_system`) while maintaining CLI functionality via symbolic links.

*   **Target Structure:**
    *   `./GEMINI.md` -> `99_system/context/GEMINI.md` (Conceptually, though physically kept in root for sync safety)
    *   `./.gemini` -> `99_system/agents/gemini` (Symlinked)

#### Context File (Memory)
__Action:__ Keep `GEMINI.md` in the __Vault Root__.
*   __Path:__ `./GEMINI.md`
*   __Reasoning:__ This is the primary instruction file. Keeping it as a physical file in the root ensures maximum compatibility with Obsidian Sync, Git, and cross-platform usage without symlink risks.

### 2. Agent Configuration (Symlinks)

__Action:__ Move the hidden `.gemini` folder to `99_system` and symlink it.
__Reasoning:__ Obsidian cannot display dot-folders. Moving it makes it visible/editable in Obsidian.

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
Since Windows symlinks don't work in Linux, use this script (`fix_agent_config.sh`) to fix the `.gemini` link when switching OS.

```bash
#!/bin/bash
echo "Linking Agent Configuration…"

# 1. Remove the broken Windows link
rm -rf .gemini

# 2. Create Linux link for the config folder
ln -s 99_system/agents/gemini .gemini

echo "Done. Skills are now editable in Obsidian."
```

### 3. Skills Configuration Strategy

[^2][^3]
We adopt a __Hybrid Strategy__ for managing agent capabilities.

#### A. Global Skills (Public/Generic Tools)
__Use Case:__ Generic utilities (Web Search, Markdown formatting) installed at the __User level__ (`~/.gemini/skills`).

```PowerShell
# Obsidian Markdown formatting
gemini skills install https://github.com/kepano/obsidian-skills.git --path skills/obsidian-markdown --scope user

# Obsidian Native CLI Bridge
gemini skills install https://github.com/kepano/obsidian-skills.git --path skills/obsidian-cli --scope user
```

#### B. Workspace Skills (Private/Project Logic)
__Use Case:__ Logic specific to _this_ vault (SOPs, Scripts).
__Location:__ `99_system/agents/gemini/skills/` (via symlink).

1.  __Create Directory:__ `99_system/agents/gemini/skills/<skill_name>/`
2.  __Create Definition:__ `SKILL.md` inside that folder.

**Skill Template:**
```Markdown
---
name: my-custom-skill
description: A short description of what this skill does (visible in /skills list).
version: 1.0.0
---

# Skill System Prompt

[Write the detailed instructions, formatting rules, or persona definition here.]
```

#### Verification
```Bash
/skills refresh
/skills list
```

### 4. Advanced Usage & Personalization

#### A. Memory Management
Gemini CLI offers two distinct ways to manage context:

1.  **Simple Facts (`save_memory`)**: "Remember that I prefer dark mode."
2.  **Context Management (`context-manager` skill)**: Managing life phases in `GEMINI.md`.

**Context Manager Skill Example:**
```markdown
---
name: context-manager
description: Manage user context in GEMINI.md by splitting memory into 'Core Identity' (long-term) and 'Current Phase' (short-term).
version: 1.0.0
---

## Context Manager Protocol

You are the custodian of the user's personal context file (`GEMINI.md`). Your goal is to maintain a high-fidelity, up-to-date model of the user by categorizing information into two distinct layers: **Core Identity** (Static) and **Current Phase** (Dynamic).

### Operational Rules
... [See full protocol in previous versions]
```

#### B. Custom Commands
Encapsulate complex prompts in `99_system/agents/gemini/commands/`.

**Example: The Private Secretary (`\daily`)**
File: `99_system/agents/gemini/commands/daily.toml`

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

__Usage:__ `\daily "Woke up at 8am, feel good. Plan to study Gemini CLI."`

### 5. Obsidian Native CLI Integration

> [!info] Native CLI Support
> Obsidian now provides a native Command Line Interface (CLI). [Official Documentation](https://help.obsidian.md/cli).

#### Setup Steps
1.  Open Obsidian __Settings__ → __General__.
2.  Toggle __Enable Command line interface__.
3.  Follow the prompt to register Obsidian CLI.

### 6. Mobile Deployment (Android/Termux)

This guide details the __Termux + Gemini CLI + Obsidian__ deployment on Android.
__Core Philosophy:__ Single-direction sync (Obsidian -> Termux) for configuration, running directly in the Vault.

#### Phase 1: Network & Base Installation
1.  __Install Termux__: Download from [F-Droid](https://f-droid.org/en/packages/com.termux/).
2.  __Fix Repositories__:
    ```bash
    echo "deb https://packages.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
    ```
3.  __Install Dependencies__:
    ```bash
    pkg update -y && pkg upgrade -y
    pkg install git curl wget tar nodejs-lts termux-api -y
    ```

#### Phase 2: Terminal Environment (Zsh + P10k)
1.  __Install Nerd Font__:
    ```bash
    mkdir -p ~/.termux
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
    tar -xf JetBrainsMono.tar.xz
    mv JetBrainsMonoNerdFont-Regular.ttf ~/.termux/font.ttf
    rm JetBrainsMono*
    termux-reload-settings
    ```
2.  __Install Oh My Zsh & Plugins__:
    ```bash
    pkg install zsh -y
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    ```
3.  __Configure `.zshrc`__:
    ```bash
    ZSH_THEME="powerlevel10k/powerlevel10k"
    plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
    ```

#### Phase 3: Install Gemini Agent
```bash
npm install -g @mmmbuto/gemini-cli-termux@latest
```

#### Phase 4: Connect Obsidian (The Core Logic)
1.  __Grant Storage Permission__: `termux-setup-storage`
2.  __Link Vault__: `ln -s ~/storage/shared/Documents/Vault ~/Vault`
3.  __Inject Startup Script (`chat`)__: Add to `.zshrc`:

    ```bash
    # Gemini Launcher: One-way Sync (Obsidian -> Termux)
    function chat() {
        local VAULT_PATH="$HOME/Vault"

        # Check for Vault
        if [ ! -d "$VAULT_PATH" ]; then
            echo "❌ Error: Vault not found at $VAULT_PATH"
            return 1
        fi

        # Enter Vault (Gemini uses current dir for context)
        cd "$VAULT_PATH" || return

        echo "🔄 Syncing configuration (Obsidian -> Termux)..."

        # Force Copy Config (99_system -> .gemini)
        if [ -d "99_system/agents/gemini" ]; then
            cp -rf 99_system/agents/gemini ./.gemini
        else
            echo "⚠️ Warning: Config source not found in 99_system/agents/gemini"
        fi

        echo "🚀 Starting Gemini CLI..."
        gemini
        echo "✅ Session ended."
    }
    ```
4.  __Apply__: `source ~/.zshrc`

#### Usage
*   **Termux**: Type `chat`.

---
[^1]: [My Obsidian And Gemini CLI Workflow - YouTube](https://www.youtube.com/watch?v=JGwFsyyewYc)
[^2]: [Agent Skills \| Gemini CLI](https://geminicli.com/docs/cli/skills/)
[^3]: [Creating Agent Skills \| Gemini CLI](https://geminicli.com/docs/cli/creating-skills/)
[^4]: [GitHub MCP Server Configuration](https://github.com/github/github-mcp-server)
[^5]: [Context7 Extension | Gemini CLI](https://geminicli.com/extensions/?name=upstashcontext7)