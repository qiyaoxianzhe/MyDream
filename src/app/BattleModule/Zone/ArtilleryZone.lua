--
-- Author: wanglei
-- Date: 2015-09-21 17:57:13
--

local ArtilleryZone = class("ArtilleryZone",Zone)
ArtilleryZone.TYPE = "ARTILLERYZONE_TYPE"

function ArtilleryZone:onCreate(id, location)
	ArtilleryZone.super.onCreate(self, id, location)
	self.isCheck_ = false
end

function ArtilleryZone:getId()
	return self.id_
end

function ArtilleryZone:isCheck()
	return self.isCheck_
end

function ArtilleryZone:hit(actor)

	self.isCheck_ = true

	-- local key = GameManager:getInstance():getResource(130005)
	-- if key <= 0 then
	-- 	return
	-- else
	-- 	GameManager:getInstance():setResource(130003,-1)
	-- end

	self.checkX_, self.checkY_ = self.location_.x, self.location_.y
	self.step_, self.direction_ = 0,0
	if ZoneVO.velocity[self.id_].x > 0 then
		self.step_, self.direction_ = 1,0
	elseif ZoneVO.velocity[self.id_].x < 0 then
		self.step_, self.direction_ = -1,0
	elseif ZoneVO.velocity[self.id_].y > 0 then
		self.step_, self.direction_ = 1,1
	elseif ZoneVO.velocity[self.id_].y < 0 then
		self.step_, self.direction_ = -1,1
	end

	self.artillery_ = display.newSprite("bullet/bullet_tieqiu.png")
	BattleManager:getCurrentRoom():addBullet(self.artillery_)
	self.artillery_:setPosition(cc.p(self.node_:getPositionX(),self.node_:getPositionY()))

	self:moveArtillery(x,y)
end

function ArtilleryZone:moveArtillery()
	if self.direction_ == 1 then
		self.checkX_, self.checkY_ = self.checkX_, self.checkY_ + self.step_
	else
		self.checkX_, self.checkY_ = self.checkX_ + self.step_, self.checkY_
	end
	local x,y = self:locationToPosition(cc.p(self.checkX_, self.checkY_))
	if self.checkX_ > BattleCommonDefine.BLOCK_WIDTH or self.checkX_ < 1 or
		self.checkY_ > BattleCommonDefine.BLOCK_HEIGHT or self.checkY_ < 1 then
		self.artillery_:removeFromParent()
		self.checkX_, self.checkY_, self.step_, self.direction_ = self.location_.x, self.location_.y, 0, 0
		self.isCheck_ = false
		return
	end
	local x,y = self:locationToPosition(cc.p(self.checkX_, self.checkY_))
	local seq = transition.sequence({
		cc.MoveTo:create(0.2, cc.p(x,y)),
		CCCallFunc:create(function()
			self:checkHit()
		end),
	})
	self.artillery_:runAction(seq)
end

function ArtilleryZone:checkHit()
	local block = BattleManager:getInstance():getCurrentRoom():getBlocks()
	if block[self.checkX_.."_"..self.checkY_] then
		local type, name = block[self.checkX_.."_"..self.checkY_].type, block[self.checkX_.."_"..self.checkY_].name
		if type == common.Type.Barrier then
			local barrier = BattleManager:getBarrierManager():getSysChild(name)
			if BarrierVO.type[barrier:getId()] == BarrierVO.barrierType.soldier or 
				BarrierVO.type[barrier:getId()] == BarrierVO.barrierType.wall then
				barrier:disppear()
				self.artillery_:removeFromParent()
				self.checkX_, self.checkY_, self.step_, self.direction_ = self.location_.x, self.location_.y, 0, 0
				self.isCheck_ = false
				return
			end
		elseif type == common.Type.Zone then
			local zone = BattleManager:getZoneManager():getSysChild(name)
			if ZoneVO.type[zone:getId()] == ZoneVO.zoneType.artillery then
				if not zone:isCheck() then
					zone:hit(actor)
				end
			end
		end
	end
	self:moveArtillery()
end

function ArtilleryZone:onDeAttached()
	if self.isCheck_ then
		self.artillery_:stopAllActions()
		self.artillery_:removeFromParent()
	end
	self.node_:removeFromParent()
end

return ArtilleryZone