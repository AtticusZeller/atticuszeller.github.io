# atticuszeller notes — build pipeline

This branch holds the mkdocs build pipeline for <https://docs.atticux.me/>.
Content lives on the `main` branch (Obsidian vault).

CI flow: push to main → notify.yml → workflow_dispatch on `page`
→ this branch's deploy.yml → mkdocs gh-deploy → gh-pages.

Local dev: `git checkout main` to edit notes; `git checkout page` to tweak build.
