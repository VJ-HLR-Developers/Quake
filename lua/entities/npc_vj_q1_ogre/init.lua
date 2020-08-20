AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_NPC_Class = {"CLASS_QUAKE1"}
ENT.Model = "models/quake1/ogre.mdl"
ENT.HullType = HULL_HUMAN
ENT.BloodColor = "Red"
ENT.CustomBlood_Particle = {"vj_hl_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"}
ENT.HasBloodPool = false
ENT.StartHealth = GetConVarNumber("vj_q1_ogre_h")
ENT.GibOnDeathDamagesTable = {"All"}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.RangeAttackEntityToSpawn = "obj_vj_q1_grenade"
ENT.HasRangeAttack = true
ENT.RangeDistance = 900
ENT.RangeToMeleeDistance = 200
ENT.RangeAttackPos_Up = 75
ENT.RangeAttackAnimationDelay = 0.01
ENT.TimeUntilRangeAttackProjectileRelease = 0.5
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.DisableFootStepOnRun = true
ENT.NextAnyAttackTime_Melee = 1.29
ENT.MeleeAttackDamage = 15
ENT.RangeAttackPos_Right = -5
ENT.MeleeAttackExtraTimers = {0.5}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.CanFlinch = 1
ENT.FlinchChance = 1
ENT.HasDeathAnimation = true
ENT.DeathAnimationTime = 0.8
ENT.AnimTbl_Death = {ACT_DIESIMPLE}
ENT.HasExtraMeleeAttackSounds = true
--ENT.AnimTbl_MeleeAttack = {"vjseq_smash","vjseq_swing"}
ENT.AnimTbl_Flinch = {"vjseq_pain","vjseq_painb","vjseq_painc","vjseq_paind","vjseq_paine"}
ENT.FootStepTimeWalk = 1.5
ENT.SoundTbl_Alert = { "q1/ogre/ogwake.wav" }
--ENT.SoundTbl_Breath = { "q1/ogre/og_chainsawidle.wav" }
ENT.SoundTbl_MeleeAttack = { "q1/ogre/ogsawatk.wav" }
ENT.SoundTbl_MeleeAttackMiss = { "q1/ogre/ogsawatk.wav" }
ENT.SoundTbl_Idle = { "q1/ogre/ogidle.wav", "q1/ogre/ogidle2.wav" }
ENT.SoundTbl_MeleeAttackExtra = { "q1/hit1.wav" }
ENT.SoundTbl_Pain = { "q1/ogre/ogpain1.wav" }
ENT.SoundTbl_Death = { "q1/ogre/ogdth.wav" }
ENT.SoundTbl_RangeAttack = { "q1/weapons/grenade.wav" }
ENT.SoundTbl_FootStep = { "q1/ogre/ogdrag.wav" }
ENT.MeleeAttackDamageDistance = 120
-- Custom
ENT.Backpack_SpawnEnt = true
ENT.SpawnGarbage = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	--self:SetModelScale( 1.35, 0.1 ) 
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
	if self.VJ_IsBeingControlled == true then return end
	self:VJ_ACT_PLAYACTIVITY("pull",true,false,true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "attack" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
--[[
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	self:SetBodygroup(0,1)
	self:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
end
--]]
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	self:SetBodygroup(0,1)
	self:SpawnBackpack()
	self:SpawnGarbageShit()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo,hitgroup)
	self:SetBodygroup(0,1)
	self:SpawnBackpack()
	self:SpawnGarbageShit()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnBackpack()
	if self.Backpack_SpawnEnt == true then
		self.Backpack = ents.Create("q1_backpack")
		self.Backpack:SetPos(self:GetPos() + self:GetUp()*30)
		self.Backpack:SetAngles(self:GetAngles())
		self.Backpack:Spawn()
		self.Backpack:Activate()
		self.Backpack.Amount = 2
		self.Backpack.AmmoType = "Q1Rockets"
		self.Backpack_SpawnEnt = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnGarbageShit()
	if self.SpawnGarbage == true then
		self:CreateGibEntity("obj_vj_gib","models/quake1/ogre_gl.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,35,30)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
		self:CreateGibEntity("obj_vj_gib","models/quake1/ogre_chainsaw.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,-30,30)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
		self.SpawnGarbage = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if self:Health() <= -80 then
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
		--self:CreateGibEntity("obj_vj_gib","models/quake1/ogre_chainsaw.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
		--self:CreateGibEntity("obj_vj_gib","models/quake1/ogre_gl.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,20))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,30))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib2.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/gib3.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/gibs/h_ogre.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
		self:CreateGibEntity("obj_vj_gib","models/quake1/ogre_gl.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
		self:CreateGibEntity("obj_vj_gib","models/quake1/ogre_chainsaw.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
		return true -- Return to true if it gibbed!
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	VJ_EmitSound(self,"q1/player/udeath.wav", 90, math.random(100,100))
	return false
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/