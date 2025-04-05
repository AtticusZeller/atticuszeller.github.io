# VSCode

# [Install](https://code.visualstudio.com/docs/setup/linux)

```bash
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
```

## Shortcut

### Terminal

1. open|close terminal ctrl+\`
2. create and open new terminal ctrl+shift +\`

![[assets/Pasted image 20250126132827.png]]

### Editor

- `ctrl + shift + ⬅️/➡️` expand to select
- `ctrl + D` select multiple same variables in current file
- `ctrl + alt/shift + ➖` go back or forward from cursor history

## [variables-reference](https://code.visualstudio.com/docs/editor/variables-reference)

### Common

```bash
${env:HOME}
```

### Predefined Variables

The following predefined variables are supported:

- __\${userHome}__ - the path of the user's home folder
- __\${workspaceFolder}__ - the path of the folder opened in VS Code
- __\${workspaceFolderBasename}__ - the name of the folder opened in VS Code without any slashes (/)
- __\${file}__ - the current opened file
- __\${fileWorkspaceFolder}__ - the current opened file's workspace folder
- __\${relativeFile}__ - the current opened file relative to `workspaceFolder`
- __\${relativeFileDirname}__ - the current opened file's dirname relative to `workspaceFolder`
- __\${fileBasename}__ - the current opened file's basename
- __\${fileBasenameNoExtension}__ - the current opened file's basename with no file extension
- __\${fileExtname}__ - the current opened file's extension
- __\${fileDirname}__ - the current opened file's folder path
- __\${fileDirnameBasename}__ - the current opened file's folder name
- __\${cwd}__ - the task runner's current working directory upon the startup of VS Code
- __\${lineNumber}__ - the current selected line number in the active file
- __\${selectedText}__ - the current selected text in the active file
- __\${execPath}__ - the path to the running VS Code executable
- __\${defaultBuildTask}__ - the name of the default build task
- __\${pathSeparator}__ - the character used by the operating system to separate components in file paths
- __\${/}__ - shorthand for __\${pathSeparator}__

#### Predefined Variables Examples

Supposing that you have the following requirements:

1. A file located at `/home/your-username/your-project/folder/file.ext` opened in your editor;
2. The directory `/home/your-username/your-project` opened as your root workspace.

So you will have the following values for each variable:

- __\${userHome}__ - `/home/your-username`
- __\${workspaceFolder}__ - `/home/your-username/your-project`
- __\${workspaceFolderBasename}__ - `your-project`
- __\${file}__ - `/home/your-username/your-project/folder/file.ext`
- __\${fileWorkspaceFolder}__ - `/home/your-username/your-project`
- __\${relativeFile}__ - `folder/file.ext`
- __\${relativeFileDirname}__ - `folder`
- __\${fileBasename}__ - `file.ext`
- __\${fileBasenameNoExtension}__ - `file`
- __\${fileDirname}__ - `/home/your-username/your-project/folder`
- __\${fileExtname}__ - `.ext`
- __\${lineNumber}__ - line number of the cursor
- __\${selectedText}__ - text selected in your code editor
- __\${execPath}__ - location of Code.exe
- __\${pathSeparator}__ - `/` on macOS or linux, `\` on Windows

> [!Tip]
> Use IntelliSense inside string values for `tasks.json` and `launch.json` to get a full list of predefined variables.

#### Variables Scoped per Workspace Folder

By appending the root folder's name to a variable (separated by a colon), it is possible to reach into sibling root folders of a workspace. Without the root folder name, the variable is scoped to the same folder where it is used.

For example, in a multi root workspace with folders `Server` and `Client`, a `${workspaceFolder:Client}` refers to the path of the `Client` root.

### Environment Variables

You can also reference environment variables through the `${env:Name}` syntax (for example, `${env:USERNAME}`).

```
{
  "type": "node",
  "request": "launch",
  "name": "Launch Program",
  "program": "${workspaceFolder}/app.js",
  "cwd": "${workspaceFolder}",
  "args": ["${env:USERNAME}"]
}
```

### Configuration Variables

You can reference VS Code settings ("configurations") through `${config:Name}` syntax (for example, `${config:editor.fontSize}`).
