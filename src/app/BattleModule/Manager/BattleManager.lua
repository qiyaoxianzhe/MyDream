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

function BattleManager:getActorManager()
	local o = BattleManager:getInstance()
	return o.actorManager_
end

function BattleManager:getItemManager()
	local o = BattleManager:getInstance()
	return o.itemManager_
end

function BattleManager:getCurrentRomm()
	local o = BattleManager:getInstance()
	return o.room_
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
    self.isMove_ = false
    self.barrierManager_ = BarrierManager.new()
    self.actorManager_ = ActorManager.new()
    self.itemManager_ = ItemManager.new()
    self:addSysChild(self.barrierManager_)
    self:addSysChild(self.actorManager_)
    self:addSysChild(self.itemManager_)
	self:initRoomPanel_()
	self:initRoom_()
    self:initTouch_()
end

function BattleManager:isMove()
	return self.isMove_
end

function BattleManager:setMove(isMove)
	self.isMove_ = isMove
end

function BattleManager:initRoom_()
	self.room_ = Room.new(self.roomPanel_)
	self:addSysChild(self.room_)
end

function BattleManager:initRoomPanel_()
	self.roomPanel_ = cc.LayerColor:create(cc.c4b(100, 100, 100, 255),BattleCommonDefine.ROOM_WIDTH,BattleCommonDefine.ROOM_HEIGHT)
    self.battleScene_:addChild(self.roomPanel_)
    self.roomPanel_:ignoreAnchorPointForPosition(false)
    self.roomPanel_:setAnchorPoint(cc.p(0.5,0.5))
    self.roomPanel_:setPosition(display.cx,display.cy)
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
				direction = BattleCommonDefine.DIRECTION_RIGHT
			else
				direction = BattleCommonDefine.DIRECTION_LEFT
			end
		else
			if pos.y > 0 then
				direction = BattleCommonDefine.DIRECTION_UP
			else
				direction = BattleCommonDefine.DIRECTION_DOWN
			end
		end
		self.beginPox_ = cc.p(0,0)
		self.endPox_ = cc.p(0,0)
		self:controlDirection(direction)
	end
end

function BattleManager:controlDirection(direction)
	--todo 增加控制逻辑 
	printf("direction : %d",direction)
	if self.room_ and not self.isMove_ then
		self.room_:controlDirection(direction)
	end
end

function BattleManager:initUI_()
end

function BattleManager:beginGame()
	self.room_:initLocationer()
end

function BattleManager:onUpdate(t)
end

return BattleManager