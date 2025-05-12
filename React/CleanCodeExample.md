

多層if else 範例

錯誤

```
function processUser(user) {
  if (user != null) {
    if (user.hasSubscription) {
      if (user.age >= 18) {
        showFullVersion();
      } else {
        showChildrenVersion();
      }
    }
    // else {
    //   throw new Error('User needs a subscription');
    // }
  } else {
    throw new Error('No user found');
  }
}
```

優化
