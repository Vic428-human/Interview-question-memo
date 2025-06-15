# 前言
> 這邊涵蓋了 ScreenWrapper 跟 ModalWrapper 的 typescript 實作

## ScreenWrapper 用途說明 >> 頁面基礎容器

需求：
- 安全區域管理：自動避開手機劉海/狀態欄/虛擬按鍵區域（通過 SafeAreaView）
- 統一頁面樣式：提供全局一致的背景色、內邊距等基礎樣式
- 防止內容溢出：確保子組件在安全範圍內渲染

典型場景：
- 所有普通頁面的根容器
- 需要適應異形屏的頁面佈局
- 作為導航堆棧中每個 screen 的包裹層

## ModalWrapper 用途說明 >> 彈出層容器

- 創建中斷式界面：強制用戶處理彈出內容後才能繼續操作
- 視覺聚焦：通過半透明遮罩突出當前彈窗內容
- 動畫集成：內置淡入/滑動等過場效果

典型場景:
- 確認對話框（如刪除確認）
- 表單輸入（如新增交易記錄）
- 臨時性全屏浮層（如濾選器）

----

### 共用類型調用

```
import {
  TextInput,
  TextInputProps,
  TextProps,
  TextStyle,
  TouchableOpacityProps,
  ViewStyle,
} from "react-native";
import React, { ReactNode } from "react";
```

### 先學習容器組件 (ScreenWrapper)
> 灰色背景的安全區域，內容有內邊距的白色區塊

```
export type ScreenWrapperProps = {
  style?: ViewStyle;
  children: React.ReactNode;
};
```

```
import React from 'react';
import { View, StyleSheet, SafeAreaView } from 'react-native';
import { ScreenWrapperProps } from './types';

const ScreenWrapper: React.FC<ScreenWrapperProps> = ({ 
  children, 
  style 
}) => {
  return (
    <SafeAreaView style={[styles.container, style]}>
      <View style={styles.innerContainer}>
        {children}
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  innerContainer: {
    flex: 1,
    padding: 16,
  },
});

export default ScreenWrapper;
```

```
// 使用範例
// 當內容超過屏幕高度時，需在內部自行添加 ScrollView

<ScreenWrapper 
  style={{ backgroundColor: '#eef2ff' }} // 可覆寫背景色
>
  <ScrollView>
    <Button title="按鈕" />
  </ScrollView>
</ScreenWrapper>
```

### 然後學習基本交互組件 (ModalWrapper, Button, Input)

#### ModalWrapperProps 類型定義
```
export type ModalWrapperProps = {
  children: React.ReactNode;
  style?: ViewStyle;
  bg?: string;
  visible: boolean;  // 新增可見性控制
  onClose?: () => void;  // 關閉回調
  animationType?: 'none' | 'slide' | 'fade';  // 擴展動畫類型
  closeOnOutsideClick?: boolean;  // 點擊外部是否關閉
};
```

```
import React from 'react';
import {
  View,
  StyleSheet,
  Modal,
  TouchableWithoutFeedback,
  TouchableOpacity,
} from 'react-native';
import { ModalWrapperProps } from './types';
import { Ionicons } from '@expo/vector-icons';

const ModalWrapper: React.FC<ModalWrapperProps> = ({
  children,
  style,
  bg = 'rgba(0,0,0,0.5)',
  visible,
  onClose,
  animationType = 'fade',
  closeOnOutsideClick = true,
}) => {
  if (!visible) return null;

  return (
    <Modal
      transparent
      animationType={animationType}
      onRequestClose={onClose}  // Android 返回鍵觸發
    >
      {/* 外部點擊區域 */}
      <TouchableWithoutFeedback 
        onPress={closeOnOutsideClick ? onClose : undefined}
      >
        <View style={[styles.overlay, { backgroundColor: bg }]}>
          {/* 阻止點擊事件冒泡 */}
          <TouchableWithoutFeedback>
            <View style={[styles.modalContainer, style]}>
              {/* 關閉按鈕 (可選) */}
              {onClose && (
                <TouchableOpacity 
                  style={styles.closeButton}
                  onPress={onClose}
                >
                  <Ionicons name="close" size={24} color="#666" />
                </TouchableOpacity>
              )}
              {children}
            </View>
          </TouchableWithoutFeedback>
        </View>
      </TouchableWithoutFeedback>
    </Modal>
  );
};

const styles = StyleSheet.create({
  overlay: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  modalContainer: {
    backgroundColor: 'white',
    borderRadius: 12,
    padding: 20,
    width: '80%',
    maxWidth: 400,
    maxHeight: '80%',
  },
  closeButton: {
    position: 'absolute',
    top: 10,
    right: 10,
    zIndex: 1,
  },
});

export default ModalWrapper;
```

```
import React, { useState } from 'react';
import { View, Text, Button, StyleSheet } from 'react-native';
import ModalWrapper from './ModalWrapper';
import Typo from './Typo';

const ModalExampleScreen = () => {
  const [isVisible, setIsVisible] = useState(false);
  const [modalType, setModalType] = useState<'standard' | 'bottom'>('standard');

  return (
    <View style={styles.container}>
      <Button 
        title="打開標準模態" 
        onPress={() => {
          setModalType('standard');
          setIsVisible(true);
        }} 
      />
      {/* 標準模態 */}
      <ModalWrapper
        style={styles.standardModal}
        visible={isVisible && modalType === 'standard'}
        onClose={() => setIsVisible(false)}
        animationType="fade"
      >
        <Button title="取消" onPress={() => setIsVisible(false)} />
      </ModalWrapper>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    padding: 20,
  },
  standardModal: {
    width: '90%',
  },
});

export default ModalExampleScreen;
```
