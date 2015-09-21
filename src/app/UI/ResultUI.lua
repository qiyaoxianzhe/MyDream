--
-- Author: wanglei
-- Date: 2015-09-19 21:35:11
--

local ResultUI = class("ResultUI", cc.load("mvc").ZNViewCtrl)

function ResultUI:ctor(name,size,isWin)
	ResultUI.super.ctor(self,name,size)
	self.isWin_ = isWin
end


function ResultUI:viewOnEnter()
	BattleManager:getInstance():setMove(true)
	if self.isWin_ then
		self.Text_1:setString("任务完成")
	else
		self.Text_1:setString("任务失败")
	end
	local seq = transition.sequence({
		cc.DelayTime:create(1),
		cc.FadeOut:create(0.5),
		CCCallFunc:create(function()
			self:getView():removeFromParent()
			BattleManager:getInstance():setMove(false)
			if not self.isWin_ then
				BattleManager:getInstance():resetGame()
			end
			BattleManager:getInstance():clearRoom()
			BattleManager:getInstance():enterMap(160001)
			BattleManager:getInstance():setIdFinish(false)
		end),
	})
	self.Text_1:runAction(seq)
end

function ResultUI:viewOnExit()
end

return ResultUI


