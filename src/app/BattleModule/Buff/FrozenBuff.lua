--
-- Author: wanglei
-- Date: 2015-09-05 14:01:11
--

local FrozenBuff = class("FrozenBuff",Buff)
FrozenBuff.TYPE = "FROZENBUFF_TYPE"

function FrozenBuff:hit(actor)
	return false
end

return FrozenBuff