--
-- Author: wanglei
-- Date: 2015-08-24 22:29:11
--

local System = class("System")
System.TYPE = "System_TYPE"

function System:ctor(...)
	--扩展消息分发机制
	local eventCom = EventCom.new()
	eventCom:bind(self)
	self.children_ = {}
	self.isChildsChange_ = false
	self:onCreate(...)
end

function System:addSysChild(system)
	self.isChildsChange_ = true
	if not system:getSysParent() then
		local keyName = tostring(system)
		self.children_[keyName] = system
		--增加父系统关联
		system:setSysParent(self)
		--执行onAttached
		system:onAttached()
	end
end

function System:removeSysChild(system)
	self.isChildsChange_ = true
	if system:getSysParent() == self then
		local keyName = tostring(system)
		self.children_[keyName] = nil
		--执行onDeAttached
		system:onDeAttached()
		--移除父系统关联
		system:setSysParent(nil)
	end
end
--移除所有子系统
function System:removeAllSysChild()
	for k,child in pairs(self.children_) do
		self:removeSysChild(child)
	end
end


function System:removeFromSysParent()
	if self.parent_ then
		self.parent_:removeSysChild(self)
	end
end

function System:getType()
	return self.class.TYPE
end

function System:onCreate()

end

--挂载到一个父系统上是会响应
function System:onAttached()
end
--从一个父系统上卸载下来的时候会响应
function System:onDeAttached()
end

function System:update(t)
	--调用子系统的update
	if not self.isPaused_ then
		self:onUpdate(t)
		for k,child in pairs(self.children_) do
			if self.isChildsChange_ then 
				self.isChildsChange_ = false
				break
			end
			child:update(t)
		end
	end
end

function System:onUpdate(t)
end

function System:setSysParent(parent)
	self.parent_ = parent
end

function System:getSysParent()
	return self.parent_
end

function System:getSysChildren()
	return self.children_
end

function System:setNode(node)
	self.node_ = node
end

function System:getNode()
	return self.node_
end

function System:pause()
	self.isPaused_ = true
end

function System:resume()
	self.isPaused_ = false
end

function System:isPaused()
	return self.isPaused_
end

function System:setTag(b)
	self.tag_ = b
end

function System:getTag()
	return self.tag_
end

return System