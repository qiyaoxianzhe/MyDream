--
-- Author: wanglei
-- Date: 2015-08-24 21:40:11
--

local BarrierManager = class("BarrierManager", System)

function BarrierManager:addBarrier(id, location)
	local barrier = Barrier.new(id, location)
	self:addSysChild(barrier)
	return barrier
end

function BarrierManager:getAllBarriers()
	return self:getSysChildren()
end

return BarrierManager