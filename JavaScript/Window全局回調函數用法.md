### **範例：打卡時間偵測系統**
假設我們要實現一個打卡系統，當用戶打卡時：
1. 記錄當前時間（上班/下班打卡）
2. 觸發全局回調（例如發送日誌、通知後端等）

#### **1. 定義全局回調函數**
在應用初始化時（例如 `App.js` 或入口文件），設定全局打卡回調：
或者定義在打包後的index.html
```javascript

 <script type="module">
// 定義打卡回調（可選執行，類似 window.onclickMarkets）
window.onClockInOut = (type, time, additionalData) => {
  console.log(`打卡類型: ${type}, 時間: ${time}`, additionalData);
  // 可擴展：發送日誌到後端、觸發通知等
};
</script>
```


#### **2. 打卡觸發邏輯**
在用戶點擊打卡按鈕時，調用以下函數：
```javascript
function handleClockInOut(clockType) {
  if (!clockType) return; // 確保有打卡類型（上班/下班）

  const currentTime = new Date().toISOString(); // 獲取當前時間
  const path = `/attendance/${clockType}`; // 可選：導航到打卡頁面

  // 1. 導航（可選）
  navigate(path); // 假設使用 React Router

  // 2. 觸發全局回調
  window.onClockInOut?.(clockType, currentTime, {
    userId: "123",
    location: "Taipei", // 可附加更多數據
  });
}
```
