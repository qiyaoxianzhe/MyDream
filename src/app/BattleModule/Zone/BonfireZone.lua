--
-- Author: wanglei
-- Date: 2015-09-21 17:57:11
--

local BonfireZone = class("BonfireZone",Zone)
BonfireZone.TYPE = "BONFIREZONE_TYPE"

function BonfireZone:onCreate(id, location)
	BonfireZone.super.onCreate(self, id, location)
	self.isCheck_ = false
end

function BonfireZone:isCheck()
	return self.isCheck_
end

function BonfireZone:getId()
	return self.id_
end

function BonfireZone:hit(actor)
	self.isCheck_ = true
	local key = GameManager:getInstance():getResource(130004)
	if key <= 0 then
		return
	else
		GameManager:getInstance():setResource(130003,-1)
	end
	local x,y = self.location_.x, self.location_.y
	local block = BattleManager:getInstance():getCurrentRoom():getBlocks()
	for i = 1, #BattleCommonDefine.area do
		local area = BattleCommonDefine.area
		if block[area[i].x + x.."_"..area[i].y + y] then
			local type, name = block[area[i].x + x.."_"..area[i].y + y].type, block[area[i].x + x.."_"..area[i].y + y].name
			if type == common.Type.Barrier then
				local barrier = BattleManager:getBarrierManager():getSysChild(name)
				if BarrierVO.type[barrier:getId()] == BarrierVO.barrierType.soldier or 
					BarrierVO.type[barrier:getId()] == BarrierVO.barrierType.tree then
					barrier:disppear()
				end
			elseif type == common.Type.Zone then
				local zone = BattleManager:getZoneManager():getSysChild(name)
				if ZoneVO.type[zone:getId()] == ZoneVO.zoneType.bonfire then
					if not zone:isCheck() then
						zone:hit(actor)
					end
				end
			end
		end
	end
	self.isCheck_ = false
end

return BonfireZone