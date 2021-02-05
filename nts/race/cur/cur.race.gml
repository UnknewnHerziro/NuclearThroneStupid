#define init
global.spr_idle = sprite_add("idle.png", 4, 12, 12);
global.spr_walk = sprite_add("walk.png", 6, 12, 11);
global.spr_hurt = sprite_add("hurt.png", 3, 12, 12);
global.spr_idleb = sprite_add("idleb.png", 4, 12, 12);
global.spr_walkb = sprite_add("walkb.png", 6, 12, 11);
global.spr_hurtb = sprite_add("hurtb.png", 3, 12, 12);
global.mapicon  = sprite_add("mapicon.png", 1, 10, 10);
global.mapiconb  = sprite_add("mapiconb.png", 1, 10, 10);
global.chs = sprite_add("CharSelect.png", 1, 0, 0);

#define nts_weapon_examine	return 
	{
	"0":			"Your mouth. Gears are turning. ", 
	"lil.horror":	"Sympathetically. ", 
	}



#define create 
image_speed_raw = 0.4
if(bskin)
	{
	spr_idle = global.spr_idleb
	spr_walk = global.spr_walkb
	spr_hurt = global.spr_hurtb
	spr_sit1 = global.spr_idleb
	spr_sit2 = global.spr_idleb
	}
else{
	spr_idle = global.spr_idle
	spr_walk = global.spr_walk
	spr_hurt = global.spr_hurt
	spr_sit1 = global.spr_idle
	spr_sit2 = global.spr_idle
	}
spr_dead = mskNone
snd_hurt = sndMutant13Hurt
snd_dead = sndMutant13Dead
snd_lowa = sndMutant13Cnfm
snd_lowh = sndMutant13Cnfm
snd_chst = sndMutant13Chst
snd_wrld = sndMutant13Wrld
snd_valt = sndMutant13Valt
snd_crwn = sndMutant13Crwn
snd_thrn = sndMutant13Thrn
snd_spch = sndMutant13Spch
snd_idpd = sndMutant13IDPD
snd_cptn = sndMutant13Cptn
nts_color_blood = [make_color_rgb(96, 59, 52), c_black]

#define step
var b = instances_matching(projectile, "creator", self)
if(ultra_get("cur", 1))
	{
	var c = (skill_get(5)?0.5:0.2)
	if(button_check(index, "spec"))
		{
		with(b){if(scrNobolt())
			{
			var dir = direction
			motion_add(point_direction(x, y, mouse_x[other.index], mouse_y[other.index]), c)
			image_angle += direction-dir
			}}
		}
	else{
		with(b){if(scrNobolt())
			{
			if("nts_cur_slow"!in self)
				{
				nts_cur_slow = speed
				speed *= 0.5
				}
			if(speed > 0){speed = clamp(speed-c, 1, 15)}
			if(speed < 0){speed = clamp(speed+c, -15, -1)}
			}}
		}
	}
else{
	with(b){if("nts_cur_slow"!in self)
		{
		nts_cur_slow = speed
		speed *= 0.5
		}}
	if(button_pressed(index, "spec"))
		{
		var a = `nts_cur_turn_${index}`
		if(scrTelecont(a,b))
			{
			var s = sound_play_hit(sndMutant13Cnfm, 0)
			audio_sound_pitch(s, skill_get(5)?8:4)
			}
		}
	}
if(ultra_get("cur", 2)){with(instances_matching_ne(projectile, "team", team)){if("nts_cur_slow"!in self)
	{
	nts_cur_slow = speed
	speed *= 0.5
	}}}
if(my_health==0 && candie)
	{
	with(instance_create(x, y, CustomObject))
		{
		sprite_index = other.spr_hurt
		image_speed_raw = 0.4
		depth = other.depth
		
		time = 45
		team = other.team
		hitid=[global.spr_hurt, "cur explosion"]
		
		on_step = scrCurExplo
		}
	}

#define scrCurExplo
time -= current_time_scale
if((time mod 5) < current_time_scale)
	{
	repeat(3){with(instance_create(x, y, skill_get("bc")?PopoExplosion:SmallExplosion))
		{
		hitid = other.hitid
		direction = random(360)
		x += lengthdir_x(irandom(32), random(360))
		y += lengthdir_y(irandom(32), random(360))
		if(skill_get("bc"))
			{
			sprite_index = sprPopoExplo
			image_xscale = 0.5
			image_yscale = 0.5
			team = other.team
			}
		}}
	sound_play_hit(skill_get("bc")?sndIDPDNadeExplo:sndExplosionS, 0.3)
	}
if(time <= 0)
	{
	repeat(3){with(instance_create(x, y, skill_get("bc")?PopoExplosion:Explosion))
		{
		hitid = other.hitid
		direction = random(360)
		x += lengthdir_x(irandom(32), random(360))
		y += lengthdir_y(irandom(32), random(360))
		if(skill_get("bc"))
			{
			sprite_index = sprPopoExplo
			team = other.team
			}
		}}
	repeat(3){with(instance_create(x, y, Corpse))
		{
		hitid = other.hitid
		direction = random(360)
		}}
	sound_play_hit(skill_get("bc")?sndIDPDNadeExplo:sndExplosion, 0.3)
	instance_destroy()
	}

#define scrTelecont(a,b)
var c = false
with(b){if(scrNobolt())
	{
	if(a!in self){variable_instance_set(self, a, 0)}
	if(variable_instance_get(self, a)<(skill_get(5)?3:1))
		{
		c = true
		variable_instance_set(self, a, variable_instance_get(self, a)+1)
		var dir = point_direction(x, y, mouse_x[other.index], mouse_y[other.index])
		image_angle += dir-direction
		direction = dir
		speed = nts_cur_slow
		}
	}}
return c

#define scrNobolt
if("canhurt"in self){return canhurt; exit}
return 1

#define draw

#define race_name
return "cur";
#define race_text
return "slower projectiles#telecontrol projectiles";
/*
#define race_portrait
return global.portrait*/
#define race_mapicon
switch(argument1)
	{
	case 0: return global.mapicon;break;
	case 1: return global.mapiconb;break;
	default: return global.mapicon;break;
	}

#define race_swep
return wep_splinter_gun

#define race_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock
return "defeat big dog"

#define race_menu_button
sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}
#define race_menu_select
sound_play_pitch(sndMutant13Cnfm, 4)
return -1;
#define race_menu_confirm
return sndMutant13Cnfm;

#define race_skins
return 2;
#define race_skin_avail
var a = false
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){a = lq_defget(v.skin, mod_current, false)}
	}
switch(argument0)
	{
	case 0: return true; break;
	case 1: return a; break;
	default: break;
	}
#define race_skin_name
switch(argument0)
	{
	case 0: return "skin a"; break;
	case 1: 
		if(race_skin_avail(1))
			{return "skin b - pure"}
		else{return "reach ???"}
		break
	default: break;
	}
#define race_skin_button
switch(argument0)
	{
	case 0: sprite_index = global.spr_idle; image_speed=0.4; break;
	case 1: sprite_index = global.spr_idleb; image_speed=0.4; break;
	default: break;
	}

#define race_tb_text
if(ultra_get("cur",1)){return "stronger telecontrol"}
else{return "more telecontrol times#per projectile"}
#define race_tb_take

#define race_ultra_name
switch(argument0)
	{
	case 1: return "overclocking";break;
	case 2: return "overload";break;
	default: return "";break;
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return "swim in data ocean";break;
	case 2: return "slower enemy projectiles";break;
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
