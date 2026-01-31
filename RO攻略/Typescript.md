
「即時資料需要 tab 切換自動更新：伺服器狀態、賽事比分、儀表板，避免顯示過期資料」

```
focusManager.setEventListener((handleFocus) => {
  if (typeof window !== 'undefined' && window.addEventListener) {
    
    /*** 詳細註解：核心 tab 切換偵測邏輯 ***/
    
    // 1. 建立專屬事件處理器，封裝 Page Visibility API 邏輯
    //    document.visibilityState：
    //    ✅ 'visible' → tab 在前台，觸發 refetch
    //    ❌ 'hidden'  → tab 在後台，暫停背景 refetch
    const visibilityHandler = () => {
      const isTabVisible = document.visibilityState === 'visible'  // true/false
      handleFocus(isTabVisible)  // 通知 TanStack Query 焦點狀態
      // handleFocus(true) → 模擬「獲得焦點」→ 自動 refetch refetchOnWindowFocus: true 的查詢
    }
    
    // 2. 註冊 HTML5 Page Visibility API 事件
    //    'visibilitychange'：專門監聽 tab 切換、最小化還原等場景
    //    false：事件冒泡階段執行（標準用法）
    window.addEventListener('visibilitychange', visibilityHandler, false)
    
    // 3. 可選：監聽整個視窗焦點（瀏覽器切換）
    //    補充場景：從其他程式切回瀏覽器
    window.addEventListener('focus', handleFocus, false)
    
    // 4. 回傳清理函式（關鍵！防止記憶體洩漏）
    //    TanStack Query 會自動呼叫，避免重複註冊事件監聽器
    return () => {
      window.removeEventListener('visibilitychange', visibilityHandler)
      window.removeEventListener('focus', handleFocus)
    }
  }
})

```
