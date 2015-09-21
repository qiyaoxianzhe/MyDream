--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local Room = class("Room",System)
Room.TYPE = "ROOM_TYPE"

Room.order = {
	terrain = 1,
	zone = 2,
	actor = 3,
	barrier = 3,
	item = 3,
}

function Room:onCreate(roomPanel,id)
	self.id_ = id
	self.blocks_ = {}
	self.actors_ = nil
	self.roomPanel_ = roomPanel
	self.isFinish_ = false
end

function Room:getId()
	return self.id_
end

function Room:initLocationer(id)
	self.id_ = id
	self:initTerrain_()
	self:initBarrier_()
	self:initItem_()
	self:initPlayer_()
	self:initZone_()
	self:updateBlock_()
end

function Room:initTerrain_()
	local terriain = display.newSprite(RoomVO.terrain[self.id_])
	self.roomPanel_:addChild(terriain, Room.order.terrain)
	local size = self.roomPanel_:getContentSize()
	terriain:setPosition(cc.p(size.width / 2, size.height / 2))
end

function Room:initBlock_()
	for i = 1, BattleCommonDefine.BLOCK_WIDTH do
		for j = 1, BattleCommonDefine.BLOCK_HEIGHT do
			self.blocks_[i.."_"..j] = nil 
		end
	end
end

function Room:getBlocks()
	return self.blocks_
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
	local barriersMap = RoomVO.barrier[self.id_]
	for i = 1, #barriersMap do
		local location = cc.p(barriersMap[i].x,barriersMap[i].y) 
		local barrier = BattleManager:getBarrierManager():addBarrier(barriersMap[i].id, location)
		self.roomPanel_:addChild(barrier:getNode(), Room.order.barrier)
	end
end

function Room:initItem_()
	-- todo 位置信息读表获取
	local itemsMap = RoomVO.item[self.id_]
	for i = 1, #itemsMap do
		local location = cc.p(itemsMap[i].x,itemsMap[i].y) 
		local item = BattleManager:getItemManager():addItem(itemsMap[i].id, location)
		self.roomPanel_:addChild(item:getNode(), Room.order.item)
	end
end

function Room:initZone_()
	-- todo 位置信息读表获取
	local zonesMap = RoomVO.zone[self.id_]
	for i = 1, #zonesMap do
		local location = cc.p(zonesMap[i].x,zonesMap[i].y) 
		local zone = BattleManager:getZoneManager():addZone(zonesMap[i].id, location)
		self.roomPanel_:addChild(zone:getNode(), Room.order.zone)
	end
end

function Room:isEmpty(x,y)
	if not self.blocks_[x.."_"..y] and x <= BattleCommonDefine.BLOCK_WIDTH and x >= 1 and 
			y <= BattleCommonDefine.BLOCK_HEIGHT and y >= 1 then
		return true
	end
	return false
end

function Room:checkRunBlock(x,y)
	if x > BattleCommonDefine.BLOCK_WIDTH or x < 1 or y > BattleCommonDefine.BLOCK_HEIGHT or y < 1 then
		return false
	end
	local actor = self:getActor_()
	if self.blocks_[x.."_"..y] then
		local type, name = self.blocks_[x.."_"..y].type, self.blocks_[x.."_"..y].name
		if type == common.Type.Barrier then
			local barrier = BattleManager:getBarrierManager():getSysChild(name)
			return actor:doWithBarrier(barrier)
		elseif type == common.Type.Item then
			local item = BattleManager:getItemManager():getSysChild(name)
			return actor:doWithItem(item)
		end
	end
	if actor:getStatus() == ActorAttr.status.wanxiang then
		for i = 1, #BattleCommonDefine.area do
			local area = BattleCommonDefine.area
			if self.blocks_[area[i].x + x.."_"..area[i].y + y] then
				local type, name = self.blocks_[area[i].x + x.."_"..area[i].y + y].type, self.blocks_[area[i].x + x.."_"..area[i].y + y].name
				if type == common.Type.Item then
					local item = BattleManager:getItemManager():getSysChild(name)
					actor:doWithItem(item)
				end
			end
		end
	end
	return true
end

function Room:checkStopZone(x,y)
	local type, name = self.blocks_[x.."_"..y].type, self.blocks_[x.."_"..y].name
	local actor = self:getActor_()
	if type == common.Type.Zone then
		local zone = BattleManager:getZoneManager():getSysChild(name)
		actor:doWithZone(zone)
	end
end

function Room:initPlayer_()
	-- todo 位置信息读表获取
	local actorsMap = RoomVO.actor[self.id_]
	for i = 1, #actorsMap do
		local location = cc.p(actorsMap[i].x,actorsMap[i].y) 
		local actor = BattleManager:getActorManager():addActor(actorsMap[i].id, actorsMap[i].power, location)
		self.actors_ = actor
		self.roomPanel_:addChild(actor:getNode(), Room.order.actor)
	end
end

function Room:barriersMove()
	local barriers = BattleManager:getBarrierManager():getAllBarriers()
	for k, barrier in pairs(barriers) do
		local x, y = BarrierVO.velocity[barrier:getId()].x, BarrierVO.velocity[barrier:getId()].y
		local checkX,checkY = barrier:getLocation().x + x, barrier:getLocation().y + y
		if x ~= 0 or y ~= 0 then
			local step = BarrierVO.step[barrier:getId()]
			if self:isEmpty(checkX, checkY) then
				barrier:move(x,y)
			end
		end
	end
end

function Room:getActor_()
	return self.actors_
end

function Room:calulatDirection8(angle)
	local vectory = cc.p(0,0)
	if angle < 23 or angle >= 337 then
		vectory.x = 1
	elseif angle < 68 and angle >= 23 then
		vectory.x = 1
		vectory.y = 1
	elseif angle < 113 and angle >= 68 then
		vectory.y = 1
	elseif angle < 158 and angle >= 113 then
		vectory.x = -1
		vectory.y = 1
	elseif angle < 203 and angle >= 158 then
		vectory.x = -1
	elseif angle < 248 and angle >= 203 then
		vectory.x = -1
		vectory.y = -1
	elseif angle < 293 and angle >= 248 then
		vectory.y = -1
	elseif angle < 337 and angle >= 293 then
		vectory.x = 1
		vectory.y = -1
	end
	return vectory
end

function Room:calulatDirection4(angle)
	local vectory = cc.p(0,0)
	if angle < 45 or angle >= 315 then
		vectory.x = 1
	elseif angle < 135 and angle >= 45 then
		vectory.y = 1
	elseif angle < 225 and angle >= 135 then
		vectory.x = -1
	elseif angle < 315 and angle >= 225 then
		vectory.y = -1
	end
	return vectory
end

function Room:controlDirection(angle)
	local actor = self:getActor_()
	local power = actor:getStatus() == ActorAttr.status.shenxing and 0.5 or 1
	local currentPower = actor:getValue(BattleCommonDefine.attribute.power) - power
	actor:setValue(BattleCommonDefine.attribute.power,currentPower)
	actor:doWithStatus()
	local canMove = actor:doWithBuff()
	if not canMove then
		return
	end
	local location = actor:getLocation()
	local vectory = cc.p(0,0)
	if actor:getStatus() == ActorAttr.status.tianqi then
		vectory = self:calulatDirection8(angle)
	else
		vectory = self:calulatDirection4(angle)
	end
	BattleManager:getInstance():setMove(true)
	self:moveActor(vectory)
end

function Room:moveActor(vectory)
	local actor = self:getActor_()
	local location = actor:getLocation()
	if self:checkRunBlock(location.x + vectory.x, location.y + vectory.y) then
		actor:move(vectory.x, vectory.y, function()
			self:moveActor(vectory)
		end)
	else
		actor:ideal()
		BattleManager:getBarrierManager():checkTension(actor:getValue(BattleCommonDefine.attribute.power))
		BattleManager:getCurrentRoom():checkStopZone(actor:getLocation().x, actor:getLocation().y)
		self:barriersMove()
		BattleManager:getInstance():setMove(false)
	end
end

function Room:finish(isWin)
	print("finishfinish")
	self.resultUI_ = ResultUI.new("ResultUI",display.size,isWin)
	BattleManager:getInstance():getBattleScene():addChild(self.resultUI_:getView())
end

return Room