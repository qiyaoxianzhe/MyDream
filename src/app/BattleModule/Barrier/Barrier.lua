--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local Barrier = class("Barrier",Locationer)
Barrier.TYPE = "BARRIER_TYPE"

function Barrier:onCreate(id, location)
	Barrier.super.onCreate(self,location)
	self.ani_ = BarrierAni.new(self.node_)
	self:addSysChild(self.ani_)
	self.id_ = id
	self.hitCount_ = BarrierVO.hitCount[id]
	self.direction_ = 1
end

function Barrier:changeDirection()
	self.direction_ = self.direction_ * -1
end

function Barrier:getDirection()
	return self.direction_ 
end

function Barrier:getId()
	return self.id_
end

function Barrier:isDead()
	local isDead = false
	if self.hitCount_ ~= -1 then
		self.hitCount_ = self.hitCount_ - 1
		if self.hitCount_ <= 0 then
			isDead = true
		end
	end
	return isDead
end

function Barrier:hit(actor)
end

function Barrier:move(x,y,step)
	self.location_.x, self.location_.y = self.location_.x + x * step, self.location_.y + y * step
	local posX, posY = self:locationToPosition(cc.p(self.location_.x,self.location_.y))
	self.node_:runAction(cc.MoveTo:create(0.2 * step, cc.p(posX + x, posY + y)))
	BattleManager:getCurrentRoom():updateBlock_()	
end

function Barrier:disppear()
	self:removeFromSysParent()
	BattleManager:getCurrentRoom():updateBlock_()	
end

function Barrier:onDeAttached()
	self.ani_:disppear()
end


return Barrier