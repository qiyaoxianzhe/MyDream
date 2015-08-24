--
-- Author: wanglei
-- Date: 2015-08-24 21:43:11
--

local SystemConfigModel = class("SystemConfigModel")

function SystemConfigModel:getInstance()
	local o = GLOBAL_VAR.SystemConfigModel
	if o then return o end
	o = SystemConfigModel.new()
	GLOBAL_VAR.SystemConfigModel = o
	return o
end

function SystemConfigModel:clean()
	GLOBAL_VAR.SystemConfigModel = nil
end

return SystemConfigModel