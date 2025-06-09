
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

3. 建立 Redux Store

// 引入 customStatsReducer
import customStatsReducer from './customStatsReducer';

const store = configureStore({
  reducer: {
    customStatsReducer,
  },
});


---

4. 定義 initialState

const initialStatsState = {
  matchListStats: [],
  // 其他狀態項目...
};


---

5. 建立 AsyncThunk Action

// 建立 async thunk：向 API 取得比賽統計資料
export const loadMatchStatsAsync = createAsyncThunk('stats/loadMatchStats', async (query) => {
  const { extraInfo } = query;
  const { data, status } = await fetchMatchStatsFromAPI(query);

  if (status === 200) {
    return data.matches.concat([extraInfo]);
  }
});


---

6. 使用 Builder 處理 fulfilled 狀態

builder.addCase(loadMatchStatsAsync.fulfilled, (state, action) => {
  state.matchListStats = action.payload;
});


---

7. 定義 API 函式

// 實際向後端發送請求的 API 函式
export const fetchMatchStatsFromAPI = (query) => {
  const paramStr = typeof query?.params === 'string'
    ? query.params
    : query.extraInfo
      ? `${query.extraInfo}`
      : '';

  return statsAxios.get(`vsb/match-stats/v3/?language=${query.language}`);
};


---

✅ 總結表格（改名後）

教學項目	改名後名稱	說明

Redux Slice 名稱	customStatsReducer	放在 store 中的 reducer
Selector Hook	useSelector(selectCustomStatsSlice)	擷取 state
Selector Function	selectCustomStatsSlice	取得 customStatsReducer
AsyncThunk 名稱	loadMatchStatsAsync	呼叫 API
fulfilled 處理器	builder.addCase(...).fulfilled	寫入 matchListStats
API 函式名稱	fetchMatchStatsFromAPI	封裝 axios GET 請求



---

若你需要我根據這些教學內容，自動產出一份完整的專案範例（包含 reducer、store、slice 檔案等），我可以再幫你擴充。是否要繼續？

