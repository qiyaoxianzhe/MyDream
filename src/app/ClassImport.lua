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
ClassImport.GameRoot = "GameModule."
ClassImport.BattleRoot = "BattleModule."
ClassImport.VO = "VO."
ClassImport.BattleManagerRoot = ClassImport.BattleRoot.."Manager."
ClassImport.BattleActorRoot = ClassImport.BattleRoot.."Actor."
ClassImport.BattleBarrierRoot = ClassImport.BattleRoot.."Barrier."
ClassImport.BattleZoneRoot = ClassImport.BattleRoot.."Zone."
ClassImport.BattleItemRoot = ClassImport.BattleRoot.."Item."
ClassImport.BattleRoomRoot = ClassImport.BattleRoot.."Room."
ClassImport.BattleBuffRoot = ClassImport.BattleRoot.."Buff."

ClassImport.define = {
	"common",
	ClassImport.WidgetRoot.."ArmatureLoader",
	ClassImport.Components.."EventCom",
	ClassImport.Components.."StateMachine",
	ClassImport.Components.."System",
	ClassImport.Components.."Locationer",
	ClassImport.UIRoot.."BattleUI",
	ClassImport.GameRoot.."GameManager",
	ClassImport.BattleRoot.."BattleCommonDefine",
	ClassImport.BattleActorRoot.."Actor",
	ClassImport.BattleActorRoot.."ActorAni",
	ClassImport.BattleActorRoot.."ActorAttr",
	ClassImport.BattleItemRoot.."Item",
	ClassImport.BattleItemRoot.."ItemAni",
	ClassImport.BattleRoomRoot.."Room",
	ClassImport.BattleBarrierRoot.."Barrier",
	ClassImport.BattleBarrierRoot.."NormalBarrier",
	ClassImport.BattleBarrierRoot.."TensionBarrier",
	ClassImport.BattleBarrierRoot.."WallBarrier",
	ClassImport.BattleBarrierRoot.."ConditionBarrier",
	ClassImport.BattleBarrierRoot.."PoisonBarrier",
	ClassImport.BattleBarrierRoot.."BarrierAni",
	ClassImport.BattleZoneRoot.."Zone",
	ClassImport.BattleZoneRoot.."PoisonZone",
	ClassImport.BattleZoneRoot.."FrozenZone",
	ClassImport.BattleZoneRoot.."TransZone",
	ClassImport.BattleZoneRoot.."TensionZone",
	ClassImport.BattleZoneRoot.."NextZone",
	ClassImport.BattleZoneRoot.."HeroZone",
	ClassImport.BattleZoneRoot.."ZoneAni",
	ClassImport.BattleBuffRoot.."Buff",
	ClassImport.BattleBuffRoot.."FrozenBuff",
	ClassImport.BattleBuffRoot.."PoisonBuff",
	ClassImport.BattleManagerRoot.."BattleManager",
	ClassImport.BattleManagerRoot.."ItemManager",
	ClassImport.BattleManagerRoot.."BarrierManager",
	ClassImport.BattleManagerRoot.."ActorManager",
	ClassImport.BattleManagerRoot.."BuffManager",
	ClassImport.BattleManagerRoot.."ZoneManager",
}

ClassImport.config = {
	ClassImport.VO.."MapVO",
	ClassImport.VO.."ItemVO",
	ClassImport.VO.."BarrierVO",
	ClassImport.VO.."ZoneVO",
	ClassImport.VO.."BuffVO",
}

function ClassImport.import()
	for i=1,#ClassImport.define do
		local filePath = ClassImport.define[i]
		local filePathTable = string.split(filePath,".")
		GLOBAL_VAR[filePathTable[#filePathTable]] = require("app."..filePath)
	end
	for i=1,#ClassImport.config do
		local filePath = ClassImport.config[i]
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
	for i=1,#ClassImport.config do
		local filePath = ClassImport.define[i]
		local filePathTable = string.split(filePaht,".")
		GLOBAL_VAR[filePathTable[#filePathTable]] = nil
	end
end

return ClassImport
