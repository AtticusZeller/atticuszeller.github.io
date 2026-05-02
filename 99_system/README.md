# 99_system/

跨机同步的系统资源。Obsidian Sync 同步本目录,git 追踪本目录。

## 子目录

- `agents/` — Claude / Gemini / etc 配置。
  在 vault 根用**相对** symlink 引用,例如:
  ```bash
  ln -s 99_system/agents/claude .claude
  ln -s 99_system/agents/gemini .gemini
  ```
  **务必相对路径** — 绝对路径 symlink (`/home/foo/...`) 跨机器会断。

- `assets/` — 系统级资源(主题图标、字体、CSS 片段、agent 用的提示文件等)。
  笔记的图片附件继续放在 vault 根的 `assets/`,不要混。
