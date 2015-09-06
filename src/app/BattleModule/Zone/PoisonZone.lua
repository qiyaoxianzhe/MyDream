--
-- Author: wanglei
-- Date: 2015-09-04 02:22:11
--

local PoisonZone = class("PoisonZone",Zone)
PoisonZone.TYPE = "POISONZONE_TYPE"

function PoisonZone:onCreate(id, location)
	PoisonZone.super.onCreate(self, id, location)
end

function PoisonZone:getId()
	return self.id_
end

function PoisonZone:hit(actor)
	actor:addBuff(PoisonBuff.new(140002))
end

return PoisonZone