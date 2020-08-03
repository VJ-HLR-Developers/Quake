AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/quake1/enforcer.mdl"
ENT.StartHealth = GetConVarNumber("vj_q1_enforcer_h")
ENT.AnimTbl_Flinch = {"vjseq_paina","vjseq_painb","vjseq_painc","vjseq_paind"}
//ENT.DeathAnimationTime = 0.3
ENT.IsEnforcer = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	--self:SetCollisionBounds(Vector(30, 22, 45), Vector(-32, -22, 0))
	self:Give("weapon_vj_q1_enforcerblaster")
	self.SoundTbl_Alert = {"q1/enforcer/sight1.wav","q1/enforcer/sight2.wav","q1/enforcer/sight3.wav","q1/enforcer/sight4.wav"}
	self.SoundTbl_Idle = {"q1/enforcer/idle1.wav"}
	self.SoundTbl_Pain = {"q1/enforcer/pain1.wav","q1/enforcer/pain2.wav"}
	self.SoundTbl_Death = {"q1/enforcer/death1.wav"}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self.Weapon_ShotsSinceLastReload = 0
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/