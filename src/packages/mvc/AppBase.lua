
local AppBase = class("AppBase")

AppBase.APP_ENTER_BACKGROUND_EVENT = "APP_ENTER_BACKGROUND_EVENT"
AppBase.APP_ENTER_FOREGROUND_EVENT = "APP_ENTER_FOREGROUND_EVENT"

function AppBase:ctor(appName, packageRoot)
    -- cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()

    self.name = appName
    self.packageRoot = packageRoot or "app"

    -- local notificationCenter = CCNotificationCenter:sharedNotificationCenter()
    -- notificationCenter:registerScriptObserver(nil, handler(self, self.onEnterBackground), "APP_ENTER_BACKGROUND_EVENT")
    -- notificationCenter:registerScriptObserver(nil, handler(self, self.onEnterForeground), "APP_ENTER_FOREGROUND_EVENT")
    -- set global app
    GLOBAL_VAR.App = self
    
    -- if DEBUG > 1 then
    --     dump(self.configs_, "AppBase configs")
    -- end

    if CC_SHOW_FPS then
        cc.Director:getInstance():setDisplayStats(true)
    end
end

function AppBase:run()
end

function AppBase:exit()
    CCDirector:sharedDirector():endToLua()
    if device.platform == "windows" or device.platform == "mac" or device.platform == "ios" then
        os.exit()
    end
end

function AppBase:enterScene(sceneName, args, transitionType, time, more)
    local scenePackageName = self.packageRoot .. ".Scenes." .. sceneName
    local sceneClass = require(scenePackageName)
    local scene = sceneClass.new(unpack(checktable(args)))
    display.runScene(scene, transitionType, time, more)
end

function AppBase:onEnterBackground()
    self:dispatchEvent({name = AppBase.APP_ENTER_BACKGROUND_EVENT})
end

function AppBase:onEnterForeground()
    self:dispatchEvent({name = AppBase.APP_ENTER_FOREGROUND_EVENT})
end

return AppBase
