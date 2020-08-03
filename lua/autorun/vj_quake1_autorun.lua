/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Quake SNPCs"
local AddonName = "Quake SNPCs"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_quake1_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "Quake 1" -- Category
	VJ.AddCategoryInfo(vCat, {Icon = "vj_hl/icons/quake.png"})
	
	VJ.AddNPC("Fiend","npc_vj_q1_demon",vCat)
	VJ.AddNPC("Rottweiler","npc_vj_q1_dog",vCat)
	VJ.AddNPC("Grunt","npc_vj_q1_soldier",vCat)
	VJ.AddNPC("Enforcer","npc_vj_q1_enforcer",vCat)
	VJ.AddNPC("Spike Mine","npc_vj_q1_spikemine",vCat)
	--VJ.AddNPC("Death Knight","npc_vj_q1_hknight",vCat)
	VJ.AddNPC("Ogre","npc_vj_q1_ogre",vCat)
	--VJ.AddNPC("Ogre Marksman","npc_vj_q1_ogrem",vCat)
	VJ.AddNPC("Knight","npc_vj_q1_knight",vCat)
	--VJ.AddNPC("Shub-Niggurath","npc_vj_q1_oldone",vCat)
	--VJ.AddNPC("Vore","npc_vj_q1_shalrath",vCat)
	--VJ.AddNPC("Shambler","npc_vj_q1_shambler",vCat)
	--VJ.AddNPC("Spawn","npc_vj_q1_tarbaby",vCat)
	--VJ.AddNPC("Scrag","npc_vj_q1_wizard",vCat)
	--VJ.AddNPC("Zombie","npc_vj_q1_zombie",vCat)
	--VJ.AddNPC_HUMAN("Dummy Human SNPC","npc_vj_dum_dummy",{"weapon_vj_dummy"},vCat) -- Adds a NPC to the spawnmenu but with a list of weapons it spawns with
	--VJ.AddWeapon("Dummy Weapon","weapon_vj_dummy",false,vCat) -- Adds a weapon to the spawnmenu
		-- First boolean defines whether or not it's an admin-only weapon
	--VJ.AddNPCWeapon("VJ_Dummy", "weapon_vj_dummy") -- Adds a weapon to the NPC weapon list
	--VJ.AddEntity("Dummy Kit","sent_vj_dummykit","Author Name",false,0,true,vCat) -- Adds an entity to the spawnmenu
		-- First boolean defines whether or not it's an admin-only entity
		-- The integer defines the offset of the entity (When it spawns)
		-- Second boolean defines whether or not it should drop to the floor when it spawns
		
	-- Precache Models --
	util.PrecacheModel("models/quake1/demon.mdl")
	util.PrecacheModel("models/quake1/dog.mdl")
	util.PrecacheModel("models/quake1/knight.mdl")
	util.PrecacheModel("models/quake1/ogre_chainsaw.mdl")
	util.PrecacheModel("models/quake1/ogre_fix.mdl")
	util.PrecacheModel("models/quake1/ogre_killed.mdl")
	util.PrecacheModel("models/quake1/shambler_anim.mdl")
	util.PrecacheModel("models/quake1/shambler_killed.mdl")
	util.PrecacheModel("models/quake1/soldier.mdl")
	util.PrecacheModel("models/quake1/dog.mdl")
	
	-- ConVars --
	VJ.AddConVar("vj_q1_demon_h",300)
	VJ.AddConVar("vj_q1_demon_leap_dmg",40)
	VJ.AddConVar("vj_q1_demon_dmg",15)
	VJ.AddConVar("vj_q1_dog_h",25)
	VJ.AddConVar("vj_q1_dog_dmg",24)
	VJ.AddConVar("vj_q1_dog_leap_dmg",15)
	VJ.AddConVar("vj_q1_grunt_h",30)
	VJ.AddConVar("vj_q1_enforcer_h",80)
	VJ.AddConVar("vj_q1_enforcer_laser_dmg",15)
	VJ.AddConVar("vj_q1_zombie_h",60)
	VJ.AddConVar("vj_q1_spikemine_h",200)
	VJ.AddConVar("vj_q1_zombie_dmg",10)
	VJ.AddConVar("vj_q1_ogre_h",200)
	VJ.AddConVar("vj_q1_ogre_dmg",40)
	VJ.AddConVar("vj_q1_shambler_h",600)
	VJ.AddConVar("vj_q1_shambler_claw_dmg",80)
	VJ.AddConVar("vj_q1_shambler_smash_dmg",120)
	VJ.AddConVar("vj_q1_shambler_lightning_dmg",10)

------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end