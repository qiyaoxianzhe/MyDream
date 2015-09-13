--
-- Author: wanglei
-- Date: 2015-09-13 22:02:11
--

local MusicManager = class("MusicManager")

MusicManager.MUSIC = 1
MusicManager.SOUND = 2

function MusicManager:ctor()
end

function MusicManager:getInstance()
	local o = GLOBAL_VAR.musicManager_
	if o then
		return o
	end
	o = MusicManager.new()
	GLOBAL_VAR.musicManager_ = o
	return o
end

function MusicManager:clean()
	GLOBAL_VAR.musicManager_ = nil
end

--播放音频 _fileName:文件名 _type:类型(1-音乐/2-音效|可为空) _isLoop:是否循环
function MusicManager:playAudio(_fileName,_type,_isLoop)
	local __type = _type
	if not __type then
		__type = MusicManager.MUSIC
	end
	if __type == MusicManager.MUSIC then
		local __isLoop = _isLoop or true
		audio.playMusic(_fileName, __isLoop)
	elseif __type == MusicManager.SOUND then
		local __isLoop = _isLoop or false
		audio.playSound(_fileName, __isLoop)
	end
end

function MusicManager:stopSound()
	audio.stopAllSounds()
end

function MusicManager:stopBackGroudMusic()
	audio.stopMusic(false)
end

return MusicManager