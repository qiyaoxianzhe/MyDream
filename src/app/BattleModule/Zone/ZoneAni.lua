--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local ZoneAni = class("ZoneAni",System)
ZoneAni.TYPE = "ZONEANI_TYPE"

function ZoneAni:onCreate(node)
	self:setNode(node)
	self.ani_ = display.newSprite("zone/hero1.png")
	node:addChild(self.ani_)
end

return ZoneAni