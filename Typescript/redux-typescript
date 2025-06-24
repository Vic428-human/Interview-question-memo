
前言
> 假設當期專案是 js 基礎，要轉換成 typescript，其中一關就會需要對 redux 進行類型定義

###  型別安全的 Redux Hooks
Redux 官方提供的 useDispatch、useSelector、useStore hooks，預設是沒有型別資訊的（即使你用 TypeScript）。
這會導致你在使用時，TypeScript 無法幫你檢查型別，容易出錯。
這段程式碼的目的，就是包裝這些 hooks，讓它們帶上你自己定義的型別（AppDispatch、RootState、AppStore），這樣在整個專案中使用時就會有完整的型別提示與檢查。

[型別安全的 Redux Hooks](https://redux.js.org/usage/usage-with-typescript)

```
import type { TypedUseSelectorHook } from 'react-redux'
import { useDispatch, useSelector, useStore } from 'react-redux'
import type { AppDispatch, AppStore, RootState } from './store' // 裡面會集中定義多個reducers，有些專案會取index.ts

// Use throughout your app instead of plain `useDispatch` and `useSelector`
export const useAppDispatch: () => AppDispatch = useDispatch
export const useAppSelector: TypedUseSelectorHook<RootState> = useSelector
export const useAppStore: () => AppStore = useStore
```

### 集中管理 reducers 
store.ts 內容

這個檔案用途：
configureStore 會集中多個 reducers 
reducers 裡面可以有 js 或是 ts 不影響 

```
import { configureStore } from '@reduxjs/toolkit'
import counterReducer from './features/counterSlice' 

// 建立 store
export const store = configureStore({
  reducer: {
    counter: counterReducer,  // Add the counter reducer
  },
})

// 型別定義
export type RootState = ReturnType<typeof store.getState>
export type AppDispatch = typeof store.dispatch
export type AppStore = typeof store
```

### counterSlice 內部定義

```
import { createSlice, PayloadAction } from '@reduxjs/toolkit'
import type { RootState } from '../../app/store'

// Define a type for the slice state
interface CounterState {
  value: number
}

// Define the initial state using that type
const initialState: CounterState = {
  value: 0
}

export const counterSlice = createSlice({
  name: 'counter',
  // `createSlice` will infer the state type from the `initialState` argument
  initialState,
  reducers: {
    increment: state => {
      state.value += 1
    },
    decrement: state => {
      state.value -= 1
    },
    // PayloadAction<> 的 <> 會根據這個 Slice 的 state 去定義類型
    incrementByAmount: (state, action: PayloadAction<number>) => {
      state.value += action.payload
    }
  }
})

export const { increment, decrement, incrementByAmount } = counterSlice.actions

// Other code such as selectors can use the imported `RootState` type
export const selectCount = (state: RootState) => state.counter.value

export default counterSlice.reducer

```
