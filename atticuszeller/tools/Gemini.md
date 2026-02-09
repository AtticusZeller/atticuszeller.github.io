# Gemini CLI

## Obsidian Integration SOP

This guide details the configuration for integrating Gemini CLI with the Obsidian vault structure. The goal is to move configuration (`.gemini`) and memory (`GEMINI.md`) files into a visible system directory (`99_system`) while maintaining CLI functionality via symbolic links.

### Windows Configuration

> [!WARNING] Administrator Privileges Required
> PowerShell must be run as Administrator to create symbolic links.

#### 1. Directory Structure

Create the dedicated system directories within the Vault root.

```powershell
# In Vault Root
New-Item -ItemType Directory -Force -Path "99_system\context"
New-Item -ItemType Directory -Force -Path "99_system\agents"
```

#### 2. Migrate Memory File

Move the context file and link it back to the root.

```powershell
# Move GEMINI.md
Move-Item -Path ".\GEMINI.md" -Destination ".\99_system\context\GEMINI.md"

# Create Symbolic Link
New-Item -ItemType SymbolicLink -Path ".\GEMINI.md" -Value ".\99_system\context\GEMINI.md"
```

#### 3. Migrate Agent Configuration

Move the hidden `.gemini` folder to a visible agent directory.

```powershell
# Move and rename .gemini to gemini
Move-Item -Path ".\.gemini" -Destination ".\99_system\agents\gemini"

# Create Symbolic Link (must be named .gemini for the CLI)
New-Item -ItemType SymbolicLink -Path ".\.gemini" -Value ".\99_system\agents\gemini"
```

### Linux / Dual-Boot Compatibility

Windows symbolic links are not compatible with Linux. Use the following script to repair links when switching OS.

#### Repair Script

Create a file named `fix_links_linux.sh` in the project root.

```bash
#!/bin/bash
# Usage: sh fix_links_linux.sh

echo "Adapting Symlinks for Linux..."

# 1. Remove Windows links
rm -f GEMINI.md
rm -f .gemini

# 2. Create Linux links
ln -s 99_system/context/GEMINI.md GEMINI.md
ln -s 99_system/agents/gemini .gemini

echo "Fix complete."
```

### Reference

*   **Target Structure:**
    *   `99_system/context/GEMINI.md`: Long-term memory.
    *   `99_system/agents/gemini/`: Agent skills and settings.
*   **Root Links:**
    *   `./GEMINI.md` -> `99_system/context/GEMINI.md`
    *   `./.gemini` -> `99_system/agents/gemini`
