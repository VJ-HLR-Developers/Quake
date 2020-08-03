AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.AmmoType = "SMG1"
ENT.Amount = 1
--ENT.IsBeingRemoved = false

function ENT:Initialize()
	self:SetModel("models/quake1/backpack.mdl")
	self:SetMoveType(MOVETYPE_FLYGRAVITY)
	self:SetTrigger(true)
	self:UseTriggerBounds(true,15)
	timer.Simple(120, function()
		if IsValid(self) then
			self:Remove()
		end
	end)
end

function ENT:Touch(ent)
	if IsValid(ent) && ent:IsPlayer() && ent:Alive() then
		ent:GiveAmmo(self.Amount,self.AmmoType,true)
		if self.AmmoType == "Q1Shells" then
			PrintMessage(HUD_PRINTCONSOLE,"You got "..self.Amount.." shells")
		elseif self.AmmoType == "Q1Cells" then
			PrintMessage(HUD_PRINTCONSOLE,"You got "..self.Amount.." cells")
		elseif self.AmmoType == "Q1Rockets" then
			PrintMessage(HUD_PRINTCONSOLE,"You got "..self.Amount.." rockets")
		end
		self:EmitSound("weapons/q1/am_pkup.wav")
		self:Remove()
	end
end