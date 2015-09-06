--
-- Author: wanglei
-- Date: 2015-08-28 0:27:11
--

local ActorAttr = class("ActorAttr",System)
ActorAttr.TYPE = "ACTORATTR_TYPE"

--人物状态，不可叠加

--霸体，强袭，万象，神行，圣洁
ActorAttr.status = {
	bati = 1,
	qiangxi = 2,
	wangxiang = 3,
	shengxing = 4,
	shengjie = 5,
}

function ActorAttr:setStatus(status)
	self.status_ = status
end

function ActorAttr:getStatus()
	return self.status_
end


function ActorAttr:onCreate()
	self.status_ = 0
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
	if BattleCommonDefine.attribute.power == attribute then
		BattleManager:getBattleUI():setPowerNum(value)
	end
end

return ActorAttr