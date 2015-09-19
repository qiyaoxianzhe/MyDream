--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local BarrierAni = class("BarrierAni",System)
BarrierAni.TYPE = "BARRIERANI_TYPE"

function BarrierAni:onCreate(node)
	self:setNode(node)
	self.ani_ = display.newSprite("barrier/wall.png")
	node:addChild(self.ani_)
end

function BarrierAni:disppear()
	local seq = transition.sequence({
		cc.Spawn:create(cc.MoveBy:create(0.5, cc.p(0,30)), cc.FadeOut:create(0.5)),
		CCCallFunc:create(function()
			self.node_:removeFromParent()
		end),
	})
	self.ani_:runAction(seq)
end

return BarrierAni