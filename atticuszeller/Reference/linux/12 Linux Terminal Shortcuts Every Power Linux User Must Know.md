---
title: 13 Linux Terminal Shortcuts Every Power Linux User Must Know
source: https://linuxhandbook.com/linux-shortcuts/
author:
  - "[[Abhishek Prakash]]"
published: 2018-06-28
created: 2024-10-17
description: Use Linux command line like a pro by mastering these terminal shortcuts and increase your productivity. Includes a free downloadable cheatsheet.
tags:
---

# 12 Linux Terminal Shortcuts Every Power Linux User Must Know

## Must Know Linux Shortcuts

I would like to mention that some of these shortcuts may depend upon the Shell you are using. [Bash](https://www.gnu.org/software/bash/manual/html_node/What-is-Bash_003f.html) is the most popular shell, so the list is focused on Bash. If you want, you may call it Bash shortcut list as well.

### 1\. Tab

Just start typing a _command_, _filename_, _directory name_ or even _command options_ and hit the tab key. It will either ==automatically complete== what you were typing or it will show all the possible results for you.

### 2\. Ctrl + C

These are the keys you should press in order to break out of a command or process on a terminal. This will ==stop (terminate)== a running program immediately.

### 3\. Ctrl + Z

This shortcut will [suspend a running program](https://linuxhandbook.com/suspend-resume-process/) and gives you control of the shell. You can see the stopped program in [background jobs](https://linuxhandbook.com/run-process-background/) and even resume to run it using the fg command.

### 4\. Ctrl + D

This keyboard shortcut will log you out of the current terminal. If you are using an [SSH](https://www.ssh.com/ssh/protocol/) connection, it will be closed. If you are using a terminal directly, the application will be closed immediately.

Consider it equivalent to the ‘==exit==’ command.

### 5\. Ctrl + L

How do you clear your terminal screen? I guess using the clear command.

Instead of writing ==C-L-E-A-R==, you can simply use Ctrl+L to clear the terminal. Handy, isn’t it?

### 6\. Ctrl + A

This shortcut will ==move== the cursor to ==the beginning of the line==.

Suppose you typed a long command or path in the terminal and you want to go to the beginning of it, using the arrow key to move the cursor will take plenty of time. Do note that you cannot use the mouse to move the cursor to the beginning of the line.

This is where Ctrl+A saves the day.

### 7\. Ctrl + E

This shortcut is sort of opposite to Ctrl+A. Ctrl+A sends the cursor to the beginning of the line whereas Ctrl+E moves the cursor to the end of the line.

> [!NOTE] If you have the _Home_ and _End_ keys on your keyboard, you can also use them. Home is __equivalent__ to Ctrl +A and End is equivalent to Ctrl + E.

### 8\. Ctrl + U

Typed a wrong command? Instead of using the backspace to discard the current command, use Ctrl+U shortcut in the Linux terminal. This shortcut ==erases everything== from the ==current cursor position to the beginning== of the line.

> [!WARNING ] Ubuntu Terminal would erase everything of the line

### 9\. Ctrl + K

This one is similar to the Ctrl+U shortcut. The only difference is that instead of the beginning of the line, it erases everything from the ==current cursor position to the end== of the line.

### 10\. Ctrl + W

You just learned about erasing text till the beginning and the end of the line. But what if you just need to ==delete a single word==? Use the Ctrl+W shortcut.

Using Ctrl+W shortcut, you can erase the word preceding to the cursor position. If the cursor is on a word itself, it will erase ==all letters from the cursor position to the beginning== of the word.

The best way to use it to move the cursor to the _next space after the targeted word_ and then use the Ctrl+W keyboard shortcut.

### 11\. Ctrl + Y

This will ==paste the erased text== that you saw with Ctrl + W, Ctrl + U and Ctrl + K shortcuts. Comes handy in case you erased wrong text or if you need to use the erased text someplace else.

### Bonus Shortcut: Ctrl + R to search in Command History

You typed some command but cannot remember what it was exactly? Meet Ctrl + R.

This keyboard shortcut allows you to ==perform a search== in your [command history](https://linuxhandbook.com/history-command/). Just press Ctrl+R and start typing. It will show the last command that matches the string you typed. Note that the typed string could be anywhere in the command. How cool is that?

![Reverse search in command history in Linux](https://linuxhandbook.com/content/images/2021/08/reverse-search-linux.png)

If you want to ==see more commands== for the same string, just keep pressing _Ctrl + R._

You can press enter to run the command selected or press _Esc_ to ==come out of the search== with the last search result.

### Download FREE Terminal Shortcut Cheatsheet

![](https://linuxhandbook.com/content/images/2022/04/lhb-terminal-shortcut-cheatsheet-1.webp)
