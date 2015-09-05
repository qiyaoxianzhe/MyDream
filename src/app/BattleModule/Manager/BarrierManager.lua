--
-- Author: wanglei
-- Date: 2015-08-24 21:40:11
--

local BarrierManager = class("BarrierManager", System)

function BarrierManager:addBarrier(id, location)
	local barrier = self:createBarrier(id, location)
	self:addSysChild(barrier)
	return barrier
end

function BarrierManager:findBarrierByType(type)
	local barriers = {}
	for k, v in pairs(self:getSysChildren()) do
		if v:getType() == type then
			barriers[#barriers + 1] = v
		end
	end
	return barriers
end

function BarrierManager:createBarrier(id, location)
	local barrier = nil
	if BarrierVO.type[id] == BarrierVO.barrierType.soldier then
		barrier = NormalBarrier.new(id, location)
	elseif BarrierVO.type[id] == BarrierVO.barrierType.poison then
		barrier = PoisonBarrier.new(id, location)
	elseif BarrierVO.type[id] == BarrierVO.barrierType.tension then
		barrier = TensionBarrier.new(id, location)
	elseif BarrierVO.type[id] == BarrierVO.barrierType.enchantment then
		barrier = ConditionBarrier.new(id, location)
	elseif BarrierVO.type[id] == BarrierVO.barrierType.wall then
		barrier = WallBarrier.new(id, location)
	end
	return barrier
end

function BarrierManager:getAllBarriers()
	return self:getSysChildren()
end

return BarrierManager