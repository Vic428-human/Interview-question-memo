✅ 完整實作：記錄上一個路徑（不使用 context、不觸發 re-render）


---

1️⃣ usePreviousPath.ts — Hook：記錄上一頁路徑

// hooks/usePreviousPath.ts
import { useEffect, useRef } from 'react';
import { useLocation } from 'react-router-dom';

export function usePreviousPath() {
  const location = useLocation();
  const prevPathRef = useRef<string | null>(null);

  useEffect(() => {
    const currentPath = location.pathname;

    // 用 cleanup function，在跳轉之前記住目前路徑
    return () => {
      prevPathRef.current = currentPath;
    };
  }, [location.pathname]);

  return prevPathRef;
}


---

2️⃣ App.tsx — 在最上層引入 usePreviousPath 開始追蹤

// App.tsx
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import MyPage from './pages/MyPage';
import { usePreviousPath } from './hooks/usePreviousPath';

function App() {
  // 放這裡代表「整個 app」的路徑都會被追蹤
  usePreviousPath();

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/home" element={<Home />} />
        <Route path="/mypage" element={<MyPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;


---

3️⃣ MyPage.tsx — 使用 prevPathRef 來「返回上一頁」

// pages/MyPage.tsx
import { useNavigate } from 'react-router-dom';
import { usePreviousPath } from '../hooks/usePreviousPath';

function MyPage() {
  const navigate = useNavigate();
  const prevPathRef = usePreviousPath();

  const goBack = () => {
    const backTo = prevPathRef.current;
    if (backTo) {
      navigate(backTo);
    } else {
      navigate('/home'); // 沒有上一頁就回首頁
    }
  };

  return (
    <div>
      <h1>This is MyPage</h1>
      <button onClick={goBack}>🔙 Back to Previous Page</button>
    </div>
  );
}

export default MyPage;


---

✅ 示意流程：

使用者動作	發生的事

進入 /home	App 載入，但 prevPathRef.current 為 null
點擊進入 /mypage	useEffect cleanup 儲存 /home 到 prevPathRef.current
在 MyPage 按下返回	navigate(prevPathRef.current) 導回 /home
