#!/usr/bin/env bash

run_uvx() {
    uvx --with mkdocs-material \
        --with mkdocs-git-revision-date-localized-plugin \
        --with mkdocs-glightbox \
        --with mkdocs-obsidian-bridge \
        --with mkdocs-publisher \
        --with pymdown-extensions \
        "$@"
}

if [ "$1" == "dev" ]; then
    # 启动本地开发服务器
    run_uvx mkdocs serve
elif [ "$1" == "deploy" ]; then
    # 部署到 GitHub Pages
    run_uvx mkdocs gh-deploy --force
else
    echo "usage: $0 {dev|deploy}"
    exit 1
fi