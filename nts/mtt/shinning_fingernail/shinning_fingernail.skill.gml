
#define init
global.icon = sprite_add("Icon.png", 1, 8, 8);
global.skill = sprite_add("Skill.png", 1, 12, 16);

#define skill_take
if(instance_exists(LevCont))
	{
	sound_play(sndCrystalShield)
	sound_play(sndMutant2Chst)
	}

#define step
	{
	var p_t = null
	with(Player)
		{
		if(is_undefined(p_t))
			{p_t = team}
		else{
			if(p_t != team)
				{
				with(projectile)
					{typ = 0}
				exit
				}
			}
		}
	
	with(instances_matching(projectile, "typ", 1, 2))
		{typ = team != p_t}
	}



#define skill_name		return "SHINNING FINGERNAIL"
#define skill_text		return "@wPROJECTILES @sARE @wUNDEFLECTABLE#OPPOSITES @sFOR THE @wENIMIES"
#define skill_tip		return []
#define skill_icon		return global.icon
#define skill_button	sprite_index = global.skill

#define skill_wepspec	return true
#define skill_avail		return true
