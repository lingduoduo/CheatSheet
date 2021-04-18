
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

