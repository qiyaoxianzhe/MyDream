--
-- Author: wanglei
-- Date: 2015-08-24 21:40:11
--

local ZoneManager = class("ZoneManager", System)

function ZoneManager:addZone(id, location)
	local zone = self:createZone(id, location)
	self:addSysChild(zone)
	return zone
end

function ZoneManager:createZone(id, location)
	local zone = nil
	if ZoneVO.type[id] == ZoneVO.zoneType.poison then
		zone = PoisonZone.new(id, location)
	elseif ZoneVO.type[id] == ZoneVO.zoneType.fronzen then
		zone = FrozenZone.new(id, location)
	elseif ZoneVO.type[id] == ZoneVO.zoneType.saber or ZoneVO.type[id] == ZoneVO.zoneType.berserker or ZoneVO.type[id] == ZoneVO.zoneType.caster
		or ZoneVO.type[id] == ZoneVO.zoneType.assassin or ZoneVO.type[id] == ZoneVO.zoneType.knight then
		zone = HeroZone.new(id, location)
	elseif ZoneVO.type[id] == ZoneVO.zoneType.trans then
		zone = TransZone.new(id, location)
	elseif ZoneVO.type[id] == ZoneVO.zoneType.exit then
		zone = ExitZone.new(id, location)
	elseif ZoneVO.type[id] == ZoneVO.zoneType.Tension then
		zone = TensionZone.new(id, location)
	end
	return zone
end

function ZoneManager:findZoneByType(type)
	local zones = {}
	for k, v in pairs(self:getSysChildren()) do
		if v:getType() == type then
			zones[#zones + 1] = v
		end
	end
	return zones
end

function ZoneManager:getAllZones()
	return self:getSysChildren()
end

return ZoneManager