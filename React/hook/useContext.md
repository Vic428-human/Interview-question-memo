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

### 與 tanstack query 搭配使用時

PostCard.tsx

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
