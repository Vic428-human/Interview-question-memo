- `fetch(url)` **本身返回一個 Promise**，表示網絡請求的結果（成功或失敗）。
- `await fetch(url)` 會等待 **該 Promise 完成**，並返回 `Response` 物件。
- `await response.json()` 也是一個 **異步操作**，因為 `.json()`
- 會解析回傳的 JSON 資料，也會返回一個 Promise。

```
// Promises in Javascript
// Ques 8 - Rewrite this example code using `async/await`
// instead of `.then/catch`

async function loadJson(url) {
    let response = await fetch(url);

    if (response.status == 200) {
        let json = await response.json();
        return json;
    }

    throw new Error(response.status);
}

loadJson("https://fakeurl.com/no-such-user.json")
    .catch(console.log);
```
