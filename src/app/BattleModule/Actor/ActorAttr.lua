--
-- Author: wanglei
-- Date: 2015-08-28 0:27:11
--

local ActorAttr = class("ActorAttr",System)
ActorAttr.TYPE = "ACTORATTR_TYPE"

function ActorAttr:onCreate()
	self.config_ = {
		["step"] = 1
	}
end

function ActorAttr:getValue(property)
	return self.config_[property]
end

return ActorAttr