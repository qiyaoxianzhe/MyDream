--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local Room = class("Room",System)
Room.TYPE = "ROOM_TYPE"


function Room:onCreate(roomPanel)
	self.blocks_ = {}
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
			self.blocks_[i.."_"..j] = 0 
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
		self.blocks_[location.x.."_"..location.y] = barrier:getType()
	end
	for k,actor in pairs(actors) do
		local location = actor:getLocation()
		self.blocks_[location.x.."_"..location.y] = actor:getType()
	end
	for k,item in pairs(items) do
		local location = item:getLocation()
		self.blocks_[location.x.."_"..location.y] = item:getType()
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

function Room:initPlayer_()
	-- todo 位置信息读表获取
	local location = cc.p(1,1) 
	local actor = BattleManager:getActorManager():addActor(location)
	self.roomPanel_:addChild(actor:getNode())
end

function Room:controlDirection(direction)

end

return Room