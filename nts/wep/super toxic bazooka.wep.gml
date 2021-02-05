
#define init 
global.spr = sprite_add_weapon("SuperToxicBazooka.png", 9, 7)

#define weapon_name		return "super toxic bazooka"
#define weapon_sprt		return global.spr

#define weapon_type		return 4
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 44
#define weapon_cost		return 5
#define weapon_area		return 15
#define weapon_swap		return sndSwapExplosive

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A toxic rocket launcher. You believe its creator has dead. "



#define weapon_fire
weapon_post(6, -9, 9)
for(var i=-15; i<=15; i+=7.5)
	{player_fire_ext(gunangle + i * accuracy, "toxic bazooka", x, y, team, self)}