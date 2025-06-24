

### Property 'env' does not exist on type 'ImportMeta'.ts(2339)

```
const example = import.meta.env.VITE_EXAMPLE;
```

### 建立 src/vite-env.d.ts 檔案

```
/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_EXAMPLE: string; // add other env variables here if needed
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}

```

