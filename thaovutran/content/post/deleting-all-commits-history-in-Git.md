---
authors:
- Thao Tran
categories:
- Command Line
- Uninx/Linux
- Github/Gitlab
- DevOps Basics
date: '2020-02-21T18:15:26'
description: Two method of deleting all Git commits history
draft: false
header:
  caption: ''
  image: ''
tags:
- bash
- shell
- unix linux
- git
title: Deleting all commits history of git (Github/Gitlab)
url: /post/deleting-all-commits-history

---

While working with Git, I think that some times we have ever wanted to delete commits history of Git. Because of that, I'm showing you two method to delete all commits history in Git (like Github or Gitlab).

## A>. Method 1 
We should not delete `.git` folder in your repository. It may cause some problems in future. If you want to delete all of commits history but keeping the code in its current state. So you should try to do this guide below.


<i>`#Check out your repo to a temporary branch:`</i><br>
$ git checkout --orphan TEMP_BRANCH

<i>`#Add all the files:`</i><br>
$ git add -A

<i>`#Commit the changes:`</i><br>
$ git commit -am "Initial commit"

<i>`#Delete the old branch (ex: master branch):`</i><br>
$ git branch -D master

<i>`#Rename the temporary branch to yours:`</i><br>
$ git branch -m master

<i>`#Finally, force update to your repository:`</i><br>
$ git push -f origin master

<p>&nbsp;</p>

## B>. Method 2

<i>`#Clone the repo, e.g. `docker_thblog`:`</i><br>
$ git clone https://github.com/thaovutran/docker_thblog.git

<i>`#All of the commits history are in the `.git` folder:`</i><br>
$ cd docker_thblog

<i>`#And delete the `.git` folder:`</i><br>
$ git rm -rf .git

<i>`#Re-initialize the repository:`</i>
<br>$ git init
<br>$ git remote add origin https://github.com/thaovutran/docker_thblog.git
<br>$ git remote -v

<i>`#Add all the files and commit the changes:`</i>
<br>$ git add --all
<br>$ git commit -am "Initial commit"

<i>`#Force push update to the master branch:`</i>
<br>$ git push -f origin master

<p>&nbsp;</p>

I hope that you guys have could found a way to make you happy when you would try to remove all commits history in Git.