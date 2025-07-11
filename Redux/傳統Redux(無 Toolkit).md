# 薪水管理系統代碼梳理與註解

我將創建一個與薪水管理相關的例子，展示如何獲取和驗證最低薪資標準。這個例子將包含Redux狀態管理、API請求和組件驗證。

## 1. 組件初始化階段 - 獲取最低薪資

```javascript
// 在員工表單組件中使用useEffect來觸發獲取最低薪資的action
useEffect(() => {
    // 當地區變化時，獲取該地區的最低薪資標準
    dispatch(fetchMinimumWageAsync(region));
}, [region]);
```

## 2. Action Creator - 發起API請求

```javascript
// 定義API請求函數，根據地區獲取最低薪資
export const apiFetchMinimumWage = (region) => 
  rootAxios.get(`salary/minimum-wage/?region=${region}`);

// 異步action creator，用於獲取最低薪資
export const fetchMinimumWageAsync = (region) => async (dispatch) => {
  try {
    // 發起API請求獲取最低薪資數據
    const { data, status } = await apiFetchMinimumWage(region);
    
    // 如果響應狀態不是200，直接返回
    if (status !== 200) return;
    
    // 調用同步action creator設置最低薪資
    // API返回的data.minimum_wage是數字類型
    dispatch(setMinimumWage(data?.minimum_wage));
  } catch (error) {
    console.error('獲取最低薪資失敗', error);
  }
};
```

## 3. 同步Action Creator - 創建action

```javascript
// 同步action creator，創建一個設置最低薪資的action
export const setMinimumWage = (payload: number) => ({
  type: 'SET_MINIMUM_WAGE',  // action類型
  payload,                  // 攜帶的數據(最低薪資金額)
});
```

## 4. Reducer - 處理action更新state

```javascript
// 初始狀態
const initialState = {
  minimumWage: 0
};

// reducer處理SET_MINIMUM_WAGE action
const salaryReducer = (state = initialState, action: PayloadAction<number>) => {
  switch (action.type) {
    case 'SET_MINIMUM_WAGE':
      // 當action類型是SET_MINIMUM_WAGE時，更新state中的minimumWage值
      return { ...state, minimumWage: action.payload };
    default:
      return state;
  }
};
```

## 5. 組件使用階段 - 驗證員工薪資

```javascript
// 從redux store中獲取minimumWage值
const { minimumWage } = useAppSelector((state) => state.salaryReducer);

// 驗證員工薪資是否達到最低薪資標準
const validateSalary = (proposedSalary: number) => {
  if (proposedSalary < minimumWage) {
    // 如果不滿足，返回錯誤信息
    return `薪資不能低於最低薪資標準: ${minimumWage}`;
  }
  return null;
};

// 在表單提交時使用驗證
const handleSubmit = () => {
  const error = validateSalary(formData.salary);
  if (error) {
    setError(error);
    return;
  }
  // 提交表單邏輯...
};
```

## 流程總結

1. **組件初始化**：當地區選擇變化時，觸發`fetchMinimumWageAsync` action
2. **API請求**：根據地區向後端請求該地區的最低薪資標準
3. **處理響應**：API返回成功後，調用`setMinimumWage` action creator
4. **更新state**：reducer處理`SET_MINIMUM_WAGE` action，更新redux store中的minimumWage值
5. **表單驗證**：在提交員工薪資時，驗證是否達到最低薪資標準

## 類型安全說明

1. **TypeScript類型**：我們明確指定了`setMinimumWage`的payload為number類型
2. **API響應**：假設後端返回的`minimum_wage`字段是數字類型
3. **Reducer驗證**：reducer也明確處理number類型的payload
4. **組件驗證**：在驗證函數中明確指定參數類型為number

這個例子展示了如何管理地區性最低薪資標準，並確保員工薪資不低於法定最低標準。您可以根据實際需求擴展功能，例如：
- 添加不同職位的最低薪資
- 考慮全職/兼職的不同標準
- 加入貨幣類型的轉換
- 根據通脹率自動調整等
