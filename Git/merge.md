
### 當前分支 dev

#### git merge 用途
主分支 main，當兩個分支產生衝突，可以使用merge
，dev 是比較新的那一個分支（此時head在dev分支上）。

因為 master 的 commit 是比較舊的，
所以我們要先將 head 移動到 master 上
如此一來新的功能就能添加到舊的分支上

#### git merge 問題點
you can easy to see each developer's contributions, it's helpful in team setting.
but, frequently merges can make the commit history look cluttered and nonelinear.
especially when multiple branches at the same time. 

#### 基於merge問題點的替代方案REBASE 
接下來，REBASE 是將一個分支的更動整合到另一個分支，但方式不同。
當你使用 REBASE 時，git 會把你目前分支上的每一個 commit，重新套用到目標分支的最上方，就好像這些 commit 原本就是在那裡建立的一樣。
由於 REBASE 本質上是重新建立 commit，所以它會改變 commit 的歷史紀錄。
REBASE 的主要優點是它可以產生更乾淨、更線性的 commit 歷史。

#### REBASE 實際應用上會產生的問題 
問題描述：
這邊要記得，假如你當前的 feat 分支已經經裡過REBASE，且mergec main branch，首先，你的 feat 已經壓縮後的commit，
不是原先那個commit，然後因為一些原因，這個REBASE過後的 feat 又加了一些新的功能，此時你又再做了一次REBASE，等於
這個feat經歷過兩次REBASE，如果此時把經歷第二次的 feat merge main ，對於main來說可能會發生那些問題？

重複的 Commit（Duplicate Commits）
如果你在第一次 REBASE 後已經將 feat merge 到 main，main 上已經有這些 commit 的內容。第二次 REBASE 會產生新的 commit（即使內容一樣，commit hash 會不同），這時再 merge 回 main，可能會造成 main branch 上出現重複內容的 commit，導致 commit 歷史混亂。

產生衝突（Conflicts）
因為同樣的內容以不同 commit hash 兩次進入 main，Git 可能會偵測到衝突，需要手動解決，這會增加維護成本。

歷史紀錄不一致（History Divergence）
由於 REBASE 會重寫 commit 歷史，main branch 上的 commit 可能和 feat 分支的 commit 內容相同但 hash 不同，這會讓追蹤歷史變得困難，降低可讀性與可維護性。

影響協作（Collaboration Issues）
如果有其他協作者基於 main 或 feat 分支進行開發，這種多次 REBASE 並 merge 的操作會讓大家的 commit 歷史產生分歧，可能導致更多協作上的混亂
```
git merged master
```
