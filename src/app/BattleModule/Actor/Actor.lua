--
-- Author: wanglei
-- Date: 2015-08-24 21:55:11
--

local Actor = class("Actor",Locationer)
Actor.TYPE = "ACTOR_TYPE"

function Actor:onCreate(location)
	Actor.super.onCreate(self,location)
end

return Actor