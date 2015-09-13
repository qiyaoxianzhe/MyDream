--
-- Author: wanglei
-- Date: 2015-09-13 00:55:11
--

local Map = class("Map",System)
Map.TYPE = "MAP_TYPE"

function Map:onCreate(mapPanel,id)
	self.mapPanel_ = mapPanel
	self.id_ = id
	self.actorLocation_ = cc.p(0,0)
	self.roomIds_ = {}
end

function Map:getId()
	return self.id_
end

function Map:initMap(id)
	self.id_ = id
	self:initRoom_()
	self:initActor_(1,2)
end

function Map:initActor_(x,y)
	self.actorLocation_.x = x 
	self.actorLocation_.y = y
	self.actor_ = display.newSprite("actor/tiny.png")
	local seq = transition.sequence({
    	cc.MoveBy:create(0.15, cc.p(0, 5)),
    	cc.MoveBy:create(0.15,cc.p(0, -5)),
    })
    self.actor_:runAction(cc.RepeatForever:create(seq))
	self.mapPanel_:addChild(self.actor_)
	local posX,posY = self:locationToPosition(cc.p(self.actorLocation_.x,self.actorLocation_.y))
	self.actor_:setPosition(cc.p(posX, posY))
end

function Map:initRoom_()
	for i = 1, #MapVO.room[self.id_] do
		local room = display.newSprite("map/room1.png")
		local x,y = self:locationToPosition(cc.p(MapVO.room[self.id_][i].x,MapVO.room[self.id_][i].y))
		self.mapPanel_:addChild(room)
		room:setPosition(cc.p(x,y))
		self.roomIds_[MapVO.room[self.id_][i].x.."_"..MapVO.room[self.id_][i].y] = MapVO.room[self.id_][i].id
	end
end

function Map:locationToPosition(location)
	local x,y = (location.x - 1) * BattleCommonDefine.MAP_SIZE + BattleCommonDefine.MAP_SIZE / 2 , 
			(location.y - 1) * BattleCommonDefine.MAP_SIZE + BattleCommonDefine.MAP_SIZE / 2
	return x,y
end

function Map:positionToLocation(position)
	local x,y = math.floor(position.x / BattleCommonDefine.BLOCK_SIZE) + 1, 
			math.floor(position.y / BattleCommonDefine.BLOCK_SIZE) + 1
	return x,y
end

function Map:enterRoom()
	local roomId = self.roomIds_[self.actorLocation_.x.."_"..self.actorLocation_.y]
	if roomId then
		BattleManager:getInstance():clearMap()
		BattleManager:getInstance():enterRoom(roomId)
	end
end

function Map:controlDirection(angle)
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
	local x = math.max(math.min(self.actorLocation_.x + vectory.x,6),1)
	local y = math.max(math.min(self.actorLocation_.y + vectory.y,3),1)
	if not self.roomIds_[x.."_"..y] then
		return
	end
	if x == self.actorLocation_.x and y == self.actorLocation_.y then
		return
	end
	local posX,posY = self:locationToPosition(cc.p(x,y))
	self.actorLocation_.x = x 
	self.actorLocation_.y = y
	local seq = transition.sequence({
		cc.MoveTo:create(0.2, cc.p(posX, posY)),
		cc.DelayTime:create(0.5),
		CCCallFunc:create(function()
			self:enterRoom()
		end),
	})
	self.actor_:runAction(seq)
end

return Map