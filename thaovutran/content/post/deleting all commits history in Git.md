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

In below, I'm showing you two method to delete all commits history in Git (like Github or Gitlab).

## A>. Method 1 
We should not delete `.git` folder in your repository. It may cause some problems in future. If you want to delete all of commits history but keeping the code in its current state. So you should try to do this guide below.


_#Check out your repo to a temporary branch:_<br>
$ git checkout --orphan TEMP_BRANCH

_#Add all the files:_<br>
$ git add -A

_#Commit the changes:_<br>
$ git commit -am "Initial commit"

_#Delete the old branch (ex: master branch):_<br>
$ git branch -D master

_#Rename the temporary branch to yours:_<br>
$ git branch -m master

_#Finally, force update to your repository:_<br>
$ git push -f origin master

<p>&nbsp;</p>

## B>. Method 2

_#Clone the repo, e.g. `docker_thblog`:_<br>
$ git clone https://github.com/thaovutran/docker_thblog.git

_#All of the commits history are in the `.git` folder:_<br>
$ cd docker_thblog

_#And delete the `.git` folder:_<br>
$ git rm -rf .git

_#Re-initialize the repository:_<br>
$ git init<br>
$ git remote add origin https://github.com/thaovutran/docker_thblog.git<br>
$ git remote -v

_#Add all the files and commit the changes:_<br>
$ git add --all<br>
$ git commit -am "Initial commit"

_#Force push update to the master branch:_<br>
$ git push -f origin master
