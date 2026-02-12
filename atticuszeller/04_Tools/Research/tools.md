# Tools

## Obsidian

在 obsidian 里面写逻辑，引用，按照约定格式导入注释的汇总
[^1]

### Citation

zotero 需要安装 [Better BibTeX for Zotero](https://retorque.re/zotero-better-bibtex/installation/index.html) 这是向外提供引用键 citekey 的基础，导出格式采用推荐的 better biblatex，导出的是 `.bib` 文件，确保是自动更新的，其他默认配置就行

[Obsidian Zotero Integretion](https://github.com/mgmeyers/obsidian-zotero-integration) 它负责从 zotero 获取并且生成 citekey 在 markdown 中，但是为了在 obsidian 里面可以自动渲染，反向链接和引用列表
- ![[assets/Pasted image 20260109104246.png]]
- ![[assets/Pasted image 20260109104258.png|200]]
- ![[assets/Pasted image 20260109104334.png|200]]
需要采用 `pandoc` 的引用格式并且配置 [obsidian-pandoc-reference-list](<(https://github.com/mgmeyers/obsidian-pandoc-reference-list>)

![[assets/Pasted image 20260109104914.png|400]]

### Import Notes

zotero 中除了文献条目的元数据，需要汇总的是对文章的批注 ![[assets/Pasted image 20260109105329.png]]

对这些阅读时候产生的理解上的碎片和记录，需要汇总到 obsidian 里面，虽然 zotero 的 better notes 插件可以在 zotero 里面实现 markdown 的基本渲染，我觉得用途局限于让 zotero 里面的 markdown 不那么难看，达不到系统性管理 markdown 笔记的层次，因此我觉得直接对 annotation 进行汇总到 obsidian 里面是必要的

收集 annotation 的方式是基于提供一个模板文件给 obsidian zotero integretion 插件的，大致思路用 gemini 生成了，yaml 块简单显示，metadata 和有评论的注释，和条目里面单独的笔记追加进去并且做成 callout 块看起来更清楚，没有评论的单独做成词条

> [!example]- template
>
> ```jinjia
> ---
> title: "{{title}}"
> authors: [{%- for creator in creators -%}"{{creator.firstName}} {{creator.lastName}}"{%- if not loop.last -%}, {% endif -%}{%- endfor -%}]
> date: {{ date | format("YYYY-MM-DD") }}
> journal: "{{publicationTitle}}"
> doi: {{DOI}}
> tags:
>   - {{itemType}}
> {%- if allTags %}
>   - {{allTags | replace(" ", "_")}}
> {%- endif %}
> category: literaturenote
> citekey: {{citekey}}
> ---
>
> > [!INFO] Metadata
> > * **Title**:: [{{title}}]({{select}})
> > * **Authors**:: {%- for creator in creators %} {{creator.firstName}} {{creator.lastName}}{% if not loop.last %}, {% endif %}{% endfor %}
> > * **Date**:: {{ date | format("YYYY-MM-DD") }}
> > * **Journal**:: {{publicationTitle}} {%- if volume %} {{volume}} {{issue}}{%- endif %}
> > * **Citekey**:: [[@{{citekey}}]]
> > * **Item Type**:: {{itemType}}
> > * **Related**:: {% for relation in relations | selectattr("citekey") %} [[@{{relation.citekey}}]]{% if not loop.last %}, {% endif%} {% endfor %}
> {%- if DOI %}
> > * **DOI**:: [{{DOI}}](https://doi.org/{{DOI}})
> {%- endif %}
> > * **Attachments**:: {%- for attachment in attachments | filterby("path", "endswith", ".pdf") %} [{{attachment.title}}](file://{{attachment.path | replace(" ", "%20")}}) {%- endfor -%}
>
> <br>
>
> > [!ABSTRACT]- Abstract
> > {{abstractNote}}
>
> ## 📝 研读笔记 (With Comments)
>
> {% persist "annotations" %}
>
> {% set newAnnotations = annotations | filterby("date", "dateafter", lastImportDate) %}
>
> {% if newAnnotations.length > 0 %}
>
> {%- for a in newAnnotations -%}
>
> {%- if a.comment %}
>
> > [!TIP] 💡 My Thought
> > **原文 (p.{{a.pageLabel}})**:
> >
> > > {{a.annotatedText | replace("\n", "\n> > ")}}
> > >
> > > [Link to PDF]({{a.desktopURI}})
> >
> > {{a.comment | replace("\n", "\n> ")}}
>
> {% endif -%}
>
> {%- endfor %}
>
> ## 📌 关键摘录汇总 (Highlights Only)
>
> {%- for a in newAnnotations -%}
>
> {%- if not a.comment -%}
>
> * {{a.annotatedText | replace("\n", " ")}} ([p.{{a.pageLabel}}]({{a.desktopURI}}))
> {% endif -%}
> {%- endfor %}
> {% endif %}
> {% endpersist %}
>
> {# ----- 处理 Zotero 独立笔记 (Standalone Notes) ----- #}
>
> {%- if notes.length > 0 %}
>
> ## 📑 Zotero Notes (General Summary)
>
> {%- for note in notes %}
>
> > [!NOTE] {{note.title if note.title else "Zotero Note"}}
> > {{note.note | replace("\n", "\n> ")}}
> {% endfor -%}
> {%- endif -%}
>
> ```

配置对应输出目录和文件名 ![[assets/Pasted image 20260109121213.png|300]]
citekey 目录下面是汇总的 notes 和手写的 `review.md` 笔记
采用 `ctrl+shift+alt+N` 绑定快捷键导入笔记

## Pandoc

```powershell
scoop install pandoc
```

转化 markdown（比如 `review.md` 文件） 为初步 tex 文件，不需要 pandoc 生成引用文献列表，只需要将 markdown 里面的 pandoc style 的 citekey 转化为 latex 的 citekey 就行

pandoc 的转化 tex 命令

pandoc 和 markdown 是为了平时写作的体验感，最终生成 pdf 需要结合 latex workstation 再进行对 latex 微调生成最终的 pdf

> 但是现在不用恶心的 latex 编译排版啥的，直接用 obsidian 的 enhanced export 插件配合 pandoc 直接生成引用文献参考目录就行了，平时停留在 obsidian 里面就行

## vscode+LaTeX Workshop

用 git 和 vscode 配合写作 latex 吧这个既可以版本控制也可以云端推送，而且可以本地快速编译查看效果

```powershell
scoop bucket add dorado https://github.com/chawyehsu/dorado
scoop install texlive-full
```

不要 `scoop install texlive` 这个有点像边下载边安装很慢，`full` 下载整个 `iso` 然后解压安装

模板仓库采用 [XuehaiPan/LaTeX-Templates](https://github.com/XuehaiPan/LaTeX-Templates)

## Esayscholar

浏览器插件商店安装，主要是从他们的数据库中显示当前网页期刊的分类等级，影响因子等等
用于判断期刊质量，作为筛选文章的标准之一
也可以配合 Ethereal Style for Zotero 在 zotero 内部显示期刊分类和影响因子等等，最终阅读肯定是 zotero 里面，浏览器是初步的

自定义期刊比如人工智能，计算机，机器人期刊可以手动额外添加
35 一年会员

> 通过 doi 拉取的期刊信息，有时候 arxiv 的 doi 是看不到正确的期刊信息的，需要手动检索正确的条目

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

#### Pdf Resolvers

![[assets/Pasted image 20251222202508.png|300]]

find `Config Eiditor` on the buttom of `edit->advanced` panel

set `extensions.zotero.findPDFs.resolvers` as following:

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

如果 zotero 里面拉取失败，Google scholar 有 pdf，但是需要手动验证，可能得打开网页手动验证或者关掉代理重试

> 真下载不了的那种，必须要充钱的，用 [sci-down](https://www.scidown.cn/)

但是得注册 sci-down 网盘 [注册账号链接](https://www.scidown.cn/wangpan/link.php?yq=llllll99)[完整注册教程xhs](http://xhslink.com/o/6WrxWUQpvas)

#### Core Plugin

sync
1. 注册官方账号就可以
2. 默认 300mb 空间够用 [^2]，主要同步一些非附件的元数据，注释笔记等等

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

- [zotero-better-notes.](https://github.com/windingwind/zotero-better-notes#readme) 作为基本的笔记功能，可以显示 markdown，配合其他插件使用，主要汇总 pdf 阅读产生的 annotation 到一个 notes 里面，然后这些 notes 可以被导入到 obsidian 里面
- __Obsidian 端：__ 安装 Zotero Integration 插件。
- __Zotero 端：__ 安装 Better BibTex（这个是核心，为了生成稳定的引用键，比如 Smith2023）。
- [zotero-pdf-translate.](https://github.com/windingwind/zotero-pdf-translate) 翻译问题，还是不建议全文翻译，这个太偷懒了。。，采用内置的局部翻译，摘要和总结直接翻译看就行了，选中翻译，配置 Google studio 的免费 api 额度，用 gemini 3 flash 翻译
- [Ethereal Style for Zotero](https://zotero-chinese.com/user-guide/plugins/style) 可以显示更多的阅读状态和期刊信息等等，影响因子和分区等等需要 esayscholar 浏览器插件 api

> sci-hub 只能抓取 21 年之前的 pdf，没什么用了

- [Tara](https://github.com/l0o0/tara/tree/z7) 蒲公英插件解决了，很多插件，配置没有同步的问题，把这些配置信息打包成一个附件 `Tara_backup` 然后随着内置的 sync 功能上传，然后新的设备恢复这些插件和配置
- [Zotero Attanger](https://zotero-chinese.com/user-guide/plugins/zotero-attanger) 网上直接拉的 pdf 命名需要进行规范化一下，或者更规范的管理附件等等需求，由它自动实现
- [Installation :: Better BibTeX for Zotero](https://retorque.re/zotero-better-bibtex/installation/index.html) BBT 就是让 Zotero 变成一个完美的、自动化维护的 BibTeX/BibLaTeX 文献数据库，专为需要频繁在 LaTeX/Markdown 中引用文献的学术写作用户设计。
- [zotero-reference](https://github.com/MuiseDestiny/zotero-reference#readme) 自动从 pdf 结尾引用抓取信息，可以得到引用的简单的预览 ![[assets/Pasted image 20251218152932.png]]，快捷导入 zotero，而不是手动复制到浏览器再搜索，
	- 并且 ctrl+ 鼠标左键快捷翻译摘要，配合 pdf-translate 插件
	- 启动需要刷新
	- api 要切换到 ![[assets/Pasted image 20251218154000.png|200]] 因为
- [zotero-format-metadata](https://github.com/northword/zotero-format-metadata/tree/main) 格式化 metadata
- [zoplicate](https://github.com/ChenglongMa/zoplicate#readme) 处理重复的附件
- [zotero-actions-tags](https://github.com/windingwind/zotero-actions-tags#readme) 自动贴上没读的标签，自定义快捷键和脚本行为，添加 tags 脚本 [^3]
- [GPT Meet Zotero.](https://github.com/MuiseDestiny/zotero-gpt) 接上 gemini 3 总结全文，快速判断文章是否值得阅读，并且阅读过程中选中局部文本快速提问和记录到注释
- 前端 [pdf2zh](https://github.com/guaguastandup/zotero-pdf2zh?tab=readme-ov-file) ，配置 deepseek 全文翻译，生成 pdf 并且解析论文，方便快速阅读，后端按照官网教程显示，跑一下 flask 接住前端，然后 pdf2zh_next 解析生成 pdf
- [ZotMoov](https://github.com/wileyyugioh/zotmoov) 把 pdf 集中移动到指定文件夹，方便单独需要 pdf 的情况，比如配合 notebooklm 到 Google drive 使用，同步我们采用了 webdev 确保行为是 copy

## Notebooklm

谷歌官方 rag 不知道效果如何，得配合 Google drive 方便共享需要看的 pdf，方便看多篇之间的联系和直接对文档提问

[^1]: [An Updated Academic Workflow: Zotero & Obsidian \| by Alexandra Phelan \| Medium](https://medium.com/@alexandraphelan/an-updated-academic-workflow-zotero-obsidian-cffef080addd)
[^2]: [数据与文件的同步 \| Zotero 中文社区](https://zotero-chinese.com/user-guide/sync)
[^3]: [Add tag shortcut (working in Zotero 7) · windingwind/zotero-actions-tags · Discussion #390 · GitHub](https://github.com/windingwind/zotero-actions-tags/discussions/390)
