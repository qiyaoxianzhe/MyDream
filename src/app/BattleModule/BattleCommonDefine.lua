--
-- Author: wanglei
-- Date: 2015-08-24 21:38:00
--
local BattleCommonDefine = class("BattleCommonDefine")

BattleCommonDefine.BLOCK_SIZE = 50
BattleCommonDefine.BLOCK_WIDTH = 18
BattleCommonDefine.BLOCK_HEIGHT = 8

BattleCommonDefine.ROOM_WIDTH = BattleCommonDefine.BLOCK_SIZE * BattleCommonDefine.BLOCK_WIDTH
BattleCommonDefine.ROOM_HEIGHT = BattleCommonDefine.BLOCK_SIZE * BattleCommonDefine.BLOCK_HEIGHT

BattleCommonDefine.DIRECTION_LEFT = 1
BattleCommonDefine.DIRECTION_RIGHT = 2
BattleCommonDefine.DIRECTION_UP = 3
BattleCommonDefine.DIRECTION_DOWN = 4

return BattleCommonDefine