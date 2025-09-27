查詢技能ID
https://ro-rnai.github.io/plainTextEditor/

FollowDis=2
MoveDelay=500
RadiusAggr=12


-- 前面的{64,128,0,256,0,0,-1,-1}是預設模式(被動)
-- 後面的{50,200,-800,25,30,-45,-1,1}是切換後的模式(主動)
SearchMode={{64,128,0,256,0,0,-1,-1},{200,50,0,25,30,0,-1,1}}

-- {50,200,-800,25,30,-45,-1,1}共有8個數字用逗號分開，依序為
-- {主人被打,生命體被打,其他玩家被打,主人攻擊,生命體攻擊,其他玩家攻擊,範圍外,範圍內}
-- 假設今天怪物A在範圍內(搜尋半徑內)會得到1點的分數
-- 如果怪物A正在攻擊生命體，這時候他會得到200點的分數(這時1+200=201分)
-- 另外同時間怪物B也在範圍內，且正在攻擊主人，這時怪物B的分數是51分(1+50)
-- 所以生命體會以怪物A為對象去攻擊(分數最高)
-- ※如果最後分數是負的就不攻擊
SearchSetting=SearchMode[2] --剛招喚生命體(傭兵)時載入被動模式；如果想要先載入主動模式可以將 1 改成 2
WeakTargets={}  --這是不使用技能的魔物ID清單，魔物ID可以查詢RO幻想廳等網站(這個設定只對生命體有效)

Skill={}

Skill[#Skill+1]={} --新增一組技能
Skill[#Skill].id=0  -- id=0, 是普通攻擊
Skill[#Skill].lv=1
Skill[#Skill].target=0
Skill[#Skill].when=1
Skill[#Skill].times=1
Skill[#Skill].delay=0 -- 普通攻擊沒有延遲問題
Skill[#Skill].sp={0,100}
Skill[#Skill].nMyEnemy=0
Skill[#Skill].nOwnerEnemy=0
Skill[#Skill].nRangeEnemy=0
Skill[#Skill].chase=1
Skill[#Skill].stemp=0
Skill[#Skill].count=0

Skill[#Skill+1]={}
Skill[#Skill].id=8014 --施展 混亂的祈福 可以幫自己補血
Skill[#Skill].lv=5
Skill[#Skill].target=0
Skill[#Skill].when=1
Skill[#Skill].times=1
Skill[#Skill].delay=5000 -- 這邊不能設定0，會導致技能放不出來
Skill[#Skill].sp={0,100}
Skill[#Skill].nMyEnemy=0
Skill[#Skill].nOwnerEnemy=0
Skill[#Skill].nRangeEnemy=0
Skill[#Skill].chase=1
Skill[#Skill].stemp=0
Skill[#Skill].count=0

Skill[#Skill+1]={}
Skill[#Skill].id=8013 -- 施展 善變，可以隨機施放法師一轉技能
Skill[#Skill].lv=5
Skill[#Skill].target=0
Skill[#Skill].when=1
Skill[#Skill].times=1
Skill[#Skill].delay=1000 -- 這邊不能設定0，會導致技能放不出來
Skill[#Skill].sp={20,100}
Skill[#Skill].nMyEnemy=0
Skill[#Skill].nOwnerEnemy=0
Skill[#Skill].nRangeEnemy=0
Skill[#Skill].chase=1
Skill[#Skill].stemp=0
Skill[#Skill].count=0 

