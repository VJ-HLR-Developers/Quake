AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_NPC_Class = {"CLASS_QUAKE1"}
ENT.Model = "models/quake1/knight.mdl"
ENT.StartHealth = 75

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {ACT_DIESIMPLE}
--ENT.DeathAnimationTime = 0.8
ENT.CustomBlood_Particle = {"vj_hl_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"}
ENT.GibOnDeathDamagesTable = {"All"}
ENT.HasBloodPool = false

ENT.CanFlinch = 1
ENT.MeleeAttackDamage = 15
ENT.FlinchChance = 1

ENT.HasExtraMeleeAttackSounds = true

ENT.AnimTbl_Flinch = {"vjseq_pain","vjseq_painb"}

ENT.SoundTbl_Alert = { "q1/knight/ksight.wav" }
ENT.SoundTbl_MeleeAttack = { "q1/knight/sword1.wav", "q1/knight/sword2.wav" }
ENT.SoundTbl_MeleeAttackMiss = { "q1/knight/sword1.wav", "q1/knight/sword2.wav" }
ENT.SoundTbl_Idle = { "q1/knight/idle.wav" }
ENT.SoundTbl_MeleeAttackExtra = { "q1/hit1.wav" }
--ENT.SoundTbl_MeleeAttack = { "q1/demon/dhit2.wav" }
ENT.SoundTbl_Pain = { "q1/knight/khurt.wav" }
ENT.SoundTbl_Death = { "q1/knight/kdeath.wav" }
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if self:Health() <= -40 then
		self.Backpack_SpawnEnt = false
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
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,20))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib2.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,30))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib1.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib1.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/h_knight.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
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
		PrintMessage( HUD_PRINTCONSOLE, ""..name.." was slashed by a Knight" )
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/