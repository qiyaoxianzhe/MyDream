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
end

function Barrier:getId()
	return self.id_
end

function Barrier:isDead()
	local dead = false
	if self.hitCount_ ~= -1 then
		self.hitCount_ = self.hitCount_ - 1
		if self.hitCount_ <= 0 then
			dead = true
		end
	end
	return dead
end

function Barrier:hit(actor)
end

function Barrier:disppear()
	self:removeFromSysParent()
	BattleManager:getCurrentRoom():updateBlock_()	
end

function Barrier:onDeAttached()
	self.ani_:disppear()
end


return Barrier