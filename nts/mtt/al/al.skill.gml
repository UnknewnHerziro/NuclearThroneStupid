#define init
icon = sprite_add("Icon.png", 1, 8, 8)
skill = sprite_add("Skill.png", 1, 12, 16)

globalvar icon, skill

#define skill_take
if(instance_exists(LevCont))
	{
	sound_play_pitch(9,0.5)
	wait 15
	sound_play_pitch(7,0.5)
	wait 20
	sound_play_pitch(4,0.5)
	}

#define step
with(instances_matching_ne(Player, "wep", wep_jackhammer))
	{
	if(!weapon_is_melee(wep) && reload>0)
		{
		reload -= current_time_scale * 0.5
		if(canfire && button_check(index,"fire"))
			{clicked = true}
		else{clicked = false}
		}
	}

#define skill_name
return "artificial limb"
#define skill_text
return "higher rate of fire#automatic weapons"
#define skill_tip
return "automatic module"
#define skill_icon
return icon
#define skill_button
sprite_index = skill

#define skill_wepspec
return true
#define skill_avail		return true
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, "bronya", false)}
	}