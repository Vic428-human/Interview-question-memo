
# 前言：
> 從gitlab上透過ssh方式，將專案clone下來的事前準備。
---

# Node Version Manager (NVM) 安裝與使用指南

## 📌 簡介
NVM（Node Version Manager）是一個管理 Node.js 版本的工具，允許開發者在不同專案中輕鬆切換 Node.js 版本。

## 🚀 安裝 NVM

在終端執行以下命令下載並安裝 NVM：

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

### 安裝後的步驟：
- NVM 會嘗試修改 shell 配置檔，例如：
  - `~/.bashrc`
  - `~/.bash_profile`
  - `~/.zprofile`
  - `~/.zshrc`
- 若安裝過程中顯示 **Profile not found**，表示系統找不到適當的 shell 設定檔，需手動建立或修改。

### 🛠 設定 NVM 環境變數：
安裝完成後，需執行以下指令，讓 NVM 生效：

```sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
source ~/.zshrc  # 重新載入 shell 配置
```

## 🎯 確認安裝是否成功
關閉並重新打開終端，或執行：

```sh
nvm --version  # 應顯示版本號，例如：0.40.3
```

## 📌 安裝與使用 Node.js 版本
### 🔽 下載指定的 Node.js 版本：
```sh
nvm install 20.12.2
nvm use 20.12.2
```

### ⚙ 設定預設 Node.js 版本：
若希望每次開啟終端時自動使用指定版本，可執行：
```sh
nvm alias default 20.12.2
```

## 📦 確認 NPM 版本
安裝完 Node.js 後，NPM 也會一併安裝，使用以下指令檢查：
```sh
npm --version  # 應顯示版本號，例如：10.5.0
```

## ✅ 測試 Node.js 是否運行正常
執行測試腳本：
```sh
node test.js  # 若無錯誤，代表 Node.js 可正常運行
```
