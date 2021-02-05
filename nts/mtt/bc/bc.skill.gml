#define init
icon = sprite_add("Icon.png", 1, 8, 8);
skill = sprite_add("Skill.png", 1, 12, 16);

globalvar icon, skill, lh

#define skill_take
if(instance_exists(LevCont))
	{
	sound_play(sndIDPDNadeExplo)
	sound_play(sndMutant12Thrn)
	}

#define step
with(Player)
	{script_bind_end_step(ref_es, 0, self, my_health)}

#define ref_es
	{
	with(argument0)
		{
		if(my_health < argument1)
			{
			with(instance_create(x, y, PopoExplosion))
				{
				creator = other
				team = other.team
				hitid = [icon, "pad"]
				}
			}
		}
	instance_destroy()
	}

#define skill_name
return "blast chest"
#define skill_text
return "@bexplode @swhen taking damage"

#define skill_tip
return "not a bra pad"
#define skill_icon
return icon
#define skill_button
sprite_index = skill

#define skill_wepspec
return false
#define skill_avail
return true