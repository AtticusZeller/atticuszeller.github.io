# Tools

## Overleaf

latex 写作工具

## Esayscholar

浏览器插件商店安装，主要是从他们的数据库中显示当前网页期刊的分类等级，影响因子等等
用于判断期刊质量，作为筛选文章的标准之一
也可以配合 Ethereal Style for Zotero 在 zotero 内部显示期刊分类和影响因子等等，最终阅读肯定是 zotero 里面，浏览器是初步的

自定义期刊比如人工智能，计算机，机器人期刊可以手动额外添加
35 一年会员

> 通过doi拉取的期刊信息，有时候arxiv 的doi是看不到正确的期刊信息的，需要手动检索正确的条目
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



#### pdf resolvers

![[assets/Pasted image 20251222202508.png|300]]

find `Config Eiditor` on the buttom of `edit->advanced` panel

set `extensions.zotero.findPDFs.resolvers`  as following:
```json
[{
  "name": "Google Scholar PDF",
  "method": "GET",
  "url": "https://scholar.google.com/scholar?q={doi}",
  "mode": "html",
  "selector": ".gs_or_ggsm a",
  "attribute": "href",
  "automatic": true
}]
```
 it will download pdf from google scholar 

#### Core Plugin

sync
1. 注册官方账号就可以
2. 默认 300mb 空间够用 [^1]，主要同步一些非附件的元数据，注释笔记等等

附件通过自定义的 webdev，镜像，配置 traefik 反向代理使用

```yaml

  webdav:
    image: ugeek/webdav:amd64
    container_name: zotero-webdav
    restart: unless-stopped
    environment:
      - USERNAME=Atticux      
      - PASSWORD=Zz030327#
      - TZ=Asia/Shanghai
      - UID=1000
      - GID=1000
    volumes:
      - ./zotero_data:/var/www/html/Data
    networks:
      - librechat_default
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.webdav.rule=Host(`zotero.atticux.me`)"
      - "traefik.http.routers.webdav.entrypoints=websecure"
      - "traefik.http.routers.webdav.tls=true"
      - "traefik.http.services.webdav.loadbalancer.server.port=80"
      - "traefik.http.routers.webdav.middlewares=secure-headers@file"
```

然后把 cloudflare 的 dns 解析加一条 `zotero.atticux.me`，因为和代理在一台机器所以，cdn 代理是关的

#### 3rd Plugins

> 插件可能需要自己手动在不同平台手动安装配置

[zotero-better-notes.](https://github.com/windingwind/zotero-better-notes#readme) 是完全不需要的也不推荐，加工后的笔记，在 obsidian 里面编写，引用 zotero 的文章采用 zotero-integration 插件来解决简单内置 footnote 不清晰的问题。zotero 只负责阅读 pdf，高亮，批注。联动 obsidian 和 zotero 分层笔记模式只需要
- __Obsidian 端：__ 安装 Zotero Integration 插件。
- __Zotero 端：__ 安装 Better BibTex（这个是核心，为了生成稳定的引用键，比如 Smith2023）。
- [zotero-pdf-translate.](https://github.com/windingwind/zotero-pdf-translate) 翻译问题，还是不建议全文翻译，这个太偷懒了。。，采用内置的局部翻译，摘要和总结直接翻译看就行了，选中翻译，配置 Google studio 的免费 api 额度，用 gemini 3 flash 翻译
- [Ethereal Style for Zotero](https://zotero-chinese.com/user-guide/plugins/style) 可以显示更多的阅读状态和期刊信息等等，影响因子和分区等等需要 esayscholar 浏览器插件 api

> # Awesome GPT for Zotero 比较多余，没必要再塞一个
> sci-hub只能抓取21年之前的pdf，没什么用了


- [Tara](https://github.com/l0o0/tara/tree/z7) 蒲公英插件解决了，很多插件，配置没有同步的问题，把这些配置信息打包成一个附件 `Tara_backup` 然后随着内置的 sync 功能上传，然后新的设备恢复这些插件和配置
- [Zotero Attanger](https://zotero-chinese.com/user-guide/plugins/zotero-attanger) 网上直接拉的 pdf 命名需要进行规范化一下，或者更规范的管理附件等等需求，由它自动实现
- [Installation :: Better BibTeX for Zotero](https://retorque.re/zotero-better-bibtex/installation/index.html) BBT 就是让 Zotero 变成一个完美的、自动化维护的 BibTeX/BibLaTeX 文献数据库，专为需要频繁在 LaTeX/Markdown 中引用文献的学术写作用户设计。
- [zotero-reference](https://github.com/MuiseDestiny/zotero-reference#readme) 自动从 pdf 结尾引用抓取信息，可以得到引用的简单的预览 ![[assets/Pasted image 20251218152932.png]]，快捷导入 zotero，而不是手动复制到浏览器再搜索，
	- 并且 ctrl+ 鼠标左键快捷翻译摘要，配合 pdf-translate 插件
	- 启动需要刷新
	- api 要切换到 ![[assets/Pasted image 20251218154000.png|200]] 因为
- [zotero-format-metadata](https://github.com/northword/zotero-format-metadata/tree/main) 格式化 metadata
- [zoplicate](https://github.com/ChenglongMa/zoplicate#readme) 处理重复的附件
- [zotero-actions-tags](https://github.com/windingwind/zotero-actions-tags#readme) 自动贴上没读的标签
- [GPT Meet Zotero.](https://github.com/MuiseDestiny/zotero-gpt) 接上 deepseek 总结全文，快速判断文章是否值得阅读

#### Obsidian Zotero Integretion

- [Zotero import template for the Zotero integration plugin for Obsidian. Screenshots and usage guide over in the Obsidian forum here: https://forum.obsidian.md/t/zotero-integration-import-templates/36310/105?u=feralflora · GitHub](https://gist.github.com/FeralFlora/78f494c1862ce4457cef28d9d9ba5a01?referrer=grok.com)

[^1]: [数据与文件的同步 \| Zotero 中文社区](https://zotero-chinese.com/user-guide/sync)
