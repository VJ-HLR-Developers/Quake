AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
-- General --
ENT.VJ_NPC_Class = {"CLASS_QUAKE1"}
ENT.Model = "models/quake1/demon.mdl"
ENT.HullType = HULL_MEDIUM
ENT.UsesBoneAngle = true
ENT.StartHealth = GetConVarNumber("vj_q1_demon_h")
ENT.BloodColor = "Red"
ENT.CustomBlood_Particle = {"vj_hl_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false
ENT.TurningSpeed = 180 -- How fast it can turn
--ENT.RangeAttackAngleRadius = 60
-- Flinching --
ENT.CanFlinch = 1
ENT.FlinchChance = 2
-- Death --
ENT.GibOnDeathDamagesTable = {"All"}
ENT.HasDeathAnimation = true
ENT.DeathAnimationTime = 0.5
ENT.AnimTbl_Death = {ACT_DIESIMPLE}
-- Leaping --
ENT.NextLeapAttackTime = 0
ENT.LeapAttackDamage = 40
ENT.LeapAttackVelocityForward = 400
ENT.LeapAttackVelocityUp = 250
ENT.HasLeapAttack = true
ENT.LeapToMeleeDistance = 130
ENT.LeapAttackDamageDistance = 130
ENT.TimeUntilLeapAttackDamage = 0.5
ENT.TimeUntilMeleeAttackDamage = false
-- Melee --
ENT.HasExtraMeleeAttackSounds = true
ENT.MeleeAttackDamage = 15
-- Animation Tables
ENT.AnimTbl_LeapAttack = {"vjseq_leap"}
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
ENT.AnimTbl_Flinch = {"vjseq_pain"}
-- Sound --
ENT.DisableFootStepSoundTimer = true
ENT.HasFootStepSound = true
ENT.FootStepSoundLevel = 75
ENT.GeneralSoundPitch1 = 100

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(30,20,45),Vector(-20,-20,0))
	self.SoundTbl_Alert = {"q1/demon/sight2.wav"}
	self.SoundTbl_MeleeAttack = {"q1/demon/dhit2.wav"}
	self.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
	self.SoundTbl_Idle = {"q1/demon/idle1.wav"}
	self.SoundTbl_LeapAttackJump = {"q1/demon/djump.wav"}
	self.SoundTbl_LeapAttackDamage = {"q1/demon/dhit.wav"}
	self.SoundTbl_MeleeAttackExtra = {"q1/demon/dhit.wav"}
	self.SoundTbl_Pain = {"q1/demon/dpain1.wav"}
	self.SoundTbl_Death = {"q1/demon/ddeath.wav"}
	self.SoundTbl_FootStep = {"q1/demon/foot.wav","q1/demon/foot2.wav"}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "melee" then
		self:MeleeAttackCode()
	end
	if key == "step" then
		self:FootStepSoundCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if self:Health() <= -80 then
		self.HasDeathSounds = false
			if self.HasGibDeathParticles == true then
				local bloodeffect = EffectData()
				bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
				bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
				bloodeffect:SetScale(120)
				util.Effect("VJ_Blood1",bloodeffect)
			
				local bloodspray = EffectData()
				bloodspray:SetOrigin(self:GetPos())
				bloodspray:SetScale(8)
				bloodspray:SetFlags(3)
				bloodspray:SetColor(0)
				util.Effect("bloodspray",bloodspray)
				util.Effect("bloodspray",bloodspray)
			end
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib1.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib1.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,20))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib1.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,30))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/h_demon.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,25))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib2.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,25))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,5))})
		return true -- Return to true if it gibbed!
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	VJ_EmitSound(self,"q1/player/udeath.wav", 90, math.random(100,100))
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(argent,attacker,inflictor)
	if IsValid(argent) then
		local name = argent:GetName()
		PrintMessage( HUD_PRINTCONSOLE, " " )
		PrintMessage( HUD_PRINTCONSOLE, "'"..name.."' was eviscerated by a Fiend" )
	end
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/