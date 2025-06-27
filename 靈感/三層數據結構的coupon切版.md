這個練習專案是關於一個分層級的優惠券系統介面切版，主要分為以下幾個部分：

1. 套組等級：
- 系統提供 Premium、Standard 等不同等級的套組
- 每個套組對應不同的面額和折扣優惠

2. 功能邏輯：
- 當用戶點選按鈕時，可以領取對應面額的折扣優惠券
- 系統會根據用戶帳號訂閱的套組等級（如 Premium）顯示相應的優惠券選項
- 這個優惠券系統同時適用於購買和銷售兩種情境

3. 資料結構：
- 後端傳回的數據結構達到三層嵌套
- 需要將原始數據整理為兩個獨立陣列：
  * buyOptions - 購買專用的優惠券選項
  * sellOptions - 銷售專用的優惠券選項

4. 介面呈現：
- 購買區域和銷售區域需要分開顯示，不能同時呈現所有優惠券按鈕
- 透過 map 方法將整理好的 sellOptions 陣列渲染為獨立的優惠券按鈕組
- Premium 用戶會看到專屬的優惠券選項，無論是在購買還是銷售界面

這個切版練習的重點在於處理多層數據結構，並根據不同使用情境（購買/銷售）動態顯示對應的優惠券選項，同時要考慮用戶的訂閱等級來過濾顯示內容。

```
import React from 'react';

// 模擬數據 - 優惠券主題
const mockData = {
  eventId: "coupon_event_123",
  marketId: "market_456", 
  couponId: "coupon_789",
  isDesktop: true,
  couponList: [
    {
      options: [
        {
          optionName: "Premium Package",
          basePrice: 1.95,
          baseStock: 1000,
          altPrice: 2.05,
          altStock: 800,
          deals: [
            { buyPrice: 1.98, buyStock: 1200, sellPrice: 2.02, sellStock: 900 },
            { buyPrice: 2.01, buyStock: 800, sellPrice: 1.99, sellStock: 1100 },
            { buyPrice: 2.05, buyStock: 600, sellPrice: 1.95, sellStock: 1300 }
          ]
        },
        {
          optionName: "Standard Package",
          basePrice: 3.25,
          baseStock: 500,
          altPrice: 3.45,
          altStock: 400,
          deals: [
            { buyPrice: 3.30, buyStock: 600, sellPrice: 3.40, sellStock: 450 },
            { buyPrice: 3.35, buyStock: 400, sellPrice: 3.35, sellStock: 550 },
            { buyPrice: 3.40, buyStock: 350, sellPrice: 3.30, sellStock: 600 }
          ]
        },
        {
          optionName: "Basic Package",
          basePrice: 4.50,
          baseStock: 300,
          altPrice: 4.80,
          altStock: 250,
          deals: [
            { buyPrice: 4.60, buyStock: 350, sellPrice: 4.70, sellStock: 300 },
            { buyPrice: 4.65, buyStock: 280, sellPrice: 4.75, sellStock: 270 },
            { buyPrice: 4.70, buyStock: 250, sellPrice: 4.80, sellStock: 240 }
          ]
        }
      ]
    }
  ]
};

// 模擬 優惠券按鈕組件
const CouponPriceButton = ({ 
  uuid, 
  selectedOption, 
  price, 
  actionType, 
  stock, 
  disabled,
  onSelectCoupon,
  onSetPrice
}) => {
  const handleClick = () => {
    onSelectCoupon(uuid);
    onSetPrice(price);
  };

  return (
    <button
      className={`coupon-button ${actionType === 'buy' ? 'buy-button' : 'sell-button'} ${disabled ? 'disabled' : ''}`}
      onClick={handleClick}
      disabled={disabled}
    >
      <div className="price-value">${price.toFixed(2)}</div>
      <div className="stock-count">{stock}</div>
    </button>
  );
};

const CouponSelectionLayout = () => {
  const { eventId, marketId, couponId, isDesktop, couponList } = mockData;
  
  const onSelectCoupon = (uuid) => console.log('Selected Coupon:', uuid);
  const onSetPrice = (price) => console.log('Set Price:', price);

  return (
    <div className="coupon-container">
      <style jsx>{`
        .coupon-container {
          padding: 20px;
          font-family: Arial, sans-serif;
          background: #f5f5f5;
        }
        
        .option-row {
          display: flex;
          align-items: center;
          margin-bottom: 15px;
          padding: 15px;
          border: 1px solid #ddd;
          border-radius: 12px;
          background: white;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .option-name {
          width: 150px;
          font-weight: bold;
          margin-right: 20px;
          color: #333;
        }
        
        .deals-section {
          display: flex;
          gap: 30px;
          flex: 1;
        }
        
        .buy-section, .sell-section {
          display: flex;
          flex-direction: column;
        }
        
        .action-title {
          font-size: 12px;
          font-weight: bold;
          margin-bottom: 8px;
          text-align: center;
          text-transform: uppercase;
          letter-spacing: 1px;
        }
        
        .buy-section .action-title {
          color: #2e7d32;
        }
        
        .sell-section .action-title {
          color: #d32f2f;
        }
        
        .deals-row {
          display: flex;
          gap: 8px;
        }
        
        .coupon-button {
          display: flex;
          flex-direction: column;
          align-items: center;
          padding: 12px 16px;
          border: none;
          border-radius: 8px;
          cursor: pointer;
          min-width: 70px;
          transition: all 0.3s ease;
          font-weight: 500;
        }
        
        .buy-button {
          background: linear-gradient(135deg, #e8f5e8, #c8e6c9);
          border: 2px solid #4caf50;
          color: #2e7d32;
        }
        
        .buy-button:hover {
          background: linear-gradient(135deg, #c8e6c9, #a5d6a7);
          transform: translateY(-2px);
          box-shadow: 0 4px 8px rgba(76, 175, 80, 0.3);
        }
        
        .sell-button {
          background: linear-gradient(135deg, #ffebee, #ffcdd2);
          border: 2px solid #f44336;
          color: #d32f2f;
        }
        
        .sell-button:hover {
          background: linear-gradient(135deg, #ffcdd2, #ef9a9a);
          transform: translateY(-2px);
          box-shadow: 0 4px 8px rgba(244, 67, 54, 0.3);
        }
        
        .coupon-button.disabled {
          opacity: 0.5;
          cursor: not-allowed;
          transform: none;
        }
        
        .coupon-button.disabled:hover {
          transform: none;
          box-shadow: none;
        }
        
        .price-value {
          font-weight: bold;
          font-size: 16px;
          margin-bottom: 2px;
        }
        
        .stock-count {
          font-size: 11px;
          opacity: 0.8;
        }
        
        .main-title {
          text-align: center;
          color: #333;
          margin-bottom: 25px;
          font-size: 24px;
          font-weight: bold;
        }
      `}</style>
      
      <h2 className="main-title">💰 優惠券選擇中心</h2>
      
      {couponList[0]?.options.map((option, i) => {
        // 構建購買和銷售選項數組
        const buyOptions = [
          { price: option.basePrice + '', stock: option.baseStock }, 
          ...option.deals.map((deal) => ({ price: deal.buyPrice, stock: deal.buyStock }))
        ];
        
        const sellOptions = [
          { price: option.altPrice + '', stock: option.altStock }, 
          ...option.deals.map((deal) => ({ price: deal.sellPrice, stock: deal.sellStock }))
        ];

        return (
          <div key={`option-${i}`} className="option-row">
            <div className="option-name">🎫 {option.optionName}</div>
            
            <div className="deals-section">
              {/* 購買區域 */}
              <div className="buy-section">
                <div className="action-title">💚 Buy</div>
                <div className="deals-row">
                  {buyOptions.slice(0, isDesktop ? buyOptions.length : 1).map((deal, index) => (
                    <CouponPriceButton
                      key={`${eventId}__${marketId}__${couponId}__buy__${i}__${index}`}
                      uuid={`${eventId}__${marketId}__${couponId}__buy__${i}__${index}`}
                      selectedOption={option}
                      price={+deal.price}
                      actionType={'buy'}
                      stock={deal.stock}
                      disabled={+deal.price < 1.01}
                      onSelectCoupon={onSelectCoupon}
                      onSetPrice={onSetPrice}
                    />
                  ))}
                </div>
              </div>
              
              {/* 銷售區域 */}
              <div className="sell-section">
                <div className="action-title">❤️ Sell</div>
                <div className="deals-row">
                  {sellOptions.slice(0, isDesktop ? sellOptions.length : 1).map((deal, index) => (
                    <CouponPriceButton
                      key={`${eventId}__${marketId}__${couponId}__sell__${i}__${index}`}
                      uuid={`${eventId}__${marketId}__${couponId}__sell__${i}__${index}`}
                      selectedOption={option}
                      price={+deal.price}
                      actionType={'sell'}
                      stock={deal.stock}
                      disabled={+deal.price < 1.01}
                      onSelectCoupon={onSelectCoupon}
                      onSetPrice={onSetPrice}
                    />
                  ))}
                </div>
              </div>
            </div>
          </div>
        );
      })}
    </div>
  );
};

export default CouponSelectionLayout;
```
