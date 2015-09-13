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
	if ZoneVO.type[self.id_] == ZoneVO.zoneType.saber then
		actor:setStatus(ActorAttr.status.qiangxi)
	elseif ZoneVO.type[self.id_] == ZoneVO.zoneType.berserker then
		actor:setStatus(ActorAttr.status.bati)
	elseif ZoneVO.type[self.id_] == ZoneVO.zoneType.caster then
		actor:setStatus(ActorAttr.status.wanxiang)
	elseif ZoneVO.type[self.id_] == ZoneVO.zoneType.Assassin then
		actor:setStatus(ActorAttr.status.shenxing)
	elseif ZoneVO.type[self.id_] == ZoneVO.zoneType.knight then
		actor:setStatus(ActorAttr.status.shengjie)
	end
end

return HeroZone