AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_NPC_Class = {"CLASS_QUAKE1"}
ENT.Model = "models/quake1/soldier.mdl"
ENT.HullType = HULL_HUMAN
ENT.StartHealth = GetConVarNumber("vj_q1_grunt_h")
ENT.BloodColor = "Red"
ENT.CustomBlood_Particle = {"vj_hl_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"}
ENT.HasBloodPool = false
ENT.HasMeleeAttack = false
ENT.GibOnDeathDamagesTable = {"All"}
ENT.CanFlinch = 1
ENT.FlinchChance = 1
ENT.HasDeathAnimation = true
ENT.DeathAnimationTime = 0.58
ENT.AnimTbl_Death = {ACT_DIESIMPLE}
ENT.Weapon_NoSpawnMenu = true
ENT.DisableWeaponFiringGesture = true
ENT.MoveRandomlyWhenShooting = false
ENT.HasLostWeaponSightAnimation = true
ENT.HasItemDropsOnDeath = false
ENT.AnimTbl_Flinch = {"vjseq_pain","vjseq_painb","vjseq_painc"}
ENT.HasFootStepSound = false
ENT.GeneralSoundPitch1 = 100
-- Custom
ENT.Backpack_SpawnEnt = true
ENT.IsEnforcer = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	--self:SetCollisionBounds(Vector(30, 22, 45), Vector(-32, -22, 0))
	self:Give("weapon_vj_q1_soldiershotgun")
	self.SoundTbl_Alert = {"q1/soldier/sight1.wav"}
	self.SoundTbl_Idle = {"q1/soldier/idle.wav"}
	self.SoundTbl_Pain = {"q1/soldier/pain1.wav","q1/soldier/pain2.wav"}
	self.SoundTbl_Death = {"q1/soldier/death1.wav"}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "boom" then
		local wep = self:GetActiveWeapon()
		if IsValid(wep) then
			wep:NPCShoot_Primary(ShootPos,ShootDir)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if self:Health() <= -35 then
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
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib1.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		if self.IsEnforcer == false then
			self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/h_guard.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
		else
			self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/h_mega.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
		end
		return true -- Return to true if it gibbed!
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(argent,attacker,inflictor)
	if IsValid(argent) then
		local name = argent:GetName()
		PrintMessage( HUD_PRINTCONSOLE, " " )
		if self.IsEnforcer == false then
			PrintMessage( HUD_PRINTCONSOLE, ""..name.." was shot by a Grunt" )
		else
			PrintMessage( HUD_PRINTCONSOLE, ""..name.." was blasted by a Enforcer" )
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	VJ_EmitSound(self,"q1/player/udeath.wav", 90, math.random(100,100))
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnBackpack()
	if self.Backpack_SpawnEnt == true then
		self.Backpack = ents.Create("q1_backpack")
		self.Backpack:SetPos(self:GetPos() + self:GetUp()*30)
		self.Backpack:SetAngles(self:GetAngles())
		self.Backpack:Spawn()
		self.Backpack:Activate()
		self.Backpack.Amount = 5
		if self.IsEnforcer == false then
			self.Backpack.AmmoType = "Q1Shells"
		else
			self.Backpack.AmmoType = "Q1Cells"
		end
		self.Backpack_SpawnEnt = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo,hitgroup)
	self:SetBodygroup(0,1)
	self:SpawnBackpack()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	self:SetBodygroup(0,1)
	self:DropWeaponOnDeathCode(dmginfo, hitgroup)
	self:SpawnBackpack()
	if IsValid(self:GetActiveWeapon()) then self:GetActiveWeapon():Remove() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/