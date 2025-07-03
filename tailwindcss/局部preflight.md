🧩 Tailwind CSS Scoped Preflight 完整設定範例

這個範例假設你是使用 Tailwind v3 並使用 CommonJS（也補上 ESM 匯入方式），目的是讓 Preflight 樣式只作用在 #example-root 元素內部：

常見需求場景

1. 微前端架構（Micro Frontends）
   - 你有多個子應用（可能由不同團隊開發），如果某個子應用使用 Tailwind，它的 Preflight 會干擾到其他不使用 Tailwind 的子應用，導致樣式跑掉。

2. 嵌入式應用（Embed App）
   - 你把 Tailwind 應用插入到非 Tailwind 的頁面中（例如在某個 CMS 或外部系統中掛上一段 React app），不希望干擾原本的樣式。

3. 樣式命名衝突
   - 雖然 Tailwind 的 class 名多半是原子化的，但它的 Preflight 會 reset 一些 HTML 標籤（像是 <button>、<h1> 等），這可能會對其他樣式系統造成破壞。

4. 協同開發中多種 CSS 工具混用
   - 團隊中有些部分用 Tailwind，有些用原生 CSS 或其他 UI framework（像是 Bootstrap、Ant Design 等），需要明確區分 reset 範圍，避免「互踩」。

1️⃣ 安裝套件

```bash
npm install tailwindcss-scoped-preflight --save-dev
```

---

2️⃣ 修改 tailwind.config.js

```js
const { scopedPreflightStyles } = require('tailwindcss-scoped-preflight');
const { isolateInsideOfContainer } = require('tailwindcss-scoped-preflight');

module.exports = {
  content: ['./src//*.{js,jsx,ts,tsx,html}'],
  theme: {
    extend: {},
  },
  plugins: [
    scopedPreflightStyles({
      isolationStrategy: isolateInsideOfContainer('#example-root', {}),
    }),
  ],
};
```

如果你用 ESM，改成這樣即可：

```js
import { scopedPreflightStyles, isolateInsideOfContainer } from 'tailwindcss-scoped-preflight';

export default {
  content: ['./src//*.{js,jsx,ts,tsx,html}'],
  theme: {
    extend: {},
  },
  plugins: [
    scopedPreflightStyles({
      isolationStrategy: isolateInsideOfContainer('#sport-root', {}),
    }),
  ],
};
```

---

3️⃣ 在 HTML 或 React 中使用 #example-root

```html
<div id="example-root">
  <h1 class="text-2xl font-bold">這裡的元素會套用 Tailwind Reset 樣式</h1>
</div>

<div id="legacy-layout">
  <h1>這裡不會被 Tailwind Preflight 影響</h1>
</div>
```
---

✅ 預期效果

- <body> 上不會有全局 reset，例如 margin: 0。
- 頁面其他區域（像 legacy app）不會被干擾。
- Tailwind reset 僅限在 #sport-root 範圍生效。

---

這樣就可以在大型專案、微前端或混用框架的場景中穩定使用 Tailwind 而不怕干擾其他樣式。Vic 如果你有想搭配的 UI 框架（像是你熟悉的 Ant Design）或有自定變數需求，也可以再幫你組出進階配置 😎 想來點進一步的整合示範嗎？
