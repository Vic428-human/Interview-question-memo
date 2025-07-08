
## 前言
> 這邊主要是區分 params 給 endpoint 的用法，跟什麼原因造成 useQuery 會call api兩次的範本

```

const [AAA, setAAA] = useState('');
const postParamsObject = {
  params: {
    params_id: 000,
    params_count: 10,
  },
};
const { data: curData } = useQuery({
  queryKey: ['keyOne', 'keyTwo', AAA],
  queryFn: () => apiExample(postParamsObject).then((res) => res.data.data),
  staleTime: Infinity,
  enabled: !!postParamsObject?.params?.params_id,
});

  useEffect(() => {
    setAAA(() => {
    });
   
  }, [其他]);

```
### 為什麼 apiExample 觸發兩次 
queryKey 動態變化
如果 AAA 的值在 render 期間變動，React Query 會認為是不同的 query key，因此觸發重新 fetch。
🧪 建議：確認 AAA 是否在初次 render 或某些 hook 中被更新。

查驗： 
1. AAA 一開始的初始值就會先觸發 useQuery
3. 爾後的 setAAA 在 useEffect 又因為 其他 dependency 有變化，所以觸發了，導致 AAA 發生改變，進而觸發 apiExample 再一次。

結論：
所以才導致觸發兩次。

### 如果是用 postParamsObject 的方式打API，實際上 endpoint 會長怎樣的模式 

```
假設 apiExample = apiExample/111/?${postParamsObject} 這個 endpoint 
```

```
http://domain/apiExample/111/?params_id=4&params_count=10 實際顯示的會長這樣 
```
