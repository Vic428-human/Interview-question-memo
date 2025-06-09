
---

📘 Redux + AsyncThunk 筆記：

教你如何從 Redux store 擷取資料、定義 Selector、
建立 async thunk 並處理 API 回傳資料。

---

📚 目錄

1. 使用 useSelector 擷取 Redux 狀態
2. 定義 Selector Function
3. 建立 Redux Store


4. 定義 initialState


5. 建立 AsyncThunk Action


6. 使用 Builder 處理 fulfilled 狀態


7. 定義 API 函式




---
### 使用 useSelector 擷取 Redux 狀態

從 Redux 中擷取 customStats slice，並解構其中的 matchListStats
```

import { useSelector } from 'react-redux';
import { selectCustomStatsSlice } from '../features/customStats/customStatsSlice';


const { matchListStats } = useSelector(selectCustomStatsSlice);
```

---
### 定義 Selector Function
```
//src/features/customStats/customStatsSlice.js

export const selectCustomStatsSlice = ({ customStatsReducer }) => customStatsReducer;

```
這裡的 customStatsReducer 是你在 store.js 裡註冊進 Redux 的 reducer key 名稱，也就是這段：

因為 customStatsReducer 是你給這個 reducer 起的名稱，所以在 select 時就會用同一個名稱來解構。


```
import customStatsReducer from '../features/customStats/customStatsSlice';

const store = configureStore({
  reducer: {
    customStatsReducer, // 👈 這個 key 的名字就是 select function 裡用的名字
  },
});
```


---
