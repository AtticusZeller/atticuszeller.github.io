---
title: "How to Monitor and Test the Health of SSD in Linux"
source: "https://linuxhandbook.com/check-ssd-health/"
author:
  - "[[Sylvain Leroux]]"
published: 2018-07-31
created: 2024-10-16
description: "A detailed analysis on S.M.A.R.T. technologies for Solid State Drives and how to use smartctl tool to monitor and check the health of SSD in Linux."
tags:
  - "linux"
---

# How to Monitor and Test the Health of SSD in Linux

Ideally, S.M.A.R.T. would allow anticipating __predictable__ failures such as those caused by mechanical wearing or degradation of the disk surface, as well as __unpredictable__ failures caused by an unexpected defect. Since drives usually don’t fail abruptly, S.M.A.R.T. gives an option for the operating system or the system administrator to identify soon-to-fail drives so they can be replaced before any data loss occurs.

According to the study, 62% of the failed SSD showed __at least__ one of the above symptoms. However, if you reverse that statement, that also means 38% of the studied SSDs failed __without__ showing any of the above symptoms. The study did not mention though if the failed drives have exhibited any other S.M.A.R.T. reported failure or not. So this cannot be directly compared to the 36% failure-without-prior-notice mentioned for hard drives in the Google paper.

```
sudo apt install smartmontools
```

As you can see, my laptop internal hard drive indeed has S.M.A.R.T. capabilities, and S.M.A.R.T. support is enabled. So, what now about the S.MA.R.T. status? Are there some errors recorded?
