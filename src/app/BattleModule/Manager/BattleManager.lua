--
-- Author: wanglei
-- Date: 2015-08-24 21:41:11
--

local BattleManager = class("BattleManager", System)
BattleManager.TYPE = "BATTLE_MANAGER"

function BattleManager:getInstance(battleScene)
	local o = GLOBAL_VAR.battleManager_
	if o then
		return o
	end
	if battleScene then
		o = BattleManager.new(battleScene)
		GLOBAL_VAR.battleManager_ = o
		return o
	end
end

function BattleManager:getBarrierManager()
	local o = BattleManager:getInstance()
	return o.barrierManager_
end

function BattleManager:getEnemyManager()
	local o = BattleManager:getInstance()
	return o.enemyManager_
end

function BattleManager:getBattleUI()
	local o = BattleManager:getInstance()
	return o.battleUI_
end

function BattleManager:clean()
	GLOBAL_VAR.battleManager_ = nil
end

function BattleManager:onCreate(battleScene)
    printf("BattleManager:onCreate")
	self.battleScene_ = battleScene
end

function BattleManager:initUI_()
end

function BattleManager:beginBattle()
end

function BattleManager:onUpdate(t)
end

return BattleManager