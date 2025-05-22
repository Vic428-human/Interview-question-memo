useContext 是 React 的一個 Hook。

它通常配合 Context API 用來跨元件樹共享狀態，實現簡易的狀態管理。

適合小型到中型應用的全域狀態管理，但大型專案建議使用更完整的狀態管理方案（如 Redux

### 備註
1. 不要把contextAPI當成global statemangement
2. 適合用在themeProvider，改變不太頻繁的，authProvider也適合使用。之前我在side project有實際應用過 [AuthProvider](https://github.com/Vic428-human/expense-tracker-app/blob/main/context/authContext.tsx)



examplecontext.tsx

```
import { createContext, useContext, useState } from 'react';

type ExampleContextValue = {
  valueA: string;
  valueB: string;
};

const ExampleContext = createContext<ExampleContextValue | undefined>(undefined);

export const ExampleProvider = ({
  children,
}: {
  children: React.ReactNode;
}) => {
  const [valueA, setValueA] = useState('A');
  const [valueB, setValueB] = useState('B');

  return (
    <ExampleContext.Provider value={{ valueA, valueB }}>
      {children}
    </ExampleContext.Provider>
  );
};

export const useExampleContext = () => {
  const context = useContext(ExampleContext);
  if (!context) {
    throw new Error('useExampleContext must be used within an ExampleProvider');
  }
  return context;
};

```

### 如何調用？

App.tsx

```
import { ExampleProvider, useExampleContext } from './ExampleContext';

export default function App() {
  return (
    <ExampleProvider>
      <ExampleComponent />
    </ExampleProvider>
  );
}

function ExampleComponent() {
  const { valueA }: { valueA: string } = useExampleContext();

  return <div>{valueA}</div>;
}

```

### 父子組件調用 tanstack query 時的範本
說明：
1. react query 有 global cache
PostCard.tsx
2. 每個組件都是獨立的，不會像createContext一樣，因為父組件觸發而導致子組件們都跟著render，react query特別好處在於只有當postId更新了才執行對應的子組件，有效的節省效能。
3. 但下面這個寫法，也是有一些問題，例如初次加載時：當組件第一次渲染、資料還沒從 API 拿回來時，useQuery 會先回傳 { data: undefined, isLoading: true, ... }，等到資料拿到後才會有值。
4. 查詢被禁用時：如果你用 enabled: false，查詢根本不會發生，data 也是 undefined。
5. 查詢失敗時：如果發生錯誤，data 也可能是 undefined，但這時你會看到 isError
6. 所以基於3-5點的理由，後來衍伸了useSuspenseQuery的做法，用以解決undefined的情況。

```
import { usePostQuery } from '../usePostQuery';

type PostCardProps = {
  postId: number;
};

export function PostCard({ postId }: PostCardProps) {

// usePostQuery來自於 tanstack query 獲取API回傳的數據
  const postQuery = usePostQuery(postId);

  if (postQuery.isLoading) {
    return <div>Loading...</div>;
  }

  if (postQuery.isError) {
    return <div>Error: {postQuery.error.message}</div>;
  }

  return (
    <>
      <PostCardHeader postId={postId} />
      <PostCardBody post={postQuery.data} />
    </>
  );
}

type PostCardHeaderProps = Pick<PostCardProps, 'postId'>;

function PostCardHeader({ postId }: PostCardHeaderProps) {
  const postQuery = usePostQuery(postId);

  return <h1>{postQuery.data?.title}</h1>;
}

type PostCardBodyProps = Pick<PostCardProps, 'postId'>;

function PostCardBody({ postId }: PostCardBodyProps) {
  const postQuery = usePostQuery(postId);

  return <div>{postQuery.data?.body}</div>;
}
```

### tanstack query 內部的樣子
usePostquery.ts
```

import { useQuery } from '@tanstack/react-query';

export function usePostQuery(postId: number) {
  return useQuery({
    queryKey: ['post', postId],
    queryFn: async () => ({
      id: postId,
      title: 'Hello World',
      body: 'This is a test post.',
    }),
  });
}

```
