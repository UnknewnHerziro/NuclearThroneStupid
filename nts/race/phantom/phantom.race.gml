#define init
	{
	global.spr_idle = sprite_add("idle.png", 4, 12, 12);
	global.spr_walk = sprite_add("walk.png", 6, 12, 12);
	global.spr_hurt = sprite_add("hurt.png", 3, 12, 12);
	global.spr_dead = sprite_add("dead.png", 6, 12, 12);

	global.chs = sprite_add("CharSelect.png", 1, 0, 0);
	global.portrait = sprite_add("portrait.png", 1, -2, 209);
	global.mapicon  = sprite_add("mapicon.png", 1, 6, 7);

	global.spr_ua = sprite_add("phan ua.png", 1, 12, 16);
	global.spr_ub = sprite_add("phan ub.png", 1, 12, 16);
	global.spr_uai = sprite_add("phan ua mini.png", 1, 9, 9);
	global.spr_ubi = sprite_add("phan ub mini.png", 1, 9, 9);


	global.spr_cidle = sprite_add("sprCLCidle.png", 5, 24, 24);
	global.spr_cfire = sprite_add("sprCLCfire.png", 2, 24, 24);
	global.spr_churt = sprite_add("sprCLChurt.png", 3, 24, 24);
	global.spr_cdead = sprite_add("sprCLCdead.png", 10, 24, 24);

	global.sprCL = sprite_add("sprCL.png", 1, 2, 4);
	global.sprCL1 = sprite_add("sprCL1.png", 4, 8, 8);
	global.sprCL2 = sprite_add("sprCL2.png", 4, 6, 6);



	globalvar baseZ, baseA, baseB

	baseZ = 
		[
		"what's under the robe",
		"cursed magician",
		"sniper wand will get stronger",
		"@qyou are mine",
		"do not miss that moment"
		]
	baseA = 
		[
		"concentrated attack",
		"aim and shot",
		"follow the command"
		]
	baseB = 
		[
		"crystal disco",
		"necessary sacrifice"
		]
	}

#define nts_weapon_examine	return 
	{
	"13":	"not awkward ", 
	"22":	"N O ", 
	}



#define create 
image_speed_raw = 0.4
spr_idle = global.spr_idle
spr_walk = global.spr_walk
spr_hurt = global.spr_hurt
spr_dead = global.spr_dead
spr_sit1 = global.spr_idle
spr_sit2 = global.spr_idle
snd_hurt = sndNecromancerHurt;
snd_dead = -1;
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
nts_color_blood = [make_color_rgb(136, 36, 174), make_color_rgb(103, 27, 131)]

ect = 0
ectmax = 30
ect1 = 2

#define step
with(instances_matching_le(InvLaserCrystal,"my_health",0)){with(other){ect += 1}}
if(canspec and button_pressed(index,"spec"))
	{
	var s = self
	while(ect>ect1 && instance_exists(InvLaserCrystal))
		{
		other.ect -= other.ect1
		with(instance_nearest(x, y, InvLaserCrystal))
			{
			with(instance_create(x, y, GuardianDeflect))
				{
				image_blend = 0
				image_xscale = 2
				image_yscale = 2
				team = s.team
				}
			with(instance_create(x, y, CustomEnemy))
				{
				spr_idle = global.spr_cidle
				spr_fire = global.spr_cfire
				spr_hurt = global.spr_churt
				spr_walk = global.spr_cidle
				spr_dead = global.spr_cdead
				mask_index = mskLaserCrystal
				image_speed_raw = 0.4
				
				creator = s
				team = s.team
				index = s.index
				my_health = skill_get(5) ? 50 : 30
				raddrop = other.raddrop
				
				ntstype = "CLC"
				nts_color_blood = [c_white, c_black]
				turntime = 0
				direction = random(360)
				firetime = 5
				on_destroy = CLCB
				on_step = CLCAI
				}
			instance_delete(self)
			}
		}
	sound_play_hit(sndCursedReminder, 0.3)
	}

var ary = instances_matching(CustomEnemy, "ntstype", "CLC")
if(instance_number(enemy) == array_length(ary))
	{with(ary){my_health = 0}}

ect = clamp(ect, 0, ectmax)

#define CLCAI
	{
	speed = 1.5
	
	if(sprite_index != spr_hurt)
		{
		if(sprite_index!=spr_idle && sprite_index!=spr_walk && image_index+image_speed_raw<image_number){}
		else{sprite_index = spr_idle}
		}
	else{
		if(image_index+image_speed_raw < image_number)
			{
			if(nexthurt>current_frame && sprite_index!=spr_hurt)
				{
				sprite_index = spr_hurt
				image_index = 0
				}
			}
		else{sprite_index = spr_idle}
		}
	image_xscale = right
	
	if(turntime > 0){turntime -= current_time_scale}
	else{
		turntime = 90
		direction = random(360)
		}
	
	if(firetime > 0){firetime -= current_time_scale}
	else{
		sprite_index = spr_fire
		sound_volume(sound_play_hit(sndLaser, 0.3), 0.5)
		if(ultra_get("phantom",1))
			{
			gunangle = point_direction(x, y, mouse_x[index], mouse_y[index])
			firetime = 10
			}
		else{
			gunangle = random(360)
			firetime = 5
			}
		CLF(gunangle)
		}
	}

#define CLCB
if(ultra_get("phantom",2))
	{
	with(instance_create(x, y, GuardianDeflect))
		{
		image_blend = 0
		image_xscale = 2
		image_yscale = 2
		image_speed = 0.2
		team = other.team
		}		
	var a = random(36) 
	for(var i=0; i<360; i+=36){CLF(a + i)}
	}

#define CLF
with(instance_create(x, y, EnemyLaser))
	{
	sprite_index = global.sprCL
	image_angle = argument0
	image_yscale = 1.5
	team = other.team
	
	event_perform(ev_alarm, 0)
	}



#define draw

#define race_name
return "phantom";
#define race_text
return "gets more @pectoplasm#@wectoplasm controller";

#define race_portrait
return global.portrait
#define race_mapicon
return global.mapicon

#define race_swep
return "sniper wand"

#define race_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock
return "carry 2 cursed weapon#at the same time"
#define race_menu_select
return sndCursedReminder
#define race_menu_confirm
return sndCrownCurses

#define race_menu_button
sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}

#define race_tb_text
return "@sall @wcolorless crystal #@shave more @rhp";
#define race_tb_take

#define race_ultra_name
switch(argument0)
	{
	case 1: return "ectoplasm commander";break;
	case 2: return "ectoplasm blaster";break;
	default: return "";break;
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return "@sall @wcolorless crystal #@swill fire on your mouse";break;
	case 2: return "@sexplode @wcolorless crystal";break;
	default: return "";break;
	}
#define race_ultra_button
switch(argument0)
	{
	case 1: sprite_index = global.spr_ua; break;
	case 2: sprite_index = global.spr_ub; break;
	default: return ;break;
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
	case 1: return global.spr_uai; break;
	case 2: return global.spr_ubi; break;
	default: break;
	}

#define race_ttip
var base=baseZ
var bst=5

if(ultra_get("phantom",1)){for(var i=0; i<3; i++){base[bst]=baseA[i]; bst++}}
if(ultra_get("phantom",2)){for(var i=0; i<2; i++){base[bst]=baseB[i]; bst++}}

return base
	