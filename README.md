# atticuszeller notes

Obsidian vault. Open this directory directly in Obsidian.

## Branches

- `main`     — pure vault content (this branch)
- `page`     — mkdocs build pipeline
- `gh-pages` — generated site (auto-built, do not edit)
- Site:       <https://docs.atticux.me/>

## Cross-machine sync

Two independent layers:

- **Files** — Obsidian Sync covers `.md` notes, `assets/`, `99_system/`,
  and selected `.obsidian/` options. Hidden folders (`.git`, AI tool dirs)
  are ignored automatically.
- **Git state** — `obsidian-git` plugin auto-pulls on startup and
  auto-commits/pushes every 5 minutes. GitHub is the source of truth.

See `99_system/README.md` for the system-resource layout.
