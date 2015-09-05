--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local ActorAni = class("ActorAni",System)
ActorAni.TYPE = "ACTORANI_TYPE"

function ActorAni:onCreate(node)
	self:setNode(node)
	self.ani_ = display.newSprite("actor/tiny.png")
	node:addChild(self.ani_)
	self:ideal()
end

function ActorAni:run()
	self.ani_:stopAllActions()
end

function ActorAni:trans()
	self.ani_:setOpacity(0)
    self.ani_:runAction(cc.FadeIn:create(0.5))
end

function ActorAni:ideal()
	self.ani_:setPosition(cc.p(0,0))
	local seq = transition.sequence({
    	cc.MoveBy:create(0.15, cc.p(0, 5)),
    	cc.MoveBy:create(0.15,cc.p(0, -5)),
    })
    self.ani_:runAction(cc.RepeatForever:create(seq))
end

function ActorAni:setColor(color)
	self.ani_:setColor(color)
end

return ActorAni