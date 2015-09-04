--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local TensionBarrier = class("TensionBarrier",Barrier)
TensionBarrier.TYPE = "TENSIONBARRIER_TYPE"

function TensionBarrier:onCreate(id, location)
	TensionBarrier.super.onCreate(self, id, location)
end

function TensionBarrier:getId()
	return self.id_
end

function TensionBarrier:hit(actor)
	-- 弹走
	TensionBarrier.super.hit(self,ator)
end

return TensionBarrier