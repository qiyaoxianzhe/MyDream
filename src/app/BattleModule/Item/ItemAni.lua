--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local ItemAni = class("ItemAni",System)
ItemAni.TYPE = "ITEMANI_TYPE"

function ItemAni:onCreate(node)
	self:setNode(node)
	self.ani_ = display.newSprite("item/item_qituan.png")
	node:addChild(self.ani_)
end

function ItemAni:disppear()
	local seq = transition.sequence({
		cc.Spawn:create(cc.MoveBy:create(0.5, cc.p(0,30)), cc.FadeOut:create(0.5)),
		CCCallFunc:create(function()
			self.node_:removeFromParent()
		end),
	})
	self.ani_:runAction(seq)
end

return ItemAni