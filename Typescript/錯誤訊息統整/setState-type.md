
setState 類型定義作為props 傳到組件時的 props type 定義 

### 錯誤版本 

```
interface ExamplProps {
  setExample: (XXX: any) => void; 
}
```


### 修正後版本 
#### 為什麼不該用 any ? 
指定 `setExample: React.Dispatch<React.SetStateAction<XXType | undefined>> ` 可確保只傳送有效的值（XXType 物件、undefined 或回傳其中之一的函數），使用更具體的類型代替 any。

```
const [example, setExample] = useState<XXType | undefined>(undefined);


<ExampleComp setExample={setExample} />

interface ExamplProps {
  setExample: React.Dispatch<React.SetStateAction<XXType | undefined>>;
 
}

const ExampleComp = ({ setExample }: ExamplProps) => {

```
