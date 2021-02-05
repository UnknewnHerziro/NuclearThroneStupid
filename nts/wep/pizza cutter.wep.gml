
#define init 
global.spr = sprite_add_weapon("PizzaCutter.png", 32, 16)

#define weapon_name		return "pizza cutter"
#define weapon_sprt		return global.spr

#define weapon_type		return 3
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 22
#define weapon_cost		return 1
#define weapon_area		return 5
#define weapon_swap		return sndSwapSword

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A safe disc launcher. "



#define weapon_fire
weapon_post(-6, 12, 1)
wepangle = -wepangle
sound_play_hit(sndDiscgun, 0.3)
with(instance_create(x, y, Slash))
	{
	direction = other.gunangle
	image_angle = direction
	creator = other
	team = other.team
	damage = 5
	}
with(instance_create(x, y, Disc))
	{
	speed			= 5
	alarm0			= 0
	
	direction	= other.gunangle
	image_angle	= direction
	
	creator = other
	team = other.team
	}


