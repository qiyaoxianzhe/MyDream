--
-- Author: wanglei
-- Date: 2015-09-02 0:21:11
--

local GameManager = class("GameManager")

function GameManager:ctor()
	self.resource_ = {}
end

function GameManager:getInstance()
	local o = GLOBAL_VAR.gameManager_
	if o then
		return o
	end
	o = GameManager.new()
	GLOBAL_VAR.gameManager_ = o
	return o
end

function GameManager:clean()
	GLOBAL_VAR.gameManager_ = nil
end

--131001 转向 131002 复活 131003 钥匙 131004英雄符文
function GameManager:addResource(resourcsType, resourcsNum)
	if not self.resource_[resourcsType] then
		self.resource_[resourcsType] = 0
	end
	self.resource_[resourcsType] = self.resource_[resourcsType] + 1
end

function GameManager:getResource(resourcsType)
	if not self.resource_[resourcsType] then
		self.resource_[resourcsType] = 0
	end
	return self.resource_[resourcsType]
end


return GameManager