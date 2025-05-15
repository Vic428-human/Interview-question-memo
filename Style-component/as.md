可以使用 `as` 屬性來改變組件所使用的標籤或基於的組件。
例如，一個以 `button` 為標籤的組件，
可以將其改為以 `a` 為標籤的組件。  

```
`;
还可以使用as属性来改变组件所使用的标签或则基于的组件，例如一个以button为标签的组件，我可以把它变成以a为标签的组件

const Button = styled.button`
  display: inline-block;
  color: palevioletred;
  font-size: 1em;
  margin: 1em;
  padding: 0.25em 1em;
  border: 2px solid palevioletred;
  border-radius: 3px;
`;

const TomatoButton = styled(Button)`
  color: tomato;
  border-color: tomato;
`;

render(
  <div>
    <Button>Normal Button</Button>
    <Button as="a" href="/">Link with Button styles</Button>
    <TomatoButton as="a" href="/">Link with Tomato Button styles</TomatoButton>
  </div>
);

```

as={ReversedButton}` 表示將 `Button` 
的底層標籤替換為 `ReversedButton`組件
```
const Button = styled.button`
  display: inline-block;
  color: palevioletred;
  font-size: 1em;
  margin: 1em;
  padding: 0.25em 1em;
  border: 2px solid palevioletred;
  border-radius: 3px;
`;

const ReversedButton = props => <button {...props} children={props.children.split('').reverse()} />

render(
  <div>
    <Button>Normal Button</Button>
    <Button as={ReversedButton}>Custom Button with Normal Button styles</Button>
  </div>
);

```

