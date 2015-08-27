--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local Room = class("Room",System)
Room.TYPE = "ROOM_TYPE"


function Room:onCreate(roomPanel)
	self.blocks_ = {}
	self.actors_ = {}
	self.roomPanel_ = roomPanel
end

function Room:initLocationer()
	self:initBarrier_()
	self:initItem_()
	self:initPlayer_()
	self:updateBlock_()
end

function Room:initBlock_()
	for i = 1, BattleCommonDefine.BLOCK_WIDTH do
		for j = 1, BattleCommonDefine.BLOCK_HEIGHT do
			self.blocks_[i.."_"..j] = "0" 
		end
	end
end

function Room:updateBlock_()
	self:initBlock_()
	local barriers = BattleManager:getBarrierManager():getAllBarriers()
	local actors = BattleManager:getActorManager():getAllActors()
	local items = BattleManager:getItemManager():getAllItems()
	for k,barrier in pairs(barriers) do
		local location = barrier:getLocation()
		self.blocks_[location.x.."_"..location.y] = tostring(barrier)
	end
	for k,actor in pairs(actors) do
		local location = actor:getLocation()
		self.blocks_[location.x.."_"..location.y] = tostring(actor)
	end
	for k,item in pairs(items) do
		local location = item:getLocation()
		self.blocks_[location.x.."_"..location.y] = tostring(item)
	end
end

function Room:initBarrier_()
	-- todo 位置信息读表获取
	local location = cc.p(5,5) 
	local barrier = BattleManager:getBarrierManager():addBarrier(location)
	self.roomPanel_:addChild(barrier:getNode())
end

function Room:initItem_()
	-- todo 位置信息读表获取
	local location = cc.p(6,5) 
	local item = BattleManager:getItemManager():addItem(location)
	self.roomPanel_:addChild(item:getNode())
end

function Room:checkBlock(x,y)
	if x > BattleCommonDefine.BLOCK_WIDTH or x < 1 or y > BattleCommonDefine.BLOCK_HEIGHT or y < 1 then
		return false
	end
	return true
end

function Room:initPlayer_()
	-- todo 位置信息读表获取
	local location = cc.p(1,1) 
	local actor = BattleManager:getActorManager():addActor(location)
	self.actors_[#self.actors_ + 1] = actor
	self.roomPanel_:addChild(actor:getNode())
end

function Room:getActor(index)
	return self.actors_[index or 1]
end

function Room:controlDirection(direction)
	local actor = self:getActor(1)
	local allStep = actor:getStep()
	local location = actor:getLocation()
	local vectory = cc.p(0,0)
	local step = 0
	for i = 1,allStep do
		if direction == BattleCommonDefine.DIRECTION_LEFT then
			vectory.x = -1
		elseif direction == BattleCommonDefine.DIRECTION_RIGHT then
			vectory.x = 1
		elseif direction == BattleCommonDefine.DIRECTION_UP then
			vectory.y = 1
		elseif direction == BattleCommonDefine.DIRECTION_DOWN then
			vectory.y = -1
		end
		if self:checkBlock(location.x + vectory.x * (step + 1), location.y + vectory.y * (step + 1)) then
			step = step + 1
		else
			break
		end
	end
	actor:move(vectory.x, vectory.y, step)
	self:updateBlock_()	
end

return Room