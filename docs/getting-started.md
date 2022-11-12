---
title: Getting Started
layout: home
---

This section exists to help you set up your computer to work on Oakton Programming Club projects.

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Installing Tools](#installing-tools)
	- [Windows Before 10](#windows-before-10)
	- [Windows After 10](#windows-after-10)
	- [MacOS](#macos)
	- [Linux](#linux)
- [Installing Extensions](#installing-extensions)
- [GitHub](#github)
- [Best Practices](#best-practices)

# Installing Tools

Use the subheading which applies to your system.

## Windows Before 10

* For Windows versions before Windows 10, `winget` is not available, so you will have to install VSCode, Git and NodeJS manually.
* To install VSCode, visit https://code.visualstudio.com/Download or use [this link](https://code.visualstudio.com/sha/download?build=stable&os=win32-user) to download the installer directly, then follow the onscreen instructions.
* To install NodeJS, visit https://nodejs.org/en/download/ or use [this link](https://nodejs.org/dist/v18.12.1/node-v18.12.1-x86.msi) to download the installer directly, then follow the onscreen instructions.
* To install Git, visit https://gitforwindows.org/ or use [this link](https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-64-bit.exe) to download the installer directly, then follow the onscreen instructions. Select Visual Studio Code as the default text editor when prompted, and set the default branch name to 'main'.
* Open the Windows Command Prompt by pressing the Windows key and typing "cmd" into the search field. Select the Command Prompt from the results.
* Type the text below into your command prompt and press enter to run it. Read it beforehand; you should never run commands without having some understanding of what they do.
```bat
:: Register your name and email address with Git. Make sure you use the same email address when signing up on GitHub.
git config --global user.email "you@example.com"
git config --global user.name "John Smith"
```
* Move on to [Installing Extensions](#installing-extensions).

## Windows After 10

* For Windows versions 10 and newer, a command-line tool called `winget` is available which will help us install our tools more quickly reliably.
* To use `winget`, make sure that the [Windows Package Installer](https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1) is installed and updated from the Windows Store.
* Open the Windows Command Prompt by pressing the Windows key and typing "cmd" into the search field. Select the Command Prompt from the results.
* Type the text below into your command prompt and press enter to run it. Read it beforehand; you should never run commands without having some understanding of what they do.
```bat
:: Installs Visual Studio Code
winget install -e --id Microsoft.VisualStudioCode
:: Installs the LTS version of NodeJS
winget install -e --id OpenJS.NodeJS
:: Installs Git
winget install -e --id Git.Git
:: Register your name and email address with Git. Make sure you use the same email address when signing up on GitHub.
git config --global user.email "you@example.com"
git config --global user.name "John Smith"
```
* Move on to [Installing Extensions](#installing-extensions).

## MacOS

* If you have Homebrew installed, you already know how to install NodeJS (via NVM), VSCode, and Git.
* If you don't, you can copy this into your terminal.
```bash
# Installs Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Installs VSCode
brew install --cask visual-studio-code
# Installs NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
# Installs LTS Node.JS
nvm install --lts
# Installs Git
brew install git
```
* Type the commands below into your shell, modifying them with your name and email address.
```bash
git config --global user.email "you@example.com"
git config --global user.name "John Smith"
```
* Move on to [Installing Extensions](#installing-extensions).

## Linux

* Different Linux systems use different package managers. You should follow the instructions on https://code.visualstudio.com/docs/setup/linux which correspond to your distribution when installing [[VSCode]].
* Install git as would be typical for your system. For example, `sudo apt install git`, `sudo dnf in git`, `sudo pacman -S git`, `sudo zypper in git`.
* To install NodeJS, copy the commands below.
```bash
# Installs NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
# Installs LTS Node.JS
nvm install --lts
```
* To configure Git, type the commands below into your shell, modifying them with your name and email address.
```bash
git config --global user.email "you@example.com"
git config --global user.name "John Smith"
```
* Move on to [Installing Extensions](#installing-extensions).

# Installing Extensions

* Start VSCode.
* Press F1 or Fn+F1 depending on your keyboard configuration to open the VSCode command panel.
* Type "clone", then press enter.
* Type "https://github.com/oakpr/extensions", then press enter.
* Select a directory to clone into. **Please don't use your desktop; every time you save stuff there, a programmer loses their wings.** I recommend making a directory like `C:\Code` or `~/Code` and cloning inside it.
* Press F1 again, then type "show recommended" and press enter.
* Under the search bar in the top left, there should be a download cloud icon. Select that, then wait a moment for the extensions to be ✨automagically✨ installed.

# GitHub

* Git, the program we installed earlier, is a tool that's designed to help with working on a project with many people. It's able to synchronize multiple copies of the same codebase, and resolve simultaneous changes (mostly) gracefully.
* In theory, you could synchronize a Git repository by passing USB sticks around, but it's best to have a server that keeps a canonical version of the repository for you and your peers to sync with.
* GitHub is a subsidiary of Microsoft, and by far the most popular place to store your code.
* You need to sign[[bestpractices]] https://github.com/signup to contribute to club projects.
* After signing up with GitHub, DM the username you chose to one of us on Discord, and we'll invite you to the club organization. Please accept the invite as soon as you receive it, since it will expire after a while.

# Best Practices

Please review the [Best Practices](best-practices) document for some tips.