#define init
icon = sprite_add("Icon.png", 1, 8, 8)
skill = sprite_add("Skill.png", 1, 12, 16)

globalvar icon, skill

#define skill_take
if(instance_exists(LevCont))
	{sound_play(sndChickenRegenHead)}

#define step
with(Player)
	{script_bind_end_step(ref_es, 0, self, my_health, variable_instance_get(self, "nts_pn_def", 0))}

#define ref_es(inst, lh, def)
	{
	with(inst)
		{
		if(my_health<lh && my_health>0)
			{
			if(lh-my_health <= def)
				{
				my_health = lh
				nts_pn_def = 0
				}
			else{
				my_health += def
				if(my_health >= maxhealth)
					{
					nts_pn_def = 0
					my_health = maxhealth
					}
				else{nts_pn_def = def + 1}
				}
			}
		}
	instance_destroy()
	}



#define skill_name
return "paralytic nerve"
#define skill_text
return "@sABSORB PARTIAL @rNONLETHAL @wDAMAGE"

#define skill_tip
return "@ranesthetic"
#define skill_icon
return icon
#define skill_button
sprite_index = skill

#define skill_wepspec
return false
#define skill_avail
return true//	!mod_exists("mod", "ntte")		//because some bugs