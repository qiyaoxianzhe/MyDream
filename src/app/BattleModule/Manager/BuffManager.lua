--
-- Author: wanglei
-- Date: 2015-08-30 16:39:11
--

local BuffManager = class("BuffManager", System)

function BuffManager:addBuff(id)
	local buff = Buff.new(id)
	self:onBuffAdd()
	self:addSysChild(buff)
	return buff
end

function BuffManager:onBuffAdd(buff)
end

function BuffManager:removeBuff(buff)
	self:onBuffRemove()
	self:removeSysChild(buff)
end

function BuffManager:onBuffRemove(buff)
end

function BuffManager:getAllBuff()
	return self:getSysChildren()
end

function BuffManager:addBuff()
	local buff = Buff.new()
	self:addSysChild(buff)
	return buff
end

return BuffManager