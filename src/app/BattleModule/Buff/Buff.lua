--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local Buff = class("Buff",System)
Buff.TYPE = "BUFF_TYPE"

function Buff:onCreate(id)	
	self.id_ = id
	self.lastTime_ = BuffVO.lastTime[id]
end

function Buff:getId()
	return self.id_
end

function Buff:hit(actor)
	return true
end

function Buff:isDead()
	local dead = false
	self.lastTime_ = self.lastTime_ - 1
	if self.lastTime_ <= 0 then
		dead = true
	end
	return dead
end

return Buff