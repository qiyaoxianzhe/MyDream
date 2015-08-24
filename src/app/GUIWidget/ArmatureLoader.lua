--
-- Author: zen.zhao88@gmail.com
-- Date: 2015-07-08 10:15:55
--
local ArmatureLoader = class("ArmatureLoader", function(name)
	if name == "" or name == nil then
		echoError("加载的骨骼动画名称:%s",tostring(name))
		return nil
	end
	local manager = ccs.ArmatureDataManager:sharedArmatureDataManager()
	--是否需要新加资源
	local table = string.split(name,"/")
	local aramtureName = table[#table]
	if not manager:getArmatureData(aramtureName) then
		printf("需要新加资源%s,%s", name,aramtureName)
		manager:addArmatureFileInfo(name..".png", name..".plist", name..".xml")
	end
	local armature = ccs.Armature:create(aramtureName)
	local interval = CCDirector:sharedDirector():getAnimationInterval()
	armature:getAnimation():setSpeedScale(24 * interval)
	return armature
end)

return ArmatureLoader