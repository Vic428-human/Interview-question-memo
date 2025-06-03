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

### 2. 組件實現

```tsx
const OrderForm = () => {
  const [formData, setFormData] = useState({
    symbol: 'BTC/USDT',
    side: 'BUY',
    type: 'LIMIT',
    amount: 0,
    price: 0
  });

  const {
    data: orderResult,
    error: orderError,
    mutate: submitOrder,
    isLoading: isSubmitting,
    reset: resetOrder
  } = useMutation({
    mutationFn: placeOrder,
    onSuccess: (data) => {
      // 成功後可以執行額外操作，如更新訂單列表
      console.log('訂單成功:', data);
    },
    onError: (error) => {
      // 錯誤處理邏輯
      console.error('訂單失敗:', error);
    }
  });

  const handleSubmit = (e) => {
    e.preventDefault();
    submitOrder(formData);
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: name === 'amount' || name === 'price' ? parseFloat(value) : value
    }));
  };

  return (
    <div className="order-form">
      <form onSubmit={handleSubmit}>
        {/* 表單字段 */}
        <select name="symbol" value={formData.symbol} onChange={handleInputChange}>
          <option value="BTC/USDT">BTC/USDT</option>
          <option value="ETH/USDT">ETH/USDT</option>
        </select>
        
        <select name="side" value={formData.side} onChange={handleInputChange}>
          <option value="BUY">買入</option>
          <option value="SELL">賣出</option>
        </select>
        
        <input 
          type="number" 
          name="amount" 
          value={formData.amount} 
          onChange={handleInputChange}
          step="0.0001"
          min="0"
        />
        
        {formData.type === 'LIMIT' && (
          <input 
            type="number" 
            name="price" 
            value={formData.price} 
            onChange={handleInputChange}
            step="0.01"
            min="0"
          />
        )}
        
        <button type="submit" disabled={isSubmitting}>
          {isSubmitting ? '下單中...' : '提交訂單'}
        </button>
      </form>
      
      {/* 狀態反饋 */}
      {orderResult && (
        <div className="alert success">
          <p>訂單成功！</p>
          <p>訂單ID: {orderResult.orderId}</p>
          <p>狀態: {orderResult.status}</p>
        </div>
      )}
      
      {orderError && (
        <div className="alert error">
          <p>下單失敗！</p>
          <p>錯誤訊息: {orderError.response?.data?.message || orderError.message}</p>
          <button onClick={resetOrder}>重試</button>
        </div>
      )}
    </div>
  );
};
```
