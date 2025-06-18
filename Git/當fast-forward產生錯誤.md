
這兩支的分支是在不同develop的基礎上區開的feature分支

feature/I2-1469 的基底 是 5f0e88 
feature/I2-1473 的基底 是 c65f66

>>> 以 feature/I2-1473  來說，當時remote最新的是 c65f66，所以當我用 c65f66 開出 feature/I2-1473 的時候，
會能正常 fast forward 回去給 develop

>>> 以 feature/I2-1469  來說，由於是比較早期的develop開出的feature，所以 fast forward 指令的時候，
會因為基底不同，Git 無法快進合併。
例如出現錯誤： fatal: Not possible to fast-forward, aborting.

git merge-base "你預計要合的feature分支" develop ( 可以看到原先的基底 commit hash

所以 如果快進合併不可行，改用一般 git merge
git merge feature/I2-1469

會出現編輯模式
輸入 :wq
把左半邊的commit紀錄 continue
