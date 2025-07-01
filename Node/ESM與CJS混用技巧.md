✅ 什麼時候會用？createRequire

1. 你用的是 .mjs 檔案 或是 package.json 裡有 "type": "module"。

3. 你需要引入一些只能透過 require 的資源，例如：

CommonJS 模組（像是某些老舊的 npm 套件）

JSON 檔案（在某些 Node.js 版本中，不能直接用 import 載入 JSON）

```
// tailwind.config.js
const plugin = require('tailwindcss/plugin');

plugins: [
      plugin({
        //這只是範例不是實際狀況
      }),
    ],

```

```
// esm-file.mjs
import { createRequire } from 'module';
const require = createRequire(import.meta.url);

// 用 require 載入 JSON 檔或 CJS 模組
const pkg = require('./package.json');
const lodash = require('lodash');

console.log(pkg.name);
console.log(lodash.shuffle([1, 2, 3, 4]));

```
