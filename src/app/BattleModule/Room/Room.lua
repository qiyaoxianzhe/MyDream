--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local Room = class("Room",System)
Room.TYPE = "ROOM_TYPE"

Room.order = {
	terrain = 1,
	actor = 2,
	barrier = 2,
	item = 2,
	zone = 3,
}

function Room:onCreate(roomPanel,id)
	self.id_ = id
	self.blocks_ = {}
	self.actors_ = {}
	self.roomPanel_ = roomPanel
end

function Room:getId()
	return self.id_
end

function Room:initLocationer()
	self:initTerrain_()
	self:initBarrier_()
	self:initItem_()
	self:initPlayer_()
	self:initZone_()
	self:updateBlock_()
end

function Room:initTerrain_()
	local terriain = display.newSprite(MapVO.terrain[self.id_])
	self.roomPanel_:addChild(terriain, Room.order.terrain)
	local size = self.roomPanel_:getContentSize()
	terriain:setPosition(cc.p(size.width / 2, size.height / 2))
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
	local zones = BattleManager:getZoneManager():getAllZones()
	for k,barrier in pairs(barriers) do
		local location = barrier:getLocation()
		self.blocks_[location.x.."_"..location.y] = {type = common.getLocationerType(barrier:getId()), name = tostring(barrier)}
	end
	for k,actor in pairs(actors) do
		local location = actor:getLocation()
		self.blocks_[location.x.."_"..location.y] = {type = common.getLocationerType(actor:getId()), name = tostring(actor)}
	end
	for k,item in pairs(items) do
		local location = item:getLocation()
		self.blocks_[location.x.."_"..location.y] = {type = common.getLocationerType(item:getId()), name = tostring(item)}
	end
	for k,zone in pairs(zones) do
		local location = zone:getLocation()
		self.blocks_[location.x.."_"..location.y] = {type = common.getLocationerType(zone:getId()), name = tostring(zone)}
	end
end

function Room:initBarrier_()
	-- todo 位置信息读表获取
	local barriersMap = MapVO.barrier[self.id_]
	for i = 1, #barriersMap do
		local location = cc.p(barriersMap[i].x,barriersMap[i].y) 
		local barrier = BattleManager:getBarrierManager():addBarrier(barriersMap[i].id, location)
		self.roomPanel_:addChild(barrier:getNode(), Room.order.barrier)
	end
end

function Room:initItem_()
	-- todo 位置信息读表获取
	local itemsMap = MapVO.item[self.id_]
	for i = 1, #itemsMap do
		local location = cc.p(itemsMap[i].x,itemsMap[i].y) 
		local item = BattleManager:getItemManager():addItem(itemsMap[i].id, location)
		self.roomPanel_:addChild(item:getNode(), Room.order.item)
	end
end

function Room:initZone_()
	-- todo 位置信息读表获取
	local zonesMap = MapVO.zone[self.id_]
	for i = 1, #zonesMap do
		local location = cc.p(zonesMap[i].x,zonesMap[i].y) 
		local zone = BattleManager:getZoneManager():addZone(zonesMap[i].id, location)
		self.roomPanel_:addChild(zone:getNode(), Room.order.zone)
	end
end

function Room:checkRunBlock(x,y)
	if x > BattleCommonDefine.BLOCK_WIDTH or x < 1 or y > BattleCommonDefine.BLOCK_HEIGHT or y < 1 then
		return false
	end
	local type, name = self.blocks_[x.."_"..y].type, self.blocks_[x.."_"..y].name
	local actor = self:getActor_(1)
	if type == common.Type.Barrier then
		local barrier = BattleManager:getBarrierManager():getSysChild(name)
		return actor:doWithBarrier(barrier)
	elseif type == common.Type.Item then
		local item = BattleManager:getItemManager():getSysChild(name)
		return actor:doWithItem(item)
	end
	return true
end

function Room:checkStopZone(x,y)
	local type, name = self.blocks_[x.."_"..y].type, self.blocks_[x.."_"..y].name
	local actor = self:getActor_(1)
	if type == common.Type.Zone then
		local zone = BattleManager:getZoneManager():getSysChild(name)
		return actor:doWithZone(zone)
	end
end

function Room:initPlayer_()
	-- todo 位置信息读表获取
	local actorsMap = MapVO.actor[self.id_]
	for i = 1, #actorsMap do
		local location = cc.p(actorsMap[i].x,actorsMap[i].y) 
		local actor = BattleManager:getActorManager():addActor(actorsMap[i].id, actorsMap[i].power, location)
		self.actors_[#self.actors_ + 1] = actor
		self.roomPanel_:addChild(actor:getNode(), Room.order.actor)
	end
end

function Room:getActor_(index)
	return self.actors_[index or 1]
end

function Room:controlDirection(direction)
	local actor = self:getActor_(1)
	local allStep = actor:getValue(BattleCommonDefine.attribute.step)
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
		if self:checkRunBlock(location.x + vectory.x * (step + 1), location.y + vectory.y * (step + 1)) then
			step = step + 1
		else
			break
		end
	end
	if step <= 0 then
		return
	end
	local currentPower = actor:getValue(BattleCommonDefine.attribute.power)
	actor:setValue(BattleCommonDefine.attribute.power,currentPower - 1)
	if currentPower <= 0 then
		self:gameOver_()
	else
		actor:move(vectory.x, vectory.y, step)
		self:updateBlock_()	
	end
end

function Room:finish()
	--TODO
	print("finish room")
end

function Room:transition(actor)
	--TODO
	print("transition actor")
end

function Room:gameOver_()
	BattleManager:getInstance():setMove(true)
end

return Room