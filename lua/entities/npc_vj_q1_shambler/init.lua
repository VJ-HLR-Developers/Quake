AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_NPC_Class = {"CLASS_QUAKE1"}
ENT.Model = "models/quake1/shambler.mdl"
ENT.BloodColor = "Red"
ENT.CustomBlood_Particle = {"vj_hl_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasDeathRagdoll = true
ENT.RangeDistance = 2000
ENT.RangeToMeleeDistance = 500 
--ENT.StartHealth = GetConVarNumber("vj_q1_shambler_health")
ENT.StartHealth = 600
ENT.BloodColor = "Red"
ENT.CustomBlood_Particle = {"vj_hl_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false
----------------------------------------------------------
ENT.MeleeAttackDamage = 80
-- Flinching --
ENT.CanFlinch = 1
ENT.FlinchChance = 2
-- Death --
ENT.GibOnDeathDamagesTable = {"All"}
ENT.HasDeathAnimation = true
ENT.DeathAnimationTime = 1
ENT.AnimTbl_Death = {ACT_DIESIMPLE}
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
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own
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
ENT.HullType = HULL_LARGE
ENT.HasExtraMeleeAttackSounds = true
--------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(60,60,124), Vector(-60,-60,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PitWorm_DoLaserEffects()
	local startpos = self:GetPos() + self:GetUp()*250 + self:GetForward()*230
	local tr = util.TraceLine({
		start = startpos,
		endpos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(),
		filter = self
	})
	local elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(tr.HitPos)
	elec:SetEntity(self)
	elec:SetAttachment(1)
	util.Effect("VJ_Q1_Electric", elec)
	return tr.HitPos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	self:PitWorm_DoLaserEffects()
	
	local StartGlow1 = ents.Create("env_sprite")
	StartGlow1:SetKeyValue("model","vj_hl/sprites/flare3.vmt")
	StartGlow1:SetKeyValue("rendercolor","161 219 255")
	StartGlow1:SetKeyValue("GlowProxySize","5.0")
	StartGlow1:SetKeyValue("HDRColorScale","1.0")
	StartGlow1:SetKeyValue("renderfx","14")
	StartGlow1:SetKeyValue("rendermode","3")
	StartGlow1:SetKeyValue("renderamt","255")
	StartGlow1:SetKeyValue("disablereceiveshadows","0")
	StartGlow1:SetKeyValue("mindxlevel","0")
	StartGlow1:SetKeyValue("maxdxlevel","0")
	StartGlow1:SetKeyValue("framerate","10.0")
	StartGlow1:SetKeyValue("spawnflags","0")
	StartGlow1:SetKeyValue("scale","3")
	StartGlow1:SetPos(self:GetPos())
	StartGlow1:Spawn()
	StartGlow1:SetParent(self)
	StartGlow1:Fire("SetParentAttachment", "0")
	self:DeleteOnRemove(StartGlow1)
	timer.Simple(0.65, function() if IsValid(self) && IsValid(StartGlow1) then StartGlow1:Remove() end end)
	
	for i = 0.1, 0.1, 0.1 do
		timer.Simple(i,function()
			if IsValid(self) && IsValid(self:GetEnemy()) && self.RangeAttacking == true then
				local hitpos = self:PitWorm_DoLaserEffects()
				util.VJ_SphereDamage(self,self,hitpos,1,10,DMG_SHOCK,true,false,{Force=90})
				sound.Play("q1/shambler/sboom.wav", hitpos, 80)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if self:Health() <= -60 then
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
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib1.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(10,0,35))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/h_shams.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,72))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib2.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,25))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib2.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(-20,20,50))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,5))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,5))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,40,40))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,-40,40))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,30))})
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
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/