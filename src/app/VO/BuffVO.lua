--
-- Author: wanglei
-- Date: 2015-09-04 16:23:11
--

local BuffVO = {}

-- 冰，毒
BuffVO.type = {
	frozen = 1,
	poison = 2,
}

BuffVO.id = {140001,140002}

BuffVO.type = {
	[140001] = 1,
	[140002] = 2,
}

-- 数值
BuffVO.value = {
	[140001] = 0,
	[140002] = -1,
}

--持续时间
BuffVO.lastTime = {
	[140001] = 1,
	[140002] = 2,
}


return BuffVO