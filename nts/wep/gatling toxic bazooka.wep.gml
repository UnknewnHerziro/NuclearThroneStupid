
#define init
global.spr = sprite_add_weapon("GatlingToxicBazooka.png", 11, 3)

#define weapon_name		return "gatling toxic bazooka"
#define weapon_sprt		return global.spr

#define weapon_type		return 4
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 11
#define weapon_cost		return 1
#define weapon_area		return 16
#define weapon_swap		return sndSwapExplosive

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"An auto toxic rocket launcher. "



#define weapon_fire
weapon_post(6, -8, 8)
player_fire_ext(gunangle+irandom_range(5,-5)*accuracy, "toxic bazooka", x, y, team, self)