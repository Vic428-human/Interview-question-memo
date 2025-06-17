Esbuild 主打性能優勢，在構建速度上可以比傳統工具快 10~100 倍

### 在 package.json 設定 mode
```
{
  "scripts": {
    "dev": "vite --mode development",
    "build": "vite --mode production",
    "preview": "vite preview"
  }
}

```
### 運行 dev環境 
```
npm run dev 
```

### 運行dev環境時會看不到console.log
> 其餘環境看得到
> 
```
import { loadEnv, ConfigEnv, defineConfig, UserConfig } from "vite";

export default defineConfig(({ mode }: ConfigEnv): UserConfig => {
  // Load environment variables based on the mode.
  const env = loadEnv(mode, process.cwd(), '');

  return {
    plugins: [],
    esbuild: {
          loader: 'tsx', // 載入器可以確保 esbuild 能夠正確地理解和編譯 (.tsx)
          include: /.*\.[jt]sx?$/, // 它匹配任何副檔名為 .js、.jsx、.ts 或 .tsx 的檔案。
          exclude: [], // [] 這是一個空的數組，意味著沒有文件被明確排除在處理之外。如果您想跳過某些文件或目錄（例如，node_modules），可以在此處指定它們
          drop: mode === 'development' ? ['console'] : [], // mode 是 'development'，就會移除 console 相關的內容。而在其他模式下（如 release 或 production），則保留 console。
    },     
  };
});

```



