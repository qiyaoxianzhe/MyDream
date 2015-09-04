--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local WallBarrier = class("WallBarrier",Barrier)
WallBarrier.TYPE = "WALLBARRIER_TYPE"

function WallBarrier:onCreate(id, location)
	WallBarrier.super.onCreate(self, id, location)
end

function WallBarrier:getId()
	return self.id_
end

return WallBarrier