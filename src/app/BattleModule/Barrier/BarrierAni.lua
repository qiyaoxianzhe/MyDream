--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local BarrierAni = class("BarrierAni",System)
BarrierAni.TYPE = "BARRIERANI_TYPE"

function BarrierAni:onCreate(node)
	self:setNode(node)
	self.ani_ = display.newSprite("barrier/Barrier_tieqiu.png")
	node:addChild(self.ani_)
end

return BarrierAni