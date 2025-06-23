
資料可能來自於任一層（但多數從上層 API 而來），如果不想讓資料「經過很多中間層的 props 傳遞」，
而只想讓「某一層以下的子孫使用」，那麼這層就可以用 Context.Provider，
定向地開放資料給後代組件。

而且共用的資料可能會有多個子孫組件剛好需要用到，
contextProvider另一個好處是，能透過這一層去判斷，
只有那些子組件之下的孫子組件的都共用了這些context。

---

🧠 假設場景：

> 後台頁面要顯示「用戶列表（User List）」，從 API 拿到資料後，傳遞到需要的 table component。

---

📍 最上層頁面：AdminDashboard.jsx

```
export default function AdminDashboard() {
  const { data: allUserList } = useQuery({
    queryKey: ['userList', 'apiFetchAllUsers', i18n.language],
    queryFn: () => apiFetchAllUsers({ language: i18n.language }),
    enabled: true,
  });

  return (
    <UserTableContainer userList={allUserList} viewMode="detailed" />
  );
}
```

---

📍 中層容器組件：UserTableContainer.jsx

```
function UserTableContainer({ userList, viewMode }) {
  return (
    <>
      {viewMode === 'detailed' && <DetailedUserTable userList={userList} />}
      {viewMode === 'summary' && <SummaryUserTable data={userList} />}
    </>
  );
}
```
---

📍 使用 Context 傳遞資料：DetailedUserTable.jsx

```
import { UserContext } from './UserContext';

const DetailedUserTable = ({ userList }) => {
  return (
    <UserContext.Provider value={{ userList: userList ?? [] }}>
      <UserTable />
      <UserStatsPanel />
    </UserContext.Provider>
  );
};

```
---

📍 更底層組件：UserTable.jsx / UserStatsPanel.jsx
```
✅ 子組件模擬：UserTable

// UserTable.jsx
import React, { useContext } from 'react';
import { UserContext } from './UserContext';

const UserTable = () => {
  const { userList } = useContext(UserContext);

  return (
    <div className="p-4">
      <h2 className="text-lg font-bold mb-2">User Table</h2>
      <table className="w-full border-collapse border border-gray-300">
        <thead>
          <tr className="bg-gray-100">
            <th className="border p-2">ID</th>
            <th className="border p-2">Name</th>
            <th className="border p-2">Email</th>
            <th className="border p-2">Role</th>
          </tr>
        </thead>
        <tbody>
          {userList?.map((user) => (
            <tr key={user.id}>
              <td className="border p-2">{user.id}</td>
              <td className="border p-2">{user.name}</td>
              <td className="border p-2">{user.email}</td>
              <td className="border p-2">{user.role}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default UserTable;

```
```
✅ 子組件模擬：UserStatsPanel

// UserStatsPanel.jsx
import React, { useContext } from 'react';
import { UserContext } from './UserContext';

const UserStatsPanel = () => {
  const { userList } = useContext(UserContext);

  const totalUsers = userList?.length ?? 0;
  const adminCount = userList?.filter((user) => user.role === 'admin').length ?? 0;
  const guestCount = userList?.filter((user) => user.role === 'guest').length ?? 0;

  return (
    <div className="p-4 mt-4 bg-blue-50 rounded">
      <h2 className="text-lg font-bold mb-2">User Statistics</h2>
      <ul className="list-disc ml-5">
        <li>Total Users: {totalUsers}</li>
        <li>Admins: {adminCount}</li>
        <li>Guests: {guestCount}</li>
      </ul>
    </div>
  );
};

export default UserStatsPanel;

```
---

✅ Context 建立檔案：UserContext.js
```
import { createContext } from 'react';
export const UserContext = createContext({});

```
---
