有分 premium standard 等..不同package，
預設情境，這三種套組，分別對應不同面額跟折扣，
假設點選某個按鈕，可以領取該面額的折扣優惠卷。

這個切版主要是練習當後段傳回來的數據結構有達到三層，
而這個 options就類似假設你的帳號，有訂閱premium，
那你就會看到premium有關的折扣券，不論你是購買商品還是銷售商品，都會有。

這邊比較複雜的點，在購買區域跟銷售區域這兩個部分的切版，
因為你不能把每個優惠卷按鈕都同時一次顯示，
你需要分兩區，所以獨立出兩個陣列，一個是buyOptions，另一個是
sellOptions。

整理好的 sellOptions ,會是一個新的數組，我們再map
它，讓他單獨顯示優惠卷按鈕。


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
