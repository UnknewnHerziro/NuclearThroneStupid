#define init
global.spr_idle = sprite_add("idle.png", 8, 12, 12);
global.spr_walk = sprite_add("walk.png", 6, 12, 12);
global.spr_run = sprite_add("run.png", 6, 12, 12);
global.spr_hurt = sprite_add("hurt.png", 3, 12, 12);
global.spr_dead = sprite_add("dead.png", 6, 12, 12);
global.mapicon  = sprite_add("mapicon.png", 1, 10, 10);
global.chs = sprite_add("CharSelect.png", 1, 0, 0);		//Thanks for Jsburg who made new CharSelect sprite. 

#define nts_weapon_examine	return 
	{
	"0":					"Your fists. Covered with sweat. ", 
	"5":					"An old shotgun. Antiquated and rare. #It's easy to distinguish it from the gators' imitations. ", 
	"hand flare grenade":	"A hand flare grenade. #Not bad for a light source. ", 
	"merge":				"So this is one of what they smuggled. ", 
	}



#define create
image_speed_raw = 0.4
spr_idle = global.spr_idle
spr_walk = global.spr_walk
spr_hurt = global.spr_hurt
spr_dead = global.spr_dead
spr_sit1 = global.spr_idle
spr_sit2 = global.spr_idle
snd_hurt = sndGatorHit
snd_dead = sndSharpTeeth
snd_lowa = -1;
snd_lowh = -1;
snd_chst = -1;
snd_wrld = -1;
snd_valt = -1;
snd_crwn = -1;
snd_thrn = -1;
snd_spch = -1;
snd_idpd = -1;
snd_cptn = -1;
nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]

spr_coward_walk = global.spr_walk
spr_coward_run = global.spr_run

nts_coward_rs = 0
nts_coward_rsmax = 20

nts_coward_stored = 3
nts_coward_stored_max = 6

nts_coward_smoke = 0



#define step
var a = my_health / maxhealth

reloadspeed = 1.5 - a*0.5
//GameCont.StoredSpeed[index] = 5 - a
maxspeed = 5 - a

if(ultra_get("coward",1))
	{nts_coward_rsmax = 15}

with(instances_matching_le(enemy, "my_health", 0)){with(other)
	{
	nts_coward_rs += sqr(other.size)
	if(nts_coward_rs >= nts_coward_rsmax)
		{
		nts_coward_stored += nts_coward_rs div nts_coward_rsmax
		nts_coward_rs = nts_coward_rs mod nts_coward_rsmax
		
		sound_play_hit(sndSalamanderEndFire, 0.3)
		
		with(instance_create(x, y, PopupText))
			{mytext = `${(other.nts_coward_stored>=other.nts_coward_stored_max)?"max":"+1"} ${skill_get(5)?"@r":"@y"}backup`}
		
		nts_coward_stored = min(nts_coward_stored, nts_coward_stored_max)
		}
	}}

if(nts_coward_smoke > 0)
	{
	nts_coward_smoke -= current_time_scale
	
	reloadspeed *= 4
	//GameCont.StoredSpeed[index] ++
	maxspeed ++
	
	if(ultra_get("coward",2))
		{
		instance_create(x, y, Smoke)
		if(nts_coward_smoke <= 0){repeat(skill_get(5)?3:2)
			{
			with(instance_create(x, y, Shell))
				{
				sprite_index = sprCigarette
				speed = random_range(3,5)
				direction = random(360)
				nts_unlock_coward = true
				}
			}}
		}
	}

if(button_pressed(index, "spec"))
	{
	if(nts_coward_stored >= 1)
		{
		nts_coward_stored --
		if(ultra_get("coward", 2))
			{
			if(skill_get(5))
				{
				nts_coward_smoke = 150
				my_health --
				}
			else{nts_coward_smoke = 90}
			sound_play_hit(sndSalamanderEndFire, 0.3)
			}
		else{
			instance_create(x, y, skill_get(5)?HPPickup:AmmoPickup)
			with(instance_create(x, y, Shell))
				{
				sprite_index = skill_get(5)?sprShotShellBig:sprShotShell
				speed = random_range(3,5)
				direction = random(360)
				}
			}
		}
	else{
		sound_play_hit(sndEmpty, 0.3)
		with(instance_create(x, y, PopupText))
			{mytext = `${skill_get(5)?"@r":"@y"}backup @wempty`}
		}
	}

spr_walk = (maxspeed>=4.5)?spr_coward_run:spr_coward_walk



#define draw

#define race_name
return "coward";
#define race_text
return "high stress#spare @yammo";
/*
#define race_portrait
return global.portrait;*/
#define race_mapicon
return global.mapicon;

#define race_swep
return wep_flare_gun

#define race_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock
return "reach 2-?"

#define race_menu_button
sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}
#define race_menu_select
sound_play_pitch(sndGatorHit, 1.5)
return -1
#define race_menu_confirm
return sndSharpTeeth
/*
#define race_skins
return 2;
#define race_skin_button
switch(argument0)
	{
	case 0: sprite_index = global.spr_dead; image_index=5; break;
	case 1: sprite_index = global.spr_deadb; image_index=5; break;
	default: break;
	}*/

#define race_tb_text
return ultra_get("coward", 2)?"stronger smoke":"spare @rhp"
#define race_tb_take

#define race_ultra_name
switch(argument0)
	{
	case 1: return "evasion";break;
	case 2: return "reaction";break;
	default: return "";break;
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return "more @sbackups";break;
	case 2: return "smoking addiction";break;
	default: return "";break;
	}
/*
#define race_ultra_button
switch(argument0)
	{
	case 1: sprite_index  =  ;
	case 2: sprite_index  =  ;
	default: sprite_index  =  ;
	}

#define race_ultra_take
switch(argument0)
	{
	case 1: break;
	case 2: break;
	default: break;
	}

#define race_ultra_icon
switch(argument0)
	{
	case 1: return ;break;
	case 2: return ;break;
	default: return ;break;
	}
*/
#define race_ttip
return [];
