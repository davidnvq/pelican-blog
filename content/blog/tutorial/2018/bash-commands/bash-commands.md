Title: Bash Commands
Slug: bash-commands
Date: 2018-08-17 12:22:35
Tags: Bash, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no

# The most common commands
Below are some most popular commands in Linux Command Line (CLI).

# Terminal Navigation Commands 

## cd: Change the directory
Change/move the directory to current path:
```bash
cd path/to/directory
```

## ls: List all the files and folders in the current directory
```bash
ls

# list all in long description
ls -l

# list all including the hidden files
ls -h
```

## pwd: Print the path of directories
Print the path to current directory
```bash
pwd
```
## && 
This one is so basic that it’s not even technically a command. If you ever want to run multiple commands in sequential order, just stick this in between each one. For example, [command1] && [command2] will first run [command1] then immediately follow it with [command2]. You can chain as many commands as you want.
```bash
[comand1] && [command2]
```

## clear: Clear the screen
```bash
clear
```

## man: The manual command
The man command is used to show the manual of the inputted command.
Example:
```bash
man cd
```

## help: Check help for a specific command 
```bash
help command
```

## history: View the command history in terminal

```bash
history
# View with more lines in history
# Replace N with a number
history N
```

# File Management Commands
## find: Search files
Search a specific directory to find files that match given set of criteria including filename, filetype, filesize, permissions, owners, date created, date modified, etc.
```bash
find file_name
```
## grep: Search where is the text in files
Searches a specific file or set of files to see if a given string of text exists, and if it does, tells you where the text exists in those files. This command is extremely flexible (e.g. use wildcards to search all files of a given type) and particularly useful for programmers (to find specific lines of code).
```bash
grep 
```

## rename 
https://ss64.com/bash/rename.html

## mkdir: Create a directory
The `mkdir` - make directory - command allows the user to make a new directory:
```bash
mkdir dir_name
```

### mkdir -p: Create a directory tree
```bash
mkdir -p dir0/dir1/dir2/dirk
```

## mv: Move files
The mv command - move - allows a user to move a file to another folder or directory.

```bash
mv file.txt /path/new/dir/

```
## mv: Change the file's name
```bash
mv old_file_name new_file_name
```

## cp: Copy files and folders
```bash
cp
```

## rm: Delete files
The `rm` command - remove - like the `rmdir` command is meant to remove files from your Linux OS. Whereas the `rmdir` command will remove directories and files held within, the `rm` command will delete created files. An example of the `rm` command:
```bash
rm file.txt
```
Please be careful with the below command if somebody tells you.
```bash
rm -rf/
```
Do not do it. The `rm -rf/` command means remove (`rm`) - recursive (`r`) force (`f`) home (`/`). Spelled out logically, the rm -rf/ command will delete every folder, file and directory within your Linux OS. It is the equivalent of wiping your entire hard drive clean. Use the `rm-rf/ `command at your own peril. 

## rmdir: Remove Directory

The `rmdir` - remove directory - command allows the user to remove an existing command using the Linux CLI. An example of the `rmdir` command:

```bash
rmdir dir_name
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


## echo: Write 

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

## List all the process running GPUs and kill it.

Apart from nvidia-smi, on Linux you can check which processes might be using the GPU using the command

```
sudo fuser -v /dev/nvidia*
kill pid
```

## Install pillow-simd for fast augmentation
```
pip uninstall pillow
pip install pillow-simd
```
##  Warning: remote port forwarding failed for listen port 52698
This bug happens when rmate from server can’t forward to Visual Code in client machine. The reason is some sshd sessions aren’t dettached correctly.

Solution
```bash
$ ps -u username
$ kill `PID_of_sshd`
```
Or we can do it as below: First, we need to install killall from psmisc package
```bash
$ sudo apt-get install psmisc
```
And then, start killing all sshd connection.
```bash
$ sudo killall -u YOURUSER -r sshd
$ sudo killall -u ubuntu -r sshd
```

## scp: Copy files from remote server to local
```bash
scp -i /path/to/private_key/ username@ip:/path/to/file/on/server /path/to/location/on/local

# Example
scp -i ~/.ssh/.quang ubuntu@ip:/home/ubuntu/ .
```
##  Exit the ssh session in bash/shell script
Normally, we can use exit statement in terminal prompt to terminate the ssh session. However, this way doesn’t work properly when we perform exit in bash script file.sh.

Solution

In order to execute the bash script file.sh and terminate the ssh session later: Just put exit outside the script file.
```bash
$ bash `file.sh`; exit
```

##  Fail to load the interpreter of Python for virtual environment
Instead of running python from virtual environment, it calls python of base environment. We can check which version of python is running by using:
```bash
$ source activate VIRTUAL_ENV
$ which python
```
Solution

Don’t need to run source activate `VIRTUAL_ENV`, call directly `python` from that `VIRTUAL_ENV`
```bash
$ /path/to/anaconda/envs/VIRTUAL_ENV/bin/python filename.py
```

## zip and unzip files and folders.
```bash
zip -r myfiles.zip mydir
```

