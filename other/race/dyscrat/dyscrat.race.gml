
#define init
	{
	global.spr_idle = sprite_add("idle.png", 27, 12, 15)
	global.spr_idle2 = sprite_add("idle2.png", 8, 12, 17)
	global.spr_walk = sprite_add("walk.png", 6, 12, 14)
	global.spr_walk2 = sprite_add("walk2.png", 8, 12, 17)
	global.spr_hurt = sprite_add("hurt.png", 3, 12, 15)
	global.spr_hurt2 = sprite_add("hurt2.png", 3, 12, 17)
	global.spr_dead = sprite_add("dead.png", 13, 13, 17)
	global.mapicon  = sprite_add("mapicon.png", 1, 10, 10)
	global.portrait = sprite_add("portrait.png", 1, -2, 209)
	global.chs = sprite_add("CharSelect.png", 1, 0, 0)
	
	globalvar sprPunch, sprPunchIdle
	sprPunch = //You may thinking the sizes of sprites and the numbers of offsets looks so weird, right? Well freaking so do I. He drew the 7 captain sprites and 6 punch sprites 3 times and the names, sizes and offsets of them are different every time, EVERY sprites in EVERY folder in EVERY time. why couldn't he just draw them all in the same size? WHY??? 
		[
			[
				sprite_add("pa.png", 6, 24, 24), 
				sprite_add("pa2.png", 7, 32, 22), 
			], 
			sprite_add("pb.png", 1, 21, 15), 
			sprite_add("pc.png", 4, 32, 30), 
			sprite_add("pd.png", 4, 25, 25), 
			[
				sprite_add("pe.png", 6, 24, 24), 
				sprite_add("pe2.png", 7, 32, 22), 
			], 
		]
	sprPunchIdle = sprite_add("portal.png", 8, 32, 22)
	}

#define nts_weapon_examine	return 
	{
	"0":	"Your fists. ", 
	}



#define create
	{
	image_speed_raw = 0.4
	spr_idle = global.spr_idle
	spr_walk = global.spr_walk
	spr_hurt = global.spr_hurt
	spr_dead = global.spr_dead
	spr_sit1 = global.spr_idle
	spr_sit2 = global.spr_idle
	snd_hurt = sndLastHurt
	snd_dead = sndLastDeath
	snd_lowa = sndLastHalfHP
	snd_lowh = sndLastLowHP
	snd_chst = sndLastPattern1
	snd_wrld = sndLastIntro
	snd_valt = sndLastTaunt
	snd_crwn = sndLastPattern2
	snd_thrn = sndLastTaunt
	snd_spch = sndLastTaunt
	snd_idpd = sndLastIntro
	snd_cptn = sndLastTaunt
	}

#define step
	{
	if(GameCont.level == 10)
		{
		spr_idle = global.spr_idle2
		spr_walk = global.spr_walk2
		spr_hurt = global.spr_hurt2
		}
	
	var ary = instances_matching(instances_matching(CustomHitme, "ntstype", "dyscrat_punch"), "index", index)
	if(array_length(ary) == 0)
		{
		with(instance_create(x, y, CustomHitme))
			{
			index = other.index
			
			sprite_index = sprPunchIdle
			mask_index = mskNone
			
			on_step = 
			on_draw = 
			}
		}
	}



#define race_name		return "DYSCRAT"
#define race_text		return ""

#define race_portrait	return global.portrait
#define race_mapicon	return global.mapicon

#define race_swep		return 

#define race_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock		return "DEFEAT ???"

#define race_menu_button
sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}
#define race_menu_select	return sndLastPattern2
#define race_menu_confirm	return sndLastPattern1
/*
#define race_skins	return 2
#define race_skin_name(skin)
switch(argument0)
	{
	case 0: return 
	case 1: return 
	default: break
	}
#define race_skin_button
switch(argument0)
	{
	case 0: sprite_index = ; break
	case 1: sprite_index = ; break
	default: break
	}
*/
#define race_tb_text	return ""
#define race_tb_take

#define race_ultra_name
switch(argument0)
	{
	case 1: return ""
	case 2: return ""
	default: return ""
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return ""
	case 2: return ""
	default: return ""
	}
/*
#define race_ultra_button
switch(argument0)
	{
	case 1: sprite_index = 
	case 2: sprite_index = 
	default: sprite_index = 
	}

#define race_ultra_take
switch(argument0)
	{
	case 1: break
	case 2: break
	default: break
	}

#define race_ultra_icon
switch(argument0)
	{
	case 1: return 
	case 2: return 
	default: return 
	}
*/
#define race_ttip
return []


