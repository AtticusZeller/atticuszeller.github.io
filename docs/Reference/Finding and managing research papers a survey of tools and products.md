---
title: "Finding and managing research papers: a survey of tools and products"
source: https://towardsdatascience.com/finding-and-managing-research-papers-a-survey-of-tools-and-products-9151810d1b4d
author:
  - Eddie Smolyansky
published: 2018-11-12
created: 2024-11-17
description: "At the end of this post you can find a tl;dr with my suggestions for the most useful tools to improve your workflow with scientific papers. Major update (2020): We have released a tool for visually…"
tags:
  - scholar
---

# Finding and Managing Research Papers a Survey of Tools and Products

[![Eddie Smolyansky](https://miro.medium.com/v2/resize:fill:88:88/1*tJ79i_Lb0Y3XqFWCQeExzA.jpeg)](https://medium.com/@eddiesmo?source=post_page---byline--9151810d1b4d--------------------------------)

[![Towards Data Science](https://miro.medium.com/v2/resize:fill:48:48/1*CJe3891yB1A1mzMdqemkdg.jpeg)](https://towardsdatascience.com/?source=post_page---byline--9151810d1b4d--------------------------------)

___At the end of this post you can find a tl;dr with my suggestions for the most useful tools to improve your workflow with scientific papers.___

__Major update (2020):
We have released a tool for visually finding and exploring academic papers. See our__ [**launching blog post**](https://medium.com/connectedpapers/announcing-connected-papers-a-visual-tool-for-researchers-to-find-and-explore-academic-papers-89146a54c7d4?sk=eb6c686826e03958504008fedeffea18) __for__ [**Connected Papers**](https://www.connectedpapers.com/)__!__

As researchers, especially in (overly) prolific fields like Deep Learning, we often find ourselves overwhelmed by the huge amount of papers to read and keep track of in our work. I think one big reason for this is insufficient use of existing tools and services that aim to make our life easier. Another reason is the lack of a really __good__ product which meets all our needs under one interface, but that is a topic for another post.

Lately I’ve been getting into a new subfield of ML and got extremely frustrated with the process of prioritizing, reading and managing the relevant papers… I ended up looking for tools to help me deal with this overload and want to share with you the products and services that I’ve found. The goal is to improve the workflow and quality of life of anyone who works with scientific papers.

I will focus mainly on consumption of papers (as opposed to writing) and cover:

1. Reference Managers (AKA paper library)
2. Social platforms to share knowledge
3. Automatic paper analysis to gain additional metadata (keywords, relevant datasets, important citations…)

## Reference Managers (AKA Paper library)

These are platforms where you can __create and organize lists of all your past and future reading, add personal notes and share with a small group__. The libraries are synced to the cloud which means your papers should be available anywhere. Think [goodreads](https://www.goodreads.com/), but for papers. Choose one of the following:

1. [Mendeley](https://www.mendeley.com/): It’s not the best looking product, but it has a freemium business model and supports multiple platforms including web, PC, Mac, and mobile. In addition to general paper notes you can annotate and highlight the PDFs directly. You pay for additional cloud storage (necessary after a few hundred papers).
2. [Paperpile](https://paperpile.com/): paid subscription (no free version), but looks and feels modern. Very easy to import your library there from other services. The library is synced to your own Google Drive, which is a plus. At the moment only works on a chrome browser.
3. [Zotero](https://www.zotero.org/): A freemium and open source implementation where you pay for additional cloud storage. Similar to Mendeley but less versatile.

There are [more](https://en.wikipedia.org/wiki/Comparison_of_reference_management_software) [options](https://guides.library.pdx.edu/c.php?g=474937&p=3249933), but these are the ones I have tried and they are all fine. If I had to choose one it would be Mendeley for its platform versatility and being freemium.

![](https://miro.medium.com/v2/resize:fit:1250/1*Ryq3u3ZhRH6xT84BCWV89A.png)

Mendeley’s Interface

## ArXiv Enhancers

ArXiv has [been around](https://en.wikipedia.org/wiki/ArXiv#History) since 1991, and generally changed very little over the last decade, while the publication volume has increased dramatically \[1\]. It is natural that today we have different requirements and needs from our primary repository of papers. __We want algorithms that perform paper analysis, we want to find code which implements the papers, we want a social layer via which we can share information, and perhaps we don’t want to squint at a double-columned pdf.__

Searching the internet for existing solutions, I found many such tools:

## Social Layers

1. [Shortscience](http://www.shortscience.org/): A platform for sharing paper summaries; Currently over 1000 summaries and growing. Works for any paper with a DOI (so, more than arXiv).
2. [OpenReview](https://openreview.net/): A transparent paper review process which is open to public reviews as well, currently available only for selected conferences such as NIPS and ICLR. In addition to the official reviews, recently many papers there are seeing active conversations with responses from the original authors.
3. [Scirate](https://scirate.com/): Adds a like (ehh, “scite”) button over a clone of arXiv. Adds a comment section. Mostly inactive.

## Find Code Implementation of Papers

1. [Papers With Code](https://paperswithcode.com/): Automatically connects papers to github repositories that implement them and sorts by github stars. There can be multiple, unmerged entries for each paper.
2. [Github pwc](https://github.com/zziz/pwc): A minimalistic approach which automatically(?) connects papers to only one code implementation, displayed as a simple table.
3. [GitXiv](http://www.gitxiv.com/): Collaboratively curated feed of projects. Each project is conveniently presented as arXiv + Github + Links + Discussion. Unfortunately this project is [no longer maintained](https://github.com/samim23/GitXiv).

![](https://miro.medium.com/v2/resize:fit:875/1*xLRgZggnQk79zDnHjHd4-g.png)

Some links from [Github pwc](https://github.com/zziz/pwc)

## Other

1. [arXiv-sanity](http://arxiv-sanity.com/): Gives a makeover to arXiv with exposed abstracts, paper previews and very basic social and library features. A valiant attempt at tying many of the ideas above together, built in spare-time by Andrej Karpathy. The ideas are all there, but in my opinion the implementation isn’t good enough to become a go-to tool for researchers, and the project has not been very active in the past year.
2. [arXiv-vanity](https://www.arxiv-vanity.com/) : Renders academic papers from [arXiv](https://arxiv.org/) as responsive web pages so you don’t have to squint at a PDF.

## Paper search and Analysis

1. [Google scholar](https://scholar.google.co.il/): Today’s go-to place to search for papers, view paper statistics as well as citations and references, set up alerts for new papers by following an author or a paper, and keep a basic library with automatic recommendations.
2. [IBM Science Summarizer](https://dimsum.eu-gb.containers.appdomain.cloud/): Summaries are generated by analyzing the content of papers, as well as their structure, sections, paragraphs, and key terms. It doesn’t always work well, but it’s continually improving and is great for skimming papers quickly.
3. [Semantic scholar](https://www.semanticscholar.org/): Semantic analysis of papers with external material aggregation. Features include: expose citations and references and measure their impact, show paper figures, automatically generate keywords (topics), analyze authors, find additional resources on the internet (e.g. related youtube videos) and suggest recommended papers.
A great new effort supported by [AI2](https://allenai.org/). Lately they’ve done a small integration with Paperswithcode mentioned above and with arXiv itself (!).

![](https://miro.medium.com/v2/resize:fit:875/1*QHHuPQGuKodxkN92m5POeg.png)

Semantic Scholar: author profile page

## Tools for Authors

1. [Overleaf](https://www.overleaf.com/): Collaborative, online LaTeX editor. Think Google docs for writing papers. Very well implemented.
2. [Authorea](https://www.authorea.com/): A 21st century approach to collaboratively writing papers online, aiming to mostly drop LaTeX in favor of a modern WYSIWYG editor. Supports inline code and data for reproducibility, inline public comments, and other features that make perfect sense.
3. [Code ocean](https://codeocean.com/): A cloud-based computational reproducibility platform. My understanding is that you upload your research as a Jupyter environment code, run it online and reproduce the same graphs /output that the authors get. Here’s an [example](https://codeocean.com/2018/05/18/deep-supervised-learning-for-hyperspectral-data-classification-through-convolutional-neural-networks/metadata) (press Run at the top right).

## ___Tl;dr — My recommendations___

- __Manage your reading library:__ [Mendeley](https://mendeley.com/)
- __Read and write paper reviews:__ [shortscience](http://shortscience.org/) and [openreview](https://openreview.net/)
- __Match papers to github repositories:__ [paperswithcode](https://paperswithcode.com/) and [pwc](https://github.com/zziz/pwc)
- __Paper and author analysis:__ [Semantic scholar](https://semanticscholar.org/)
- __Write papers:__ [Overleaf](https://www.overleaf.com/)

I hope this post has introduced you to at least one service that will improve your workflow.
Please, if you know any helpful tools which haven’t been mentioned in this post, share them below for everyone’s benefit.

\[1\] By October 2016 the submission rate had grown to more than 10,000 per month. [https://en.wikipedia.org/wiki/ArXiv](https://en.wikipedia.org/wiki/ArXiv),

![](https://miro.medium.com/v2/resize:fit:875/0*kbyDBaypvjdmg2Zt.png)

arXiv submission by Topic, from their [statistics page](https://arxiv.org/help/stats/2017_by_area/index)
