--
-- Author: wanglei
-- Date: 2015-08-24 21:38:00
--
local BattleCommonDefine = class("BattleCommonDefine")

BattleCommonDefine.BLOCK_SIZE = 50
BattleCommonDefine.BLOCK_WIDTH = 20
BattleCommonDefine.BLOCK_HEIGHT = 10

BattleCommonDefine.ROOM_WIDTH = BattleCommonDefine.BLOCK_SIZE * BattleCommonDefine.BLOCK_WIDTH
BattleCommonDefine.ROOM_HEIGHT = BattleCommonDefine.BLOCK_SIZE * BattleCommonDefine.BLOCK_HEIGHT

BattleCommonDefine.DIRECTION_LEFT = 1
BattleCommonDefine.DIRECTION_RIGHT = 2
BattleCommonDefine.DIRECTION_UP = 3
BattleCommonDefine.DIRECTION_DOWN = 4

BattleCommonDefine.Zorder = {
	Room = 1,
	UI = 9,
	Joystick = 10
}

BattleCommonDefine.attribute = {
	step = 1,
}

BattleCommonDefine.color = {
	[1] = cc.c3b(255,0,0),
	[2] = cc.c3b(255,255,0),
	[3] = cc.c3b(0,255,0),
	[4] = cc.c3b(0,255,255),
	[5] = cc.c3b(0,0,255),
	[6] = cc.c3b(255,0,255),
}

return BattleCommonDefine