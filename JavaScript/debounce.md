
### 防抖（Debouncing）的主要用途
1. **合併高頻觸發事件**  
   當連續觸發的事件（如輸入框打字、窗口縮放、滾動等）過於頻繁時，防抖會將多次觸發合併為**最後一次有效執行**，避免重複計算或請求。例如：
   - 搜索框輸入時，只在用戶停止打字後才發送請求。
   - 滾動視窗的時候
   - 觸發多次按鈕點擊的時候
   - 窗口縮放（resize）後，僅在調整結束時計算最終布局。

2. **優化性能與資源消耗**  
   高頻事件（如滾動每秒觸發數十次）若直接綁定複雜邏輯（如DOM操作、AJAX請求），會導致瀏覽器卡頓。防抖通過推遲執行，減少不必要的函數調用。

3. **避免重複操作**  
   例如防止表單重複提交，或按鈕多次點擊觸發多次動作。

### 技術原理
防抖通過定時器實現：
- 每次事件觸發時，清除之前的定時器並重新計時。
- 若在等待時間（如300ms）內未再次觸發，則執行函數；否則重新開始計時。  
簡單實現範例：
```javascript
function debounce(func, delay) {
  let timer;
  return function() {
    clearTimeout(timer);
    timer = setTimeout(() => func.apply(this, arguments), delay);
  };
}
```

## 搜索框輸入時
假設每次輸入文字，耗時100毫秒，不用debounce，會導致每更新一個文字，就觸發一次API，這會導致API請求服務器造成過載，若有debounce設定，就能要求輸入文字的時候，停頓多少毫秒之後，沒更新內容，才觸發API請求，這能大幅降低請求次數。

## 滾動視窗的時候
如果每一次滾動，都觸發請求新的文章內容，會太多次請求，這時候可以設定，當滾輪觸及畫面底部網上幾px距離的範圍內時，才call API，架設螢幕高度是800px，然後我要求觸及到底部往上500px範圍內才發送API請求，意謂者，當滾輪在由上往下300px內，是不會觸發到請求的，這能大幅減少請求頻率。

## 觸發多次按鈕點擊的時候

```
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Debounce 示例</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
    <style>
        .container {
            text-align: center;
            margin-top: 50px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <button id="incrementBtn">點擊我</button>
        <p>按鈕點擊次數: <span id="pressCount">0</span></p>
        <p>觸發次數: <span id="triggerCount">0</span></p>
    </div>

    <script>
        const btn = document.getElementById("incrementBtn");
        const pressCountDisplay = document.getElementById("pressCount");
        const triggerCountDisplay = document.getElementById("triggerCount");

        let pressedCount = 0;
        let triggerCount = 0;

        const debouncedCount = _.debounce(() => {
            triggerCountDisplay.textContent = ++triggerCount;
        }, 800);

        btn.addEventListener("click", () => {
            pressCountDisplay.textContent = ++pressedCount;
            debouncedCount();
        });
    </script>
</body>
</html>
```

### lodash中的debounce基本用法
```
import debounce from 'lodash/debounce'

// 創建一個防抖函數，500ms 內多次觸發只會執行最後一次
const debouncedFn = debounce(function() {
  console.log('Debounced function executed')
}, 500)

// 綁定到事件，例如輸入框輸入
inputElement.addEventListener('input', debouncedFn)
```
