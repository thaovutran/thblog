---
authors:
- Thao Tran
categories:
- Command Line
- Uninx/Linux
- Shell Scripting
- SysAdmin Basics
date: '2019-10-21T08:15:26'
description: Examples of bash for loops that can make any shell users life easier
draft: false
header:
  caption: ''
  image: ''
tags:
- bash
- cut
- gnu linux
- grep
- home directories
- scripting
- shell
- unix linux
title: Several Bash for loop examples
url: /post/some-bash-for-loop-examples

---


## 1. Quickly creating files using seq

In the first example I am going to show how to create 1,000 files in a numbered order. While this example is more about showing how to use bash for loops, I do for some strange reason find myself performing this type of task more often than one would expect.

    $ for NUM in `seq 1 1 1000`
     > do
     > touch $NUM-test.txt
     > done

In the above for loop we run the command `seq` which outputs a sequence of numbers. The first argument to seq is the starting number, the second is the integer to increase by and the last is the integer to stop on. The output of seq is provided as the input for the for loop and each line is assigned to the NUM variable.

    $ ls -l | head 
    total 0
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 1000-test.txt
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 100-test.txt
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 101-test.txt
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 102-test.txt
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 103-test.txt
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 104-test.txt

You may notice that the for loop is written on multiple lines; in bash you can write for/while/until loops and if statements over multiple lines with the command not running until the statement is closed. I will be using this format to make it easier to read however you can also write the for loop over one line using the semicolon ";" to separate lines.

**Example:**

    $ for NUM in `seq 1 1 1000`; do touch $NUM-test.txt; done

<p>&nbsp;</p>

## 2. Quickly rename "specific files"

This next example will show how to execute a command (mv in our case) against files that are listed in a text file. This example is fairly useful and can be adopted to various scenarios.

    $ for FILE in `cat filestomove.txt`;
     > do
     > FILEBASENAME=$(echo $FILE | cut -d. -f1)
     > FILEEXT=$(echo $FILE | cut -d. -f2)
     > mv $FILE $FILEBASENAME-moved.$FILEEXT
     > done

    $ ls -la *-moved* | head
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 800-file-moved.txt
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 801-file-moved.txt
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 802-file-moved.txt
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 803-file-moved.txt
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 804-file-moved.txt
    -rw-rw-r-- 1 thao.tran thao.tran 0 Oct 20 19:22 805-file-moved.txt

As you can see from the output the for loop was able to read the files listed in **"filestomove.txt"** and rename them adding `-moved` to the filename. This example is a little loaded as it assumed that every file had a file extension in the name, but I wanted to highlight how you could use variable assignments and the `cut` command to breakup the filename and include `-moved` while keeping the file extension. This gives you a starting point on how to modify the input text as needed.

<p>&nbsp;</p>

## 3. Get user info from /etc/passwd and chown their home directory

Let's face it, sometimes when you give Jr. Admins too much access they tend to make rookie mistakes. Like chowning the `/home` directory recursively to the root user... In this example we will grab the username and home directory of each **"real user"** in the /etc/passwd and changing the ownership of the home directory to a more realistic owner.

    $ IFS=$'\n'
    $ for USERINFO in `grep "/bin/bash" /etc/passwd | grep ":/home"`
     > do
     > USERNAME=$(echo $USERINFO | cut -d: -f1)
     > HOMEDIR=$(echo $USERINFO | cut -d: -f6)
     > chown -R $USERNAME $HOMEDIR
     > done

<p>&nbsp;</p>

## 4. Check if the directories in home are assigned to a user

This example is a bit of a continuation of the previous; however it will show a different method of getting input for the for loop. The following command will gather a list of directories in the `/home` directory and check if that directory is listed in `/etc/passwd`.

    $ cd /home/
    $ for DIR in *
     > do
     > CHK=$(grep -c "/home/$DIR" /etc/passwd)
     > if [ $CHK -ge 1 ]
     > then
     > echo "$DIR is good"
     > else
     > echo "$DIR is not good"
     > fi
     > done
    thao.tran is good
    testdir is not good

Unlike the previous for loops where the input was generated by the output of a command run in a subshell, the input in this example was generated by an `*`. This is equivalent to running `ls *`, it will list all of the items located in the current directory that do not start with a `.`.

This example also introduces the usage of if statements, like for loops these can also be used on the command line. The above will check the number of instances of `/home/$DIR` in `/etc/passwd` and assign that value to the `$CHK` variable. The if statement simply checks if the `$CHK` value is greater than or equal to 1. If it is than the shell will `echo "$DIR is good"` if not than the shell will `echo "$DIR is not good"`.

<p>&nbsp;</p>

## 5. Copying a file to a list of hosts

I often find myself wanting to copy a file to a number of hosts. Rather than running scp manually over and over I usually tend to write an adhoc for loop that is similar to the following.

    $ for HOST in node01 node03 node05 node07
     > do
     > scp somefile $HOST:/var/tmp/
     > done

In this example you may notice that the input for the for loop is simply a list of hosts. In Bash the default field separator is a space; by giving a list of host-names separated by a space the for loop will run an scp command targeting each host. This command is a bit more effective when you have SSH keys setup between the hosts, but even if you have to type a password I think this tends to be faster when your loop is running against a list of 5+ hosts.

That about covers it for my list of example for loops, if you have another example that you think I should have covered hop to the comments and share it.