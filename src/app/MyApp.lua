
local MyApp = class("MyApp", cc.load("mvc").AppBase)
local ClassImport = import(".ClassImport")
function MyApp:ctor()
	MyApp.super.ctor(self)
	self:classImport_()
    math.randomseed(os.time())
end

function MyApp:run()
	self:enterScene("BattleScene")
end

function MyApp:classImport_()
	ClassImport.import()
end

return MyApp
