--
-- Author: wanglei
-- Date: 2015-08-24 22:04:11
--

local ClassImport = {}
ClassImport.CtrlRoot = "Ctrls."
ClassImport.WidgetRoot = "GUIWidget."
ClassImport.ModelRoot = "Model."
ClassImport.UIRoot = "UI."
ClassImport.Components = "Components."
ClassImport.BattleModule = "BattleModule."
ClassImport.BattleRoot = "BattleModule."
ClassImport.VO = "VO."
ClassImport.BattleManagerRoot = ClassImport.BattleRoot.."Manager."
ClassImport.BattleActorRoot = ClassImport.BattleRoot.."Actor."
ClassImport.BattleBarrierRoot = ClassImport.BattleRoot.."Barrier."
ClassImport.BattleItemRoot = ClassImport.BattleRoot.."Item."
ClassImport.BattleRoomRoot = ClassImport.BattleRoot.."Room."

ClassImport.define = {
	"common",
	ClassImport.WidgetRoot.."ArmatureLoader",
	ClassImport.Components.."EventCom",
	ClassImport.Components.."StateMachine",
	ClassImport.Components.."System",
	ClassImport.Components.."Locationer",
	ClassImport.BattleRoot.."BattleCommonDefine",
	ClassImport.UIRoot.."BattleUI",
	ClassImport.BattleActorRoot.."Actor",
	ClassImport.BattleActorRoot.."ActoAni",
	ClassImport.BattleActorRoot.."ActorAttr",
	ClassImport.BattleItemRoot.."Item",
	ClassImport.BattleRoomRoot.."Room",
	ClassImport.BattleBarrierRoot.."Barrier",
	ClassImport.BattleManagerRoot.."BattleManager",
	ClassImport.BattleManagerRoot.."ItemManager",
	ClassImport.BattleManagerRoot.."BarrierManager",
	ClassImport.BattleManagerRoot.."ActorManager",
}

function ClassImport.import()
	for i=1,#ClassImport.define do
		local filePath = ClassImport.define[i]
		local filePathTable = string.split(filePath,".")
		GLOBAL_VAR[filePathTable[#filePathTable]] = require("app."..filePath)
	end
end

function ClassImport.unimport()
	for i=1,#ClassImport.define do
		local filePath = ClassImport.define[i]
		local filePathTable = string.split(filePaht,".")
		GLOBAL_VAR[filePathTable[#filePathTable]] = nil
	end
end

return ClassImport
