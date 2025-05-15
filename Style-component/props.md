如果是使用 styled.html 標籤，那麼在使用所得的元件時，可以傳遞已知的 HTML 屬性給它，這些屬性將會被傳遞到 DOM 中。

DefaultValue 會被傳遞到真實的 DOM 中並被渲染，但是 inputColor 不是已知的 HTML 屬性，所以不能被渲染。


```
const Input = styled.input`
  padding: 0.5em;
  margin: 0.5em;
  color: ${props => props.inputColor || "palevioletred"};
  background: papayawhip;
  border: none;
  border-radius: 3px;
`;

// Render a styled text input with the standard input color, and one with a custom input color
render(
  <div>
    <Input defaultValue="@probablyup" type="text" />
    <Input defaultValue="@geelen" type="text" inputColor="rebeccapurple" />
  </div>
);
```


當我們使用透過自訂方式得到的元件時，如果傳入 props（屬性），可以在元件內部取得這些屬性。每個屬性值都可以是一個函式（function），而這個函式的參數就是傳入的 props。


```
const Button = styled.button`
  /* Adapt the colors based on primary prop */
  background: ${props => props.primary ? "palevioletred" : "white"};
  color: ${props => props.primary ? "white" : "palevioletred"};

  font-size: 1em;
  margin: 1em;
  padding: 0.25em 1em;
  border: 2px solid palevioletred;
  border-radius: 3px;
`;

render(
  <div>
    <Button>Normal</Button>
    <Button primary>Primary</Button>
  </div>
);
```
