
#define init 
global.spr = sprite_add("Flashlight.png", 7, 0, 2)
global.snd = sound_add("flashlight1.ogg")
global.wep_b = 
	{
	wep: mod_current, 
	name: "laser", 
	ammo: 100, 
	pow: false, 
	}

#define weapon_name		return "flashlight"
#define weapon_sprt		return global.spr

#define weapon_type		return 0
#define weapon_melee	return false
#define weapon_auto		return -1
#define weapon_load		return 10
#define weapon_cost		return 0
#define weapon_area		return 4
#define weapon_swap		return sndSwapPistol

#define weapon_gold			return false
#define weapon_laser_sight	return lq_defget(argument0, "pow", false)

#define nts_weapon_examine	return
	"A flashlight with a sealed battery. "



#define weapon_fire
if(is_object(wep))
	{
	wep.pow = !wep.pow
	sound_play_hit(global.snd, 0.3)
	}



#define step
if(argument0){if(!is_object(wep))
	{wep = lq_clone(global.wep_b)}}
else{if(!is_object(bwep))
	{bwep = lq_clone(global.wep_b)}}
if((current_frame mod 1) < current_time_scale){scrLight(argument0 ? wep : bwep)}

#define scrLight(wep)
if(wep.pow)
	{
	if(wep.ammo)
		{
		wep.ammo = max(wep.ammo-0.5, 0)
		if((current_frame mod 2) < current_time_scale)
			{
			with(instance_create(x, y, EnemyLaser))
				{
				direction = other.gunangle
				image_angle = direction
				image_yscale = 0.6
				image_alpha = 0
				team = other.team
				creator = other
				event_perform(ev_alarm, 0)
				}
			}
		}
	else{
		sound_play_hit(global.snd, 0.3)
		wep.pow = false
		}
	}
else{wep.ammo = min(wep.ammo+(skill_get(17)?1:0.6), 100)}


