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
customStatsSlice.js 這個檔案

```
import { createSlice } from '@reduxjs/toolkit';

// 1. 定義 initialState
const initialState = {
  matchListStats: [],
  status: 'idle', // 'idle' | 'loading' | 'succeeded' | 'failed'
  error: null,
};

// 2. 建立 slice
const customStatsSlice = createSlice({
  name: 'customStats',
  initialState,
  reducers: {
    // 這裡可以定義同步的 reducer，例如 resetStats
    resetStats(state) {
      state.matchListStats = [];
      state.status = 'idle';
      state.error = null;
    },
  },
  // 3. 如果有 asyncThunk，這裡可以加上 extraReducers
  // extraReducers: (builder) => {...}
});

// 4. 導出 actions（可選）
export const { resetStats } = customStatsSlice.actions;

// 5. 導出 reducer，給 store 註冊用
export default customStatsSlice.reducer;

// 6. (可選) 定義 selector
export const selectCustomStatsSlice = (state) => state.customStatsReducer;

```


幫我優化跟檢查，有錯的話自動更改

## Redux + AsyncThunk 筆記優化版

這份筆記將帶你完整實作：如何從 Redux store 擷取資料、定義 selector、建立 async thunk 並處理 API 回傳資料，並修正原本範例的常見錯誤與最佳實踐。

---

### 1. 使用 useSelector 擷取 Redux 狀態

**正確用法：**  
useSelector 必須在 React component 內部呼叫，且參數是 state → slice 的 selector function。

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
- **說明**：key 名 customStatsReducer 必須和 selector 的 state.customStatsReducer 對應。

---

### 4. 定義 initialState

```js
// src/features/customStats/customStatsSlice.js
const initialState = {
  matchListStats: [],
  status: 'idle', // 'idle' | 'loading' | 'succeeded' | 'failed'
  error: null,
};
```

---

### 5. 建立 AsyncThunk Action

```js
// src/features/customStats/customStatsSlice.js
import { createAsyncThunk } from '@reduxjs/toolkit';
import { fetchMatchListStatsAPI } from '../../api/customStatsApi';

export const fetchMatchListStats = createAsyncThunk(
  'customStats/fetchMatchListStats',
  async (params, thunkAPI) => {
    try {
      const response = await fetchMatchListStatsAPI(params);
      return response.data;
    } catch (error) {
      return thunkAPI.rejectWithValue(error.response?.data || error.message);
    }
  }
);
```
- **說明**：createAsyncThunk 用於處理 API 非同步請求，並自動產生 pending/fulfilled/rejected action[2][5]。

---

### 6. 使用 Builder 處理 fulfilled 狀態

```js
import { createSlice } from '@reduxjs/toolkit';
import { fetchMatchListStats } from './customStatsSlice';

const customStatsSlice = createSlice({
  name: 'customStats',
  initialState,
  reducers: {
    resetStats(state) {
      state.matchListStats = [];
      state.status = 'idle';
      state.error = null;
    },
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
      })
      .addCase(fetchMatchListStats.rejected, (state, action) => {
        state.status = 'failed';
        state.error = action.payload || action.error.message;
      });
  },
});

export const { resetStats } = customStatsSlice.actions;
export default customStatsSlice.reducer;
```
- **說明**：用 builder 處理 asyncThunk 的三種狀態，管理 loading、資料與錯誤[2][5]。

---

### 7. 定義 API 函式

```js
// src/api/customStatsApi.js
import axios from 'axios';

export const fetchMatchListStatsAPI = (params) =>
  axios.get('/api/match-list-stats', { params });
```
- **說明**：將 API 請求邏輯獨立於 slice，方便維護與測試。

---

## 常見錯誤與最佳實踐

- **useSelector 用法**：不要直接在 useSelector 解構 state，應該先取 slice 再取欄位，否則 re-render 可能異常[4]。
- **selector 命名**：selector function 要明確對應 store 裡的 key。
- **AsyncThunk 狀態管理**：利用 extraReducers 處理 loading、succeeded、failed 狀態，讓 UI 能根據 status 顯示 loading/error。
- **API 錯誤處理**：thunk 內建 rejectWithValue 可傳遞錯誤訊息給 reducer 處理[5]。

---

## 小結

這份範例已修正 useSelector、selector function、store 註冊、asyncThunk 與 API 錯誤處理等常見問題，並符合 Redux Toolkit 官方最佳實踐。你可以直接依照這個結構開發與維護大型 React + Redux 專案。

引用：
[1] best practices for triggering async updates with createAsyncThunk https://www.reddit.com/r/reactjs/comments/rdzhlh/best_practices_for_triggering_async_updates_with/
[2] Redux: Using createSlice and createAsyncThunk for Cleaner State ... https://dev.to/sivamani18/redux-simplified-using-createslice-and-createasyncthunk-for-cleaner-state-management-2nb8
[3] Problem in Redux Toolkit's Async Thunks: State Not Properly ... https://stackoverflow.com/questions/78848986/problem-in-redux-toolkits-async-thunks-state-not-properly-updated-in-react-com
[4] Mastering the useSelector Hook in Redux Toolkit - 30 Days Coding https://30dayscoding.com/blog/mastering-useselector-in-redux-toolkit
[5] Redux Essentials, Part 5: Async Logic and Data Fetching https://redux.js.org/tutorials/essentials/part-5-async-logic
[6] createAsyncThunk - Redux Toolkit https://redux-toolkit.js.org/api/createAsyncThunk
[7] Complete Guide to Using Redux Toolkit and Redux Thunk with Best ... https://www.linkedin.com/pulse/complete-guide-using-redux-toolkit-thunk-best-sherif-a-mounir
[8] Usage Guide - Redux Toolkit https://redux-toolkit.js.org/usage/usage-guide
[9] Mastering Async Actions within createAsyncThunk in Redux Toolkit https://blog.stackademic.com/mastering-async-actions-within-createasyncthunk-in-redux-toolkit-382af0eaae57
[10] createSlice - Redux Toolkit https://redux-toolkit.js.org/api/createslice
