AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/quake1/spikmine.mdl"
ENT.StartHealth = GetConVarNumber("vj_q1_spikemine_h")
ENT.VJ_NPC_Class = {"CLASS_QUAKE1"}
ENT.MovementType = VJ_MOVETYPE_AERIAL
ENT.BloodColor = "Red"
ENT.CustomBlood_Particle = {"vj_hl_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"}
ENT.Aerial_FlyingSpeed_Calm = 80
ENT.Aerial_FlyingSpeed_Alerted = 350
ENT.MeleeAttackDistance = 1
ENT.SoundTbl_Breath = {"q1/spikemine/spikmine.wav"}
ENT.CallForHelp = false
ENT.HasBreathSound = true
ENT.BreathSoundLevel = 70
ENT.DisableWandering = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(30, 22, 20), Vector(-32, -22, -20))
	timer.Simple(0.01,function()
		if IsValid(self) then
		self:SetPos(self:GetPos() + Vector(0,0,50))
		end
	end)
	self:SetTrigger(true)
	self:UseTriggerBounds(true,35)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	local controlled = self.VJ_IsBeingControlled
	if IsValid(self:GetEnemy()) && !controlled then
		local dist = self:VJ_GetNearestPointToEntityDistance(self:GetEnemy())
		if !(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60))) && dist > 5 then
			// Rush the player if not looking
			self.Aerial_FlyingSpeed_Alerted = 800
		else
			self.Aerial_FlyingSpeed_Alerted = 350

		end
	else
		self.Aerial_FlyingSpeed_Alerted = 350
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTouch(ent)
	if self.Dead == false then
		timer.Simple(0.1,function()
			if IsValid(self) then
				self:TakeDamage(99999999999,self,self)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo,hitgroup)
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale(500)
	local spr = ents.Create("env_sprite")
		spr:SetKeyValue("model","vj_hl/sprites/q1/s_explod.vmt")
		spr:SetKeyValue("GlowProxySize","2.0")
		spr:SetKeyValue("HDRColorScale","1.0")
		spr:SetKeyValue("renderfx","14")
		spr:SetKeyValue("rendermode","5")
		spr:SetKeyValue("renderamt","255")
		spr:SetKeyValue("disablereceiveshadows","0")
		spr:SetKeyValue("mindxlevel","0")
		spr:SetKeyValue("maxdxlevel","0")
		spr:SetKeyValue("framerate","10.0")
		spr:SetKeyValue("spawnflags","0")
		spr:SetKeyValue("scale","1")
		spr:SetPos(self:GetPos())
		spr:Spawn()
		spr:Fire("Kill","",0.51)
		timer.Simple(0.51,function() if IsValid(spr) then spr:Remove() end end)
	self:EmitSound("weapons/q1/r_exp3.wav", 100, 100)
	self.ExplosionLight1 = ents.Create("light_dynamic")
	self.ExplosionLight1:SetKeyValue("brightness", "4")
	self.ExplosionLight1:SetKeyValue("distance", "300")
	self.ExplosionLight1:SetLocalPos(self:GetPos())
	self.ExplosionLight1:SetLocalAngles( self:GetAngles() )
	self.ExplosionLight1:Fire("Color", "255 150 0")
	self.ExplosionLight1:SetParent(self)
	self.ExplosionLight1:Spawn()
	self.ExplosionLight1:Activate()
	self.ExplosionLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.ExplosionLight1)
	util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)
	util.BlastDamage(self,self,self:GetPos(),150,200) 
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(argent,attacker,inflictor)
	if IsValid(argent) then
		local name = argent:GetName()
		PrintMessage( HUD_PRINTCONSOLE, " " )
		PrintMessage( HUD_PRINTCONSOLE, "'"..name.."' was blasted by a spike mine" )
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/