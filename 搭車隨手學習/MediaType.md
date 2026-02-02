1. application/x-www-form-urlencoded

· 最常見的表單提交格式
· 資料會像 URL 查詢字串一樣被編碼：name1=value1&name2=value2
· 特殊字元和空格會被轉換（如空格變 +，中文變 %XX）
· 適合：純文字、小型資料、無檔案上傳的情況
· 範例：username=John&password=12345

2. multipart/form-data

· 用於包含檔案上傳的表單
· 資料被分成多個「部分」，每部分有自己的標頭和內容
· 不會對資料進行編碼，適合傳送二進位檔案（圖片、文件等）
· 適合：需要上傳檔案的表單
· 範例：表單中同時有文字欄位和上傳的圖片

3. text/plain

· 純文字格式
· 資料以純文字形式傳送，不進行編碼
· 格式為：name1=value1 換行 name2=value2
· 較少使用，某些舊瀏覽器支援
· 適合：簡單的除錯或測試
