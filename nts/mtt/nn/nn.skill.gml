#define init
icon = sprite_add("Icon.png", 1, 8, 8)
skill = sprite_add("Skill.png", 1, 12, 16)

globalvar icon, skill

#define skill_take
if(instance_exists(LevCont))
	{sound_play(sndLastTaunt)}

#define step
if(instance_exists(Player))
	{
	with(Revive)
		{
		var sp = instance_nearest(x, y, Player)
		direction = point_direction(x, y, sp.x, sp.y)
		speed = 2
		
		var bsp = self
		var bspi = p
		var w = wep
		var bw = bwep
		if(fork())
			{
			wait 1
			if(!instance_exists(self))
				{
				with(instances_matching(Player, "index", bspi))
					{
					if(wep==0){with(instances_matching(WepPickup,"wep",w)){other.wep=wep; instance_destroy()}}
					if(bwep==0){with(instances_matching(WepPickup,"wep",bw)){other.bwep=wep; instance_destroy()}}
					my_health = maxhealth
					}
				}
			exit
			}
		}
	}



#define skill_name
return "neural network"
#define skill_text
return "tow dead teammates"
#define skill_tip
return "community"
#define skill_icon
return icon
#define skill_button
sprite_index = skill

#define skill_wepspec
return false
#define skill_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){if(!lq_defget(v.race, "clown", false)){return false}}
	}
for({var pn = -1; var i = 0}; i<maxp; i++){pn += player_is_active(i)}
return pn