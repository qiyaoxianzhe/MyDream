--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local ConditionBarrier = class("ConditionBarrier",Barrier)
ConditionBarrier.TYPE = "CONDITIONBARRIER_TYPE"

function ConditionBarrier:onCreate(id, location)
	ConditionBarrier.super.onCreate(self, id, location)
end

function ConditionBarrier:getId()
	return self.id_
end

function ConditionBarrier:open()
	self:disppear()
end

return ConditionBarrier