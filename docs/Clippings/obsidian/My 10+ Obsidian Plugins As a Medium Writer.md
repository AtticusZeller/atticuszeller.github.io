---
title: "My 10+ Obsidian Plugins As a Medium Writer"
source: "https://medium.programmerscareer.com/my-10-obsidian-plugins-as-a-medium-writer-6f440119587f"
author:
  - "Wesley Wei"
published: 2024-07-16
created: 2024-10-21
description: "Hello, here is Wesley, Today’s article is about Obsidian Plugins. Without further ado, let’s get started.💪 I highly recommend Richard Feynman’s approach to promoting self-learning through output…"
tags:
  - "plugin"
---
## Streamline Your Workflow: Top Plugins for Obsidian Writers

[

![Wesley Wei](https://miro.medium.com/v2/resize:fill:88:88/1*hCLWNjdqAVrir1skS1WAaw.jpeg)

](https://wesley-wei.medium.com/?source=post_page-----6f440119587f--------------------------------)[

![Programmer’s Career](https://miro.medium.com/v2/resize:fill:48:48/1*o2ds7K8QjAnEJBhcD63ZwA.png)

](https://medium.programmerscareer.com/?source=post_page-----6f440119587f--------------------------------)

![](https://miro.medium.com/v2/resize:fit:1400/0*Vsm36yrGvKkbrI65)

Photo by [Claudio Schwarz](https://unsplash.com/@purzlbaum?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com/?utm_source=medium&utm_medium=referral)

Hello, here is Wesley, Today’s article is about Obsidian Plugins. Without further ado, let’s get started.💪

## Overview

==I highly recommend Richard Feynman’s approach to promoting self-learning through output. First, unreflected output is useless and won’t attract anyone’s attention; second, when you decide to write an article introducing a piece of knowledge, you need to convince yourself that you’ve learned something before wanting to share it with others.==

Unconsciously, output will become a huge driving force, allowing you to enter the learning state faster and helping you learn more deeply. Moreover, each time you output, it’s like reviewing and refining your understanding of the knowledge for yourself, and sharing it with others through records and exchanges.

I’ve been writing on Medium for some time now, and I think there are many good feedback mechanisms here because there are many readers and a paid subscription wall. So why not continue writing on Medium?

In my journey as a writer, I’ve used many note-taking software tools, including OneNote and Notion, but they all have their limitations. Now, I’m using Obsidian as my main note-taking tool, which has native support for local files and a wide range of plugins that make me love it even more. This allows me to write on Medium with greater ease, and this article will share some simple tips.

This article may be suitable for those who have used Obsidian before. Here, I’ll introduce the plugins I commonly use when writing blog posts or outputting content.

The focus of this article is on showcasing the effectiveness of using these plugins, rather than step-by-step instructions. If you think these plugins might be helpful to you, feel free to explore them yourself.

## 1\. Content-related

## 1.1 Templater

This plugin helps me reduce repetitive work when creating new series articles. Whenever I create a new article, I consider using Templater to lower my workload.

When you set up the template, it can generate content according to your settings, such as:

![](https://miro.medium.com/v2/resize:fit:1400/0*Q5ILV60tB61E-n92.gif)

The corresponding Templater code is as follows:

```
---<%*  let title = tp.file.title  if (title.startsWith("Untitled")) {    title = await tp.system.prompt("Title");    await tp.file.rename(title);  }%>title: <%* tR += title %>author: Wesley Weidate: <% tp.file.creation_date() %>tags: stayaheadcategories: efficiency---<% tp.web.random_picture("500x500", "landscape, nature") %><% tp.user.quote(tp) %>
```

Note that the quote function is customized according to my own blog format:

```
async function quote(tp) {      str = await tp.web.daily_quote()    let newStr = str.replace(/>\s\[!quote]\s/g, "");    newStr = newStr.replace(/>/g, "");  newStr = "{% colorquote success %}\n" + newStr;  newStr += "\n{% endcolorquote %}";  return newStr}module.exports = quote;
```

If you’re interested in setting up more customized content, you can refer to Templater’s official documentation.

## 1.2 Auto Link Title

This plugin is very convenient and intuitive, so I directly quoted the official content:

![](https://miro.medium.com/v2/resize:fit:1340/0*mrMXmlUj_51YV4HX.png)

This plugin automatically fetches the webpage to extract link titles when they’re pasted, creating a markdown link with the correct title set.

For example:  
When pasting [https://github.com/zolrath/obsidian-auto-link-title](https://github.com/zolrath/obsidian-auto-link-title), the plugin fetches the page and retrieves the title, resulting in a paste of: [zolrath/obsidian-auto-link-title: Automatically fetch the titles of pasted links](https://github.com/zolrath/obsidian-auto-link-title)

## 1.3 Copilot

Writing processes can always benefit from AI assistance, such as generating medium article subtitles.

For my article: [Timer changes in Go 1.23: Enhancing Accuracy and Simplifying Concurrency | by Wesley Wei | Jul, 2024 | Programmer’s Career](https://medium.com/programmers-career/timer-changes-in-go-1-23-enhancing-accuracy-and-simplifying-concurrency-c45399598185), I used the Copilot plugin to ask Ollama for its opinion, and it provided the following response:

![](https://miro.medium.com/v2/resize:fit:1400/0*kAa87fLX1UBUZixX.png)

If you’re familiar with this content, you’ll find that its response is indeed worth referencing. The corresponding prompt is as follows:

![](https://miro.medium.com/v2/resize:fit:1400/0*tDT8BnSxoUArC1lg.png)

AI is still rapidly developing, and its potential is limitless. If you input the corresponding prompt and question, it can provide relevant responses. We can fully utilize localized AI to boost productivity. Why not use it?

Free AI tools are already very useful today. I welcome you to read my previous article:

> *More about My AI Tools:* [*Welcome to the AI Revolution: My Guide to Essential Tools and Concepts | by Wesley Wei | Jun, 2024 | Programmer’s Career*](https://medium.com/programmers-career/welcome-to-the-ai-revolution-my-guide-to-essential-tools-and-concepts-44bd7ca44362)

## 1.4 Linter

This plugin can help us standardize article formatting. I’ve made some customizations, and whenever I trigger the save article shortcut key, this plugin can automatically format my article according to my customized style, as shown below:

![](https://miro.medium.com/v2/resize:fit:1400/0*YQzPmpzVR3ELsybL.gif)

If you’re someone who writes frequently, you should understand what this means: **time-saving**.

When I finish writing an article, all I need to do is input the shortcut key, and the article formatting will be basically done, which will definitely save a lot of time.

## 2\. Usage-related

## 2.1 Another Quick Switcher, Better Command Palette, Omnisearch

![](https://miro.medium.com/v2/resize:fit:1400/0*tBA5KQuqqve2JQiO.png)

What I use most often in Another Quick Switcher is — Recent search. By setting a shortcut key, I can quickly know which articles I’ve recently opened.

![](https://miro.medium.com/v2/resize:fit:1400/0*ef4WheGL58i1Dr2T.png)

Better Command Palette helps me find commands more easily. Similarly, by setting a shortcut key, I can quickly open the search and use the command.

![](https://miro.medium.com/v2/resize:fit:1400/0*6MFaaS7nlheRRH-s.png)

Omnisearch performs faster and more detailed searches.

## 2.2 ExcaliBrain, Excalidraw

![](https://miro.medium.com/v2/resize:fit:1400/0*pYg_KO0Hahm8SiZX.png)

ExcaliBrain can help me view my articles from various angles and visualize them as images. It also allows me to see relationships between this article and other articles.

![](https://miro.medium.com/v2/resize:fit:1400/0*VigiDDXdzg0BkADa.png)

Excalidraw enables me to create diagrams locally, and with ExcaliBrain, I can modify the structure diagram of my article and generate an image that represents the structure I want.

## 2.3 Style Settings, Supercharged Links

![](https://miro.medium.com/v2/resize:fit:1400/0*cz5qg2HZN1wr05-Z.png)

Style Settings and Supercharged Links allow me to categorize my articles based on tags and other dimensions, which helps me manage my articles. For example, I set different colors for articles with different tags:

![](https://miro.medium.com/v2/resize:fit:1236/0*3HIMoo_zQw1aixzS.png)

## 2.4 Commander

This plugin enables me to customize some frequently used commands. For instance, I can create a command to enter or exit focus mode and place it on the Tab Bar:

![](https://miro.medium.com/v2/resize:fit:1400/0*lx_zcD-zMCLlzKHP.png)

![](https://miro.medium.com/v2/resize:fit:1400/0*_fIbrYnc2FLIIu2C.png)

![](https://miro.medium.com/v2/resize:fit:1400/0*NNQwUg3z56Sm8ork.png)

By clicking on the icon in the top-right corner, I can easily toggle the status bar on or off. Of course, this is just one small example, and there are many more things to explore.

## 3\. Tools-Related

## 3.1 Image Auto Upload Plugin

This plugin helps us use PicGo to upload images to third-party services, without saving them locally. The uploading process is as follows:

![](https://miro.medium.com/v2/resize:fit:1292/0*Pc8sDRd3R6L_JDd3.png)

## 3.2 Git

![](https://miro.medium.com/v2/resize:fit:1400/0*0Rndqb21TA-6n0US.png)

When I publish my articles on Medium and my blog, I use this plugin to push them to GitHub with one click, then deploy the blog content to my server using GitHub Actions.

## 3.3 Terminal

We all know that Obsidian’s default files are in Markdown format, but sometimes I need to create other types of files, such as a custom JavaScript file for the Template plugin. This requires me to switch to another window to create these types of files, which is inconvenient and distracts from my workflow.

I solved this problem by using the Terminal plugin, which allows us to open a terminal in the same Obsidian instance and create a JavaScript file through the terminal.

![](https://miro.medium.com/v2/resize:fit:1400/0*sYABlFDfh5W0oEoh.png)

Of course, if you’re familiar with terminals, you’ll understand that it can do many more things.

## 4\. Conclusion

All plugins can be downloaded through Community plugins, and you can choose the ones that are helpful to you based on the recommendations above.

![](https://miro.medium.com/v2/resize:fit:1400/0*_nUW2n2yohVEdR41.png)

I think there are too many plugins on Obsidian, which can be overwhelming. I believe we only need to select the ones that best suit our needs. I hope my recommended plugins include what you’re looking for.

The plugins mentioned in this article are all those I’ve accumulated over time while using Obsidian to write slowly. They’re just a small part of the iceberg when it comes to Obsidian plugins, and the usage scenarios are only personal examples. **I welcome your comments telling me which plugins you like and how you use them.**

More Series Articles about Stay Ahead of The Curve：

![Wesley Wei](https://miro.medium.com/v2/resize:fill:40:40/1*hCLWNjdqAVrir1skS1WAaw.jpeg)

## Stay Ahead of The Curve

And I’m Wesley, delighted to share knowledge from the world of programming.

**Don’t forget to follow me for more informative content, or feel free to share this with others who may also find it beneficial. it would be a great help to me.**

> *Give me some free applauds, highlights, or replies, and I’ll pay attention to those reactions, which will determine whether or not I continue to post this type of article.*

See you in the next article. 👋

> *中文文章:* [*https://programmerscareer.com/zh-cn/obsidian-plugins/*](https://programmerscareer.com/zh-cn/obsidian-plugins/)*Author:* [*Wesley Wei — Twitter*](https://twitter.com/WesleyWei0316) [*Wesley Wei — Medium*](https://wesley-wei.medium.com/)*Note: Originally written at* [*https://programmerscareer.com/obsidian-plugins/*](https://programmerscareer.com/obsidian-plugins/) *at 2024–07–14 21:38. If you choose to repost or use this article, please cite the original source.*