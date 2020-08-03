ENT.Base 			= "obj_vj_projectile_base"
ENT.Type 			= "anim"
ENT.PrintName 		= "Q1 Enforcer Projectile"
ENT.Author 			= "Mawskeeto"
ENT.Contact 		= "http://steamcommunity.com/groups/mawwork"
ENT.Purpose 		= "Boom!"
ENT.Instructions 	= "Hecc"
ENT.Category		= "Quake 1"

if (CLIENT) then
	local Name = "Q1 Enforcer Projectile"
	local LangName = "obj_vj_q1_enforcerproj"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end