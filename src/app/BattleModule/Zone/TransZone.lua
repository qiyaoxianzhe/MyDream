--
-- Author: wanglei
-- Date: 2015-09-04 02:22:11
--

local TransZone = class("TransZone",Zone)
TransZone.TYPE = "TRANSZONE_TYPE"

function TransZone:onCreate(id, location)
	TransZone.super.onCreate(self, id, location)
end

function TransZone:getId()
	return self.id_
end

function TransZone:hit(actor)
	local zones = BattleManager:getZoneManager():findZoneByType(TransZone.TYPE)
	for k,v in pairs(zones) do
		if actor:getLocation().x ~= v:getLocation().x or actor:getLocation().y ~= v:getLocation().y 
			and self:getId() == v:getId() then
			actor:transTo(v:getLocation())
			break
		end
	end
end

return TransZone