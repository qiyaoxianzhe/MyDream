--
-- Author: zen.zhao88@gmail.com
-- Date: 2015-06-17 15:36:05
--
local EventCom = class("EventCom")

local EXPORTED_METHODS = {
    "addEventListener",
    "dispatchEvent",
    "removeEventListener",
    "removeAllEventListenersForEvent",
    "removeAllEventListeners",
    "removeEventListenerForObject",
    "dumpAllEventListeners",
    "setDebugEnabled",
}

function EventCom:ctor()
	self:init_()
end

function EventCom:init_()
	self.target_ = nil
	self.listeners_ = {}
    self.isSortListeners_ = {}
end

function EventCom:bind(target)
	self:init_()
	cc.setmethods(target, self, EXPORTED_METHODS)
    self.target_ = target
end

function EventCom:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
    self:init_()
end

--[[
    注册通知监听传入一个listener表
    object-接受通知的对象实例
    name-监听的通知名称
    handler-响应的方法
    data-可作为响应方法第一个默认参数
    priority-响应优先级
]]

function EventCom:addEventListener(listener)
    local eventName = listener.name
    listener.priority = listener.priority or 1
    -- listener.priority = math.max(listener.priority,1)
    assert(type(eventName) == "string" and eventName ~= "",
        "EventCom:addEventListener() - invalid eventName")
    eventName = string.upper(eventName)
    if self.listeners_[eventName] == nil then
        self.listeners_[eventName] = {}
    end

    table.insert(self.listeners_[eventName],listener)

    self.isSortListeners_[eventName] = false
    if self.debug_ then
        if data then
            echoInfo("EventCom:addEventListener() - add listener [%s] %s:%s for event %s", listener.object, tostring(listener.data), tostring(listener.handler), eventName)
        else
            echoInfo("EventCom:addEventListener() - add listener [%s] %s for event %s", listener.object, tostring(listener.handler), eventName)
        end
    end
    return self
end

--[[
    发送通知，传入event必须带:
    name -- 对应的通知名称
]]

function EventCom:dispatchEvent(event)
    event.name = string.upper(event.name)
    local eventName = event.name
    if self.debug_ then
        echoInfo("EventCom:dispatchEvent() - dispatching event %s", eventName)
    end
    if self.listeners_[eventName] == nil then return end
    event.target = self.target_
    self:sortListeners_(eventName)
    for i=1,#self.listeners_[eventName] do
        local listener = self.listeners_[eventName][i]
        if self.debug_ then
            echoInfo("EventCom:dispatchEvent() - dispatching event %s to listener [%s]", listener.eventName, listener.handle)
        end
        local ret
        if listener.data then
            ret = listener.handler(listener.data,event)
        else
            ret = listener.handler(event)
        end
        if ret == false then
            if self.debug_ then
                echoInfo("EventCom:dispatchEvent() - break dispatching for event %s", eventName)
            end
            break
        end
    end
end

--[[
    移除对应通知名称的所有监听
]]

function EventCom:removeAllEventListenersForEvent(eventName)
   assert(type(eventName) == "string" and eventName ~= "",
        "EventCom:removeAllEventListenersForEvent() - invalid eventName")
    self.listeners_[string.upper(eventName)] = nil
    if self.debug_ then
        echoInfo("EventCom:removeAllEventListenersForEvent() - remove all listeners for event %s", eventName)
    end
end

--[[
    移除所有监听
]]

function EventCom:removeAllEventListeners()
    self.listeners_ = {}
    if self.debug_ then
        echoInfo("EventCom:removeAllEventListeners() - remove all listeners")
    end
end

function EventCom:removeEventListenerForObject(object,eventName)
    if eventName and type(eventName) == "string" then
        local listeners = self.listeners_[string.upper(eventName)]
        if listeners then
            self:removeEventListener_(listeners, object)
        end
    else
        for name,listeners in pairs(self.listeners_) do
            self:removeEventListener_(listeners, object)
        end
    end
end

function EventCom:dumpAllEventListeners()
    printf("---- EventNoticeManager:dumpAllEventListeners() ----")
    for name, listeners in pairs(self.listeners_) do
        printf("EventCom -- event: %s", name)
        for _, listener in pairs(listeners) do
            printf("EventCom -- handle: %s, %s", tostring(listener.object), tostring(listener.handler))
        end
    end
end

function EventCom:setDebugEnabled(enabled)
    self.debug_ = enabled
end

--private methods
function EventCom:removeEventListener_(listeners,object)
    for i=#listeners,1,-1 do
        local listener = listeners[i]
        if listener.object == object then
            table.remove(listeners,i)
        end
    end
end

function EventCom:sortListeners_(eventName)
    if self.isSortListeners_[eventName] == true then
        return
    end
    local listeners = self.listeners_[eventName]
    table.sort(listeners,function(a,b)
        return a.priority < b.priority
        end)
    self.isSortListeners_[eventName] = true
end

return EventCom