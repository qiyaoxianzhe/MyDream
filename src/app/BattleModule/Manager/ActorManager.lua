--
-- Author: wanglei
-- Date: 2015-08-24 21:41:11
--

local ActorManager = class("ActorManager", System)

function ActorManager:addActor(id, location)
	local actor = Actor.new(id, location)
	self:addSysChild(actor)
	return actor
end

function ActorManager:getAllActors()
	return self:getSysChildren()
end

return ActorManager