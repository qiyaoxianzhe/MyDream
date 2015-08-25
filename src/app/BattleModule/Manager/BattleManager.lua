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
	self:initRoomPanel_()
    self:initPlay_()
    self:initTouch_()
end

function BattleManager:initRoomPanel_()
	self.roomPanel_ = display.newLayer()
    self.battleScene_:addChild(self.roomPanel_)
    self.roomPanel_:setPosition(display.cx,display.cy)
end

function BattleManager:initPlay_()
end

function BattleManager:initTouch_()
	self.roomPanel_:setTouchEnabled(true)
    self.roomPanel_:registerScriptTouchHandler(handler(self,self.touch_))
end

function BattleManager:touch_(event,x,y)
	local direction = "ideal"
	if event == "began" then
		self.beginPox_ = cc.p(x,y)
		return true			
	elseif event == "moved" then
	elseif event == "ended" then
		self.endPox_ = cc.p(x,y)
		local pos = cc.pSub(self.endPox_,self.beginPox_)
		if math.abs(pos.x) > math.abs(pos.y) then
			if pos.x > 0 then
				direction = "right"
			else
				direction = "left"
			end
		else
			if pos.y > 0 then
				direction = "up"
			else
				direction = "down"
			end
		end
		self.beginPox_ = cc.p(0,0)
		self.endPox_ = cc.p(0,0)
		self:controlDirection(direction)
	end
end

function BattleManager:controlDirection(direction)
	--todo 增加控制逻辑 
	printf("direction : %s",direction)
end

function BattleManager:initUI_()
end

function BattleManager:beginBattle()
end

function BattleManager:onUpdate(t)
end

return BattleManager