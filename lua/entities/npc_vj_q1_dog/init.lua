AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_NPC_Class = {"CLASS_QUAKE1"}
ENT.Model = "models/quake1/dog.mdl"
ENT.HullType = HULL_TINY
ENT.StartHealth = GetConVarNumber("vj_q1_dog_h")
ENT.LeapAttackDamage = GetConVarNumber("vj_q1_dog_leap_dmg")
ENT.MeleeAttackDamage = GetConVarNumber("vj_q1_dog_dmg")
ENT.LeapToMeleeDistance = 200
ENT.LeapAttackDamageDistance = 100
ENT.LeapAttackVelocityForward = 100
ENT.LeapAttackVelocityUp = 150
ENT.HasDeathAnimation = true
ENT.DeathAnimationTime = 0.65
ENT.UsesDamageForceOnDeath = false
ENT.AnimTbl_Death = {ACT_DIESIMPLE}
ENT.SoundTbl_Alert = {"q1/dog/dsight.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"q1/dog/dattack1.wav"}
ENT.SoundTbl_MeleeAttack = {"q1/demon/dhit.wav"}
ENT.SoundTbl_LeapAttackJump = {"q1/dog/dattack1.wav"}
--ENT.SoundTbl_MeleeAttackMiss = {"q1/dog/dattack1.wav"}
ENT.SoundTbl_Idle = {"q1/dog/idle.wav"}
ENT.SoundTbl_LeapAttackDamage = {"q1/demon/dhit2.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"q1/demon/dhit2.wav"}
--ENT.SoundTbl_MeleeAttack = { "q1/dog/dhit2.wav" }
ENT.SoundTbl_Pain = {"q1/dog/dpain1.wav"}
ENT.SoundTbl_Death = {"q1/dog/ddeath.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(30, 22, 45), Vector(-32, -22, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if self:Health() <= -35 then
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
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib1.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib1.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib1.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib1.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/h_dog.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
		return true -- Return to true if it gibbed!
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(argent,attacker,inflictor)
	if IsValid(argent) then
		local name = argent:GetName()
		PrintMessage( HUD_PRINTCONSOLE, " " )
		PrintMessage( HUD_PRINTCONSOLE, ""..name.." was mauled by a Rottweiler" )
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/