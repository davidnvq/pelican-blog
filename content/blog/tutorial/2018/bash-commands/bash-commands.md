Title: Bash Commands
Slug: bash-commands
Date: 2018-08-17 12:22:35
Tags: Bash, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no

# The most common commands

## cd: Change the directory
Change/move the directory to current path
```bash
cd path/to/directory
```

## mkdir: Create a directory
```bash
mkdir dir_name
```

### mkdir -p: Create a directory tree
```bash
mkdir -p dir0/dir1/dir2/dirk
```

## mv: Move files
```bash
mv

```
## mv: Change the file's name
```bash
mv
```

## man: The manual command
The man command is used to show the manual of the inputted command.
Example:
```bash
man cd
```

## cp: Copy files and folders
```bash
cp
```

## rm: Delete files
```bash
rm
```

## ls: List all the files and folders in the current directory
```bash
ls
```

## pwd: Print the path of directories
Print the path to current directory
```bash
pwd
```

## history: View the command history in terminal

```bash
history
# View with more lines in history
# Replace N with a number
history N
```

## help: Check help for a specific command 
```bash
help command
```

## cat: View a file in terminal
```bash
cat file
```

## touch: Create a file in terminal
Create a file with `touch`. The touch command - a.k.a. the make file command - allows users to make files using the Linux CLI. Just as the mkdir command makes directories, the touch command makes files. Just as you would make a .doc or a .txt using a PC desktop, the touch command makes empty files. An example of the touch command:

```bash
touch file
```

## nano: Create and open a file in terminal
```bash
# Create or open a file
nano file
```

## nvidia-smi: Check GPU's status
We use `watch -1` to track the GPU's status every second. 
```bash
watch -1 nvidia-smi
```

## kill: Kill a process 
```bash
kill pid
```

## clear: Clear the screen
```bash
clear
```


# Commands with git
If the current directory or files are under `git` repository, it is useful to use `mv` and `rm` with `git` command for further tracking:

```bash
git mv old_file_name new_file_name
# Change the name of a file or dir

git rm file
# Remove a file
```

# Shortcuts


## code 
```bash
# Open the current folder
code .
# Open or create the file
code file
```

## chrome
```bash
```

## Exit
We can press `Ctrl + C` or sometimes `Ctrl + D` to exit the current program in terminal.

```bash
exit
```

# Some useful commands

## ps: List process by username
```bash
ps -u ubuntu
```

## htop: Task manager
```bash
htop
```

## kill a process on a specific port
```bash
# find the pid running on the port 
lsof -i :port_number
# kill the process with this port
kill pid
```

## 
```bash

```
