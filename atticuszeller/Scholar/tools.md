# Tools

## Zotero

核心参考文档 [Zotero 中文社区 \| Zotero 中文维护小组](https://zotero-chinese.com/)

### Install

windows

```powershell
winget install DigitalScholar.Zotero
```

linux

![[OS/Ubuntu/System#Zotero]]

browser plugin [Zotero Connector - Chrome Web Store](https://chromewebstore.google.com/detail/zotero-connector/ekhagklcjbdpajgpjgmbionohlpdbjgc?hl=en)

Android version [Zotero - Apps on Google Play](https://play.google.com/store/apps/details?id=org.zotero.android&hl=en_US)

### Config

#### Core Plugin

sync
1. 注册官方账号就可以
2. 默认 300mb 空间够用 [^1]

#### 3rd Plugins

> 插件可能需要自己手动在不同平台手动安装配置

[zotero-better-notes.](https://github.com/windingwind/zotero-better-notes#readme) 是完全不需要的也不推荐，加工后的笔记，在 obsidian 里面编写，引用 zotero 的文章采用 zotero-integration 插件来解决简单内置 footnote 不清晰的问题。zotero 只负责阅读 pdf，高亮，批注。联动 obsidian 和 zotero 分层笔记模式只需要
- __Obsidian 端：__ 安装 Zotero Integration 插件。
- __Zotero 端：__ 安装 Better BibTex（这个是核心，为了生成稳定的引用键，比如 Smith2023）。

[^1]: [数据与文件的同步 \| Zotero 中文社区](https://zotero-chinese.com/user-guide/sync)
