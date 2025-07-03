### 錯誤訊息
Argument of type '{ propertiesA: string }[]' is not assignable to parameter of type 'SetStateAction<never[]>'


### 出錯誤情境
簡單來說，TypeScript 不知道 setState 的型別是什麼，所以推斷為 never[]，
就是「不應該有任何值的陣列」，這當然無法接受你指定的陣列。

```
// 父層
const somethingOld = somethingOld ? somethingOld : [];

// 父層傳 props 下來
<SettingStakeCard somethingOld={somethingOld}  />

// props 下來後 rename 成 somethingNew
const SettingStakeCard = ({ somethingOld: somethingNew }: Tprops) => {

const [state, setState] = useState([]);

// somethingNew 提供給 useState hook 開始出錯，但只要對 `useState([])` 定義初始值類型就能解決
useEffect(() => {
  if (somethingNew.length === 0) return;
  setState(somethingNew);
}, [somethingNew]);
```

### 解法：你需要給 setState 對應的 useState 指定正確型別。
`<T[]>` 例如對 useState 定義初始值類型
```
const [state, setState] = useState<T[]>([]);
```
