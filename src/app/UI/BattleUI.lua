--
-- Author: wanglei
-- Date: 2015-08-24 21:57:11
--

local BattleUI = class("BattleUI", cc.load("mvc").ZNViewCtrl)

function BattleUI:ctor(name,size)
	BattleUI.super.ctor(self,name,size)
end

function BattleUI:viewOnEnter()
end

function BattleUI:viewOnExit()
end

return BattleUI
