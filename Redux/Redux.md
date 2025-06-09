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

### store.js

```
import customStatsReducer from '../features/customStats/customStatsSlice';

const store = configureStore({
  reducer: {
    customStatsReducer, // 👈 這個 key 的名字就是 select function 裡用的名字
  },
});
```
---
customStatsSlice.js 這個檔案

```





```js
// 在 component 檔案內
import { useSelector } from 'react-redux';
import { selectCustomStatsSlice } from '../features/customStats/customStatsSlice';

const matchListStats = useSelector(
  (state) => selectCustomStatsSlice(state).matchListStats
);
```
- **說明**：useSelector 傳入的 function 會收到全域 state，這裡要再取出 slice 內的 matchListStats 欄位[4]。

---

### 2. 定義 Selector Function

```js
// src/features/customStats/customStatsSlice.js
export const selectCustomStatsSlice = (state) => state.customStatsReducer;
```
- **說明**：這個 selector 取出你在 store 註冊的 customStatsReducer slice[4]。

---

### 3. 建立 Redux Store

```js
// src/app/store.js
import { configureStore } from '@reduxjs/toolkit';
import customStatsReducer from '../features/customStats/customStatsSlice';

const store = configureStore({
  reducer: {
    customStatsReducer, // key 名稱要和 selector 對應
  },
});

export default store;
```
### customStatsSlice.js
```
import { createSlice } from '@reduxjs/toolkit';
// 假設這是你的 async thunk
export const fetchMatchListStats = createAsyncThunk(
  'customStats/fetchMatchListStats',
  async (params, thunkAPI) => {
    // 這裡放你的 API 請求邏輯
    const response = await fetch('/api/match-list-stats');
    if (!response.ok) throw new Error('Network response was not ok');
    return await response.json();
  }
);
const initialState = {
  matchListStats: [],
  status: 'idle', // 'idle' | 'loading' | 'succeeded' | 'failed'
  error: null,
};

const customStatsSlice = createSlice({
  name: 'customStats',
  initialState,
  reducers: {
    resetStats(state) {
      state.matchListStats = [];
      state.status = 'idle';
      state.error = null;
    },
extraReducers: (builder) => {
    builder
      .addCase(fetchMatchListStats.pending, (state) => {
        state.status = 'loading';
        state.error = null;
      })
      .addCase(fetchMatchListStats.fulfilled, (state, action) => {
        state.status = 'succeeded';
        state.matchListStats = action.payload;
        state.error = null;
      })
      .addCase(fetchMatchListStats.rejected, (state, action) => {
        state.status = 'failed';
        state.error = action.error.message;
      });
  },
  },
});

export const { resetStats } = customStatsSlice.actions;
export default customStatsSlice.reducer;

// Selector，建議直接取得 customStats 狀態
export const selectCustomStats = (state) => state.customStats;
```

 
