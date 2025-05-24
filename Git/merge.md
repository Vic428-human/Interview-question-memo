
### 當前分支 dev
主分支 main，當兩個分支產生衝突，可以使用merge
dev 是比較新的那一個分支（此時head在dev分支上）。

因為 master 的 commit 是比較舊的，
所以我們要先將 head 移動到 master 上
如此一來新的功能就能添加到舊的分支上

```
git merged master
```
