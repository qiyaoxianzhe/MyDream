--
-- Author: wanglei
-- Date: 2015-08-29 02:07:11
--
local RoomVO = {}

RoomVO.id = {110001,110002,110003,}

RoomVO.actor = {
	[110001] = { 
		{x = 1, y = 1, id = 140001, power = 1},
	},
	[110002] = { 
		{x = 1, y = 1, id = 140001, power = 1},
	},
	[110003] = { 
		{x = 1, y = 1, id = 140001, power = 1},	
	},
}

RoomVO.terrain = {
	[110001] = "terrain/grass.png",
	[110002] = "terrain/grass.png",
	[110003] = "terrain/grass.png",
}

RoomVO.zone = {
	[110001] = {
		{x = 1, y = 3, id = 150001},
		{x = 2, y = 3, id = 150002},
		{x = 3, y = 3, id = 150003},
		{x = 4, y = 3, id = 150008},
		{x = 5, y = 3, id = 150005},
		{x = 6, y = 3, id = 150006},
		{x = 7, y = 3, id = 150007},
		{x = 13, y = 1, id = 150001},

	},
	[110002] = {
		{x = 2, y = 3, id = 150002},
		{x = 3, y = 3, id = 150003},
		{x = 4, y = 3, id = 150004},
		{x = 5, y = 3, id = 150005},
		{x = 6, y = 3, id = 150006},
		{x = 7, y = 3, id = 150007},
		{x = 13, y = 1, id = 150003},

	},
	[110003] = {
		{x = 2, y = 3, id = 150002},
		{x = 3, y = 3, id = 150003},
		{x = 4, y = 3, id = 150004},
		{x = 5, y = 3, id = 150005},
		{x = 6, y = 3, id = 150006},
		{x = 7, y = 3, id = 150007},
		{x = 13, y = 1, id = 150011},
		{x = 13, y = 2, id = 150012},

	},
}

RoomVO.barrier = {
	[110001] = { 
		{x = 1, y = 2, id = 120008},
		{x = 2, y = 2, id = 120001},
		{x = 3, y = 2, id = 120001},
		{x = 4, y = 2, id = 120001},
		{x = 5, y = 2, id = 120001},
		{x = 6, y = 2, id = 120001},
		{x = 7, y = 2, id = 120001},
		{x = 8, y = 2, id = 120001},
		{x = 9, y = 2, id = 120001},
		{x = 10, y = 2, id = 120001},
		{x = 1, y = 5, id = 120001},
		{x = 2, y = 5, id = 120001},
		{x = 3, y = 5, id = 120001},
		{x = 4, y = 5, id = 120001},
		{x = 13, y = 7, id = 120001},
	},
	[110002] = { 
		{x = 1, y = 2, id = 120008},
		{x = 2, y = 2, id = 120001},
		{x = 3, y = 2, id = 120001},
		{x = 4, y = 2, id = 120001},
	},
	[110003] = { 
		{x = 1, y = 2, id = 120008},
		{x = 2, y = 2, id = 120001},
		{x = 3, y = 2, id = 120001},
		{x = 4, y = 2, id = 120001},
		{x = 13, y = 7, id = 120001},
		{x = 11, y = 2, id = 120001},
	},
}

RoomVO.item = {
	[110001] = { 
		{x = 5, y = 5, id = 130001},
		{x = 8, y = 5, id = 131001},
		{x = 14, y = 2, id = 130001},
	},
	[110002] = { 
		{x = 5, y = 5, id = 130001},
		{x = 8, y = 5, id = 131002},
	},
	[110003] = { 
		{x = 5, y = 5, id = 130001},
		{x = 5, y = 5, id = 131001},
	},
}

return RoomVO
