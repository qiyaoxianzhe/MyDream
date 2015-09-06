--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local PoisonBarrier = class("PoisonBarrier",Barrier)
PoisonBarrier.TYPE = "POISONBARRIER_TYPE"

function PoisonBarrier:onCreate(id, location)
	PoisonBarrier.super.onCreate(self, id, location)
end

function PoisonBarrier:getId()
	return self.id_
end

function PoisonBarrier:hit(actor)
	actor:addBuff(PoisonBuff.new(140002))
end

return PoisonBarrier