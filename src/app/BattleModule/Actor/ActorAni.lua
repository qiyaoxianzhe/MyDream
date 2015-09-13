--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local ActorAni = class("ActorAni",System)
ActorAni.TYPE = "ACTORANI_TYPE"

function ActorAni:onCreate(node)
	self:setNode(node)
	self.ani_ = display.newSprite("actor/tiny.png")
	node:addChild(self.ani_,2)
	self:ideal()
end

function ActorAni:run()
	self.ani_:stopAllActions()
end

function ActorAni:trans()
	self.ani_:setOpacity(0)
    self.ani_:runAction(cc.FadeIn:create(0.5))
end

function ActorAni:setParticle(type)
	if self.particle_ then
		self.node_:removeChild(self.particle_, true)
	end
	if type ~= ActorAttr.status.none then
		self.particle_ = cc.ParticleSystemQuad:create("particle/Galaxy.plist")
		self.particle_:setScale(0.2)
   	 	self.node_:addChild(self.particle_,1)
   		self.particle_:setPosition(self.node_:getContentSize().width / 2,
   			self.node_:getContentSize().height / 2)
   		if type == ActorAttr.status.bati then
   			self.particle_:setStartColor(BattleCommonDefine.color[1])
   		elseif type == ActorAttr.status.qiangxi then
   			self.particle_:setStartColor(BattleCommonDefine.color[2])
   		elseif type == ActorAttr.status.wanxiang then
   			self.particle_:setStartColor(BattleCommonDefine.color[3])
   		elseif type == ActorAttr.status.shenxing then
   			self.particle_:setStartColor(BattleCommonDefine.color[4])
   		elseif type == ActorAttr.status.tianqi then
   			self.particle_:setStartColor(BattleCommonDefine.color[5])
   		end
	end
end

function ActorAni:setColor(color)
	self.ani_:setColor(BattleCommonDefine.color[color])
end

function ActorAni:ideal()
	self.ani_:setPosition(cc.p(0,0))
	local seq = transition.sequence({
    	cc.MoveBy:create(0.15, cc.p(0, 5)),
    	cc.MoveBy:create(0.15,cc.p(0, -5)),
    })
    self.ani_:runAction(cc.RepeatForever:create(seq))
end

return ActorAni