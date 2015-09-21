--
-- Author: wanglei
-- Date: 2015-09-04 02:22:11
--

local ExitZone = class("ExitZone",Zone)
ExitZone.TYPE = "EXITZONE_TYPE"

function ExitZone:onCreate(id, location)
	ExitZone.super.onCreate(self, id, location)
end

function ExitZone:getId()
	return self.id_
end

function ExitZone:hit(actor)
	BattleManager:getInstance():finishRoom(true)
end

return ExitZone