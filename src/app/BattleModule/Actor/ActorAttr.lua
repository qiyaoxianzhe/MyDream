--
-- Author: wanglei
-- Date: 2015-08-28 0:27:11
--

local ActorAttr = class("ActorAttr",System)
ActorAttr.TYPE = "ACTORATTR_TYPE"

--人物状态，不可叠加

--霸体，强袭，万象，神行，奇智
ActorAttr.status = {
	none = 1,
	bati = 2,
	qiangxi = 3,
	wanxiang = 4,
	shenxing = 5,
	tianqi = 6,
}

ActorAttr.statusName = {
	[1] = "普通",
	[2] = "霸体",
	[3] = "强袭",
	[4] = "万象",
	[5] = "神行",
	[6] = "天启",
}

function ActorAttr:setStatus(status)
	self.status_ = status
end

function ActorAttr:getStatus()
	return self.status_
end


function ActorAttr:onCreate()
	self.status_ = ActorAttr.status.none
	self.config_ = {
		[BattleCommonDefine.attribute.step] = 20,
		[BattleCommonDefine.attribute.power] = 20,
	}
end

function ActorAttr:getValue(attribute)
	return self.config_[attribute]
end

function ActorAttr:setValue(attribute,value)
	self.config_[attribute] = value
end

return ActorAttr