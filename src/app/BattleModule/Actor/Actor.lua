--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local Actor = class("Actor",Locationer)
Actor.TYPE = "ACTOR_TYPE"

function Actor:onCreate(id, power, location)
	Actor.super.onCreate(self,location)
	self.ani_ = ActoAni.new(self.node_)
	self:addSysChild(self.ani_)
	self.attr_ = ActorAttr.new()
	self:addSysChild(self.attr_)
	self.id_ = id
	self:setValue(BattleCommonDefine.attribute.power, power)
end

function Actor:getId()
	return self.id_
end

function Actor:doWithBarrier(barrier)
	local dead = barrier:hit(self)
	if dead then
		barrier:disppear()
	end
	return false
end

function Actor:doWithZone(zone)
	zone:hit(self)
end

function Actor:doWithItem(item)
	GameManager:getInstance():addResource(item:getId(), 1)
	item:disppear()
	return true
end

function Actor:setValue(attribute, value)
	self.attr_:setValue(attribute, value)
end

function Actor:getValue(attribute)
	return self.attr_:getValue(attribute)
end

function Actor:setStatus(status)
	self.attr_:setStatus(status)
end

function Actor:getStatus()
	return self.attr_:getStatus()
end


function Actor:move(x,y,step)
	BattleManager:getInstance():setMove(true)
	local offset = 5
	self.location_.x, self.location_.y = self.location_.x + x * step, self.location_.y + y * step
	local posX, posY = self:locationToPosition(cc.p(self.location_.x,self.location_.y))
	local seq = transition.sequence({
		cc.EaseElasticOut:create(cc.MoveTo:create(0.2 * step, cc.p(posX + x, posY + y)),0.2 * step),
		CCCallFunc:create(function()
			self.ani_:ideal()
			BattleManager:getCurrentRoom():checkStopZone(self.location_.x, self.location_.y)
			BattleManager:getInstance():setMove(false)
		end),
	})
	self.node_:runAction(seq)
	self.ani_:run()
end

return Actor