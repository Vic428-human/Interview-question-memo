前言：
預設情境是，gitlab管理權限的人對 merge request有設定 fast forward。

### 錯誤訊息
- 1.Merge conflicts must be resolved. 
- 2.Merge request must be rebased, because a fast-forward merge is not possible.

先解決 merge conflicts 表示你的feature分支跟 (develop目標分支) 之間有衝突。
必須先 pull 目標分支的最新變更，然後在本地解決這些衝突。完成後再 commit 一次。

```
git checkout feature/001
git fetch origin
git rebase origin/develop
```

### 這時候可能會有衝突，解決後要 commit。
- 狀況１: 可能遇到 Make sure you configure your "user.name" and "user.email" in git.

```
git config --global user.name "gitlab-user-name"
git config --global user.email "gitlab-user@example.com"
```

### config設定完之後，可能你會在 左半邊的地方commit，但可能又出現新的錯誤

```
Git: Failed to execute git
```

我的解法是，直接在terminal commit 
先確定所有檔案的 git add . 
手動輸入 git commit 

下一步
### 這個指令會告訴 Git：「我解完衝突、也 commit 了，請繼續跑剩下的 rebase」。
如果後面還有其他 commit 衝突，就會繼續提示你解。如果沒有了，就會顯示 Successfully rebased and updated。
```
git rebase --continue
```

### 如果直接push，會出問題
rebase 後要強制 push，因為歷史被改寫了。
因為 之前 rebase 過 develop，改寫了本地的 commit 歷史，
但遠端的 feature/001 還保留了舊的 commit，所以 push 的時候就衝突了。

- --force-with-lease 比 --force 更安全一些，它會檢查遠端分支是否有人同時改過，以避免不小心覆蓋別人的工作
- 有可能會遇到 N個 pull 以及 Y個push 紀錄，都優先push  
```
git push origin HEAD:feature/001 --force-with-lease
```

### 「我知道我改寫了歷史，請用我這份覆蓋掉遠端，但如果遠端分支已經被別人推上新 commit，那就先不要推，讓我知道。」

```
原本 develop 上的提交：
A — B — C

你的 feature branch 原本：
A — B — C
            \
             D — E

你執行 rebase develop 後：
A — B — C — D' — E'
```

## 理論上到這個階段應該能正常推上去，然後之後再 gitlab merge request 確認沒問題就能合併了。
