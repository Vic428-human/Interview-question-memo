
### 問題描述: 
> 通常我們想修改 svg 的顏色會透 fill 方式給予顏色
> 但如果SVG本身是作為src給img tag，上層的img並不會把fill傳給svg，
>即使 用inline style 也沒效，變成只能寫死在svg檔案本身的屬性，但這樣不實際
>所以遇到可能全局更改SVG顏色的情況，就不要直接透過img另外包一層了。


```
      <img src={`./src/assets/${iconName}.svg`} alt={'ffff'} style={{ width: 24, height: 24}}  />
```
