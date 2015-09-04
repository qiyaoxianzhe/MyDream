--
-- Author: wanglei
-- Date: 2015-08-30 17:39:11
--

local ItemVO = {}

ItemVO.type = {
	snake = 1,
	stone = 2,
	runes = 3,
	key = 4,
}

ItemVO.id = {130001,130002,130003,130004}

-- 转向蛇，复活石，符文，结界，墙
ItemVO.type = {
	[130001] = 1,
	[130002] = 1,
	[130003] = 0,
	[130004] = 0,
}

ItemVO.count = {
	[130001] = 2,
	[130002] = 2,
	[130003] = 1,
	[130004] = 1,
}


return ItemVO