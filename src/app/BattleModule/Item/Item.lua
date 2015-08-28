--
-- Author: wanglei
-- Date: 2015-08-27 0:53:11
--

local Item = class("Item",Locationer)
Item.TYPE = "ITEM_TYPE"

function Item:onCreate(location)
	Item.super.onCreate(self,location)
	self.ani_ = ItemAni.new(self.node_)
	self:addSysChild(self.ani_)
end

function Item:disppear()
	self.ani_:disppear()
end

function Item:onDeAttached()
	self.node_:removeFromParent()
end

return Item