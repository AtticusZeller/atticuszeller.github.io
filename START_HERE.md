# 🛠️ Handbook: The Execution Manual

> **Current Vault**: `Vault 3 - Handbook`
> **Role**: Engineering Implementation, Code Snippets, and "How-To" Guides.
> **Publication**: This vault is published via **MkDocs**. Structure matters.

## 1. 🏗️ The "Three-Vault" Philosophy
**This vault is ONLY for Level 3 (Action & Code).**

| Vault | Name | Purpose | Example Content |
| :--- | :--- | :--- | :--- |
| **1** | **LifeOS** | **Logistics** | "When to study." |
| **2** | **Scholar** | **Theory** | "What is a Transformer?" |
| **3 (Here)** | **Handbook** | **Execution** | **"How to implement `__call__` in Python?"**, **"Docker Compose for PostgreSQL"**. |

## 2. 🗺️ Directory Map (MkDocs Structure)
The root content is in `atticuszeller/`.

### `Language/` (Syntax & Standard Libs)
*   **Purpose**: Cheatsheets for coding languages.
*   **Content**: `Python/Mypy.md`, `C++/STL/vector.md`.

### `Backend/` & `OS/` (Infrastructure)
*   **Purpose**: Deployment and Environment.
*   **Content**: `Docker`, `FastAPI`, `Ubuntu` config, `SSH` keys setup.

### `Machine Learning/` & `Robots/` (The Stack)
*   **Purpose**: Framework usage (not theory).
*   **Content**: `PyTorch` dataloader snippets, `Isaac Lab` config steps. (Theory goes to Vault 2!).

### `tools/` (Dev Tools)
*   **Purpose**: Tool configuration manuals.
*   **Content**: `Git`, `Obsidian` plugins, `IDE` shortcuts.

### `private/` (⚠️ Local Only)
*   **Purpose**: API Keys, Tokens, Personal Configs.
*   **Rule**: Ensure these are EXCLUDED from the public MkDocs build (check `.gitignore` or `mkdocs.yml`).

## 3. 🧠 Agent Protocols
*   **Agent Persona**: "The Senior Engineer".
*   **Tone**: Pragmatic, code-heavy, minimal fluff.
*   **Focus**:
    *   **Snippets**: Provide copy-pasteable blocks.
    *   **Steps**: numbered lists for installation/setup.
    *   **Config**: YAML/JSON examples.
*   **Boundary**:
    *   **Ask**: "How does Backprop work?" -> **Go to Vault 2**.
    *   **Ask**: "PyTorch training loop boilerplate?" -> **Answer Here**.
