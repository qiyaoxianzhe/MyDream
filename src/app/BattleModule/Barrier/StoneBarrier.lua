--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local StoneBarrier = class("StoneBarrier",Barrier)
StoneBarrier.TYPE = "STONEBARRIER_TYPE"

function StoneBarrier:onCreate(id, location)
	WallBarrier.super.onCreate(self, id, location)
end

function StoneBarrier:getId()
	return self.id_
end

function StoneBarrier:hit(actor)
	local actorLocation = actor:getLocation()
	local x,y = 0,0
	if actorLocation.x < self.location_.x then
		x,y = 1,0
	elseif actorLocation.x > self.location_.x then
		x,y = -1,0
	elseif actorLocation.y < self.location_.y then
		x,y = 0,1
	elseif actorLocation.y > self.location_.y then
		x,y = 0,-1
	end
	if BattleManager:getInstance():getCurrentRoom():isEmpty(self.location_.x + x, self.location_.y + y) then
		self:move(x,y)
	end
end

return StoneBarrier