## 核心需求分析

1. **下單功能**：用戶可以提交交易訂單
2. **狀態反饋**：需要顯示下單成功或失敗的訊息
3. **API交互**：使用React Query的useMutation處理異步操作
4. **用戶體驗**：在加載時禁用按鈕防止重複提交

## 實現方案

### 1. API函數定義

```typescript
const placeOrder = async (orderData: OrderData) => {
  const response = await axios.post('/api/exchange/orders', orderData);
  return response.data;
};

interface OrderData {
  symbol: string;       // 交易對，如 BTC/USDT
  side: 'BUY' | 'SELL'; // 買或賣
  type: 'LIMIT' | 'MARKET'; // 訂單類型
  amount: number;       // 數量
  price?: number;       // 限價單需要價格
}
```
