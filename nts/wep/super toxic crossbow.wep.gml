
#define init 
global.spr = sprite_add_weapon("SuperToxicCrossbow.png", 6, 8)

#define weapon_name		return "super toxic crossbow"
#define weapon_sprt		return global.spr

#define weapon_type		return 3
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 36
#define weapon_cost		return 5
#define weapon_area		return 12
#define weapon_swap		return sndSwapBow

#define weapon_gold			return false
#define weapon_laser_sight	return true

#define nts_weapon_examine	return
	"A toxic crossbow. You believe its creator has dead. "



#define weapon_fire
weapon_post(6, -80, 8)
for(var i=-15; i<=15; i+=7.5)
	{player_fire_ext(gunangle + i * accuracy, wep_toxic_bow, x, y, team, self)}