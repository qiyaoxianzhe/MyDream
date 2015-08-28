--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local Barrier = class("Barrier",Locationer)
Barrier.TYPE = "BARRIER_TYPE"

function Barrier:onCreate(location)
	Barrier.super.onCreate(self,location)
	self.ani_ = BarrierAni.new(self.node_)
	self:addSysChild(self.ani_)
end

return Barrier