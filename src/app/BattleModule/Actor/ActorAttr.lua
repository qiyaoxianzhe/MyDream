--
-- Author: wanglei
-- Date: 2015-08-28 0:27:11
--

local ActorAttr = class("ActorAttr",System)
ActorAttr.TYPE = "ACTORATTR_TYPE"

function ActorAttr:onCreate()
	self.config_ = {
		[BattleCommonDefine.attribute.step] = 7
	}
end

function ActorAttr:getValue(attribute)
	return self.config_[attribute]
end

function ActorAttr:setValue(attribute,value)
	self.config_[attribute] = value
end

return ActorAttr