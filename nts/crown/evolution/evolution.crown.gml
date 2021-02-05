
#define init
	{
	global.icon = sprite_add("icon.png", 0, 12, 16)
	global.lock = sprite_add("lock.png", 0, 12, 16)
	global.spr_idle = sprite_add("idle.png", 1, 8, 8)
	global.spr_walk = sprite_add("walk.png", 6, 8, 8)
	
	global.aryNames = 
		[
			[BigMaggot,		JungleFly], 
			[Maggot,		RadMaggot], 
			[Bandit,		JungleBandit], 
			[Scorpion,		GoldScorpion], 
			[Mimic,			SuperMimic], 
			[Exploder,		SuperFrog], 
			[Gator,			BuffGator], 
			[LaserCrystal,	LightningCrystal], 
			[SnowTank,		GoldSnowTank], 
			[Freak,			ExploFreak], 
			[Guardian,		CrownGuardian], 
			[Molefish,		Molesarge], 
			[FireBaller,	SuperFireBaller], 
		]
	global.lenNames = array_length(global.aryNames)
	}

#define crown_name			return "Crown of Evolution"
#define crown_text_base		return "@wELITE ENEMIES@s"
#define crown_text_unlock	return "@sREACH LEVEL @gULTRA@s"
#define crown_tip			return "REVOLUTION"

#define crown_button		sprite_index = global.icon
#define crown_button_lock	sprite_index = global.lock

#define crown_avail			return GameCont.loops == 0



#define crown_take
	{
	sound_play(sndMenuCrown)
	sound_play(sndMutant11Thrn)
	}

#define step
	{
	if(!instance_exists(Crown))
		{instance_create(10016, 10016, Crown)}
	with(Crown)
		{
		spr_idle = global.spr_idle
		spr_walk = global.spr_walk
		}
	for(var i=0; i<global.lenNames; i++)
		{
		with(instances_matching_ne(global.aryNames[@i][@0], "nts_evolution_allow", false))
			{instance_change(global.aryNames[@i][@1], true)}
		}
	}



#define nts_guard_text		return "@gDEFENCE @wDEGRADE ENEMIES@s"
#define nts_guard_tb_text	return "@gDEFENCE @sBIGGER AND SLOWER#DEGRADATION @wRETAIN @gRADS@s"

#define nts_guard_ultra
	{
	for(var i=0; i<global.lenNames; i++)
		{
		with(instances_matching_ne(global.aryNames[@i][@1], "nts_evolution_allow", false))
			{
			if(place_meeting(x, y, GuardianDeflect))
				{
				var h = my_health
				var r = raddrop
				
				instance_change(global.aryNames[@i][@0], true)
				nts_evolution_allow = false
				
				my_health = min(h, my_health)
				if(skill_get(mut_throne_butt))
					{raddrop = max(r, raddrop)}
				}
			}
		}
	}



#define crown_text
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){if(!lq_defget(v.crown, mod_current, false))
		{
		return `${crown_text_base()}#@sunlock: ${crown_text_unlock()}`
		}}
	}
return crown_text_base()