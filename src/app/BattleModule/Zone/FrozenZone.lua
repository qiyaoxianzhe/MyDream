--
-- Author: wanglei
-- Date: 2015-09-04 02:22:11
--

local FrozenZone = class("FrozenZone",Zone)
FrozenZone.TYPE = "FROZENZONE_TYPE"

function FrozenZone:onCreate(id, location)
	FrozenZone.super.onCreate(self, id, location)
end

function FrozenZone:getId()
	return self.id_
end

function FrozenZone:hit(actor)
	-- TODO 增加冰属性buff
end

return FrozenZone