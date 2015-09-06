--
-- Author: wanglei
-- Date: 2015-09-04 02:22:11
--

local HeroZone = class("HeroZone",Zone)
HeroZone.TYPE = "ZONE_TYPE"

function HeroZone:onCreate(id, location)
	HeroZone.super.onCreate(self, id, location)
end

function HeroZone:getId()
	return self.id_
end

function HeroZone:hit(actor)
	if ZoneVO.type[self.id_] == ZoneVO.type.saber then
		actor:setStatus(ActorAttr.status.qiangxi)
	elseif ZoneVO.type[self.id_] == ZoneVO.type.berserker then
		actor:setStatus(ActorAttr.status.bati)
	elseif ZoneVO.type[self.id_] == ZoneVO.type.caster then
		actor:setStatus(ActorAttr.status.wangxiang)
	elseif ZoneVO.type[self.id_] == ZoneVO.type.Assassin then
		actor:setStatus(ActorAttr.status.shengxing)
	elseif ZoneVO.type[self.id_] == ZoneVO.type.knight then
		actor:setStatus(ActorAttr.status.shengjie)
	end
end

return HeroZone