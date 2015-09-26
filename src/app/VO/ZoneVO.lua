--
-- Author: wanglei
-- Date: 2015-09-04 16:19:11
--

local ZoneVO = {}

-- 冰，毒，英雄剑士，英雄战士，英雄法师，英雄游侠，英雄圣骑，传送，出口，结界开关，炮台，篝火
ZoneVO.zoneType = {
	fronzen = 1,
	poison = 2,
	saber = 3,
	berserker = 4,
	caster = 5,
	assassin = 6,
	knight = 7,
	trans = 8,
	exit = 9,
	tension = 10,
	artillery = 11,
	bonfire = 12,
}

ZoneVO.id = {150001,150002,150003,150004,150005,150006,150007,150008,150009,150010,150011,150012}

ZoneVO.hitCount = {
	[150001] = 2,
	[150002] = 2,
	[150003] = 1,
	[150004] = 1,
	[150005] = 1,
	[150006] = 1,
	[150007] = 1,
	[150008] = -1,
	[150009] = -1,
	[150010] = -1,
	[150011] = -1,
	[150012] = -1,
}

ZoneVO.velocity = {
	[150001] = {x = 0, y = 0},
	[150002] = {x = 0, y = 0},
	[150003] = {x = 0, y = 0},
	[150004] = {x = 0, y = 0},
	[150005] = {x = 0, y = 0},
	[150006] = {x = 0, y = 0},
	[150007] = {x = 0, y = 0},
	[150008] = {x = 0, y = 0},
	[150009] = {x = 0, y = 0},
	[150010] = {x = 0, y = 0},
	[150011] = {x = 0, y = 1},
	[150012] = {x = -1, y = 0},
}

ZoneVO.type = {
	[150001] = 1,
	[150002] = 2,
	[150003] = 3,
	[150004] = 4,
	[150005] = 5,
	[150006] = 6,
	[150007] = 7,
	[150008] = 8,
	[150009] = 9,
	[150010] = 10,
	[150011] = 11,
	[150012] = 11,
}

return ZoneVO