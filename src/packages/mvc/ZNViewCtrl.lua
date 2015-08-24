--
-- Created by IntelliJ IDEA.
-- User: tianzezhao
-- Date: 15/6/10
-- Time: 下午3:46
-- To change this template use File | Settings | File Templates.
--

local ZNViewCtrl = class("ZNViewCtrl")
ZNViewCtrl.viewsRoot = "app.Views."
function ZNViewCtrl:ctor(viewName, layoutSize)
	self:initView_(viewName,layoutSize)
end

function ZNViewCtrl:setView(view)
	if self.view_ then
		self.view_ = nil
	end
	self.view_ = view
	self.view_:onNodeEvent("enter", handler(self, self.viewOnEnter))
	self.view_:onNodeEvent("exit", handler(self, self.viewOnExit))
	self.view_:onNodeEvent("enterTransitionFinish", handler(self, self.viewOnEnterTransitionFinish))
	self.view_:onNodeEvent("exitTransitionStart", handler(self, self.viewOnExitTransitionStart))
	self.view_:onNodeEvent("exitTransitionStart", handler(self, self.viewOnCleanup))
end

function ZNViewCtrl:registerTouch_(isMultiTouches,isSallowTouches)
	self:onTouch(handler(self,self.onTouch_),isMultiTouches,isMultiTouches)
end
--点击触发时间
function ZNViewCtrl:onTouch_(event)
	if event.name == "began" then
		return true
	end
end

function ZNViewCtrl:setViewTouchEnabled(b,isMultiTouches,isSallowTouches)
	if isSallowTouches == nil then
		isSallowTouches = true
	end
	if b then
		self:registerTouch_(isMultiTouches,isSallowTouches)
	end
	self:getView():setTouchEnabled(false)
end

function ZNViewCtrl:viewOnEnter()
end

function ZNViewCtrl:viewOnExit()
	if self['animation'] and not tolua.isnull(self['animation']) then
		printf("self['animation']清除")
		self['animation']:release()
	end
end

function ZNViewCtrl:viewOnEnterTransitionFinish()
end

function ZNViewCtrl:viewOnExitTransitionStart()
end

function ZNViewCtrl:viewOnCleanup()
end

function ZNViewCtrl:getView()
	return self.view_
end

function ZNViewCtrl:playAnimationByName(animationName,isLoop)
	if self['animation'] == nil or tolua.isnull(self['animation']) then
		return
	end
	local animationInfo = self['animation']:getAnimationInfo(animationName)
	if not animationInfo then
		return
	end
	self['animation']:play(animationName,isLoop)
end

function ZNViewCtrl:playAnimation(beginIndex,endIndex,isLoop)
	self['animation']:gotoFrameAndPlay(0,5,isLoop)
end

function ZNViewCtrl:initView_(viewName,layoutSize)
	local view
	if viewName then
		local ViewClass = require(ZNViewCtrl.viewsRoot..viewName)
		local root = ViewClass.create(handler(self,self.btnCallbackBinding_))
		view = self:parseRoot_(root)
	end
	if not view then
		view = display.newNode()
	end
	layoutSize = layoutSize or display.size
	view:setContentSize(cc.size(layoutSize.width, layoutSize.height))
	if ccui.Helper then
		ccui.Helper:doLayout(view)
	end
	self:setView(view)
end
--遍历所有节点
function ZNViewCtrl:searchAllNodes_(parent)
	local children = parent:getChildren()
	for i=1,#children do
		local child = children[i]
		local name = child:getName()
		if name then
			self[name] = child
		end
		self:searchAllNodes_(child)
	end
end
--
function ZNViewCtrl:parseRoot_(root)
	local view = root['root']
	self['animation'] = root['animation']
	if self['animation'] and not tolua.isnull(self['animation']) then
		self['animation']:setFrameEventCallFunc(handler(self,self.frameEventCallback))
		self['animation']:retain()
	end
	--重置所有timeline的ActionTimeLine
	local timeLines = self['animation']:getTimelines()
	printf("timeLines = %d ",#timeLines)
	for k,timeLine in pairs(timeLines) do
		timeLine:setActionTimeline(self['animation'])
		local frames = timeLine:getFrames()
		for _,frame in pairs(frames) do
			frame:setTimeline(timeLine)
			frame:setNode(frame:getNode())
		end
	end
	--
	self:searchAllNodes_(view)
	view:runAction(self['animation'])
	return view
end
--绑定按钮事件
function ZNViewCtrl:btnCallbackBinding_(className,btn,functionName)
	local functionType = type(self[functionName])
	if functionType == "function" then
		return handler(self,self[functionName])
	end
end
--绑定帧事件
function ZNViewCtrl:frameEventCallback(fame)
	printf("frameEventCallback_%s",tostring(fame:getEvent()))
end

return ZNViewCtrl