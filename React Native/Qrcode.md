
## React Native QRcode 組件功能
> 說明:
> 整體會是一個 白色圓角卡片，裡面有一個 淡藍色背景的方塊，中間顯示 黑色 QR Code。
> 如果 logoFromFile 有值，QR Code 中間會有一個小 Logo（例如公司 Logo 或 App Icon）。
> 由於 qrCode 的寬高 (280px) 比 QR Code 本身 (200px) 大，所以 QR Code 周圍會有 淡藍色留白。

### 資源

- [react-native-qrcode-svg](https://www.npmjs.com/package/react-native-qrcode-svg)


### 對於 React Native 0.60+ 版本，還需要運行以下命令：
```
npm install react-native-qrcode-svg --save  
# 或者  
yarn add react-native-qrcode-svg
```

```
cd ios  
pod install  
```

### 如果你使用的是 React Native <= 0.59.X，需要手動連結原生專案
備注：
如果連結失敗，可能需要手動修改 android/settings.gradle 和 MainApplication.java（參考 react-native-svg 官方文件）。
舊版 React Native 可能需額外檢查 react-native 與 react-native-svg 的相容性。

```
npm install react-native-svg --save // 安裝 react-native-svg 依賴
react-native link react-native-svg // 連結 react-native-qrcode-svg
cd ios && pod install // 重新編譯專案
```

### 實作
> 例如要做 QRcode身份登入
> 或是QRcode乘車票卷出示的時候

```
import React from 'react';  
import { View } from 'react-native';  
import QRCode from 'react-native-qrcode-svg';



const App = ({value = 'https://google.com/'}) => {

  let logoFromFile = require('../assets/logo.png');

  return (  
    <View style={styles.qrCodeContainer}>
      <View style={styles.qrCode}>
        <QRCode  
          value={value}
          size={200}
          logo={logoFromFile} //可加可不加
          bgColor="#FFFFFF"  
          fgColor="#000000"  
        />
      </View>
    </View>  
  );  
};

const styles = StyleSheet.create({
  qrCode: {
      backgroundColor: '#F0F5FF', // 淡藍色背景
      alignItems: 'center',
      justifyContent: 'center',
      height: 280,  
      width: 280,  
  },
  qrCodeContainer: {
      backgroundColor: 'white',
      alignItems: 'center',
      justifyContent: 'center',
      borderTopLeftRadius: 16,
      borderTopRightRadius: 16,
  },
});

export default App;  
```
