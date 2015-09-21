--
-- Author: wanglei
-- Date: 2015-09-21 17:57:13
--

local ArtilleryZone = class("ArtilleryZone",Zone)
ArtilleryZone.TYPE = "ARTILLERYZONE_TYPE"

function ArtilleryZone:onCreate(id, location)
	ArtilleryZone.super.onCreate(self, id, location)
	self.isCheck_ = false
end

function ArtilleryZone:getId()
	return self.id_
end

function ArtilleryZone:isCheck()
	return self.isCheck_
end

function ArtilleryZone:hit(actor)
	self.isCheck_ = true
	local key = GameManager:getInstance():getResource(130005)
	if key <= 0 then
		return
	else
		GameManager:getInstance():setResource(130003,-1)
	end

	local checkX,checkY = self.location_.x, self.location_.y
	local block = BattleManager:getInstance():getCurrentRoom():getBlocks()
	local init,step,condition,direction = 0,0,0,0
	if ZoneVO.velocity[self.id_].x > 0 then
		init,step,condition,direction = 1,1,BattleCommonDefine.BLOCK_WIDTH,0
	elseif ZoneVO.velocity[self.id_].x < 0 then
		init,step,condition,direction = BattleCommonDefine.BLOCK_WIDTH,-1,0,0
	elseif ZoneVO.velocity[self.id_].y > 0 then
		init,step,condition,direction = 1,1,BattleCommonDefine.BLOCK_HEIGHT,1
	elseif ZoneVO.velocity[self.id_].y < 0 then
		init,step,condition,direction = BattleCommonDefine.BLOCK_HEIGHT,-1,0,1
	end

	for i = init, condition, step do
		if direction == 1 then
			checkX, checkY = checkX, checkY + step
		else
			checkX, checkY = checkX + step, checkY
		end
		if block[checkX.."_"..checkY] then
			local type, name = block[checkX.."_"..checkY].type, block[checkX.."_"..checkY].name
			if type == common.Type.Barrier then
				local barrier = BattleManager:getBarrierManager():getSysChild(name)
				if BarrierVO.type[barrier:getId()] == BarrierVO.barrierType.soldier or 
					BarrierVO.type[barrier:getId()] == BarrierVO.barrierType.wall then
					barrier:disppear()
					break
				end
			elseif type == common.Type.Zone then
				local zone = BattleManager:getZoneManager():getSysChild(name)
				if ZoneVO.type[zone:getId()] == ZoneVO.zoneType.artillery then
					if not zone:isCheck() then
						zone:hit(actor)
					end
				end
			end
		end
	end
	self.isCheck_ = false
end

return ArtilleryZone