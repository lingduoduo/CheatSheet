#### Setup

** Genereate SSH Key
`ssh-keygen -t rsa -b 4096 -C "linghypshen@gmail.com"`

** Initialize Git**
`git init`

`git remote` 列出所有远程仓库

`git remote add origin url` -- 关联远程仓库

`git remote set-url origin <URL>`--修改远程仓库的 url

`git config --global credential.helper stor` -- 拉取、上传免密码

`git pull`

`git fetch` -- 获取远程仓库中所有的分支到本地

** autosetup rebase so that pulls rebase by default**

`git config --global branch.autosetuprebase always`

** if you already have branches (made before `autosetuprebase always`)**

`git config branch.mybranchname.rebase true`

** you almost certainly want to run this as well, to allow git commands to be output with colour:**

`git config --global color.ui always`

`git status --ignored` --展示忽略的文件

#### Workflow

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
`git merge --no-ff -m '合并描述' 分支名` -- 不使用Fast forward方式合并，采用这种方式合并可以看到合并记录

--no-ff preserves feature history and easy full-feature reverts merge commits should not include changes; 

`git rebase -i HEAD-n` -- rebasing reconciles issues

`git rebase -i master mybranch`

`git rm -r --cached 文件/文件夹名字` 取消文件被版本控制

`git reflog` -- 获取执行过的命令, 显示本地更新过 HEAD 的 git 命令记录

`git log --graph` -- 查看分支合并图, 查看 commit 历史

`git whatchanged --since= 2 weeks ago` --查看两个星期内的改动

`git check-ignore -v 文件名` -- 查看忽略规则

`git update-index --assume-unchanged file` --忽略单个文件

`git rm -r --cached 文件/文件夹名字` -- 忽略全部文件

`git update-index --no-assume-unchanged file` -- 取消忽略文件

`git update-ref -d HEAD` 把所有的改动都重新放回工作区，并清空所有的 commit，这样就可以重新提交第一个 commit 了

`git checkout <branch-name> && git cherry-pick <commit-id>`把 A 分支的某一个 commit，放到 B 分支上

### General

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

#### Reset

`git rest --hard HEAD` ---- 回退到上一个版本

`git reset –-hard HEAD` ——撤销最近提交以来暂存区和非暂存区的改动

`git reset --hard origin/master` --回到远程仓库的状态

Hard reset (move HEAD and change staging dir and working dir to match repo): -- 回退到某个版本,  彻底回退到指定commit-id的状态，暂存区和工作区也会变为指定commit-id版本的内容
`git reset --hard commit_id`
`git reset --hard 073791e7dd71b90daa853b2c5acc2c925f02dbc6`

reset 命令会抹去某个 commit id 之后的所有 commit

`git reset <commit-id>`  默认就是-mixed参数

`git reset –mixed HEAD^`  回退至上个版本，它将重置HEAD到另外一个commit,并且重置暂存区以便和HEAD相匹配，但是也到此为止。工作区不会被更改。

`git reset –soft HEAD~3`  回退至三个版本之前，只回退了commit的信息，暂存区和工作区与回退之前保持一致。如果还要提交，直接commit即可

Undo latest commit: 
`git reset --soft HEAD~ `

Soft reset (move HEAD only; neither staging nor working dir is changed):

`git reset --soft 073791e7dd71b90daa853b2c5acc2c925f02dbc6`

`git reset HEAD file` -- 撤回暂存区的文件修改到工作区

Mixed reset (move HEAD and change staging to match repo; does not affect working dir):
`git reset --mixed 073791e7dd71b90daa853b2c5acc2c925f02dbc6`

Go back to commit: 以新增一个 commit 的方式还原某一个 commit 的修改
`git revert 073791e7dd71b90daa853b2c5acc2c925f02dbc6`

`git commit --amend` 修改上一个 commit 的描述

`git commit --amend --author= Author Name <email@address.com>` 修改作者名

#### Update & Delete

Test-Delete untracked files:
`git clean -n`

Delete untracked files (not staging):
`git clean -f`

Unstage (undo adds):
`git reset HEAD index.html`

Update most recent commit (also update the commit message):
`git commit --amend -m "New Message"`

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

`git blame <file-name>` 查看某段代码是谁写的
`git blame -L10,+1 index.html`

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

#### Compare

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

Checkout a specific release version:
`git checkout v1.0.0`

`git checkout -b branch_name tag_name` --切回到某个标签

`git show tagname` -- 查看标签信息

`git push origin tagname` -- 推送标签到远程仓库

`git push origin <local-version-number>` 推送标签到远程仓库

`git push origin --tags` -- 推送所有标签到远程仓库, 一次性推送所有标签，同步到远程仓库

`git tag -d tagname` -- 删除本地标签

`git push my remote –tags` -- 将所有本地标记发送到远程版本库中

`git push origin :refs/tags/<tag-name>`--删除远程标签

`git push origin :refs/tags/tagnames` -- 从远程仓库中删除标签

#### Collaborate

Show remote:
`git remote`

Show remote details:
`git remote -v`

Add remote upstream from GitHub project:
`git remote add upstream https://github.com/user/project.git`

Add remote upstream from existing empty project on server:
`git remote add upstream 
://root@123.123.123.123/path/to/repository/.git`

Fetch:

`git fetch upstream`

Fetch a custom branch:
`git fetch upstream branchname:local_branchname`

`git fetch origin pull/<id>/head:<branch-name>` — 从远程仓库根据 ID，拉下某一状态，到本地分支

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

Get the version of Git:
`git --version`

Create an alias (shortcut) for `git status`:
`git config --global alias.st status`

#### Help

Help:
`git help`

`git help -g`

