--
-- Author: wanglei
-- Date: 2015-08-27 0:52:11
--

local ItemManager = class("ItemManager", System)

function ItemManager:addItem(location)
	local item = Item.new(location)
	self:addSysChild(item)
	return item
end

function ItemManager:getAllItems()
	return self:getSysChildren()
end


return ItemManager