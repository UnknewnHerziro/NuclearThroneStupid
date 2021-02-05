
#define init
	{
	global.spr_idle		= sprite_add("idle.png",		4,	12,	12)
	global.spr_walk		= sprite_add("walk.png",		6,	12,	12)
	global.spr_hurt		= sprite_add("hurt.png",		3,	12,	12)
	global.spr_dead		= sprite_add("dead.png",		6,	12,	12)
	global.spr_idleb	= sprite_add("idleb.png",		4,	12,	12)
	global.spr_walkb	= sprite_add("walkb.png",		6,	12,	12)
	global.spr_hurtb	= sprite_add("hurtb.png",		3,	12,	12)
	global.spr_deadb	= sprite_add("deadb.png",		6,	12,	12)
	global.portrait		= sprite_add("portrait.png",	1,	35,	200)
	global.portraitb	= sprite_add("portraitb.png",	1,	36,	236)
	global.mapicon		= sprite_add("mapicon.png",		1,	10,	10)
	global.chs			= sprite_add("CharSelect.png",	1,	0,	0)
	global.EGI1			= sprite_add("Icon1.png",		1,	9,	9)
	global.EGI2			= sprite_add("Icon2.png",		1,	9,	9)
	global.EG1			= sprite_add("Skill1.png",		1,	12,	16)
	global.EG2			= sprite_add("Skill2.png",		1,	12,	16)
	}

#define nts_weapon_examine	return 
	{
	"0":	"Your fists. ", 
	}



#define create
	{
	spr_idle = spr
	spr_walk = spr
	spr_hurt = spr
	spr_dead = spr
	spr_sit1 = spr
	spr_sit2 = spr
	snd_hurt= snd
	snd_dead= snd
	snd_lowa= snd
	snd_lowh= snd
	snd_chst= snd
	snd_wrld= snd
	snd_valt= snd
	snd_crwn= snd
	snd_thrn= snd
	snd_spch= snd
	snd_idpd= snd
	snd_cptn= snd
	nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
	}

#define create
	{
	image_speed_raw = 0.4
	spr_idle = global.spr_idle
	spr_walk = global.spr_walk
	spr_hurt = global.spr_hurt
	spr_dead = global.spr_dead
	spr_sit1 = global.spr_sit1
	spr_sit2 = global.spr_sit2
	snd_hurt = -1
	snd_dead = -1
	snd_lowa = -1
	snd_lowh = -1
	snd_chst = -1
	snd_wrld = -1
	snd_valt = -1
	snd_crwn = -1
	snd_thrn = -1
	snd_spch = -1
	snd_idpd = -1
	snd_cptn = -1
	nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
	}

#define step



#define race_name		return ""
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
#define race_lock		return ""

#define race_menu_button
sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}
#define race_menu_select
return 
#define race_menu_confirm
return 

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

#define race_ttip
return []
