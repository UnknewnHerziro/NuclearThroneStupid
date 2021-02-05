#define init
global.spr_idle = sprite_add("idle.png", 6, 16, 16)
global.spr_walk = sprite_add("walk.png", 6, 16, 16)
global.spr_hurt = sprite_add("hurt.png", 3, 16, 16)
global.spr_dead = sprite_add("death.png", 6, 12, 12)
global.mapicon = sprite_add("map.png", 1, 10, 10)
global.chs = sprite_add("CharSelect.png", 1, 0, 0)

#define nts_weapon_examine	return 
	{
	"0":	"Two of your hands. ", 
	}



#define create 
image_speed_raw = 0.4
spr_idle = global.spr_idle
spr_walk = global.spr_walk
spr_hurt = global.spr_hurt
spr_dead = global.spr_dead
spr_sit1 = global.spr_idle
spr_sit2 = global.spr_idle
nts_color_blood = [c_white, c_black]

nts_tricker_stwep = [0, 0]



#define step

if(my_health<=0 && nts_tricker_stwep[@0]!=0){with(instance_create(x, y, WepPickup))
	{
	wep = other.nts_tricker_stwep[@0]
	speed = 5
	other.nts_tricker_stwep=[0, 0]
	}}



if(ultra_get("tricker", 1))
	{
	if(canswap && button_pressed(index,"swap") && curse==0)
		{
		var s = [wep, skill_get(5) ? max(reload,0) : weapon_get_load(wep)]
		wep = nts_tricker_stwep[@0]
		reload = nts_tricker_stwep[@1]
		nts_tricker_stwep = s
		can_shoot = false
		sound_play_hit(weapon_get_swap(wep), 0)
		}
	nts_tricker_stwep[@1] = max(nts_tricker_stwep[@1]-reloadspeed*current_time_scale, 0)
	if(canspec && button_check(index,"spec"))
		{
		if(nts_tricker_stwep[@1]<=0 && ammo[@weapon_get_type(nts_tricker_stwep[0])]>weapon_get_cost(nts_tricker_stwep[@0]))
			{
			var w = wep
			var wa = wepangle
			wepangle = 0
			wep = nts_tricker_stwep[0]
			player_fire()
			nts_tricker_stwep[@0] = wep
			nts_tricker_stwep[@1] = weapon_get_load(nts_tricker_stwep[@0])
			wep = w
			wepangle = wa
			}
		}
	}
else{
	if(canspec && button_pressed(index,"spec"))
		{
		if(curse > 0)
			{sound_play_hit(sndCursedReminder, 0.3)}
		else{
			var s = [wep, skill_get(5) ? max(reload,0) : weapon_get_load(wep)]
			wep = nts_tricker_stwep[@0]
			reload = nts_tricker_stwep[@1]
			nts_tricker_stwep = s
			can_shoot = false
			sound_play_hit(weapon_get_swap(wep), 0)
			}
		}
	}

if(ultra_get("tricker", 2))
	{nts_tricker_stwep[@1] = max(nts_tricker_stwep[@1] - reloadspeed*current_time_scale*2, 0)}



#define draw_begin
if(ultra_get("tricker", 1))
	{
	if(back)
		{draw_sprite_ext(weapon_get_sprt(nts_tricker_stwep[0]), 0, x, y, 1, right, gunangle, c_white, 1)}
	}
else{
	if(!back)
		{draw_sprite_ext(weapon_get_sprt(nts_tricker_stwep[0]), 0, x, y, 1, right, gunangle+(right?-45:45), c_gray, 1)}
	}

#define draw
if(ultra_get("tricker", 1))
	{
	if(!back)
		{draw_sprite_ext(weapon_get_sprt(nts_tricker_stwep[0]), 0, x, y, 1, right, gunangle, c_white, 1)}
	}
else{
	if(back)
		{draw_sprite_ext(weapon_get_sprt(nts_tricker_stwep[0]), 0, x, y, 1, right, gunangle+(right?-45:45), c_gray, 1)}
	}
	

#define race_soundbank
return 16
#define race_name
return "tricker"
#define race_text
return "can take more weapons"

/*#define race_portrait
return */
#define race_mapicon
return global.mapicon

#define race_swep
return "venuz knife"

#define race_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock
return "???"
#define race_menu_button
sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}

#define race_tb_text
return "stored reload"
#define race_tb_take

#define race_ultra_name
switch(argument0)
	{
	case 1: return "hyperplasia"
	case 2: return "malignance"
	default: break
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return "reload stored weapons#dual shot"
	case 2: return "quickly reload stored weapons"
	default: break
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
	default: break
	}
*/
#define race_ttip
return []
