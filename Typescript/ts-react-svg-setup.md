
## 出現 Cannot find module  或 its corresponding type declarations 錯誤

- 假設error訊息有出現 svg 或圖檔有關的關鍵字

處理 SVG 檔案與 React 元件之間的轉換，但在改成 .tsx 檔案之後出現錯誤。這通常跟專案的 
TypeScript 設定、SVG 模組處理或是 Vite/Webpack 的設定有關。這裡有幾個常見排查方向


### 用 Vite，可以試著安裝並設定 vite-plugin-svgr
```
npm install vite-plugin-svgr -D
```

### vite.config.ts
```
import svgr from 'vite-plugin-svgr';

export default defineConfig({
  plugins: [svgr()],
});

```

### src/types 底下建立 svg.d.ts 讓 TS 認得這種 import 方式

```
declare module '*.svg?react' {
  import * as React from 'react';
  const ReactComponent: React.FunctionComponent<React.SVGProps<SVGSVGElement>>;
  export default ReactComponent;
}

```

### tsconfig.json 應該包含以下設定
```
{
  "compilerOptions": {
    "jsx": "react", // 若有問題改成 react-jsx
    "module": "ESNext",
    "esModuleInterop": true, // 可能不用設定
    "moduleResolution": "Node" // 若有問題改成 bundler
  }
}
```




