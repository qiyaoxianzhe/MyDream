--
-- Author: wanglei
-- Date: 2015-08-30 17:39:11
--

local ItemVO = {}

ItemVO.type = {
	stone = 1,
	runes = 2,
	key = 3,
}

ItemVO.id = {130001,130002,130003}

-- 复活石，符文，钥匙
ItemVO.type = {
	[130001] = 1,
	[130002] = 1,
	[130003] = 0,
}

ItemVO.count = {
	[130001] = 2,
	[130002] = 2,
	[130003] = 1,
}


return ItemVO