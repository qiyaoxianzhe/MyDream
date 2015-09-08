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

function BattleManager:getZoneManager()
	local o = BattleManager:getInstance()
	return o.zoneManager_
end

function BattleManager:getBuffManager()
	local o = BattleManager:getInstance()
	return o.buffManager_
end

function BattleManager:getCurrentRoom()
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
    self.buffManager_ = BuffManager.new()
    self.zoneManager_ = ZoneManager.new()
    self:addSysChild(self.barrierManager_)
    self:addSysChild(self.actorManager_)
    self:addSysChild(self.itemManager_)
    self:addSysChild(self.buffManager_)
    self:addSysChild(self.zoneManager_)
	self:initRoomPanel_()
	self:initRoom_()
    self:initTouch_()
    self:initUI_()
    self:initShowdow_()
end

function BattleManager:isMove()
	return self.isMove_
end

function BattleManager:setMove(isMove)
	self.isMove_ = isMove
end

function BattleManager:initRoom_()
	--TODO 设计关卡
	self.room_ = Room.new(self.roomPanel_, 110001)
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

function BattleManager:initShowdow_()
	self.showdow_ = display.newLayer()
	self.showdow_.cloud = display.newSprite("shadow/cloud.png")
	self.showdow_.cloud:setPosition(cc.p(display.cx,display.cy))
	self.showdow_.cloud:setOpacity(0)
	self.showdow_.cloud:setVisible(false)
	self.showdow_:addChild(self.showdow_.cloud)
	self.battleScene_:addChild(self.showdow_)
end

function BattleManager:closeShowdow_(hasAnimation,callback)
	self.roomPanel_:setTouchEnabled(false)
	self.showdow_.cloud:setVisible(true)
	if hasAnimation then
		self.showdow_.cloud:runAction(transition.sequence({cc.FadeIn:create(0.5),
			CCCallFunc:create(function()
				self.showdow_.cloud:setVisible(true)
				self.roomPanel_:setTouchEnabled(false)
				if callback then
					callback()
				end
			end)}))
	else
		self.showdow_.cloud:setOpacity(255)
		self.showdow_.cloud:setVisible(true)
		self.roomPanel_:setTouchEnabled(false)
		if callback then
			callback()
		end
	end
end

function BattleManager:openShowdow_(hasAnimation,callback)
	self.roomPanel_:setTouchEnabled(false)
	self.showdow_.cloud:setVisible(true)
	if hasAnimation then
		self.showdow_.cloud:runAction(transition.sequence({
			cc.DelayTime:create(0.5),
			cc.FadeOut:create(0.5),
			CCCallFunc:create(function()
				self.showdow_.cloud:setVisible(false)
				self.roomPanel_:setTouchEnabled(true)
				if callback then
					callback()
				end
			end)}))
	else
		self.showdow_.cloud:setOpacity(0)
		self.showdow_.cloud:setVisible(false)
		self.roomPanel_:setTouchEnabled(true)
		if callback then
			callback()
		end
	end
end

-- function BattleManager:initShowdow_()
-- 	self.showdow_ = display.newLayer()
-- 	self.showdow_:setContentSize(display.size)
-- 	self.showdow_.left_ = display.newSprite("shadow/cloud.png")
-- 	self.showdow_.right_ = display.newSprite("shadow/cloud.png")
-- 	self.showdow_.left_:setPosition(cc.p(display.left,display.cy))
-- 	self.showdow_.right_:setPosition(cc.p(display.right,display.cy))
-- 	self.showdow_:addChild(self.showdow_.left_)
-- 	self.showdow_:addChild(self.showdow_.right_)
-- 	self.showdow_:setVisible(false)
-- 	self.battleScene_:addChild(self.showdow_)
-- end

-- function BattleManager:closeShowdow_(hasAnimation)
-- 	self.showdow_:setVisible(true)
-- 	self.roomPanel_:setTouchEnabled(false)
-- 	if hasAnimation then
-- 		self.showdow_.left_:runAction(transition.sequence({cc.MoveTo:create(1, cc.p(display.cx, display.cy)),
-- 			CCCallFunc:create(function()
-- 			end)}))
-- 		self.showdow_.right_:runAction(transition.sequence({cc.MoveTo:create(1, cc.p(display.cx, display.cy)),
-- 			CCCallFunc:create(function()
-- 			end)}))
-- 	else
-- 		self.showdow_.left_:setPosition(cc.p(display.cx,display.cy))
-- 		self.showdow_.right_:setPosition(cc.p(display.cx,display.cy))
-- 	end
-- end

-- function BattleManager:openShowdow_(hasAnimation)
-- 	self.showdow_:setVisible(true)
-- 	self.roomPanel_:setTouchEnabled(false)
-- 	if hasAnimation then
-- 		self.showdow_.left_:runAction(transition.sequence({cc.MoveTo:create(1, cc.p(- display.width / 2, display.cy)),
-- 			CCCallFunc:create(function()
-- 				self.showdow_:setVisible(false)
-- 				self.roomPanel_:setTouchEnabled(true)
-- 			end)}))
-- 		self.showdow_.right_:runAction(transition.sequence({cc.MoveTo:create(1, cc.p(3 * display.width / 2, display.cy)),
-- 			CCCallFunc:create(function()
-- 				self.showdow_:setVisible(false)
-- 				self.roomPanel_:setTouchEnabled(true)
-- 			end)}))
-- 	else
-- 		self.showdow_.left_:setPosition(cc.p(display.left,display.cy))
-- 		self.showdow_.right:setPosition(cc.p(display.right,display.cy))
-- 		self.showdow_:setVisible(false)
-- 		self.roomPanel_:setTouchEnabled(true)
-- 	end
-- end

function BattleManager:touch_(event,x,y)
	local direction = nil
	if event == "began" then
		self.beginPox_ = cc.p(x,y)
		return true			
	elseif event == "moved" then
	elseif event == "ended" then
		self.endPox_ = cc.p(x,y)
		local pos = cc.pSub(self.endPox_,self.beginPox_)
		local angle = math.deg(cc.pToAngleSelf(pos))
		if angle < 0 then
			angle = angle + 360
		end
		self.beginPox_ = cc.p(0,0)
		self.endPox_ = cc.p(0,0)
		self:controlDirection(angle)
	end
end

function BattleManager:controlDirection(angle)
	--todo 增加控制逻辑 
	printf("angle : %d",angle)
	if self.room_ and not self.isMove_ then
		self.room_:controlDirection(angle)
	end
end

function BattleManager:initUI_()
	self.battleUI_ = BattleUI.new("BattleUI",display.size)
	self.battleScene_:addChild(self.battleUI_:getView())
end

function BattleManager:beginGame()
	self:closeShowdow_(false,function()
		self:openShowdow_(true)
	end)
	self.room_:initLocationer()
end

function BattleManager:onUpdate(t)
end

return BattleManager