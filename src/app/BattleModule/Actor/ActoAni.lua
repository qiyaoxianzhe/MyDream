--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local ActoAni = class("ActoAni",System)
ActoAni.TYPE = "ACTORANI_TYPE"

function ActoAni:onCreate(node)
	self:setNode(node)
	self.ani_ = display.newSprite("actor/tiny.png")
	node:addChild(self.ani_)
	self:ideal()
end

function ActoAni:run()
	self.ani_:stopAllActions()
end

function ActoAni:ideal()
	self.ani_:setPosition(cc.p(0,0))
	local seq = transition.sequence({
    	cc.MoveBy:create(0.15, cc.p(0, 5)),
    	cc.MoveBy:create(0.15,cc.p(0, -5)),
    })
    self.ani_:runAction(cc.RepeatForever:create(seq))
end

function ActoAni:setColor(color)
	self.ani_:setColor(color)
end

return ActoAni