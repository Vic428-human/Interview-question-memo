useContext 是 React 的一個 Hook。

它通常配合 Context API 用來跨元件樹共享狀態，實現簡易的狀態管理。

適合小型到中型應用的全域狀態管理，但大型專案建議使用更完整的狀態管理方案（如 Redux

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
