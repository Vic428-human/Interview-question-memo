### **元件初次渲染時（預設行為，但被禁用）**

- 通常 **`useQuery`** 會在元件掛載時自動觸發，但你的程式碼中設定了 **`enabled: false`**，所以**不會自動執行**。

### **手動觸發 `refetch`**

- 當 **`enabled: false`** 時，可以透過 **`refetch`** 方法手動觸發查詢：

### **視窗重新獲得焦點時（`refetchOnWindowFocus`）**

- 你的程式碼中設定了 **`refetchOnWindowFocus: true`**，所以當使用者切換瀏覽器標籤或應用程式後再返回時，會自動重新獲取數據（即使 **`enabled: false`** 也會觸發）。

### **數據過期時（`staleTime`）**

- **`staleTime: 5000`** 表示數據在 5 秒後會被標記為「過時」（stale），但不會立即觸發重新獲取。若同時有其他觸發條件（如視窗焦點），則會重新獲取。

- ```
  import { useQuery } from 'react-query';

const fetchData = async () => {
  const response = await fetch('https://api.example.com/data');
  return response.json();
};


const MyComponent = () => {

  const { data: renameData, isLoading, error: renameError, refetch } = useQuery(
	  'fetchData',  // === queryKey: ['fetchData'], 這是靜態key 。 除非寫成 ['fetchData', id]  那就會根據id的變化而查詢 
		 fetchData ,  // ===  queryFn: fetchData, (實際獲取數據的函數)
		 {
		   enabled: false, // enabled: 控制查询是否自动运行。
		   staleTime: 5000, // 数据在 5 秒内不会重新获取
		   cacheTime: 10000, // 数据在 10 秒后从缓存中移除
		   retry: 3, // 失败后重试 3 次
		   refetchOnWindowFocus: true,
		   retry: 2,
		   onSuccess: (data) => console.log('Fetched:', data),
		   onError: (err) => console.error('Error:', err),
		   }
		);

  if (isLoading) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;
	
  return <div>
				    {JSON.stringify(renameData)}
					  <div>
						  <button onClick={() => refetch()}>Fetch Data</button>
					  </div>
				  </div>;
}; 
```
在 TanStack Query (以前稱為 React Query) 的主題下，useQuery 和 useMutation 雖然都用於處理資料，但它們的主要使用情境區別在於：
 * useQuery：處理資料的讀取 (Fetching/Reading Data)
 * useMutation：處理資料的變更 (Creating, Updating, Deleting Data)
以下是它們更詳細的區別：
useQuery 的使用情境
useQuery 用於從後端 獲取 (fetch) 或 讀取 (read) 資料。它的核心目的是處理資料的查詢、緩存、背景重新獲取 (refetching) 和狀態管理 (如載入中、錯誤、成功)。
主要特性和適用情境：
 * 資料讀取： 當你需要從 API 獲取資料並在 UI 中顯示時，例如：
   * 顯示用戶列表
   * 獲取文章內容
   * 載入產品詳細資訊
   * 取得設定選項
 * 自動緩存： useQuery 會自動緩存查詢結果，減少不必要的網路請求，提升應用程式性能。
 * 背景重新獲取 (Background Refetching)： 當資料可能在後端更新時，useQuery 會在特定條件下（如視窗重新聚焦、網路重新連接、定時器）自動在背景重新獲取資料，確保資料的新鮮度。
 * 去重 (Deduplication)： 如果多個組件同時發出相同的查詢，useQuery 會自動去重，只發送一次網路請求。
 * 錯誤處理與載入狀態： 內建了完善的 isLoading, isError, error, isFetching 等狀態，方便你處理 UI 的載入和錯誤顯示。
 * 資料新鮮度管理： 提供了 staleTime, cacheTime 等選項來細緻地控制資料的新鮮度和緩存行為。
 * 分頁和無限滾動： 提供了 useInfiniteQuery 來處理分頁和無限滾動的場景。
簡而言之，只要你的操作是從伺服器端「拿」資料，就應該考慮使用 useQuery。
