
```
git switch develop （先切去要被你合併進去的主分支) 

 fast forward 用與不用的差異
git merge feature/jira-001 —no-ff ( 傳統merge => non fast forward ) 會有分支概念
git merge --ff-only origin/feature/jira-001 （如果是 取消分支概念，可以用 fast forward ，分支本身就會變成線性的，獨立一條，可以從 git log —online —graph —all 看出區別）

git push origin develop (把剛才更新後的推上去develop)

git log —online —graph —all  ( 如果用 —no-ff 會觀察到，是從別的分支合過去）

git reset "commit hash" —hard 回到特定節點comit  ( 如果妳 merge 操作錯誤，想回到上一步
