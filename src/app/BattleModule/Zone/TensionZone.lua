--
-- Author: wanglei
-- Date: 2015-09-05 10:01:11
--

local TensionZone = class("TensionZone",Zone)
TensionZone.TYPE = "TTENSIONZONE_TYPE"

function TensionZone:onCreate(id, location)
	TensionZone.super.onCreate(self, id, location)
end

function TensionZone:getId()
	return self.id_
end

function TensionZone:hit(actor)
	local barriers = BattleManager:getBarrierManager():findBarrierByType(ConditionBarrier.TYPE)
	for k,v in pairs(barriers) do
		if BarrierVO.type[v:getId()] == BarrierVO.barrierType.enchantZone then
			v:open()
		end
	end
end

return TensionZone