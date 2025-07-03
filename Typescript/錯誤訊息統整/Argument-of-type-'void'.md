```
Argument of type 'void' is not assignable to parameter of type '{ is_default: boolean; ... }'.ts(2345)
```

```
const updateUserStakesMutation = useMutation({
  mutationFn: (data) => updateUserSettings(data),
```

### 原因
這個錯誤通常是因為 useMutation 沒有正確推斷 mutation 參數的型別，預設把 mutation 參數型別推成 void，導致你呼叫 mutate(data) 時型別不符

### 詳細解釋
useMutation 有四個泛型參數，其中第三個就是你 mutation function 參數的型別。如果你沒明確指定，TypeScript 會預設成 void

### 解決方法
你需要在 useMutation 明確指定 mutation function 的參數型別。像這樣：

```
import { useMutation } from '@tanstack/react-query';

type UpdateUserSettingsParams = {
  is_default: boolean;
  default_stake?: string;
  quick_stakes?: {
    q_amount: string;
    is_primary: boolean;
  }[];
  odds_change?: boolean;
  language?: string;
};

const updateUserSettingsMutation = useMutation({
  mutationFn: (data: UpdateUserSettingsParams) => updateUserSettings(data),
});
```
