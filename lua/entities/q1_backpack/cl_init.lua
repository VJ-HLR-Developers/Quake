//borrowed from upset

include('shared.lua')

function ENT:Initialize()
	self.Rotate = 0
	self.RotateTime = CurTime()
end

function ENT:Draw()
	self:DrawModel()
	self.Rotate = (CurTime() - self.RotateTime)*100
	if self.Rotate >= 360 then
		self.RotateTime = CurTime()
	end
	self:SetAngles(Angle(0,self.Rotate,0))
end