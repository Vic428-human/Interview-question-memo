does not exist on type 'EventTarget'.ts(2339)

```
function handleChange(event: Event) {
  const target = event.target as HTMLInputElement;
  console.log(target.value); // Correctly accesses the value property
}
```



