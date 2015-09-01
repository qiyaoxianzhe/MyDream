--
-- Author: wanglei
-- Date: 2015-08-27 1:13:11
--

local Locationer = class("Locationer",System)
Locationer.TYPE = "LOCATIONER_TYPE"

function Locationer:onCreate(location)
	self.location_ = location
	local node = display.newNode()
	node:setAnchorPoint(cc.p(0.5,0.5))
	local x,y = self:locationToPosition(self.location_)
	node:setPosition(x,y)
	self:setNode(node)
end

function Locationer:locationToPosition(location)
	local x,y = (location.x - 1) * BattleCommonDefine.BLOCK_SIZE + BattleCommonDefine.BLOCK_SIZE / 2 , 
			(location.y - 1) * BattleCommonDefine.BLOCK_SIZE + BattleCommonDefine.BLOCK_SIZE / 2
	return x,y
end

function Locationer:getLocation()
	return self.location_
end

function Locationer:positionToLocation(position)
	local x,y = math.floor(position.x / BattleCommonDefine.BLOCK_SIZE) + 1, 
			math.floor(position.y / BattleCommonDefine.BLOCK_SIZE) + 1
	return x,y
end

return Locationer