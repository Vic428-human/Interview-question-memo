
功能：
- 1.isAlertEnabled, accessToken存在才觸發 websocket
- 2.

```
import { useSelector } from 'react-redux';
import useWebSocket from 'react-use-websocket';

const isAlertEnabled = useSelector((state) => state.alertSettings.isAlertEnabled);
// 這裡假設 accessToken 存在於 state.auth.accessToken
const accessToken = useSelector((state) => state.auth.accessToken);
const [alertWsUrl, setAlertWsUrl] = useState(!isAlertEnabled ? null : `${import.meta.env.VITE_WSS_URL}vsb/vbt/c?authorization=bearer%20${accessToken}`);
useEffect(() => {
  if (isAlertEnabled === undefined || !accessToken) return;
  if (isAlertEnabled) {
    setAlertWsUrl(`${import.meta.env.VITE_ALERT_WSS_URL}alerts/stream?authorization=bearer%20${accessToken}`);
  }
}, [isAlertEnabled, accessToken]);


  // 4. 使用 useWebSocket hook
  const {
    sendMessage,
    lastMessage,
    readyState,
    getWebSocket,
    closeWebSocket,
  } = useWebSocket(alertWsUrl);

  // 5. 你可以根據 getWebSocket 做後續操作
  // 例如：顯示連線狀態、接收訊息等
```
