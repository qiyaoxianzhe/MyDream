--
-- Author: wanglei
-- Date: 2015-09-05 14:03:11
--

local PoisonBuff = class("PoisonBuff",Buff)
PoisonBuff.TYPE = "POSISONBUFF_TYPE"

function PoisonBuff:hit(actor)
	local currentPower = actor:getValue(BattleCommonDefine.attribute.power)
	actor:setValue(BattleCommonDefine.attribute.power,currentPower + BuffVO.value[self:getId()])
	return true
end

return PoisonBuff