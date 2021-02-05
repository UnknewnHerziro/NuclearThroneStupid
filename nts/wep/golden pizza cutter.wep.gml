
#define init 
global.spr = sprite_add_weapon("GoldenPizzaCutter.png", 32, 16)

#define weapon_name		return "golden pizza cutter"
#define weapon_sprt		return global.spr

#define weapon_type		return 3
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 18
#define weapon_cost		return 1
#define weapon_area		return 20
#define weapon_swap		return sndSwapGold

#define weapon_gold			return -1
#define weapon_laser_sight	return true

#define nts_weapon_examine	return
	"A safe golden disc launcher. "



#define weapon_fire
weapon_post(-6, 12, 1)
wepangle = -wepangle
sound_play_hit(sndGoldDiscgun, 0.3)
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
	sprite_index	= sprGoldDisc
	speed			= 8
	alarm0			= 0
	
	direction	= other.gunangle
	image_angle	= direction
	
	creator = other
	team = other.team
	}