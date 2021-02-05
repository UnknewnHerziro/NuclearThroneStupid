#define init
icon = sprite_add("Icon.png", 1, 8, 8)
skill = sprite_add("Skill.png", 1, 12, 16)

globalvar icon, skill

#define step
with(Player)
	{script_bind_end_step(ref_es, 0, self, gunangle)}

#define ref_es
	{
	with(argument0)
		{
		if(reload > 0)
			{
			reload -= weapon_get_load(wep) * abs(angle_difference(argument1, gunangle)) / 360
			if(reload <= 0)
				{
				reload = 0
			//	sound_play_hit(sndEmpty, 0.3)
				}
			}
		}
	instance_destroy()
	}

#define skill_name
return "Geometrical Elbow"
#define skill_text
return "@sSPIN TO @wRELOAD@s"
#define skill_tip
return []
#define skill_icon
return icon
#define skill_button
sprite_index = skill

#define skill_wepspec
return false
#define skill_avail
return true