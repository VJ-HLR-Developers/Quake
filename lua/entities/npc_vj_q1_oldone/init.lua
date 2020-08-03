AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_NPC_Class = {"CLASS_QUAKE1"}
ENT.Model = "models/quake1/demon.mdl"
ENT.HasDeathRagdoll = false
ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {ACT_DIESIMPLE}
ENT.StartHealth = 300
ENT.DeathAnimationTime = 5
ENT.LeapAttackDamage = 40
ENT.LeapAttackVelocityForward = 3000
ENT.LeapAttackVelocityUp = 220
ENT.BloodColor = "Red"
ENT.BloodDecalUseGMod = true
ENT.CanFlinch = 1
ENT.MeleeAttackDamage = 15
ENT.FlinchChance = 1
ENT.FlinchAnimation_UseSchedule = true
ENT.ScheduleTbl_Flinch = {SCHED_BIG_FLINCH}
ENT.LeapToMeleeDistance = 100
ENT.LeapAttackDamageDistance = 100
ENT.HasExtraMeleeAttackSounds = true
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
ENT.AnimTbl_LeapAttack = {ACT_LEAP}
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH}
ENT.HasLeapAttack = true
ENT.SoundTbl_Alert = { "q1/demon/sight2.wav" }
ENT.SoundTbl_MeleeAttack = { "q1/demon/sight2.wav" }
ENT.SoundTbl_MeleeAttackMiss = { "q1/demon/sight2.wav" }
ENT.SoundTbl_Idle = { "q1/demon/idle1.wav" }
ENT.SoundTbl_LeapAttackJump = { "q1/demon/djump.wav" }
ENT.SoundTbl_LeapAttackDamage = { "q1/demon/dhit2.wav" }
ENT.SoundTbl_MeleeAttackExtra = { "q1/demon/dhit2.wav" }
--ENT.SoundTbl_MeleeAttack = { "q1/demon/dhit2.wav" }
ENT.SoundTbl_Pain = { "q1/demon/dpain1.wav" }
ENT.SoundTbl_Death = { "q1/demon/ddeath.wav" }
ENT.HullType = HULL_HUMAN

function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 60), Vector(-13, -13, 0))
end













/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/