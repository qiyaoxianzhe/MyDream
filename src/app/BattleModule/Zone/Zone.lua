--
-- Author: wanglei
-- Date: 2015-09-04 02:22:11
--

local Zone = class("Zone",Locationer)
Zone.TYPE = "ZONE_TYPE"

function Zone:onCreate(id, location)
	Zone.super.onCreate(self,location)
	self.ani_ = ZoneAni.new(self.node_)
	self:addSysChild(self.ani_)
	self.id_ = id
end

function NormalBarrier:hit(actor)
end

function Zone:getId()
	return self.id_
end

return Zone