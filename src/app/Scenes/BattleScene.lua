--
-- Author: wanglei
-- Date: 2015-08-24 21:45:11
--
local BattleScene = class("MainScene",function()
	return display.newScene(name)
end)

function BattleScene:ctor()
	printf("BattleScene:ctor:%s",tostring(self))
	--初始化battlemanager
	BattleManager:clean()
	self.battleManager_ = BattleManager:getInstance(self)
	self.battleManager_:onAttached()
	self:enableNodeEvents()
	self:scheduleUpdate(handler(self, self.update_))
end

function BattleScene:onEnter()
	printf("BattleScene:onEnter")
	self.battleManager_:beginGame()
end

function BattleScene:onExit()
end

function BattleScene:update_(t)
	self.battleManager_:update(t)
end

return BattleScene