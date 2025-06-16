
從 WebSocket 獲取到新的加密貨幣即時價格時，
是否需要主動比對 Redux 內的價格是否有變化，
取決於你的應用需求與設計。

避免重複更新：如果你想避免「新價格」和「舊價格」
一樣時也觸發 Redux 更新，
可以在 dispatch 前加一層比對。

預設 Redux 機制已會根據 state 
變化自動 re-render。

若需更嚴格的「只在價格變動時才 dispatch」
或有額外副作用，可在 hook 內自行比對新舊值。

這樣做可提升效能、減少不必要的狀態更新與重渲染。

```
// src/actions/actionTypes.js
export const CRYPTO_LIVE_PRICE_RECEIVED = 'CRYPTO_LIVE_PRICE_RECEIVED';
```

### dispatch 前比對

```
import { useDispatch, useSelector } from 'react-redux';
import useWebSocket from 'react-use-websocket';
import { CRYPTO_LIVE_PRICE_RECEIVED } from '../../actions/actionTypes';

const useCryptoLivePriceHook = () => {
  const dispatch = useDispatch();
  const currentPrice = useSelector(state => state.cryptoPrice.cryptoLivePrice);

  const wsUrl = 'wss://fake-websocket-url.example.com';

  useWebSocket(wsUrl, {
    onMessage: (message) => {
      const data = JSON.parse(message.data);
      // 假設 data.es 是新價格
      if (currentPrice !== data.es) {
        dispatch({
          type: CRYPTO_LIVE_PRICE_RECEIVED,
          payload: { data: data.es }
        });
      }
    }
  });
};

export default useCryptoLivePriceHook;
```


### reducer 定義

```
// src/reducers/cryptoPriceReducer.js
import { CRYPTO_LIVE_PRICE_RECEIVED } from '../actions/actionTypes';

const initialState = {
  cryptoLivePrice: null
};

const cryptoPriceReducer = (state = initialState, action) => {
  switch (action.type) {
    case CRYPTO_LIVE_PRICE_RECEIVED:
      return {
        ...state,
        cryptoLivePrice: action.payload.data
      };
    default:
      return state;
  }
};

export default cryptoPriceReducer;
```

### 集合多個reducer的根


```
// src/reducers/index.js
import { combineReducers } from 'redux';
import cryptoPriceReducer from './cryptoPriceReducer';

const rootReducer = combineReducers({
  cryptoPrice: cryptoPriceReducer
});

export default rootReducer;
```

組件掛載
   ↓
useCryptoLivePriceHook 建立 WebSocket 連線
   ↓
WebSocket 持續接收資料
   ↓
onMessage 觸發 dispatch
   ↓
Redux 狀態被即時刷新
   ↓
元件用 useSelector 取得新資料

```
import React from 'react';
import useCOrderBook from './hook/orderBook/useCOrderBook'; // 路徑依你的專案結構調整
import { useSelector } from 'react-redux';

const CryptoPriceComponent = () => {
  useCryptoLivePriceHook(); // 只要呼叫這行，WebSocket 就會啟動並自動 dispatch 資料

  // 從 redux 取得即時價格
  const cryptoLivePrice = useSelector(state => state.cryptoPrice.cryptoLivePrice);

  return (
    <div>
      <h2>加密貨幣即時價格</h2>
      <pre>{JSON.stringify(cryptoLivePrice, null, 2)}</pre>
    </div>
  );
};

export default CryptoPriceComponent;
```
