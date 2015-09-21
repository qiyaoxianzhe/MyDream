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

--复活130001 英雄符文130002 钥匙130003 火石130004 炮弹130005
function GameManager:setResource(resourcsType, resourcsNum)
	if not self.resource_[resourcsType] then
		self.resource_[resourcsType] = 0
	end
	self.resource_[resourcsType] = self.resource_[resourcsType] + resourcsNum
end

function GameManager:getResource(resourcsType)
	if not self.resource_[resourcsType] then
		self.resource_[resourcsType] = 0
	end
	return self.resource_[resourcsType]
end


return GameManager