
| Alias  | Command                               |
| :----- | :------------------------------------ |
| gapa   | git add --patch                       |
| gc!    | git commit -v -amend                  |
| gcl    | git clone --recursive                 |
| gclean | git reset --hard && git clean -dfx    |
| gcm    | git check out master                  |
| gcmsg  | git comit -m                          |
| gco    | git checkout                          |
| gd     | git diff                              |
| gdca   | git diff --cached                     |
| glola  | git log --graph --pretty=format:...   |
| gp     | git push                              |
| grbc   | git rebase --continue                 |
| gst    | git status                            |
| gup    | git pull --rebase                     |
| gwip   | git add -a; git commit -m '---wip---' |
| 查看历史   | - |
| git log --oneline   | 每个提交在一行内显示 |
| git log --all --grep='homepage'   | 在所有提交日志中搜索包含「homepage」的提交 |
| git log --author="Maxence"	| 获取某人的提交日志 | 
| git log --oneline --decorate --graph	| - | 
| 之前重置了一个不想保留的提交，但是现在又想要回滚	| - | 
| git reflog	| 获取所有操作历史 | 
| git reset HEAD@{4}	| 重置到相应提交 | 
| git reset --hard <提交的哈希值>	| git reset --hard 37d09fc |
| 我把本地仓库搞得一团糟，应该怎么清理	| - | 
| git fetch origin	| - | 
| git checkout master | - | 
| git reset --hard origin/master	|  - |	
| git diff master..my-branch| 查看我的分支和 master 的不同 |
| 定制提交| - | 	
| git commit --amend -m "更好的提交日志"	| 编辑上次提交| 
| git add . && git commit --amend --no-edit	| 在上次提交中附加一些内容，保持提交日志不变| 
| git commit --allow-empty -m "chore: re-trigger build"	| 空提交 —— 可以用来重新触发 CI 构建| 

#### Hotkeys
1 按 t 可以快速进入模糊文件名搜索模式, w 可以快速进行分支过滤,  ? 展示当前页面可用的快捷键
2 忽略空格: ?w=1
3 按范围过滤提交记录: master@{time}..master, e.g., https://github.com/rails/rails/compare/master@{1.day.ago}…master 
4 按作者过滤提交记录: ?author=github_handle, e.g., https://github.com/dynjs/dynjs/commits/master?author=jingweno
5 compare/master@{1.day.ago}…master.patch 显示Rails项目中全部昨天开始的提交记录和变化的文本格式, compare/master@{1.day.ago}…master.patch 


#### Workflow

```
1、git log -p FILE
查看 README.md 的修改历史，例如：
> git log -p README.md

2、git log -S’PATTERN’
例如，搜索修改符合 stupid 的历史：
> git log -S'stupid'
每个提交在一行内显示
> git log --oneline
在所有提交日志中搜索包含「homepage」的提交
> git log --all --grep='homepage'
获取某人的提交日志
> git log --author="Maxence"

3、git add -p
交互式的保存和取消保存变化，使用：
> git add -p

4、git rm –cached FILE
这个命令只删除远程文件，例如：
> git rm --cached database.yml
删除 database.yml 被保存的记录，但是不影响本地文件。这对删除已经推送过的忽略文件记录而且不影响本地文件是非常的方便的。

5、git log ..BRANCH
这个命令返回某个非 HEAD 分支的提交记录。假如你在一个功能分支，输入：
> git log ..master
返回全部 master 分支的历史记录，包括未被合并到当前分支的提交记录。

6、git branch –merged & git branch –no-merged
Git操作常用的命令都在这里了，点击这里查看。这个命令返回已合并分支列表或未合并的分支列表。这个命令对合并前检查非常有用。例如，在一个功能分支，输入
> git branch --no-merged
返回未合并到该分支的分支列表。

7、git branch –contains SHA
返回包含某个指定 sha 的分支列表。例如：
> git branch --contains 2f8e2b
显示全部包含提交 2f832b 的分支。这个命令对于验证 git cherry-pick 完成非常有帮助。

8、git status -s
返回一个简单版的 git status。我设置这个命令为默认 git status 来减少噪音。

9、git reflog
显示你在本地已完成的操作列表。

10、git shortlog -sn
显示提交记录的参与者列表。和GitHub的参与者列表相同。
```

```
1、获取当前提交的commit id
命令：git log
获取到当前项目分支下的所有commit记录

2、将某个commit id前的commit清除，并保留修改的代码
命令：git reset <commit_id>  

3、修改代码完成后，将修改好的代码add到暂存区，并提交到本地仓库中
命令：git add <file_name>  and  git commit   当前场景下：git add .  and  git commit
将最新修改后的代码commit

4、将本地修改同步到远程仓库
命令：git push origin HEAD --force
```

```
git log
git reset commit_id3
修改代码
git add .
git commit -m '第三次修改README文件-更新错误后提交'
git push origin HEAD --force
git status --ignored` --展示忽略的文件
git pull
git fetch -- 获取远程仓库中所有的分支到本地
```

#### Workflow
```
** everything is happy and up-to-date in master**

`git checkout master`

`git pull origin master`

** create branch

`git branch my-new-feature`

`git branch -b my-new-feature`

** let's branch to make changes**

`git checkout -b my-new-feature`

** go ahead, make changes now.**

`vim file`

** commit your (incremental, atomic) changes**

`git add -p`

`git commit -m "my changes"`

** optional: push your branch for discussion (pull-request)  you might do this many times as you develop.**
-- 推送本地分支到远程仓库

`git push origin my-new-feature`

`git push origin/mybranch -u`

** if your branch becomes too old (2-3 days) and diverges from master,you will want to merge origin/master into your future branch before deploying**

`git fetch origin`

`git fetch --all`

`git merge origin master`

** merge when done developing.**

`git checkout master`

`git pull origin master`

`git merge --no-ff -m 'merge my new-feature with no-ff' my-new-feature`
```

`git merge --no-ff -m '合并描述' 分支名` -- 不使用Fast forward方式合并，采用这种方式合并可以看到合并记录

--no-ff preserves feature history and easy full-feature reverts merge commits should not include changes; 

`git rebase -i HEAD-n` -- rebasing reconciles issues

`git rebase -i master mybranch`

`git rm -r --cached 文件/文件夹名字` 取消文件被版本控制

`git reflog` -- 获取执行过的命令, 显示本地更新过 HEAD 的 git 命令记录

```
# 显示当前分支的最近几次提交
$ git reflog
```

`git log --graph` -- 查看分支合并图, 查看 commit 历史

`git whatchanged --since= 2 weeks ago` --查看两个星期内的改动

`git check-ignore -v 文件名` -- 查看忽略规则

`git update-index --assume-unchanged file` --忽略单个文件

`git rm -r --cached 文件/文件夹名字` -- 忽略全部文件

`git update-index --no-assume-unchanged file` -- 取消忽略文件

`git update-ref -d HEAD` 把所有的改动都重新放回工作区，并清空所有的 commit，这样就可以重新提交第一个 commit 了

`git checkout <branch-name> && git cherry-pick <commit-id>`把 A 分支的某一个 commit，放到 B 分支上


### General

#### Setup
** Genereate SSH Key
`ssh-keygen -t rsa -b 4096 -C "linghypshen@gmail.com"`
ssh-add -K ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub

#### Initialization

```
# 初始化当前项目
$ git init

# 新建一个目录，将其初始化为Git代码库
$ git init [project-name]

# 在指定目录创建一个空的 Git 仓库。运行这个命令会创建一个名为 directory，只包含 .git 子目录的空目录。

$ git init --bare <directory>

# 下载一个项目和它的整个代码历史
# 这个命令就是将一个版本库拷贝到另一个目录中，同时也将分支都拷贝到新的版本库中。这样就可以在新的版本库中提交到远程分支
$ git clone [url]
```

#### Remote

Show remote:
`git remote`

Show remote details:
`git remote -v`

Add remote upstream from GitHub project:
`git remote add upstream https://github.com/user/project.git`

Add remote upstream from existing empty project on server:
`git remote add upstream 
://root@123.123.123.123/path/to/repository/.git`

`git remote` 列出所有远程仓库

`git remote add origin url` -- 关联远程仓库

`git remote set-url origin <URL>`--修改远程仓库的 url

#### Config

`git config --global credential.helper stor` -- 拉取、上传免密码

** autosetup rebase so that pulls rebase by default**

`git config --global branch.autosetuprebase always`

** if you already have branches (made before `autosetuprebase always`)**

`git config branch.mybranchname.rebase true`

** you almost certainly want to run this as well, to allow git commands to be output with colour:**

`git config --global color.ui always`

```
# 显示当前的Git配置
$ git config --list

# 编辑Git配置文件
$ git config -e [--global]

# 输出、设置基本的全局变量
$ git config --global user.email
$ git config --global user.name

$ git config --global user.email "MyEmail@gmail.com"
$ git config --global user.name "My Name"

# 定义当前用户所有提交使用的作者邮箱。
$ git config --global alias.<alias-name> <git-command>

# 为Git命令创建一个快捷方式（别名）。
$ git config --system core.editor <editor>
```

#### Add
```
# 添加一个文件
$ git add test.js

# 添加一个子目录中的文件
$ git add /path/to/file/test.js

# 支持正则表达式
$ git add ./*.js

# 添加指定文件到暂存区
$ git add [file1] [file2] ...

# 添加指定目录到暂存区，包括子目录
$ git add [dir]

# 添加当前目录的所有文件到暂存区
$ git add .

# 添加每个变化前，都会要求确认
# 对于同一个文件的多处变化，可以实现分次提交
$ git add -p
```

#### Remove
```
# 移除 HelloWorld.js
$ git rm HelloWorld.js

# 移除子目录中的文件
$ git rm /pather/to/the/file/HelloWorld.js

# 删除工作区文件，并且将这次删除放入暂存区
$ git rm [file1] [file2] ...

# 停止追踪指定文件，但该文件会保留在工作区
$ git rm --cached [file]
```

#### Mv
```
将其他分支合并到当前分支
$ git merge branchName

\# 在合并时创建一个新的合并后的提交
\# 不要 Fast-Foward 合并，这样可以生成 merge 提交
$ git merge --no-ff branchName
```

#### Commit

`git commit --amend` 修改上一个 commit 的描述
`git commit --amend --author= Author Name <email@address.com>` 修改作者名
`git commit --amend -m "New Message"` Update most recent commit (also update the commit message)

```
commit - 将当前索引的更改保存为一个新的提交，这个提交包括用户做出的更改与信息

# 提交暂存区到仓库区附带提交信息
$ git commit -m [message]

# 提交暂存区的指定文件到仓库区
$ git commit [file1] [file2] ... -m [message]

# 提交工作区自上次commit之后的变化，直接到仓库区
$ git commit -a

# 提交时显示所有diff信息
$ git commit -v

# 使用一次新的commit，替代上一次提交
# 如果代码没有任何新变化，则用来改写上一次commit的提交信息
$ git commit --amend -m [message]

# 重做上一次commit，并包括指定文件的新变化
$ git commit --amend [file1] [file2] ...

git commit --amend
# follow prompts to change the commit message

# make your change
git add . # or add individual files
git commit --amend --no-edit
# now your last commit contains that change!
# WARNING: never amend public commits

```

#### Reset

将当前的头指针复位到一个特定的状态。这样可以使你撤销 merge、pull、commits、add 等 这是个很强大的命令，但是在使用时一定要清楚其所产生的后果

reset命令有三种处理模式：
--soft：保留commit修改，将修改存储到index中；也就是说git add后的区域
--mixed：保留commit修改，将修改存储到本地工作区域中；也就是说git add前的区域
--hard：删除commit修改，慎用！

git reset --soft
回滚commit_id前的所有提交，不删除修改：
`git reset HEAD file` -- 撤回暂存区的文件修改到工作区
`git reset HEAD index.html` --Unstage (undo adds)
`git reset HEAD~1`
git reset --soft commit_id
重设head，不动index，所以效果是commit_id之后的commit修改全部在index中将id3 和 id4的修改放到index区（暂存区），也就是add后文件存放的区域，本地当前的修改保留
`git reset --soft 073791e7dd71b90daa853b2c5acc2c925f02dbc6`
`git reset --soft HEAD~ ` --soft reset (move HEAD only; neither staging nor working dir is changed):
`git reset –soft HEAD~3`  回退至三个版本之前，只回退了commit的信息，暂存区和工作区与回退之前保持一致。如果还要提交，直接commit即可


git reset --mixed
回滚commit_id前的所有提交，不删除修改：git reset commit_id  等同于 git reset --mixed commit_id
与 下述的 git reset --hard commit_id效果不同
重设head 和 index，不重设work tree，效果就是commit_id之前的修改，全部在work tree中，为还未add的状态将id3 和 id4 的所有修改放到本地工作区中，本地当前的修改保留
`git reset <commit-id>`  默认就是-mixed参数
`git reset –mixed HEAD^`  回退至上个版本，它将重置HEAD到另外一个commit,并且重置暂存区以便和HEAD相匹配，但是也到此为止。工作区不会被更改。
Mixed reset (move HEAD and change staging to match repo; does not affect working dir):
`git reset --mixed 073791e7dd71b90daa853b2c5acc2c925f02dbc6`

git reset --hard
Hard reset (move HEAD and change staging dir and working dir to match repo): -- 回退到某个版本,  彻底回退到指定commit-id的状态，暂存区和工作区也会变为指定commit-id版本的内容
回滚commit_id前的所有提交，将修改全部删除：git reset --hard commit_id
重设head、index、work tree，也就是说将当前项目的状态恢复到commit_id的状态，其余的全部删除（包含commit_id后的提交和本地还未提交的修改）慎用！！
`git rest --hard HEAD` ---- 回退到上一个版本
`git reset –-hard HEAD` ——撤销最近提交以来暂存区和非暂存区的改动
`git reset --hard origin/master` --回到远程仓库的状态
`git reset --hard commit_id`
`git reset --hard 073791e7dd71b90daa853b2c5acc2c925f02dbc6`

```
# 使 staging 区域恢复到上次提交时的状态，不改变现在的工作目录
$ git reset

# 使 staging 区域恢复到上次提交时的状态，覆盖现在的工作目录
$ git reset --hard

# 将当前分支恢复到某次提交，不改变现在的工作目录
# 在工作目录中所有的改变仍然存在
$ git reset dha78as

# 将当前分支恢复到某次提交，覆盖现在的工作目录
# 并且删除所有未提交的改变和指定提交之后的所有提交
$ git reset --hard dha78as
```


#### Revert

在revert命令中常用的就两个：
git revert -e <commit_id>：重做指定commit的提交信息
git revert -n <commit_id>：重做执行commit的代码修改

git revert -e 重做commit_id的提交信息，生成为一个新的new_commit_id
git revert -e commit_id
git revert -n 重做commit_id的提交, 将commit_id中修改，放到index区，我们可以对他重新做修改并重新提交
git revert -n commit_id 

revert vs reset
git revert是用一次新的commit来回滚之前的commit，此次提交之前的commit都会被保留不动；
git reset是回到某次提交，提交及之前的commit都会被保留，但是此commit id之后的修改都会被删除或放回工作区等待下一次提交；

Go back to commit: 以新增一个 commit 的方式还原某一个 commit 的修改
`git revert 073791e7dd71b90daa853b2c5acc2c925f02dbc6`

#### Reflog
```
git reflog
# you will see a list of every thing you've
# done in git, across all branches!
# each one has an index HEAD@{index}
# find the one before you broke everything
git reset HEAD@{index}
# magic time machine
```

#### Checkout

我们知道使用git checkout可以
git checkout <branch_name>切换分支
git checkout -b <branch_bame>创建分支等操作
它还有回滚指定文件的修改的功能

命令：git checkout -- <file_name>
上述语句的作用，就是将file_name的本地工作区的修改全部撤销，有两种情况：
如果file_name在commit后没有add过这个文件，则撤销到版本库中的状态
如果file_name在commit后add过这个文件，则撤销到暂存区的状态，也就是add后的状态
总之，就是让指定的文件回滚到最近的一次git add 或者 git commit时的状态！

```
# 检出一个版本库，默认将更新到master分支
$ git checkout
# 检出到一个特定的分支
$ git checkout branchName
# 新建一个分支，并且切换过去，相当于"git branch <名字>; git checkout <名字>"
$ git checkout -b newBranch

Checkout a specific release version:
`git checkout v1.0.0`

`git checkout -b branch_name tag_name` --切回到某个标签
```

#### Update & Delete

Test-Delete untracked files:
`git clean -n`

Delete untracked files (not staging):
`git clean -f`

恢复删除的文件

`git rev-list -n 1 HEAD -- <file_path>`  得到 deleting_commit
`git checkout <deleting_commit>^ -- <file_path> 回到删除文件 deleting_commit 之前的状态`

#### Branch

Show branches:
`git branch`

展示本地分支关联远程仓库的情况

`git branch -vv`

关联远程分支

`git branch -u origin/mybranch`

Create branch:
`git branch branchname`

Change to branch:
`git checkout branchname`

Create and change to new branch:
`git checkout -b branchname`

从远程分支中创建并切换到本地分支

`git checkout -b <branch-name> origin/<branch-name>`

列出所有远程分支 -r 参数相当于：remoted

`git branch -r`

列出本地和远程分支 -a 参数相当于：all

`git branch -a`

Show all completely merged branches with current branch, 查看别的分支和当前分支合并过的分支:
`git branch --merged`

删除已经合并到 master 的分支

`git branch --merged master | grep -v  ^* |  master  | xargs -n 1 git branch -d`

Show all branches without merged -- 查看未与当前分支合并的分支
`git branch --no-merged`

`git checkout --orphan <branch-name>` — 相当于保存修改，但是重写 commit 历史

Delete merged branch (only possible if not HEAD): -- 删除本地分支
`git branch -d local-branchname` or:`git branch --delete branchname`

Delete not merged branch: -- 强行删除分支
`git branch -D branch_to_delete`

Delete remote branch: -- 删除远处仓库分支
`git branch origin: branchname`

Rename branch:
`git branch -m branchname new_branchname` or:
`git branch --move branchname new_branchname`

```
# 查看远程分支
$ git br -r

# 创建新的分支
$ git br <new_branch>

# 查看各个分支最后提交信息
$ git br -v

# 查看已经被合并到当前分支的分支
$ git br --merged

# 查看尚未被合并到当前分支的分支
$ git br --no-merged
```

```
# 查看所有的分支和远程分支
$ git branch -a

# 创建一个新的分支
$ git branch [branch-name]

# 重命名分支
# git branch -m <旧名称> <新名称>
$ git branch -m [branch-name] [new-branch-name]

# 编辑分支的介绍
$ git branch [branch-name] --edit-description

# 列出所有本地分支
$ git branch

# 列出所有远程分支
$ git branch -r

# 新建一个分支，但依然停留在当前分支
$ git branch [branch-name]

# 新建一个分支，并切换到该分支
$ git checkout -b [branch]

# 新建一个分支，指向指定commit
$ git branch [branch] [commit]

# 新建一个分支，与指定的远程分支建立追踪关系
$ git branch --track [branch] [remote-branch]

# 切换到指定分支，并更新工作区
$ git checkout [branch-name]

# 切换到上一个分支
$ git checkout -

# 建立追踪关系，在现有分支与指定的远程分支之间
$ git branch --set-upstream [branch] [remote-branch]

# 合并指定分支到当前分支
$ git merge [branch]

# 选择一个commit，合并进当前分支
$ git cherry-pick [commit]

# 删除分支
$ git branch -d [branch-name]

# 删除远程分支
$ git push origin --delete [branch-name]
$ git branch -dr [remote/branch]

# 切换到某个分支
$ git co <branch>

# 创建新的分支，并且切换过去
$ git co -b <new_branch>

# 基于branch创建新的new_branch
$ git co -b <new_branch> <branch>

# 把某次历史提交记录checkout出来，但无分支信息，切换到其他分支会自动删除
$ git co $id

# 把某次历史提交记录checkout出来，创建成一个分支
$ git co $id -b <new_branch>

# 删除某个分支
$ git br -d <branch>

# 强制删除某个分支 (未被合并的分支被删除的时候需要强制)
$ git br -D <branch>
```

#### Merge

True merge (fast forward): --合并分支到当前分支上
`git merge branchname`

Merge to master (only if fast forward):
`git merge --ff-only branchname`

Merge to master (force a new commit):
`git merge --no-ff branchname`

Stop merge (in case of conflicts):
`git merge --abort`

Stop merge (in case of conflicts):
`git reset --merge` // prior to v1.7.4

Undo local merge that hasn't been pushed yet:
`git reset --hard origin/master`

Merge only one specific commit: 
`git cherry-pick 073791e7`

```
# 将其他分支合并到当前分支
$ git merge branchName

# 在合并时创建一个新的合并后的提交
# 不要 Fast-Foward 合并，这样可以生成 merge 提交
$ git merge --no-ff branchName
```

#### Rebase

```
git pull
git checkout develop
git log --graph --oneline
git rebase master develop
git push origin develop --force
```

```
git pull
git checkout develop
blabla work
git checkout master
git pull origin master
git checkout develop
git rebase master
git checkout master
git rebase develop
```

```
git fetch origin master
git rebase origin/master
blabla conflicts
git add conflicted_file
git rebase --continue
:wq
git push origin feature -f 
```

`git checkout branchname` » `git rebase master`
or:
`git merge master branchname`
(The rebase moves all of the commits in `master` onto the tip of `branchname`.)

Cancel rebase:
`git rebase --abort`

Squash multiple commits into one:
`git rebase -i HEAD~3` 

Squash-merge a feature branch (as one commit):
`git merge --squash branchname` (commit afterwards)

`git rebase --autostash` 执行 rebase 之前自动 stash

将一个分支上所有的提交历史都应用到另一个分支上*不要在一个已经公开的远端分支上使用 rebase*.

```
# 将experimentBranch应用到master上面
# git rebase <basebranch> <topicbranch>
$ git rebase master experimentBranch
```

- merge 是一个合并操作，会将两个分支的修改合并在一起，默认操作的情况下会提交合并中修改的内容。
- merge 的提交历史记录了实际发生过什么，关注点在真实的提交历史上面。
- rebase 并没有进行合并操作，只是提取了当前分支的修改，将其复制在了目标分支的最新提交后面。
- rebase 操作会丢弃当前分支已提交的 commit，故不要在已经 push 到远程，和其他人正在协作开发的分支上执行 rebase 操作。
- merge 与 rebase 都是很好的分支合并命令，没有好坏之分，使用哪一个应由团队的实际开发需求及场景决定。
- 如果比较关注commit时间的话，还是用git merge，rebase会打乱时间线是不可避免的。

远程和本地已经各自有commit了，我们常规的做法是git pull一下，在本地解决冲突，然后继续push，本质上git pull = git fetch + git merge。

如果我们此时采用git pull --rebase，也就是=git fetch + git rebase. 还是会提示我们去处理冲突，但是从git log 上可以看出明显已经发生了rebase，也就是变基，本地分支基于了远程的最新commit，而不是上次的本地commit。

git rebase 处理冲突，每处理完一次本地commit冲突，用git add标记冲突已处理完，用git rebase --continue继续处理下一个本地commit，也可以先用git rebase -i将本地的commit合并为一个commit，这样git pull --rebase就能一次处理所有的冲突。

#### Stash

Put in stash: -- 暂存当前修改
`git stash save "Message"`

`git stash -u` 保存当前状态，包括 untracked 的文件

Show stash: -- 查看暂存列表, 展示所有 stashes
`git stash list`

Show stash stats:
`git stash show stash@{0}`

Show stash changes:
`git stash show -p stash@{0}`

`git stash pop` — 回到最后一个 stash 的状态，并删除这个 stash

Use custom stash item and drop it: -- 恢复暂存并删除暂存记录
`git stash pop stash@{0}`

获取并删除暂存项
`git stash apply stash@{1}`
`git stash drop stash@{1}`

Use custom stash item and do not drop it: -- 恢复最近的一次暂存
`git stash apply stash@{0}`

`git stash apply <stash@{n}>` 回到某个 stash 的状态

Use custom stash item and index:
`git stash apply --index`

Create branch from stash: 
`git stash branch new_branch`

Delete custom stash item: -- 移除某次暂存
`git stash drop stash@{0}`

Delete complete stash: --  清除暂存
`git stash clear`

`git checkout <stash@{n}> -- <file-path>` 从 stash 中拿出某个文件的修改

`git ls-files -t` 展示所有 tracked 的文件

`git ls-files --others` 展示所有 untracked 的文件

`git ls-files --others -i --exclude-standard` 展示所有忽略的文件

#### Blame
`git blame <file-name>` 查看某段代码是谁写的
`git blame -L10,+1 index.html`

```
# 显示指定文件是什么人在什么时间修改过
$ git blame [file]
```

`git clean <directory-name> -df ` 强制删除 untracked 的目录

`git bundle create <file> <branch-name>` 把某一个分支到导出成一个文件

`git clone repo.bundle <repo-dir> -b <branch-name>` 从包中导入分支

#### Log

Show commits:
`git log`

Show oneline-summary of commits:
`git log --oneline`

Show oneline-summary of commits with full SHA-1:
`git log --format=oneline`

Show oneline-summary of the last three commits:
`git log --oneline -3`

Show only custom commits:
`git log --author="Ling"`
`git log --grep="Message"`
`git log --until=2013-01-01`
`git log --since=2013-01-01`

Show only custom data of commit:
`git log --format=short`
`git log --format=full`
`git log --format=fuller`
`git log --format=email`
`git log --format=raw`

Show changes:
`git log -p`

Show every commit since special commit for custom file only:
`git log 6eb715d.. index.html`

Show changes of every commit since special commit for custom file only:
`git log -p 6eb715d.. index.html`

Show stats and summary of commits:
`git log --stat --summary`

Show history of commits as graph:
`git log --graph`

Show history of commits as graph-summary: 展示简化的 commit 历史
`git log --oneline --graph --all --decorate`

`git log Branch1 ^Branch2`  — commit 历史中显示 Branch1 有的，但是 Branch2 没有 commit

`git log --show-signature` — 在 commit log 中显示 GPG 签名

```
# 显示commit历史，以及每次commit发生变更的文件
$ git log --stat

# 搜索提交历史，根据关键词
$ git log -S [keyword]

# 显示某个commit之后的所有变动，每个commit占据一行
$ git log [tag] HEAD --pretty=format:%s

# 显示某个commit之后的所有变动，其"提交说明"必须符合搜索条件
$ git log [tag] HEAD --grep feature

# 显示某个文件的版本历史，包括文件改名
$ git log --follow [file]
$ git whatchanged [file]

# 显示指定文件相关的每一次diff
$ git log -p [file]

# 显示过去5次提交
$ git log -5 --pretty --oneline
```

```
# 显示所有提交
$ git log

# 显示某几条提交信息
$ git log -n 10

# 仅显示合并提交
$ git log --merges

# 查看该文件每次提交记录
$ git log <file>

# 查看每次详细修改内容的diff
$ git log -p <file>

# 查看最近两次详细修改内容的diff
$ git log -p -2

#查看提交统计信息
$ git log --stat
```

#### Diff

Compare modified files in working directory. 输出工作区和暂存区的不同
`git diff`

Compare modified files within the staging area:
`git diff --staged`

展示暂存区和最近版本的不同

`git diff --cached`

Compare commits in local repository - 

`git diff 6eb715d`

输出工作区、暂存区 和本地最近的版本 (commit) 的不同

`git diff 6eb715d..HEAD`

`git diff <commit-id> <commit-id>` -展示本地仓库中任意两个 commit 之间的文件变动

`git diff 6eb715d..537a09f`

Compare modified files and highlight changes only:
`git diff --color-words index.html`

Compare branches:
`git diff master..branchname`

Compare branches like above:
`git diff --color-words master..branchname^`

Compare without caring about spaces:
`git diff -b 6eb715d..HEAD` or:
`git diff --ignore-space-change 6eb715d..HEAD`

Compare without caring about all spaces:
`git diff -w 6eb715d..HEAD` or:
`git diff --ignore-all-space 6eb715d..HEAD`

Useful comparings:
`git diff --stat --summary 6eb715d..HEAD`

`git diff --word-diff `-- 详细展示一行中的修改

```
# 显示暂存区和工作区的差异
$ git diff

# 显示暂存区和上一个commit的差异
$ git diff --cached [file]

# 显示工作区与当前分支最新commit之间的差异
$ git diff HEAD

# 显示两次提交之间的差异
$ git diff [first-branch]...[second-branch]

# 显示今天你写了多少行代码
$ git diff --shortstat "@{0 day ago}"

# 比较暂存区和版本库差异
$ git diff --staged

# 比较暂存区和版本库差异
$ git diff --cached

# 仅仅比较统计信息
$ git diff --stat

```

```
# 显示工作目录和索引的不同
$ git diff

# 显示索引和最近一次提交的不同
$ git diff --cached

# 显示工作目录和最近一次提交的不同
$ git diff HEAD

```

#### Grep

```
可选配置：

# 在搜索结果中显示行号
$ git config --global grep.lineNumber true

# 是搜索结果可读性更好
$ git config --global alias.g "grep --break --heading --line-number"
# 在所有的java中查找variableName
$ git grep 'variableName' -- '*.java'

# 搜索包含 "arrayListName" 和, "add" 或 "remove" 的所有行
$ git grep -e 'arrayListName' --and \( -e add -e remove \)
```

### Ci
```
$ git ci <file>
$ git ci .
# 将git add, git rm和git ci等操作都合并在一起做
$ git ci -a
$ git ci -am "some comments"
# 修改最后一次提交记录
$ git ci --amend
```

#### Releases & Version Tags

Show all released versions: -- 列出所有标签列表
`git tag`

展示当前分支的最近的 tag
`git describe --tags --abbrev=0`

Show all released versions with comments: 查看标签详细信息
`git tag -l -n1`

`git tag -ln`

Create release version: --添加标签(默认对当前版本)
`git tag v1.0.0`

Create release version with comment: -- 创建新标签并增加备注
`git tag -a v1.0.0 -m 'Message'`

默认 tag 是打在最近的一次 commit 上，如果需要指定 commit 打 tag：

`git tag -a <version-number> -m "v1.0 发布(描述)" <commit-id>`

```
# 列出所有tag
$ git tag

# 新建一个tag在当前commit
$ git tag [tag]

# 新建一个tag在指定commit
$ git tag [tag] [commit]

# 删除本地tag
$ git tag -d [tag]

# 删除远程tag
$ git push origin :refs/tags/[tagName]

# 查看tag信息
$ git show [tag]

# 提交指定tag
$ git push [remote] [tag]

# 提交所有tag
$ git push [remote] --tags

# 新建一个分支，指向某个tag
$ git checkout -b [branch] [tag]
```

#### Show

`git show tagname` -- 查看标签信息

```# 显示某次提交的元数据和内容变化
$ git show [commit]

# 显示某次提交发生变化的文件
$ git show --name-only [commit]

# 显示某次提交时，某个文件的内容
$ git show [commit]:[filename]
```

```
# 显示所有提交过的用户，按提交次数排序
$ git shortlog -sn
```

### Push

`git push origin tagname` -- 推送标签到远程仓库

`git push origin <local-version-number>` 推送标签到远程仓库

`git push origin --tags` -- 推送所有标签到远程仓库, 一次性推送所有标签，同步到远程仓库

`git tag -d tagname` -- 删除本地标签

`git push my remote –tags` -- 将所有本地标记发送到远程版本库中

`git push origin :refs/tags/<tag-name>`--删除远程标签

`git push origin :refs/tags/tagnames` -- 从远程仓库中删除标签


### Pull

```
# 从远端origin的master分支更新版本库
# git pull <远端> <分支>
$ git pull origin master

# 抓取远程仓库所有分支更新并合并到本地，不要快进合并
$ git pull --no-ff
```

#### Fetch:
`git fetch upstream`

Fetch a custom branch:
`git fetch upstream branchname:local_branchname`

`git fetch origin pull/<id>/head:<branch-name>` — 从远程仓库根据 ID，拉下某一状态，到本地分支

`git fetch -p` 移除远程仓库上不存在的分支

`git fetch -p && git branch --remote | fgrep greenkeeper | sed 's/^.\{9\}//' | xargs git push origin --delete`  移除所有包含 `greenkeeper` 的分支

Merge fetched commits:
`git merge upstream/master`

Remove origin:
`git remote rm origin`

Show remote branches:
`git branch -r`

Show all branches (remote and local):
`git branch -a`

Create and checkout branch from a remote branch:
`git checkout -b local_branchname upstream/remote_branchname`

Compare:
`git diff origin/master..master`

Push (set default with `-u`):
`git push -u origin master`

Push:
`git push origin master`

Force-Push:
`git push origin master --force`

Pull:
`git pull`

Pull specific branch:
`git pull origin branchname`

Fetch a pull request on GitHub by its ID and create a new branch:
`git fetch upstream pull/ID/head:new-pr-branch`

Clone to localhost:
`git clone https://github.com/user/project.git` or:
`git clone ssh://user@domain.com/~/dir/.git`

Clone to localhost folder:
`git clone https://github.com/user/project.git ~/dir/folder`

Clone specific branch to localhost:
`git clone -b branchname https://github.com/user/project.git`

Delete remote branch (push nothing), 删除远程分支
`git push origin :branchname` or:
`git push origin --delete branchname`

#### Archive

Create a zip-archive: 

`git archive --format zip --output filename.zip master`

Export/write custom log to a file: 

`git log --author=sven --all > log.txt`

#### Gitignore & Gitkeep

About: https://help.github.com/articles/ignoring-files

Useful templates: https://github.com/github/gitignore

Add or edit gitignore: 
`nano .gitignore`

Track empty dir: 
`touch dir/.gitkeep`

`git clean -X -f` 详细展示一行中的修改

#### Troubleshooting

Ignore files that have already been committed to a Git repository: http://stackoverflow.com/a/1139797/1815847

#### Security

Hide Git on the web via `.htaccess`: `RedirectMatch 404 /\.git` 
(more info here: http://stackoverflow.com/a/17916515/1815847)

#### Large File Storage

Website: https://git-lfs.github.com/

Install: `brew install git-lfs`

Track `*.psd` files: `git lfs track "*.psd"` (init, add, commit and push as written above)

```
**own git repo examples**

`git branch ling`

`git checkout master`

`git add .`

`git status`

`git commit --m 'add new files'`

`git pull origin master`

`git push -u origin master`

**php examples**

`git branch`

`rsub -f components/Gdpr/Collector/User/LastActiveTimes.php` 

`git diff`

`git diff -staged`

`git add -u`

`git commit -m "Testing"`

`vendor/bin/phpcbf components/Gdpr/Collector/User/LastActiveTimes.php`

**rebase examples**

`git rebase add_shift_dt_fn/master`

`git rebase -i 5cc90d163c8eeec54c823a09a1cbab57daf6163b`

`git pull --rebase`

`git add dlorean/utils/dates.py`

`git status`

`git diff`

`git diff -staged`

`git push`

**revert/undo the last commit:**

`git reset --soft HEAD~`

`git reset HEAD~1`

check out the current directory:
`git checkout -- .`

**look for difference:**
`git diff`

`git checkout -- .`

`vim whitelists.yaml`

`git diff`

**commit to PR and force-push**

`git commit --m 'add ling to the whitelist'`

`git push`

`git push --set-upstream origin add_ling_whitelist_grp -f`

#### Reminder

Press `minus + shift + s` and `return` to chop/fold long lines!

Show folder content: `ls -la`

#### Notes

Do not put (external) dependencies in version control!

#### Setup

See where Git is located:
`which git`

Get the version of Git 查看Git的版本
`git --version`

Create an alias (shortcut) for `git status`:
`git config --global alias.st status`

# 生成一个可供发布的压缩包
$ git archive

# 打补丁
$ git apply ../sync.patch

# 测试补丁能否成功
$ git apply --check ../sync.patch
```
#### Help

Help:
`git help`

`git help -g`

```
# 查找可用命令
$ git help

# 查找所有可用命令
$ git help -a

# 在文档当中查找特定的命令
# git help <命令>
$ git help add
$ git help commit
$ git help init
```

```
Get everything ready to commit:
`git add .`

Get custom file ready to commit:
`git add index.html`

Commit changes:
`git commit -m "Message"`

Commit changes with title and description:
`git commit -m "Title" -m "Description..."`

Add and commit in one step:
`git commit -am "Message"`
`git commit –amend` ——将暂存区的更改添加到最近一次提交中。

Remove files from Git:
`git rm index.html`

Update all changes:
`git add -u`

Remove file but do not track anymore:
`git rm --cached index.html`

Move or rename files:
`git mv index.html dir/index_new.html`

Undo modifications (restore files from latest commited version): - 撤销修改的文件(如果文件加入到了暂存区，则回退到暂存区的，如果文件加入到了版本库，则还原至加入版本库之后的状态)
`git checkout -- index.html`

Restore file from a custom commit (in current branch):
`git checkout 6eb715d -- index.html`

Hard reset of a single file (`@` is short for `HEAD`):
`git checkout @ -- index.html`

`git show <branch-name>:<file-name>  --展示任意分支某一文件的内容`

`git clone -b <branch-name> --single-branch https://github.com/user/repo.git --clone 下来指定的单一分支`

`git update-index --assume-unchanged path/to/file` 忽略某个文件的改动, 关闭 track 指定文件的改动，也就是 Git 将不会在记录这个文件的改动

`git update-index --no-assume-unchanged path/to/file`忽略某个文件的改动, 关闭 track 指定文件的改动，也就是 恢复 track 指定文件的改动

`git config core.fileMode false` — 忽略文件的权限变化

`git for-each-ref --sort=-committerdate --format= %(refname:short)  refs/heads/` --以最后提交的顺序列出所有 Git 分支
```

```
➜  campaign-runner git:(a9ccd04) sbt compile
[info] Loading settings for project campaign-runner-build from plugins.sbt ...
[info] Loading project definition from /Users/lingh/Git/campaign-runner/project
[info] Loading settings for project root from build.sbt ...
[info] Set current project to campaign-runner-parent (in build file:/Users/lingh/Git/campaign-runner/)
[info] Executing in batch mode. For better performance use sbt's shell
[success] Total time: 1 s, completed Jan 14, 2020 1:54:35 PM
➜  campaign-runner git:(a9ccd04) git diff HEAD master
➜  campaign-runner git:(a9ccd04)
➜  campaign-runner git:(a9ccd04) git log
➜  campaign-runner git:(a9ccd04)
➜  campaign-runner git:(a9ccd04) git checkout master
Previous HEAD position was a9ccd04 Update sbt.version (#169)
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
➜  campaign-runner git:(master) git diff a9ccd04
➜  campaign-runner git:(master)
➜  campaign-runner git:(master) git log -p
➜  campaign-runner git:(master) git checkout a9ccd04
Note: checking out 'a9ccd04'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at a9ccd04 Update sbt.version (#169)
➜  campaign-runner git:(a9ccd04) git branch -d master
warning: deleting branch 'master' that has been merged to
         'refs/remotes/origin/master', but not yet merged to HEAD.
Deleted branch master (was ae882bd).

➜  campaign-runner git:(a9ccd04) git checkout -b master
Switched to a new branch 'master'
➜  campaign-runner git:(master) git log -p
➜  campaign-runner git:(master) git push origin master -f
Total 0 (delta 0), reused 0 (delta 0)
remote: error: GH006: Protected branch update failed for refs/heads/master.
remote: error: Cannot force-push to a protected branch
To ghe.spotify.net:edison/campaign-runner.git
 ! [remote rejected] master -> master (protected branch hook declined)
error: failed to push some refs to 'git@ghe.spotify.net:edison/campaign-runner.git'
➜  campaign-runner git:(master) git push origin master -f
Total 0 (delta 0), reused 0 (delta 0)
To ghe.spotify.net:edison/campaign-runner.git
 + ae882bd...a9ccd04 master -> master (forced update)
```

```
远程同步的远端分支

# 下载远程仓库的所有变动
$ git fetch [remote]

# 显示所有远程仓库
$ git remote -v

# 显示某个远程仓库的信息
$ git remote show [remote]

# 增加一个新的远程仓库，并命名
$ git remote add [shortname] [url]

# 查看远程服务器地址和仓库名称
$ git remote -v

# 添加远程仓库地址
$ git remote add origin git@ github:xxx/xxx.git

# 设置远程仓库地址(用于修改远程仓库地址)
$ git remote set-url origin git@ github.com:xxx/xxx.git

# 删除远程仓库
$ git remote rm <repository>

# 上传本地指定分支到远程仓库
# 把本地的分支更新到远端origin的master分支上
# git push <远端> <分支>
# git push 相当于 git push origin master
$ git push [remote] [branch]

# 强行推送当前分支到远程仓库，即使有冲突
$ git push [remote] --force

# 推送所有分支到远程仓库
$ git push [remote] --all
```

```
撤销

# 恢复暂存区的指定文件到工作区
$ git checkout [file]

# 恢复某个commit的指定文件到暂存区和工作区
$ git checkout [commit] [file]

# 恢复暂存区的所有文件到工作区
$ git checkout .

# 重置暂存区的指定文件，与上一次commit保持一致，但工作区不变
$ git reset [file]

# 重置暂存区与工作区，与上一次commit保持一致
$ git reset --hard

# 重置当前分支的指针为指定commit，同时重置暂存区，但工作区不变
$ git reset [commit]

# 重置当前分支的HEAD为指定commit，同时重置暂存区和工作区，与指定commit一致
$ git reset --hard [commit]

# 重置当前HEAD为指定commit，但保持暂存区和工作区不变
$ git reset --keep [commit]

# 新建一个commit，用来撤销指定commit
# 后者的所有变化都将被前者抵消，并且应用到当前分支
$ git revert [commit]

# 恢复最后一次提交的状态
$ git revert HEAD

# 暂时将未提交的变化移除，稍后再移入
$ git stash
$ git stash pop

# 列所有stash
$ git stash list

# 恢复暂存的内容
$ git stash apply

# 删除暂存区
$ git stash drop
```


Oh shit, I did something terribly wrong, please tell me git has a magic time machine!?!
```
git reflog
# you will see a list of every thing you've done in git, across all branches! 
# each one has an index HEAD@{index}
# find the one before you broke everything

git reset HEAD@{index}
# magic time machine
```

Oh shit, I committed and immediately realized I need to make one small change!
```
# make your change
git add . # or add individual files

git commit --amend --no-edit
# now your last commit contains that change!
# WARNING: never amend public commits, Only amend commits that only exist in your local copy or you're gonna have a bad time.
```

Oh shit, I need to change the message on my last commit!
```
git commit --amend
# follow prompts to change the commit message
```

Oh shit, I accidentally committed something to master that should have been on a brand new branch!
```
# create a new branch from the current state of master
git branch some-new-branch-name

# remove the last commit from the master branch
git reset HEAD~ --hard
git checkout some-new-branch-name
# your commit lives in this branch now :)
```

Oh shit, I accidentally committed to the wrong branch!
```
# undo the last commit, but leave the changes available
git reset HEAD~ --soft
git stash

# move to the correct branch
git checkout name-of-the-correct-branch
git stash pop
git add . # or add individual files
git commit -m "your message here";
# now your changes are on the correct branch
```

A lot of people have suggested using cherry-pick for this situation too, so take your pick on whatever one makes the most sense to you!
```
git checkout name-of-the-correct-branch

# grab the last commit to master
git cherry-pick master

# delete it from master
git checkout master
git reset HEAD~ --hard
```

Oh shit, I tried to run a diff but nothing happened?!
```
git diff --staged
```

Oh shit, I need to undo a commit from like 5 commits ago!]
```
# find the commit you need to undo
git log

# use the arrow keys to scroll up and down in history
# once you've found your commit, save the hash

git revert [saved hash]
# git will create a new commit that undoes that commit
# follow prompts to edit the commit message
# or just save and commit
```

Oh shit, I need to undo my changes to a file!
```
# find a hash for a commit before the file was changed
git log
# use the arrow keys to scroll up and down in history
# once you've found your commit, save the hash
git checkout [saved hash] -- path/to/file
# the old version of the file will be in your index
git commit -m "Wow, you don't have to copy-paste to undo"
```

For real though, if your branch is sooo borked that you need to reset the state of your repo to be the same as the remote repo in a "git-approved" way, try this, but beware these are destructive and unrecoverable actions!

```
# get the lastest state of origin
git fetch origin
git checkout master
git reset --hard origin/master
# delete untracked files and directories
git clean -d --force
# repeat checkout/reset/clean for each borked branch
```

下边我们整理了45个日常用git合代码的经典操作场景，基本覆盖了工作中的需求。

**我刚才提交了什么?**

如果你用 git commit -a 提交了一次变化(changes)，而你又不确定到底这次提交了哪些内容。你就可以用下面的命令显示当前HEAD上的最近一次的提交(commit):

```
(main)$ git show
```

```
$ git log -n1 -p  
```

**我的提交信息(commit message)写错了**

如果你的提交信息(commit message)写错了且这次提交(commit)还没有推(push), 你可以通过下面的方法来修改提交信息(commit message):


```
$ git commit --amend --only  
```

这会打开你的默认编辑器, 在这里你可以编辑信息. 另一方面, 你也可以用一条命令一次完成:

```
$ git commit --amend --only -m 'xxxxxxx'  
```

如果你已经推(push)了这次提交(commit), 你可以修改这次提交(commit)然后强推(force push), 但是不推荐这么做。


**我提交(commit)里的用户名和邮箱不对**

如果这只是单个提交(commit)，修改它：

```
$ git commit --amend --author "New Authorname <authoremail@mydomain.com>"  
```

如果你需要修改所有历史, 参考 'git filter-branch'的指南页.

**我想从一个提交(commit)里移除一个文件**

通过下面的方法，从一个提交(commit)里移除一个文件:

```
$ git checkout HEAD^ myfile  $ git add -A  $ git commit --amend
```

这将非常有用，当你有一个开放的补丁(open patch)，你往上面提交了一个不必要的文件，你需要强推(force push)去更新这个远程补丁。

 **我想删除我的的最后一次提交(commit)**

如果你需要删除推了的提交(pushed commits)，你可以使用下面的方法。可是，这会不可逆的改变你的历史，也会搞乱那些已经从该仓库拉取(pulled)了的人的历史。简而言之，如果你不是很确定，千万不要这么做。

```
$ git reset HEAD^ --hard  $ git push -f [remote] [branch]
```

如果你还没有推到远程, 把Git重置(reset)到你最后一次提交前的状态就可以了(同时保存暂存的变化):

```
(my-branch*)$ git reset --soft HEAD@{1}  
```

这只能在没有推送之前有用. 如果你已经推了, 唯一安全能做的是 git revert SHAofBadCommit， 那会创建一个新的提交(commit)用于撤消前一个提交的所有变化(changes)；或者, 如果你推的这个分支是rebase-safe的 (例如：其它开发者不会从这个分支拉), 只需要使用 git push -f。

**删除任意提交(commit)**

同样的警告：不到万不得已的时候不要这么做.

```
$ git rebase --onto SHA1_OF_BAD_COMMIT^ SHA1_OF_BAD_COMMIT  
$ git push -f [remote] [branch]
```

或者做一个 交互式rebase 删除那些你想要删除的提交(commit)里所对应的行。

**# 我尝试推一个修正后的提交(amended commit)到远程，但是报错：**

```
To https://github.com/yourusername/repo.git  
! [rejected]       mybranch -> mybranch (non-fast-forward)  
error: failed to push some refs to 'https://github.com/tanay1337/webmaker.org.git'  
hint: Updates were rejected because the tip of your current branch is behind  
hint: its remote counterpart. Integrate the remote changes (e.g.  hint: 'git pull ...') before pushing again.  
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

```

注意,rebasing(见下面)和修正(amending)会用一个新的提交(commit)代替旧的, 所以如果之前你已经往远程仓库上推过一次修正前的提交(commit)，那你现在就必须强推(force push) (-f)。注意 – 总是 确保你指明一个分支!

```
(my-branch)$ git push origin mybranch -f
```

一般来说, 要避免强推. 最好是创建和推(push)一个新的提交(commit)，而不是强推一个修正后的提交。后者会使那些与该分支或该分支的子分支工作的开发者，在源历史中产生冲突。

**我意外的做了一次硬重置(hard reset)，我想找回我的内容**

如果你意外的做了 git reset --hard, 你通常能找回你的提交(commit), 因为Git对每件事都会有日志，且都会保存几天。

```
(main)$ git reflog
```

你将会看到一个你过去提交(commit)的列表, 和一个重置的提交。选择你想要回到的提交(commit)的SHA，再重置一次:

```
(main)$ git reset --hard SHA1234
```

这样就完成了。

**暂存(Staging)**

**我需要把暂存的内容添加到上一次的提交(commit)**

```
(my-branch*)$ git commit --amend
```

**我想要暂存一个新文件的一部分，而不是这个文件的全部**
一般来说, 如果你想暂存一个文件的一部分, 你可这样做:

```
$ git add --patch filename.x
```

-p 简写。这会打开交互模式， 你将能够用 s 选项来分隔提交(commit)；然而, 如果这个文件是新的, 会没有这个选择， 添加一个新文件时, 这样做:

```
$ git add -N filename.x
```

然后,你需要用 e 选项来手动选择需要添加的行，执行 git diff --cached 将会显示哪些行暂存了哪些行只是保存在本地了。

**我想把在一个文件里的变化(changes)加到两个提交(commit)里**

git add 会把整个文件加入到一个提交. git add -p 允许交互式的选择你想要提交的部分.

**我想把暂存的内容变成未暂存，把未暂存的内容暂存起来**

多数情况下，你应该将所有的内容变为未暂存，然后再选择你想要的内容进行commit。但假定你就是想要这么做，这里你可以创建一个临时的commit来保存你已暂存的内容，然后暂存你的未暂存的内容并进行stash。然后reset最后一个commit将原本暂存的内容变为未暂存，最后stash pop回来。

```
$ git commit -m "WIP"  $ git add .  $ git stash  $ git reset HEAD^  $ git stash pop --index 0
```

注意1: 这里使用pop仅仅是因为想尽可能保持幂等。注意2: 假如你不加上--index你会把暂存的文件标记为为存储。

**未暂存(Unstaged)的内容**

**我想把未暂存的内容移动到一个新分支**

```
$ git checkout -b my-branch  
```

**我想把未暂存的内容移动到另一个已存在的分支**

```
$ git stash  $ git checkout my-branch  $ git stash pop
```

**我想丢弃本地未提交的变化(uncommitted changes)**

如果你只是想重置源(origin)和你本地(local)之间的一些提交(commit)，你可以：

```
# one commit  (my-branch)$ git reset --hard HEAD^  # two commits  (my-branch)$ git reset --hard HEAD^^  # four commits  (my-branch)$ git reset --hard HEAD~4  # or  (main)$ git checkout -f

```

重置某个特殊的文件, 你可以用文件名做为参数:

```
$ git reset filename
```

**我想丢弃某些未暂存的内容**

如果你想丢弃工作拷贝中的一部分内容，而不是全部。
签出(checkout)不需要的内容，保留需要的。

```
$ git checkout -p  # Answer y to all of the snippets you want to drop
```

另外一个方法是使用 stash， Stash所有要保留下的内容, 重置工作拷贝, 重新应用保留的部分。

```
$ git stash -p  # Select all of the snippets you want to save  $ git reset --hard  $ git stash pop
```

或者,stash 你不需要的部分, 然后stash drop。

```
$ git stash -p  # Select all of the snippets you don't want to save  $ git stash drop  
```

**分支(Branches)**

**我从错误的分支拉取了内容，或把内容拉取到了错误的分支**
这是另外一种使用 git reflog 情况，找到在这次错误拉(pull) 之前HEAD的指向。

```
(main)$ git reflog  ab7555f HEAD@{0}: pull origin wrong-branch: Fast-forward  c5bc55a HEAD@{1}: checkout: checkout message goes here
```

重置分支到你所需的提交(desired commit):

```
$ git reset --hard c5bc55a
```

完成。

**我想扔掉本地的提交(commit)，以便我的分支与远程的保持一致**

先确认你没有推(push)你的内容到远程。

git status 会显示你领先(ahead)源(origin)多少个提交:

```
(my-branch)$ git status  # On branch my-branch  # Your branch is ahead of 'origin/my-branch' by 2 commits.  #   (use "git push" to publish your local commits)  #  
```

一种方法是:

```
(main)$ git reset --hard origin/my-branch  
```

**我需要提交到一个新分支，但错误的提交到了main**
在main下创建一个新分支，不切换到新分支,仍在main下:

```
(main)$ git branch my-branch  
```

把main分支重置到前一个提交:

```
(main)$ git reset --hard HEAD^
```

HEAD^ 是 HEAD^1 的简写，你可以通过指定要设置的HEAD来进一步重置。
或者,如果你不想使用 HEAD^, 找到你想重置到的提交(commit)的hash(git log 能够完成)， 然后重置到这个hash。使用git push 同步内容到远程。
例如,main分支想重置到的提交的hash为a13b85e:

```
(main)$ git reset --hard a13b85e  HEAD is now at a13b85e
```

签出(checkout)刚才新建的分支继续工作:

```
(main)$ git checkout my-branch
```

**我想保留来自另外一个ref-ish的整个文件**

假设你正在做一个原型方案(原文为working spike (see note)), 有成百的内容，每个都工作得很好。现在, 你提交到了一个分支，保存工作内容:

```
(solution)$ git add -A && git commit -m "Adding all changes from this spike into one big commit."  
```

当你想要把它放到一个分支里 (可能是feature, 或者 develop), 你关心是保持整个文件的完整，你想要一个大的提交分隔成比较小。
假设你有:

- 分支 solution, 拥有原型方案， 领先 develop 分支。
- 分支 develop, 在这里你应用原型方案的一些内容。
  我去可以通过把内容拿到你的分支里，来解决这个问题:

```
(develop)$ git checkout solution -- file1.txt
```

这会把这个文件内容从分支 solution 拿到分支 develop 里来:

```
# On branch develop  # Your branch is up-to-date with 'origin/develop'.  # Changes to be committed:  #  (use "git reset HEAD <file>..." to unstage)  #  #        modified:   file1.txt
```

然后,正常提交。

> Note: Spike solutions are made to analyze or solve the problem. These solutions are used for estimation and discarded once everyone gets clear visualization of the problem.

**我把几个提交(commit)提交到了同一个分支，而这些提交应该分布在不同的分支里**

假设你有一个main分支， 执行git log, 你看到你做过两次提交:

```
(main)$ git log    commit e3851e817c451cc36f2e6f3049db528415e3c114  Author: Alex Lee <alexlee@example.com>  Date:   Tue Jul 22 15:39:27 2014 -0400        Bug #21 - Added CSRF protection    commit 5ea51731d150f7ddc4a365437931cd8be3bf3131  Author: Alex Lee <alexlee@example.com>  Date:   Tue Jul 22 15:39:12 2014 -0400        Bug #14 - Fixed spacing on title    commit a13b85e984171c6e2a1729bb061994525f626d14  Author: Aki Rose <akirose@example.com>  Date:   Tue Jul 21 01:12:48 2014 -0400        First commit
```

让我们用提交hash(commit hash)标记bug (e3851e8 for #21, 5ea5173 for #14).
首先,我们把main分支重置到正确的提交(a13b85e):

```
(main)$ git reset --hard a13b85e  HEAD is now at a13b85e
```

现在, 我们对 bug21 创建一个新的分支:

```
(main)$ git checkout -b 21  (21)$  
```

接着, 我们用_cherry-pick_把对bug21的提交放入当前分支。这意味着我们将应用(apply)这个提交(commit)，仅仅这一个提交(commit)，直接在HEAD上面。

- ``

```
(21)$ git cherry-pick e3851e8
```

这时候, 这里可能会产生冲突， 参见交互式 rebasing 章 冲突节 解决冲突.
再者， 我们为bug #14 创建一个新的分支, 也基于main分支

```
(21)$ git checkout main  (main)$ git checkout -b 14  (14)$  
```

最后, 为 bug #14 执行 cherry-pick:

```
(14)$ git cherry-pick 5ea5173
```

**我想删除上游(upstream)分支被删除了的本地分支**

一旦你在github 上面合并(merge)了一个pull request, 你就可以删除你fork里被合并的分支。如果你不准备继续在这个分支里工作, 删除这个分支的本地拷贝会更干净，使你不会陷入工作分支和一堆陈旧分支的混乱之中。

```
$ git fetch -p
```

**我不小心删除了我的分支**

如果你定期推送到远程, 多数情况下应该是安全的，但有些时候还是可能删除了还没有推到远程的分支。让我们先创建一个分支和一个新的文件:

```
(main)$ git checkout -b my-branch  (my-branch)$ git branch  (my-branch)$ touch foo.txt  (my-branch)$ ls  README.md foo.txt
```

添加文件并做一次提交

```
(my-branch)$ git add .  (my-branch)$ git commit -m 'foo.txt added'  (my-branch)$ foo.txt added   1 files changed, 1 insertions(+)   create mode 100644 foo.txt  (my-branch)$ git log    commit 4e3cd85a670ced7cc17a2b5d8d3d809ac88d5012  Author: siemiatj <siemiatj@example.com>  Date:   Wed Jul 30 00:34:10 2014 +0200        foo.txt added    commit 69204cdf0acbab201619d95ad8295928e7f411d5  Author: Kate Hudson <katehudson@example.com>  Date:   Tue Jul 29 13:14:46 2014 -0400        Fixes #6: Force pushing after amending commits
```

现在我们切回到主(main)分支，‘不小心的’删除my-branch分支

```
(my-branch)$ git checkout main  Switched to branch 'main'  Your branch is up-to-date with 'origin/main'.  (main)$ git branch -D my-branch  Deleted branch my-branch (was 4e3cd85).  (main)$ echo oh noes, deleted my branch!  oh noes, deleted my branch!
```

在这时候你应该想起了reflog, 一个升级版的日志，它存储了仓库(repo)里面所有动作的历史。

```
(main)$ git reflog  69204cd HEAD@{0}: checkout: moving from my-branch to main  4e3cd85 HEAD@{1}: commit: foo.txt added  69204cd HEAD@{2}: checkout: moving from main to my-branch
```

正如你所见，我们有一个来自删除分支的提交hash(commit hash)，接下来看看是否能恢复删除了的分支。

```
(main)$ git checkout -b my-branch-help  Switched to a new branch 'my-branch-help'  (my-branch-help)$ git reset --hard 4e3cd85  HEAD is now at 4e3cd85 foo.txt added  (my-branch-help)$ ls  README.md foo.txt
```

看!我们把删除的文件找回来了。Git的 reflog 在rebasing出错的时候也是同样有用的。

**我想删除一个分支**

删除一个远程分支:

```
(main)$ git push origin --delete my-branch
```

你也可以:

```
(main)$ git push origin :my-branch  
```

删除一个本地分支:

```
(main)$ git branch -D my-branch
```

**我想从别人正在工作的远程分支签出(checkout)一个分支**


首先,从远程拉取(fetch) 所有分支:

```
(main)$ git fetch --all  
```

假设你想要从远程的daves分支签出到本地的daves

```
(main)$ git checkout --track origin/daves  Branch daves set up to track remote branch daves from origin.  Switched to a new branch 'daves'  
```

(--track 是 git checkout -b [branch] [remotename]/[branch] 的简写)

这样就得到了一个daves分支的本地拷贝, 任何推过(pushed)的更新，远程都能看到.

**Rebasing 和合并(Merging)**

**我想撤销rebase/merge**

你可以合并(merge)或rebase了一个错误的分支, 或者完成不了一个进行中的rebase/merge。Git 在进行危险操作的时候会把原始的HEAD保存在一个叫ORIG_HEAD的变量里, 所以要把分支恢复到rebase/merge前的状态是很容易的。

```
(my-branch)$ git reset --hard ORIG_HEAD  
```

**我已经rebase过, 但是我不想强推(force push)**

不幸的是，如果你想把这些变化(changes)反应到远程分支上，你就必须得强推(force push)。是因你快进(Fast forward)了提交，改变了Git历史, 远程分支不会接受变化(changes)，除非强推(force push)。

这就是许多人使用 merge 工作流, 而不是 rebasing 工作流的主要原因之一， 开发者的强推(force push)会使大的团队陷入麻烦。使用时需要注意，一种安全使用 rebase 的方法是，不要把你的变化(changes)反映到远程分支上, 而是按下面的做:

```
(main)$ git checkout my-branch  (my-branch)$ git rebase -i main  (my-branch)$ git checkout main  (main)$ git merge --ff-only my-branch
```

**我需要组合(combine)几个提交(commit)(())

假设你的工作分支将会做对于 main 的pull-request。一般情况下你不关心提交(commit)的时间戳，只想组合 所有 提交(commit) 到一个单独的里面, 然后重置(reset)重提交(recommit)。确保主(main)分支是最新的和你的变化都已经提交了, 然后:

```
(my-branch)$ git reset --soft main  (my-branch)$ git commit -am "New awesome feature"  
```

如果你想要更多的控制, 想要保留时间戳, 你需要做交互式rebase (interactive rebase):

```
(my-branch)$ git rebase -i main
```

如果没有相对的其它分支， 你将不得不相对自己的HEAD 进行 rebase。例如：你想组合最近的两次提交(commit), 你将相对于HEAD~2 进行rebase， 组合最近3次提交(commit), 相对于HEAD~3, 等等。

```
(main)$ git rebase -i HEAD~2  
```

在你执行了交互式 rebase的命令(interactive rebase command)后, 你将在你的编辑器里看到类似下面的内容:

```
pick a9c8a1d Some refactoring  pick 01b2fd8 New awesome feature  pick b729ad5 fixup  pick e3851e8 another fix    # Rebase 8074d12..b729ad5 onto 8074d12  #  # Commands:  #  p, pick = use commit  #  r, reword = use commit, but edit the commit message  #  e, edit = use commit, but stop for amending  #  s, squash = use commit, but meld into previous commit  #  f, fixup = like "squash", but discard this commit's log message  #  x, exec = run command (the rest of the line) using shell  #  # These lines can be re-ordered; they are executed from top to bottom.  #  # If you remove a line here THAT COMMIT WILL BE LOST.  #  # However, if you remove everything, the rebase will be aborted.  #  # Note that empty commits are commented out
```

所有以 开头的行都是注释, 不会影响 rebase.

然后，你可以用任何上面命令列表的命令替换 pick, 你也可以通过删除对应的行来删除一个提交(commit)。

例如,如果你想 单独保留最旧(first)的提交(commit),组合所有剩下的到第二个里面, 你就应该编辑第二个提交(commit)后面的每个提交(commit) 前的单词为 f:

```
pick a9c8a1d Some refactoring  pick 01b2fd8 New awesome feature  f b729ad5 fixup  f e3851e8 another fix
```

如果你想组合这些提交(commit) 并重命名这个提交(commit), 你应该在第二个提交(commit)旁边添加一个r，或者更简单的用s 替代 f:

```
pick a9c8a1d Some refactoring  pick 01b2fd8 New awesome feature  s b729ad5 fixup  s e3851e8 another fix
```

你可以在接下来弹出的文本提示框里重命名提交(commit)。

```
Newer, awesomer features    # Please enter the commit message for your changes. Lines starting  # with '#' will be ignored, and an empty message aborts the commit.  # rebase in progress; onto 8074d12  # You are currently editing a commit while rebasing branch 'main' on '8074d12'.  #  # Changes to be committed:  # modified:   README.md  #
```

如果成功了, 你应该看到类似下面的内容:

```
(main)$ Successfully rebased and updated refs/heads/main.
```

**安全合并(merging)策略**
--no-commit 执行合并(merge)但不自动提交, 给用户在做提交前检查和修改的机会。no-ff 会为特性分支(feature branch)的存在过留下证据, 保持项目历史一致。

```
(main)$ git merge --no-ff --no-commit my-branch
```

** 我需要将一个分支合并成一个提交(commit)**

```
(main)$ git merge --squash my-branch
```

**我只想组合(combine)未推的提交(unpushed commit)**

有时候，在将数据推向上游之前，你有几个正在进行的工作提交(commit)。这时候不希望把已经推(push)过的组合进来，因为其他人可能已经有提交(commit)引用它们了。

```
(main)$ git rebase -i @{u}
```

这会产生一次交互式的rebase(interactive rebase), 只会列出没有推(push)的提交(commit)， 在这个列表时进行reorder/fix/squash 都是安全的。

** 检查是否分支上的所有提交(commit)都合并(merge)过了**

检查一个分支上的所有提交(commit)是否都已经合并(merge)到了其它分支, 你应该在这些分支的head(或任何 commits)之间做一次diff:

```
(main)$ git log --graph --left-right --cherry-pick --oneline HEAD...feature/120-on-scroll  
```

这会告诉你在一个分支里有而另一个分支没有的所有提交(commit), 和分支之间不共享的提交(commit)的列表。另一个做法可以是:

```
(main)$ git log main ^feature/120-on-scroll --no-merges  
```

**交互式rebase(interactive rebase)可能出现的问题**

**这个rebase 编辑屏幕出现'noop'

如果你看到的是这样:

```
noop  
```

这意味着你rebase的分支和当前分支在同一个提交(commit)上, 或者 领先(ahead) 当前分支。你可以尝试:

- 检查确保主(main)分支没有问题
- rebase HEAD~2 或者更早

**有冲突的情况**
如果你不能成功的完成rebase, 你可能必须要解决冲突。
首先执行 git status 找出哪些文件有冲突:

```
(my-branch)$ git status  On branch my-branch  Changes not staged for commit:    (use "git add <file>..." to update what will be committed)    (use "git checkout -- <file>..." to discard changes in working directory)     modified:   README.md  
在这个例子里面, README.md 有冲突。打开这个文件找到类似下面的内容: <<<<<<< HEAD     some code     =========     some code     >>>>>>> new-commit
```

你需要解决新提交的代码(示例里, 从中间==线到new-commit的地方)与HEAD 之间不一样的地方.
有时候这些合并非常复杂，你应该使用可视化的差异编辑器(visual diff editor):

```
(main*)$ git mergetool -t opendiff
```

在你解决完所有冲突和测试过后, git add 变化了的(changed)文件, 然后用git rebase --continue 继续rebase。

```
(my-branch)$ git add README.md  (my-branch)$ git rebase --continue  
```

如果在解决完所有的冲突过后，得到了与提交前一样的结果, 可以执行git rebase --skip。
任何时候你想结束整个rebase 过程，回来rebase前的分支状态, 你可以做:

```
(my-branch)$ git rebase --abort
```

**Stash**

### 暂存所有改动

暂存你工作目录下的所有改动

```
$ git stash  
```

你可以使用-u来排除一些文件

```
$ git stash -u
```

**暂存指定文件**

假设你只想暂存某一个文件

```
$ git stash push working-directory-path/filename.ext  
```

假设你想暂存多个文件

```
$ git stash push working-directory-path/filename1.ext working-directory-path/filename2.ext  
```

**暂存时记录消息**
这样你可以在list时看到它

```
$ git stash save <message>  
```

或

```
$ git stash push -m <message>
```

**使用某个指定暂存**
首先你可以查看你的stash记录

```
$ git stash list
```

然后你可以apply某个stash

```
$ git stash apply "stash@{n}"  
```

此处，'n'是stash在栈中的位置，最上层的stash会是0
除此之外，也可以使用时间标记(假如你能记得的话)。

```
$ git stash apply "stash@{2.hours.ago}"  
```

** 暂存时保留未暂存的内容**
你需要手动create一个stash commit， 然后使用git stash store。

```
$ git stash create  $ git stash store -m "commit-message" CREATED_SHA1
```

**杂项(Miscellaneous Objects)**
**克隆所有子模块**

```
$ git clone --recursive git://github.com/foo/bar.git
```

如果已经克隆了:

```
$ git submodule update --init --recursive  
```

**删除标签(tag)**

```
$ git tag -d <tag_name>  $ git push <remote> :refs/tags/<tag_name>
```

**恢复已删除标签(tag)**
如果你想恢复一个已删除标签(tag), 可以按照下面的步骤: 首先, 需要找到无法访问的标签(unreachable tag):

```
$ git fsck --unreachable | grep tag
```

记下这个标签(tag)的hash，然后用Git的 update-ref

```
$ git update-ref refs/tags/<tag_name> <hash>
```

这时你的标签(tag)应该已经恢复了。

**已删除补丁(patch)**

如果某人在 GitHub 上给你发了一个pull request, 但是然后他删除了他自己的原始 fork, 你将没法克隆他们的提交(commit)或使用 git am。在这种情况下, 最好手动的查看他们的提交(commit)，并把它们拷贝到一个本地新分支，然后做提交。

做完提交后, 再修改作者，参见变更作者。然后, 应用变化, 再发起一个新的pull request。

** 跟踪文件(Tracking Files)**

**我只想改变一个文件名字的大小写，而不修改内容**

```
(main)$ git mv --force myfile MyFile
```

**我想从Git删除一个文件，但保留该文件**

```
(main)$ git rm --cached log.txt
```

**配置(Configuration)**

** 我想给一些Git命令添加别名(alias)**

在OS X 和 Linux 下, 你的 Git的配置文件储存在 ~/.gitconfig。我在[alias] 部分添加了一些快捷别名(和一些我容易拼写错误的)，如下:

```
[alias]      a = add      amend = commit --amend      c = commit      ca = commit --amend      ci = commit -a      co = checkout      d = diff      dc = diff --changed      ds = diff --staged      f = fetch      loll = log --graph --decorate --pretty=oneline --abbrev-commit      m = merge      one = log --pretty=oneline      outstanding = rebase -i @{u}      s = status      unpushed = log @{u}      wc = whatchanged      wip = rebase -i @{u}      zap = fetch -p
```

** 我想缓存一个仓库(repository)的用户名和密码**

你可能有一个仓库需要授权，这时你可以缓存用户名和密码，而不用每次推/拉(push/pull)的时候都输入，Credential helper能帮你。

```
$ git config --global credential.helper cache  # Set git to use the credential memory cache  

$ git config --global credential.helper 'cache --timeout=3600'  # Set the cache to timeout after 1 hour (setting is in seconds)
```

**我不知道我做错了些什么**

你把事情搞砸了：你 重置(reset) 了一些东西, 或者你合并了错误的分支, 亦或你强推了后找不到你自己的提交(commit)了。有些时候, 你一直都做得很好, 但你想回到以前的某个状态。

这就是git reflog 的目的， reflog 记录对分支顶端(the tip of a branch)的任何改变, 即使那个顶端没有被任何分支或标签引用。基本上, 每次HEAD的改变, 一条新的记录就会增加到reflog。遗憾的是，这只对本地分支起作用，且它只跟踪动作 (例如，不会跟踪一个没有被记录的文件的任何改变)。

```
(main)$ git reflog  0a2e358 HEAD@{0}: reset: moving to HEAD~2  0254ea7 HEAD@{1}: checkout: moving from 2.2 to main  c10f740 HEAD@{2}: checkout: moving from main to 2.2  
```

上面的reflog展示了从main分支签出(checkout)到2.2 分支，然后再签回。那里，还有一个硬重置(hard reset)到一个较旧的提交。最新的动作出现在最上面

以 HEAD@{0}标识.

如果事实证明你不小心回移(move back)了提交(commit), reflog 会包含你不小心回移前main上指向的提交(0254ea7)。

```
$ git reset --hard 0254ea7
```

然后使用git reset就可以把main改回到之前的commit，这提供了一个在历史被意外更改情况下的安全网。