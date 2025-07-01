
功能：
- 1.isAlertEnabled, accessToken存在才觸發 websocket
- 2.

```
import React, { useState, useEffect } from 'react';
import { useSelector } from 'react-redux';
import useWebSocket, { ReadyState } from 'react-use-websocket';

const AlertWebSocketComponent = () => {
  // 從 Redux store 取得狀態
  const isAlertEnabled = useSelector((state) => state.alertSettings.isAlertEnabled);
  const accessToken = useSelector((state) => state.auth.accessToken);
  
  // WebSocket URL 狀態
  const [alertWsUrl, setAlertWsUrl] = useState(null);

  // 根據設定更新 WebSocket URL
  useEffect(() => {
    if (isAlertEnabled === undefined || !accessToken) {
      setAlertWsUrl(null);
      return;
    }
    
    if (isAlertEnabled) {
      setAlertWsUrl(`${import.meta.env.VITE_ALERT_WSS_URL}alerts/stream?authorization=bearer%20${accessToken}`);
    } else {
      setAlertWsUrl(null);
    }
  }, [isAlertEnabled, accessToken]);

  // 使用 useWebSocket hook
  const {
    sendMessage,
    lastMessage,
    readyState,
    getWebSocket,
  } = useWebSocket(alertWsUrl, {
    onOpen: () => {
      console.log('WebSocket 連接已建立');
    },
    onClose: (event) => {
      console.log('WebSocket 連接已關閉', event);
    },
    onError: (event) => {
      console.error('WebSocket 發生錯誤', event);
    },
    onMessage: (event) => {
      console.log('收到訊息:', event.data);
    },
    shouldReconnect: (closeEvent) => {
      // 當警報啟用且有 token 時才重新連接
      return isAlertEnabled && !!accessToken;
    },
    reconnectAttempts: 5,
    reconnectInterval: 3000,
  });

  // 處理接收到的訊息
  useEffect(() => {
    if (lastMessage !== null) {
      try {
        const data = JSON.parse(lastMessage.data);
        console.log('解析後的訊息:', data);
        // 在這裡處理接收到的警報數據
        handleAlertMessage(data);
      } catch (error) {
        console.error('解析訊息失敗:', error);
      }
    }
  }, [lastMessage]);

  // 處理警報訊息的函數
  const handleAlertMessage = (data) => {
    // 根據您的需求處理警報數據
    // 例如：顯示通知、更新 UI 等
    console.log('處理警報訊息:', data);
  };

  // 獲取連接狀態文字
  const getConnectionStatus = () => {
    switch (readyState) {
      case ReadyState.CONNECTING:
        return '連接中...';
      case ReadyState.OPEN:
        return '已連接';
      case ReadyState.CLOSING:
        return '關閉中...';
      case ReadyState.CLOSED:
        return '已關閉';
      case ReadyState.UNINSTANTIATED:
        return '未初始化';
      default:
        return '未知狀態';
    }
  };

  // 手動發送訊息的函數
  const handleSendMessage = (message) => {
    if (readyState === ReadyState.OPEN) {
      sendMessage(JSON.stringify(message));
    } else {
      console.warn('WebSocket 未連接，無法發送訊息');
    }
  };

  // 手動關閉連接的函數
  const handleCloseConnection = () => {
    const webSocket = getWebSocket();
    if (webSocket) {
      webSocket.close();
    }
  };

  return (
    <div className="websocket-status">
      <h3>WebSocket 狀態</h3>
      <p>警報啟用: {isAlertEnabled ? '是' : '否'}</p>
      <p>連接狀態: {getConnectionStatus()}</p>
      <p>WebSocket URL: {alertWsUrl || '未設定'}</p>
      
      {isAlertEnabled && accessToken && (
        <div>
          <button 
            onClick={() => handleSendMessage({ type: 'ping' })}
            disabled={readyState !== ReadyState.OPEN}
          >
            發送 Ping
          </button>
          <button 
            onClick={handleCloseConnection}
            disabled={readyState !== ReadyState.OPEN}
          >
            關閉連接
          </button>
        </div>
      )}
      
      {lastMessage && (
        <div>
          <h4>最後收到的訊息:</h4>
          <pre>{lastMessage.data}</pre>
        </div>
      )}
    </div>
  );
};

export default AlertWebSocketComponent;
```

---

🔍 詳細說明：

變數名	說明

lastMessage	是一個 MessageEvent 物件，代表從 WebSocket 收到的最新訊息
lastMessage.data	是訊息的實際內容，通常是字串（可能是 JSON）
lastMessage 的初始值	是 null，當尚未接收到任何訊息時

---
