
### 為什麼前端會傳 ISO 格式的日期給後端？

因為 JavaScript 的 Date 物件有一個 .toISOString() 方法，它會將日期轉成上面這種格式。
前端通常會用這個方法把日期轉成字串再送到後端，確保時間資訊不會因為時區而混淆。

這個字串代表：

```
2016-04-06T22:35:11.540Z
```

2016-04-06：年-月-日
T：分隔日期與時間的部分
22:35:11.540：時:分:秒.毫秒
Z：表示這是 UTC 時間（也就是時區為 +0 的時間）


### 假設這是前端傳來的數據
```
{
  "value": "2016-04-06T22:35:11.540Z",
}
```

### 在後端的應用中如何處理？
你在 Mongoose 裡面設定了 value 是 Mixed 型別，所以你可以儲存各種類型的值，
因為沒有定義類型的數據類型。下面這些都能存：

- 字串（String）
- 數字（Number）
- 日期物件（Date）

#### 當你收到一個請求，裡面的 value 是 ISO 格式的字串，例如：

```
const MetaSchema = new mongoose.Schema({
  value: {type: mongoose.Schema.Types.Mixed}, // 後端db schema收到的 value規格不限定格式
});

const Meta = mongoose.model("Meta", MetaSchema);

module.exports = Meta;
```

用 markModified() 來更新資料文檔，
```
Meta.markModified('value')
```

