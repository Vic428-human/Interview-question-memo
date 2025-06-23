
### 通常，你會在以下情況下遇到需要配置 globals：
 * 初次設定專案的 ESlint：這是你應該考慮運行環境（瀏覽器、Node.js、測試）並配置相應 env 或 globals 的最佳時機。
 * ESLint 報錯 [variable-name] is not defined：當你看到這種錯誤，而你確信這個變數應該存在且可用時，就應該檢查是否需要在 globals 中進行配置。
 * 引入新的第三方庫或工具：如果這些庫會注入新的全域變數，你可能需要更新你的 ESlint 配置。
 * 團隊規範要求：在一些團隊中，會有明確的規範要求將所有全域變數都列在 ESlint 配置中，以提高程式碼的可讀性和維護性。
配置 globals 的目的就是讓 ESlint 能夠正確地理解你的程式碼，避免誤報錯誤，從而讓你專注於真正的程式碼問題。

情況：在前端開發中，使用像 jQuery、React 這樣的全局變量或函式庫時，
ESLint 可能會因未定義這些變量而報錯，此時可透過配置 ESLint 的 `globals` 屬性來忽略這些檢查。

```
{
    "globals": {
        "jQuery": true, 
        "$": true,//jquery
        "React": true,
        "_": true // lodash
    }
}
```

#### **📌 WebWorker / Service Worker**  
```
globals: {
  self: true,
  caches: true,
  indexedDB: true,
  ...
}
```

### console' is not defined
New config system (eslint.config.js)

npm 依賴衝突的情況，用車來比喻的話：

「就像你買了一臺新車（ESLint），它需要高級輪胎（globals@^13.19.0）。
但車廠（@babel）自帶了一套舊款輪胎（globals@^11.1.0），結果系統自動裝了舊輪胎，
導致新車報警。最後你手動買了正確的輪胎（npm install globals），問題就解決了。」
簡單說：嵌套依賴自動安裝了舊版 globals，手動安裝新版後衝突解除。

#### 先確認global 是在最新版本
```
npm install globals
```

#### 在進行global配置

```
languageOptions: {
			globals: {
				...globals.browser,
			}
		},
```

#### jest配置

來源：https://eslint.org/docs/latest/use/configure/language-options

### **2. 常見的 ESLint 共享配置（`eslint-config-*`）**  
除了 `globals`，你還可以透過 `extends` 使用現成的 ESLint 配置，例如：  

#### **📌 基礎 JavaScript 規範**  
```js
extends: [
  "eslint:recommended", // ESLint 官方推薦規則
  "standard",          // StandardJS 風格
  "airbnb",            // Airbnb 風格
  "prettier",          // 配合 Prettier
]
```
