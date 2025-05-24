### 指令用於回到解決衝突之前的狀態

注意事項：
- 回到合併前的狀態，指的是這些紀錄都有commit過，如果今天某個檔案，沒有commit的過，只是有修改內容，那就算abort也沒用。
- 建議使用 `git stash` 指令將這些未 commit 的檔案暫存起來，並在解決衝突後使用 `git stash pop` 將這些未 commit 的檔案還原出來。
- 
```
git merge --abort
```

  
