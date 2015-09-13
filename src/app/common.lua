--
-- Author: wanglei
-- Date: 2015-08-24 21:37:00
--

local common = class("Common")

common.Type = {
	Actor = 10,
	Room = 11,
	Barrier = 12,
	Item = 13,
	Buff = 14,
	Zone = 15,
	Map = 16,
}

function common.getLocationerType(id)
	return math.floor(id / 10000)
end

return common