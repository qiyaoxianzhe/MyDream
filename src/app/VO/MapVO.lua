--
-- Author: wanglei
-- Date: 2015-08-29 02:07:11
--
local MapVO = {}

MapVO.id = {160001,160002,160003,160004}

MapVO.room = { 
	[160001] = {
		{x = 1, y = 2, id = 110001, key = 0},
		{x = 2, y = 1, id = 110001, key = 0},
		{x = 2, y = 2, id = 110003, key = 0},
		{x = 2, y = 3, id = 110002, key = 0},
		{x = 3, y = 1, id = 110001, key = 0},
		{x = 3, y = 3, id = 110002, key = 0},
		{x = 4, y = 1, id = 110001, key = 0},
		{x = 4, y = 2, id = 110003, key = 0},
		{x = 4, y = 3, id = 110001, key = 0},
		{x = 5, y = 2, id = 110002, key = 0},
		{x = 6, y = 2, id = 110003, key = 0},
		{x = 6, y = 2, id = 110001, key = 0},
		{x = 7, y = 2, id = 110001, key = 0},
		{x = 8, y = 2, id = 110001, key = 0},
		{x = 9, y = 2, id = 110001, key = 0},
		{x = 10, y = 5, id = 110001, key = 0},
	},
}

MapVO.actor = {
	[160001] = {x = 1, y = 2}
}

return MapVO
