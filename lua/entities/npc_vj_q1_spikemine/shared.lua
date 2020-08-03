ENT.Base 			= "npc_vj_creature_base" -- Full list of bases is in the base, or go back to this link and read the list: https://saludos.sites.google.com/site/vrejgaming/makingvjbaseaddon
ENT.Type 			= "ai"
ENT.PrintName 		= "Spike Mine"
ENT.Author 			= "oteek"
ENT.Contact 		= "http://steamcommunity.com/groups/mawwork"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Quake 1"
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
function ENT:Initialize()
	self.Rotate = 0
	self.RotateTime = CurTime()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	//self:DrawModel()
	self.Rotate = (CurTime() - self.RotateTime)*100
	if self.Rotate >= 360 then
		self.RotateTime = CurTime()
	end
	self:SetAngles(Angle(self.Rotate,self.Rotate,self.Rotate))
    end
end