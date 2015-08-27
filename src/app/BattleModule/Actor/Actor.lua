--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local Actor = class("Actor",Locationer)
Actor.TYPE = "ACTOR_TYPE"

function Actor:onCreate(location)
	Actor.super.onCreate(self,location)
	self.ani_ = ActoAni.new(self.node_)
	self:addSysChild(self.ani_)
	self.attr_ = ActorAttr.new()
	self:addSysChild(self.attr_)
end

function Actor:getStep()
	return self.attr_:getValue("step")
end

function Actor:move(x,y,step)
	BattleManager:getInstance():setMove(true)
	local offset = 5
	self.location_.x, self.location_.y = self.location_.x + x * step, self.location_.y + y * step
	local posX, posY = self:locationToPosition(cc.p(self.location_.x,self.location_.y))
	local seq = transition.sequence({
		cc.MoveTo:create(0.2 * step, cc.p(posX + x * offset, posY + y * offset)),
		cc.MoveTo:create(0.1, cc.p(posX + x, posY + y)),
		CCCallFunc:create(function()
			BattleManager:getInstance():setMove(false)
		end),
	})
	self.node_:runAction(seq)
end

return Actor