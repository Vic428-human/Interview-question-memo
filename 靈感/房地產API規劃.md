

### 先在網路上找有公開的csv檔案

### 把csv檔案讀取資料，並且寫入數據庫
```
var mysql = require('mysql');
var connection = mysql.createConnection({
  host: 'localhost',
  user: '你的帳號',
  password: '你的密碼',
  database: '你的資料庫'
});
connection.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});

```

```
// Import the data from the csv with these columns: Date,RegionName,AreaCode,AveragePrice,Index
const data = fs.readFileSync('UK-HPI.csv', 'utf8');
const rows = data.split('\n');
const columns = ['Date', 'RegionName', 'AreaCode', 'AveragePrice', 'Index'];

// Create the columns string
const values = rows.slice(1).map(row => {
  let columnsInRow = row.split(',');
  if (columnsInRow.length !== columns.length) {
    console.error(`Row ${i} has incorrect number of columns.`);
    return null;
  }

  // Convert the date format
  const dateParts = columnsInRow[0].split('/');
  columnsInRow[0] = `${dateParts[1]}-${dateParts[0]}`;
  
  // Replace empty strings with null
  columnsInRow = columnsInRow.map(column => column === '' ? null : column);
  return columnsInRow;
}).filter(Boolean);

// The rest of your code...
const query = `INSERT INTO house_prices (${columns.join(',')}) VALUES ?`;

// Batch insert the data in batches of 1000
const batchSize = 1000;
for (let i = 0; i < values.length; i += batchSize) {
  const batch = values.slice(i, i + batchSize);
  connection.query(query, [batch], (error, results) => {
    if (error) {
      console.error(error);
    } else {
      console.log('Data imported successfully.');
    }
  });
}

connection.end();

```
