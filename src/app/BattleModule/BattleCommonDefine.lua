--
-- Author: wanglei
-- Date: 2015-08-24 21:38:00
--
local BattleCommonDefine = class("BattleCommonDefine")

BattleCommonDefine.MAP_SIZE = 100
BattleCommonDefine.MAP_WIDTH = 10
BattleCommonDefine.MAP_HEIGHT = 5

BattleCommonDefine.BLOCK_SIZE = 50
BattleCommonDefine.BLOCK_WIDTH = 13
BattleCommonDefine.BLOCK_HEIGHT = 7

BattleCommonDefine.ROOM_WIDTH = BattleCommonDefine.BLOCK_SIZE * BattleCommonDefine.BLOCK_WIDTH
BattleCommonDefine.ROOM_HEIGHT = BattleCommonDefine.BLOCK_SIZE * BattleCommonDefine.BLOCK_HEIGHT

BattleCommonDefine.MapStatus = 1
BattleCommonDefine.RoomStatus = 2

BattleCommonDefine.Zorder = {
	Room = 1,
	UI = 9,
	Joystick = 10
}

BattleCommonDefine.attribute = {
	power = 1,
}

BattleCommonDefine.area = {
	{x = 1, y = 0},
	{x = -1, y = 0},
	{x = 0, y = 1},
	{x = 0, y = -1},
	{x = 1, y = 1},
	{x = 1, y = -1},
	{x = -1, y = 1},
	{x = -1, y = -1},
}

BattleCommonDefine.color = {
	[1] = cc.c3b(255,0,0),
	[2] = cc.c3b(255,255,0),
	[3] = cc.c3b(0,255,0),
	[4] = cc.c3b(0,255,255),
	[5] = cc.c3b(0,0,255),
	[6] = cc.c3b(255,0,255),
	[7] = cc.c3b(255,255,255),
}

return BattleCommonDefine