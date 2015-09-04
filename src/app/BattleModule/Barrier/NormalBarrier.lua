--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local NormalBarrier = class("NormalBarrier",Barrier)
NormalBarrier.TYPE = "NORMALBARRIER_TYPE"

function NormalBarrier:onCreate(id, location)
	NormalBarrier.super.onCreate(self, id, location)
end

function NormalBarrier:getId()
	return self.id_
end

function NormalBarrier:hit(actor)
	local currentPower = actor:getValue(BattleCommonDefine.attribute.power)
	actor:setValue(BattleCommonDefine.attribute.power,currentPower - BarrierVO.value[self:getId()])
	return NormalBarrier.super.hit(self,ator)
end

return NormalBarrier