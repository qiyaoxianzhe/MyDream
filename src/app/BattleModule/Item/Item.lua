--
-- Author: wanglei
-- Date: 2015-08-27 0:53:11
--

local Item = class("Item",Locationer)
Item.TYPE = "ITEM_TYPE"

function Item:onCreate(location)
	Item.super.onCreate(self,location)
end

return Item