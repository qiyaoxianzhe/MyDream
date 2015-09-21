--
-- Author: wanglei
-- Date: 2015-08-30 17:39:11
--

local ItemVO = {}

ItemVO.type = {
	stone = 1,
	runes = 2,
	key = 3,
	fire = 4,
	bullet = 5,
}

ItemVO.id = {130001,130002,130003,130004,130005}

-- 复活石，符文，钥匙，火石，炮弹
ItemVO.type = {
	[130001] = 1,
	[130002] = 2,
	[130003] = 3,
	[130004] = 4,
	[130005] = 5,
}

ItemVO.count = {
	[130001] = 1,
	[130002] = 1,
	[130003] = 1,
	[130004] = 1,
	[130005] = 1,
}


return ItemVO