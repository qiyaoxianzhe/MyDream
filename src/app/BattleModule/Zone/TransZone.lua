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
	BattleManager:getCurrentRoom():transition(actor)
end

return TransZone