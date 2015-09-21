--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local Actor = class("Actor",Locationer)
Actor.TYPE = "ACTOR_TYPE"

function Actor:onCreate(id, power, location)
	Actor.super.onCreate(self,location)
	self.ani_ = ActorAni.new(self.node_)
	self:addSysChild(self.ani_)
	self.attr_ = ActorAttr.new()
	self:addSysChild(self.attr_)
	self.id_ = id
	self.buffs_ = {}
	self:setValue(BattleCommonDefine.attribute.power, power)
end

function Actor:addBuff(buff)
	if self:getStatus() ~= ActorAttr.status.bati then
		self.buffs_[#self.buffs_ + 1] = buff
		self.ani_:setColor(BuffVO.color[buff:getId()])
	end
end

function Actor:getId()
	return self.id_
end

function Actor:transTo(location)
	self.location_.x, self.location_.y = location.x, location.y
	local x,y = self:locationToPosition(location)
	self.node_:setPosition(cc.p(x,y))
	self.ani_:trans()
	BattleManager:getCurrentRoom():updateBlock_()	
end

function Actor:doWithBarrier(barrier)
	barrier:hit(self)
	local dead = barrier:isDead()
	if dead or self:getStatus() == ActorAttr.status.qiangxi then
		barrier:disppear()
		return true
	end
	return false
end

function Actor:showHitNum(num,color)
	self.ani_:showHitNum(num,color)
end

function Actor:doWithBuff()
	local canMove = true
	local color = 7
	for i = #self.buffs_, 1, -1 do
		canMove = canMove and self.buffs_[i]:hit(self)
		local dead = self.buffs_[i]:isDead()
		if dead then
			table.remove(self.buffs_,i)
		else
			color = BuffVO.color[self.buffs_[i]:getId()]
		end
	end
	self.ani_:setColor(color)
	return canMove
end

function Actor:doWithZone(zone)
	zone:hit(self)
end

function Actor:doWithItem(item)
	GameManager:getInstance():setResource(item:getId(), 1)
	item:disppear()
	return true
end

function Actor:doWithStatus()
	local runes = GameManager:getInstance():getResource(130002)
	if runes <= 0 then
		self:setStatus(ActorAttr.status.none)
	else
		runes = runes - 1
	end
end

function Actor:setValue(attribute, value)
	self.attr_:setValue(attribute, value)
	if BattleCommonDefine.attribute.power == attribute then
		if value < 0 then
			BattleManager:getInstance():finishRoom(false)
		else
			BattleManager:getBattleUI():setPowerNum(value)
		end
	end
end

function Actor:getValue(attribute)
	return self.attr_:getValue(attribute)
end

function Actor:setStatus(status)
	self.attr_:setStatus(status)
	BattleManager:getBattleUI():setStatusName(status)
	self.ani_:setParticle(status)
end

function Actor:getStatus()
	return self.attr_:getStatus()
end

function Actor:ideal()
	self.ani_:ideal()
	BattleManager:getCurrentRoom():updateBlock_()	
end


function Actor:move(x,y,callBack)
	self.location_.x, self.location_.y = self.location_.x + x, self.location_.y + y
	local posX, posY = self:locationToPosition(cc.p(self.location_.x,self.location_.y))
	local seq = transition.sequence({
		cc.MoveTo:create(0.2, cc.p(posX + x, posY + y)),
		CCCallFunc:create(function()
			callBack()
		end),
	})
	self.node_:runAction(seq)
	self.ani_:run()
end

function Actor:onDeAttached()
	self.node_:removeFromParent()
end

return Actor