### Workflow
#### everything is happy and up-to-date in master
git checkout master

git pull origin master

#### let's branch to make changes
git checkout -b my-new-feature

#### go ahead, make changes now.
$EDITOR file

#### commit your (incremental, atomic) changes
git add -p

git commit -m "my changes"

#### optional: push your branch for discussion (pull-request)  you might do this many times as you develop.
git push origin my-new-feature

#### if your branch becomes too old (2-3 days) and diverges from master,you will want to merge origin/master into your future branch before deploying
git fetch origin

git merge origin master

#### merge when done developing.
#### --no-ff preserves feature history and easy full-feature reverts
#### merge commits should not include changes; 

#### rebasing reconciles issues

#### stash takes care of this in a pull-request merge
git checkout master

git pull origin master

git merge --no-ff -m 'merge my new-feature with no-ff' my-new-feature

git rebase -i HEAD-n

git rebase -i master mybranch

#### autosetup rebase so that pulls rebase by default
git config --global branch.autosetuprebase always

#### if you already have branches (made before `autosetuprebase always`)
git config branch.<branchname>.rebase true

#### you almost certainly want to run this as well, to allow git commands to be output with colour:
git config --global color.ui always

git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch users.csv'

### drop big GitHub files
git filter-branch -f --index-filter '

git rm --cached --ignore-unmatch users.csv'

### own git repo examples
cd 'user retention'

git branch ling

git checkout master

git status

git add .

git status

git commit --m 'add new files'

git status

git pull origin master

git push -u origin master

### php examples
git branch

rsub -f components/Gdpr/Collector/User/LastActiveTimes.php 

git status

git diff

git add -u

git commit -m "Testing"

vendor/bin/phpcbf components/Gdpr/Collector/User/LastActiveTimes.php


### rebase examples
git rebase add_shift_dt_fn/master

git rebase -i 5cc90d163c8eeec54c823a09a1cbab57daf6163b

git add dlorean/utils/dates.py

git status

git diff

git push

### revert/undo the last commit:
git reset --soft HEAD~

git reset HEAD~1

#### check out the current directory:
git checkout -- .

#### edit file:
git diff

git checkout -- .

vim whitelists.yaml 

git diff

#### commit to PR and force-push
git commit --m 'add ling to the whitelist'

git push

git push --set-upstream origin add_ling_whitelist_grp -f
