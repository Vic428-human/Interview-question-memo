- 對桌面的ROZ右鍵點選內容 > 開啟檔案位置
- 刪除RO的時候要確保不光是移除下載的應用程式，也要對殘留檔案整個移除 ex: C:\Gravity\RagnarokZero，直接把 把 Gravity 整個刪除能確保真的有完全移除
- 只有應用程式刪除，資料夾殘餘檔也還是存在
- cdc是被防毒誤刪，雖然誤刪可以復原，但要找路徑那個不好用口述，所以我建議整個刪掉重裝，另一方面也是確保這種重大更新可以與官方一致
- 而cdc被防毒誤刪，會導致你要把cdc加入白名單的時候無法加入，因為根本不在RO資料夾內，所以首要目的是透過防毒阻擋那一端找回cdclient，或是透過重新安裝找回
- 像我重新安裝後 cdclient 確實就出現了，這個時候才是把他加入白名單，當然如果你本來就已經知道防毒在哪裡阻擋，也可以在那個位置就復原cdclient
- 重新安裝好後 windows 沒過多久，會跳出隔離訊息，到 windows 保護歷程紀錄 
- 圖中會看到cdclient 的訊息，這個時候還原
- 接下來，在windows下方搜尋處，搜尋”排除項目“，找到 病毒與威脅防護設定，點選”管理設定“，往下滑會看到 “排除項目”，到這個位置排除cdclient 項目
- 未來就不會遇到這個問題了

註: 
- 🔐 [排除項目在哪找？](https://www.youtube.com/watch?v=ztvgxkVGDjE)
- 🔐 [保護歷程紀錄如何開啟](https://support.microsoft.com/zh-tw/windows/windows-%E5%AE%89%E5%85%A8%E6%80%A7-%E6%87%89%E7%94%A8%E7%A8%8B%E5%BC%8F%E4%B8%AD%E7%9A%84%E4%BF%9D%E8%AD%B7%E6%AD%B7%E7%A8%8B%E8%A8%98%E9%8C%84-f1e5fd95-09b4-46d1-b8c7-1059a1e09708#:~:text=Windows%20%E5%AE%89%E5%85%A8%E6%80%A7%20%E6%87%89%E7%94%A8%E7%A8%8B%E5%BC%8F%E5%8A%9F%E8%83%BD%E4%B9%8B%E4%B8%80%E6%98%AF%20%E4%BF%9D%E8%AD%B7%E6%AD%B7%E7%A8%8B%20%E8%A8%98%E9%8C%84%EF%BC%8C%E5%AE%83%E6%8F%90%E4%BE%9B%20Microsoft%20Defender%20%E9%98%B2%E7%97%85%E6%AF%92%E8%BB%9F%E9%AB%94%E4%BB%A3%E8%A1%A8%E6%82%A8%E6%89%80%E6%8E%A1%E5%8F%96%E5%8B%95%E4%BD%9C%E7%9A%84%E5%AE%8C%E6%95%B4%E6%B8%85%E5%96%AE%E3%80%81%E5%B7%B2%E7%A7%BB%E9%99%A4%E7%9A%84%E6%BD%9B%E5%9C%A8%E5%9E%83%E5%9C%BE%E6%87%89%E7%94%A8%E7%A8%8B%E5%BC%8F%EF%BC%8C%E4%BB%A5%E5%8F%8A%E5%B7%B2%E9%97%9C%E9%96%89%E7%9A%84%E9%87%8D%E8%A6%81%E6%9C%8D%E5%8B%99%E3%80%82,%E4%BF%9D%E8%AD%B7%E6%AD%B7%E7%A8%8B%E8%A8%98%E9%8C%84%E5%8F%AA%E6%9C%83%E4%BF%9D%E7%95%99%E4%BA%8B%E4%BB%B6%E5%85%A9%E5%91%A8%EF%BC%8C%E4%B9%8B%E5%BE%8C%E4%BA%8B%E4%BB%B6%E5%B0%B1%E6%9C%83%E5%BE%9E%E6%B8%85%E5%96%AE%E4%B8%AD%E6%B6%88%E5%A4%B1%E3%80%82%20%E5%9C%A8%E9%9B%BB%E8%85%A6%E4%B8%8A%E7%9A%84%20%5BWindows%20%E5%AE%89%E5%85%A8%E6%80%A7%5D%20%E6%87%89%E7%94%A8%E7%A8%8B%E5%BC%8F%20%E4%B8%AD%EF%BC%8C%E9%81%B8%E5%8F%96%20%EF%BC%8C%E6%88%96%E4%BD%BF%E7%94%A8%E4%B8%8B%E5%88%97%E9%80%A3%E7%B5%90%EF%BC%9A%20%E4%BF%9D%E8%AD%B7%E6%AD%B7%E7%A8%8B%E8%A8%98%E9%8C%84)

