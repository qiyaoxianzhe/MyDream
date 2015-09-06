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
	enchantBarrier = 4,
	enchantPower = 5,
	enchantZone = 6,
	wall = 7,
}

-- 结界类型 清楚指定人数敌人消失 剩余指定步数消失
BarrierVO.enchatmentType = {
	barrier = 1,
    step = 2,
    zone = 3,
}

BarrierVO.id = {120001,120002,120003,120004,120005,120006,120007}

BarrierVO.hitCount = {
	[120001] = 2,
	[120002] = 2,
	[120003] = 2,
	[120004] = -1,
	[120005] = -1,
	[120006] = -1,
	[120007] = -1,
}

BarrierVO.type = {
	[120001] = 1,
	[120002] = 2,
	[120003] = 3,
	[120004] = 4,
	[120005] = 5,
	[120006] = 6,
	[120007] = 7,
}

-- 数值
BarrierVO.value = {
	[120001] = -2,
	[120002] = 0,
	[120003] = -3,
	[120004] = 13,
	[120005] = 19,
	[120006] = 150010,
	[120007] = 0,
}


return BarrierVO