
#define init
global.icon = sprite_add("Icon.png", 1, 8, 8)
global.skill = sprite_add("Skill.png", 1, 12, 16)

#define game_start

#define skill_take
if(instance_exists(LevCont))
	{sound_play()}

#define skill_lose

#define step
	{
	
	}



#define skill_name		return ""
#define skill_text		return ""
#define skill_tip		return []
#define skill_icon		return global.icon
#define skill_button	sprite_index = global.skill

#define skill_wepspec	return 
#define skill_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, "", false)}
	}
