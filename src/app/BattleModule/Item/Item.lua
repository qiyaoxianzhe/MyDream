--
-- Author: wanglei
-- Date: 2015-08-27 0:53:11
--

local Item = class("Item",Locationer)
Item.TYPE = "ITEM_TYPE"

function Item:onCreate(id, location)
	Item.super.onCreate(self,location)
	self.ani_ = ItemAni.new(self.node_)
	self:addSysChild(self.ani_)
	self.id_ = id
end

function Item:getId()
	return self.id_
end

function Item:disppear()
	self:removeFromSysParent()
	BattleManager:getCurrentRoom():updateBlock_()	
end

function Item:onDeAttached()
	self.ani_:disppear()
end

return Item