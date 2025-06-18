
這樣的做法主要涉及以下幾個重要的 TypeScript 知識點：

1. 介面 (interface) 的擴展 (extends)  
   - 利用 extends 來繼承共用屬性，減少重複代碼，提高可維護性。
   - 例如：DailyCheckInItem、EventCheckInItem 和 SpecialCheckInItem 都繼承 BaseCheckInItem，共用 userId 屬性。

2. 物件型別 (type) 與鍵值映射 (keyof typeof)  
   - 透過 type CheckInData = { DAILY: DailyCheckInItem; EVENT: EventCheckInItem; SPECIAL: SpecialCheckInItem; } 來建立不同類型的映射結構。
   - keyof CheckInData 允許我們在函式中動態存取不同類型，例如 fetchCheckInData(checkInType: keyof typeof checkInTypeToApiParam, userId: string)。

3. 常量映射 (as const)  
   - const checkInTypeToApiParam = { DAILY: "dailycheckin", EVENT: "eventcheckin" } as const; 用 as const 讓 TypeScript 生成不可變的物件類型，確保 API 參數不會被修改。

4. 泛型 (Generics) 與類型安全回傳值  
   - fetchCheckInData 使用 Promise<CheckInData[keyof CheckInData]>，確保回傳值符合 CheckInData 定義，保持類型安全。

5. 條件判斷 (if 限制某些類型的請求)  
   - if (checkInType === "SPECIAL") return undefined as unknown as CheckInData["SPECIAL"]; 讓 SPECIAL 類型不發送 API 請求，模擬某些類型不需要請求的情境。

這些概念綜合運用，使得程式碼更具結構性、可擴展性和類型安全性，你覺得這樣的整理有幫助嗎？或者你有想深挖某個點的需求？

```
const checkInTypeToApiParam = {
  DAILY: "daily_checkin",
  EVENT: "event_checkin",
} as const;

const fetchCheckInData = async (checkInType: keyof typeof checkInTypeToApiParam, userId: string): Promise<CheckInData[keyof CheckInData]> => {
  if (checkInType === "SPECIAL") return undefined as unknown as CheckInData["SPECIAL"]; // 模擬不需要請求的類型

  const apiParam = checkInTypeToApiParam[checkInType];
  const res = await checkInRequest.get(
    `get-checkin-records/?user_id=${userId}&type=${apiParam}&t=${Date.now()}`
  );

  return res.data as CheckInData[keyof CheckInData];
};

// 使用範例
const dailyRecords: CheckInData["DAILY"] = await fetchCheckInData("DAILY", "U123456");
const eventRecords: CheckInData["EVENT"] = await fetchCheckInData("EVENT", "U789012");

console.log(dailyRecords, eventRecords);
```

```
// 定義基礎打卡類型
interface BaseCheckInItem {
  userId: string;
}

// DAILY 打卡類型
interface DailyCheckInItem extends BaseCheckInItem {
  records: DailyCheckInRecord[];
}

interface DailyCheckInRecord {
  date: string;
  location: string;
  method: string;
  details: CheckInDetails;
}

interface CheckInDetails {
  deviceInfo: string;
  ipAddress: string;
  verificationStatus: "Success" | "Failed";
}

// EVENT 打卡類型
interface EventCheckInItem extends BaseCheckInItem {
  records: EventCheckInRecord[];
}

interface EventCheckInRecord {
  eventId: string;
  name: string;
  checkInTime: string;
  location: string;
  attendees: AttendeeDetails[];
}

interface AttendeeDetails {
  userId: string;
  name: string;
  role: "Participant" | "Speaker" | "Organizer";
}

// SPECIAL 打卡類型
interface SpecialCheckInItem extends BaseCheckInItem {
  records: SpecialCheckInRecord[];
}

interface SpecialCheckInRecord {
  reason: string;
  rewardPoints: number;
  checkInDate: string;
  approvalDetails: ApprovalStatus;
}

interface ApprovalStatus {
  approverId: string;
  approverName: string;
  status: "Approved" | "Pending" | "Rejected";
}

// 定義 CheckInData 類型
type CheckInData = {
  DAILY: DailyCheckInItem;
  EVENT: EventCheckInItem;
  SPECIAL: SpecialCheckInItem;
};

// 假數據示例
const checkInData: CheckInData = {
  DAILY: {
    userId: "U123456",
    records: [
      {
        date: "2025-06-18",
        location: "Taipei Office",
        method: "QR Scan",
        details: {
          deviceInfo: "iPhone 14, iOS 18",
          ipAddress: "192.168.1.10",
          verificationStatus: "Success",
        },
      },
      {
        date: "2025-06-17",
        location: "Remote Work",
        method: "GPS Check-in",
        details: {
          deviceInfo: "MacBook Pro, macOS 15",
          ipAddress: "203.0.113.20",
          verificationStatus: "Failed",
        },
      },
    ],
  },
  EVENT: {
    userId: "U789012",
    records: [
      {
        eventId: "EVT001",
        name: "Tech Conference 2025",
        checkInTime: "10:30 AM",
        location: "Taipei Expo Center",
        attendees: [
          { userId: "U001", name: "Alice", role: "Participant" },
          { userId: "U002", name: "Bob", role: "Speaker" },
          { userId: "U003", name: "Charlie", role: "Organizer" },
        ],
      },
    ],
  },
  SPECIAL: {
    userId: "U345678",
    records: [
      {
        reason: "Anniversary Bonus",
        rewardPoints: 500,
        checkInDate: "2025-06-18",
        approvalDetails: {
          approverId: "A123",
          approverName: "Manager Lee",
          status: "Approved",
        },
      },
    ],
  },
};

console.log(checkInData);
```
