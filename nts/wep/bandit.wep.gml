#define init
global.wep_b = {wep: mod_current}

#define weapon_name		return "BANDIT"
#define weapon_sprt		return wep_data(argument0, "spr_walk", sprBanditWalk)

#define weapon_type		return 0
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 29
#define weapon_cost		return 0
#define weapon_area		return 0
#define weapon_swap		return wep_data(argument0, "snd_hurt", sndBanditHit)

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"plant" : "Looks so yum. ", 
	"rebel" : "...They are all crazy because the Throne. #Poor little buddy. ", 
	"rogue" : "Lower aborigine. ", 
	"digger" : "Dump the corpse to hide the crime. ", 
	"d" : "Just a dizzy bandit. ", 
	}



#define weapon_fire
	{
	if(!is_object(argument0))
		{wep = lq_clone(global.wep_b)}
	
	//sound_play_hit(weapon_swap(argument0), 0.3)
	motion_add(gunangle,4)
	weapon_post(0, -6, 0)
	
	var w = argument0
	with(instance_create(x, y, Bandit))
		{
		my_health = 0
		spr_hurt = wep_data(w, "spr_hurt", sprBanditHurt)
		spr_dead = wep_data(w, "spr_dead", sprBanditDead)
		snd_hurt = wep_data(w, "snd_hurt", sndBanditHit)
		snd_dead = wep_data(w, "snd_dead", sndBanditDie)
		projectile_hit(id, 0, 16, other.gunangle)
		}
	wep = wep_none
	curse = 0
	}

#define wep_data(wep, name, def)
return lq_defget(lq_defget(argument0, "vars", {}), argument1, argument2)
