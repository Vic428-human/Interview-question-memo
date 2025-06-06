 <feTurbulence> 與 <feDisplacementMap> 兩個 SVG 濾鏡原件，製作出波浪扭曲的視覺效果。

```
<svg width="250" height="250" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <filter id="feDisplacementMapAndfeTurbulence">
      <feTurbulence 
        type="turbulence" 
        baseFrequency="0.05" 
        numOctaves="1" 
        result="turbulence" />
      <feDisplacementMap 
        in="SourceGraphic" 
        in2="turbulence" 
        scale="50" 
        xChannelSelector="R" 
        yChannelSelector="G" />
    </filter>
  </defs>
  <circle fill="#ff0000" cx="125" cy="125" r="100" filter="url(#feDisplacementMapAndfeTurbulence)" />
</svg>
```
各元素說明
### feTurbulence
功能：產生一張雜訊圖（類似雲或水波紋），可用於後續的扭曲效果。

常用屬性：

type：turbulence（預設）或 fractalNoise。fractalNoise 產生的雜訊較柔和一致，turbulence 則較為雜亂。

baseFrequency：決定雜訊圖的細緻程度。數值越小，圖案越大塊；數值越大，圖案越細碎。

numOctaves：疊加雜訊層數，數值越大，圖案越複雜。

result：給這個步驟命名，供後續濾鏡引用。

### feDisplacementMap
功能：根據另一張圖片（通常是雜訊圖）的像素值，將原圖的像素做空間上的位移，達到扭曲效果。

常用屬性：

in：要被扭曲的來源圖像（這裡是 SourceGraphic，即紅色圓形）。

in2：用來決定扭曲程度的參考圖像（這裡是上一步產生的 turbulence）。

scale：扭曲強度，數值越大，變形越明顯。

xChannelSelector / yChannelSelector：指定參考圖像的哪個色頻（R/G/B/A）用來決定 X/Y 方向的偏移量。

運作原理
產生雜訊圖
<feTurbulence> 產生一張雜訊圖，這張圖不會直接顯示出來，而是作為後續扭曲的參考依據。

像素扭曲
<feDisplacementMap> 會根據雜訊圖的像素值，將原圖（紅色圓形）的每個像素往不同方向移動，形成水波或扭曲的視覺效果。

其運算公式如下（簡化說明）：

新座標 = 原座標 + scale × (參考圖像的色頻值 - 0.5)

實作效果
你會看到紅色圓形被“扭曲”成水波紋狀，這是因為每個像素都根據雜訊圖被移動了。

調整 baseFrequency、scale、numOctaves 可以得到不同的扭曲風格。

常見應用
製作水波、雲霧、火焰等自然紋理特效

動畫過渡、偽 3D 扭曲

進階小提示
將 type="fractalNoise" 可讓扭曲更平滑。

xChannelSelector 與 yChannelSelector 可選不同色頻，產生不同方向的變形。

你可以用 <animate> 等方式讓 baseFrequency 或 scale 動態改變，做出動態扭曲效果。
