--
-- Author: wanglei
-- Date: 2015-08-30 17:39:11
--

local BarrierVO = {}

-- 士兵，毒，回弹，结界，墙
BarrierVO.barrierType = {
	soldier = 1,
	poison = 2,
	tension = 3,
	enchantment = 4,
	wall = 5,
}

BarrierVO.id = {120001,120002,120003,120004,120005}

BarrierVO.hitCount = {
	[120001] = 2,
	[120002] = 2,
	[120003] = 2,
	[120004] = -1,
	[120005] = -1,
}

BarrierVO.type = {
	[120001] = 1,
	[120002] = 2,
	[120003] = 3,
	[120004] = 4,
	[120005] = 5,
}

-- 数值
BarrierVO.value = {
	[120001] = 2,
	[120002] = -1,
	[120003] = 3,
	[120004] = -1,
	[120005] = -1,
}


return BarrierVO