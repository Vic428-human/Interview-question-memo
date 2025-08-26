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
import counterReducer from './features/counterSlice'  (假設這個是還沒從 js 轉成 ts的slice)
// 其他多個 reducers 

// 建立 store
export const store = configureStore({
  reducer: {
    counter: counterReducer,
   // ....Add the counter reducer
  },
})

// 型別定義
export type AppStore = typeof store
export type RootState = ReturnType<typeof store.getState> // export type RootState = ReturnType<AppStore['getState']>;
export type AppDispatch = typeof store.dispatch // export type AppDispatch = AppStore['dispatch'];

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

// RootState 先前已經在 Store 裡面定義好類型
// 當你在 configureStore 裡定義了多個 reducer（如 001、002、counter），RootState 會自動推導出整個 store 的結構，例如： `counter: CounterState,  // { value: number }`
// 當你在 selector（如 selectCount）裡使用 state.counter.value 時，TypeScript 就能正確推導 state 的型別，並檢查你是否正確存取 state。
// counter ==> slice 的 name
// value ==> slice 的 state value 
export const selectCount = (state: RootState) => state.counter.value

export default counterSlice.reducer

```

### 組件中實際調用 useAppSelector 跟 useAppDispatch

```
import React, { useState } from 'react'

import { useAppSelector, useAppDispatch } from 'app/hooks'

import { decrement, increment } from './counterSlice'

export function Counter() {
  // The `state` arg is correctly typed as `RootState` already
  const count = useAppSelector(state => state.counter.value)
  const dispatch = useAppDispatch()

  // omit rendering logic
}
```

- 轉成typescript的useAppSelector後,就不要在引用舊的 useSelector 跟 useDispatch

https://github.com/Vic428-human/Interview-question-memo/blob/main/Eslint/no-restricted-imports.md

### 1. useDispatch 是什麼？
在 Redux 中，我們要改變資料（state）時，需要發送「指令」（叫做 action）。
useDispatch 就是 React-Redux 提供的一個 Hook，可以拿到 dispatch 這個函式，用來發送 action。
Redux store 就像是學校的「公告欄」，上面寫著大家共用的資訊（state）。
dispatch 就像是你把一張「請求單」交給教務處，請他更新公告欄上的資訊。
action 就是那張「請求單」，上面寫著你要做什麼事情（例如「新增一個學生」、「刪除一個課程」）。

### 2.AppDispatch 是什麼？
我定義一個新的型別叫 AppDispatch，它等於我 AppStore 裡面的 dispatch 函式型別。
這樣做的好處是：未來我們在程式中使用 dispatch，就能有 型別提示，TypeScript 會幫我們檢查 action 有沒有寫對。

### 3.useAppDispatch 是什麼？
Redux 官方的 useDispatch 回傳的是一個「沒特別指定型別」的 dispatch。
如果直接用它，TypeScript 不知道你到底可以 dispatch 什麼樣的 action。

### 4. 總結
useDispatch：拿到 dispatch，發送 action。
AppDispatch：定義 dispatch 的型別，避免寫錯 action。
useAppDispatch：自己包裝過的 useDispatch，專門幫 TypeScript 初學者「加上安全帽」。

### Redux 的資料流小圖
```
[ Component 組件 ]
        │
        │  (1) 呼叫 useAppDispatch() 
        ▼
   [ dispatch 函式 ]   ← 你要的「教務處窗口」
        │
        │  (2) 發送一張 action 請求單
        ▼
   [ Reducer 處理器 ]   ← 判斷要怎麼改公告欄
        │
        │  (3) 根據 action 更新 state
        ▼
   [ Store 公告欄 (state) ]
        │
        │  (4) 通知所有用到 state 的組件
        ▼
[ Component 自動重新渲染 ]
```
