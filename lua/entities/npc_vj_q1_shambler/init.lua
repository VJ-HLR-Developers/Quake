AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_NPC_Class = {"CLASS_QUAKE1"}
ENT.Model = "models/quake1/shambler_anim.mdl"
ENT.DeathCorpseModel = { "models/quake1/shambler_killed.mdl" }
ENT.HasDeathRagdoll = true
ENT.RangeDistance = 2000
ENT.RangeToMeleeDistance = 500 
--ENT.StartHealth = GetConVarNumber("vj_q1_shambler_health")
ENT.StartHealth = 600
ENT.BloodColor = "Red"
----------------------------------------------------------
ENT.MeleeAttackDamage = 80
----------------------------------------------------------
ENT.CanFlinch = 1
ENT.FlinchChance = 1
ENT.FlinchAnimation_UseSchedule = true
----------------------------------------------------------
ENT.ScheduleTbl_Flinch = {SCHED_BIG_FLINCH}
--ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH}
ENT.AnimTbl_Death = {ACT_DIESIMPLE}
----------------------------------------------------------
ENT.HasRangeAttack = true
ENT.RangeAttackPos_Up = 100
ENT.NextRangeAttackTime = 1
ENT.RangeAttackEntityToSpawn = "obj_vj_q1_shambler_lightning"
ENT.TimeUntilRangeAttackProjectileRelease = 0.5
----------------------------------------------------------
ENT.SoundTbl_Alert = { "q1/shambler/ssight.wav" }
ENT.SoundTbl_MeleeAttack = { "q1/shambler/melee1.wav", "q1/shambler/melee2.wav" }
ENT.SoundTbl_MeleeAttackMiss = { "npc/zombie/claw_miss1.wav", "npc/zombie/claw_miss2.wav" }
ENT.SoundTbl_Idle = { "q1/shambler/sidle.wav" }
ENT.SoundTbl_MeleeAttackExtra = { "q1/shambler/smack.wav" }
ENT.SoundTbl_MeleeAttack = { "q1/shambler/smack.wav" }
ENT.SoundTbl_BeforeRangeAttack = { "q1/shambler/sattck1.wav" }
--ENT.SoundTbl_RangeAttack = { "q1/shambler/sboom.wav" }
ENT.SoundTbl_Pain = { "q1/shambler/shurt2.wav" }
ENT.SoundTbl_Death = { "q1/shambler/sdeath.wav" }
----------------------------------------------------------
ENT.HullType = HULL_MEDIUM_TALL
ENT.HasExtraMeleeAttackSounds = true

function ENT:CustomOnInitialize()
	self:SetModelScale( 1.25, 0.1 )
end

function ENT:MultipleMeleeAttacks()	
	local randattack = math.random(1,2)
        if randattack == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_swing"}
		self.NextAnyAttackTime_Melee = 0.72
		self.MeleeAttackDistance = 100
		self.MeleeAttackExtraTimers = {}
		--self.MeleeAttackDamage = GetConVarNumber("vj_q1_shambler_claw")
		self.MeleeAttackDamageDistance = 120
		self.MeleeAttackDamage = 80

        elseif randattack == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_smash"}
		self.NextAnyAttackTime_Melee = 0.72
		self.MeleeAttackDistance = 80
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamageDistance = 100
		--self.MeleeAttackDamage = GetConVarNumber("vj_q1_shambler_smash")
		self.MeleeAttackDamage = 120
	end
end		


/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/