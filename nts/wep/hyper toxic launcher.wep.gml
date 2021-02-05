
#define init 
global.spr = sprite_add_weapon("HyperToxicLauncher.png", 6, 8)

#define weapon_name		return "hyper toxic launcher"
#define weapon_sprt		return global.spr

#define weapon_type		return 4
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 10
#define weapon_cost		return 2
#define weapon_area		return 18
#define weapon_swap		return sndSwapExplosive

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"Toxic gas released before explode. #How? "



#define weapon_fire
sound_play_hit(sndHyperLauncher, 0.3)
weapon_post(8, -20, 4)
with(instance_create(x, y, HyperGrenade))
	{
	direction = other.gunangle + irandom_range(-2,2) * other.accuracy
	image_angle = direction
	team = other.team
	creator = other
	event_perform(ev_alarm, 0)
	with(instance_create(x, y, ToxicDelay))
		{event_perform(ev_alarm, 0)}
	}

