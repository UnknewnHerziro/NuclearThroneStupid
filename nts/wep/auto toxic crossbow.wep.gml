
#define init 
global.spr = sprite_add_weapon("AutoToxicCrossbow.png", 4, 8)

#define weapon_name		return "auto toxic crossbow"
#define weapon_sprt		return global.spr

#define weapon_type		return 3
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 9
#define weapon_cost		return 1
#define weapon_area		return 11
#define weapon_swap		return sndSwapBow

#define weapon_gold			return false
#define weapon_laser_sight	return true

#define nts_weapon_examine	return
	"An auto toxic crossbow. #Wasteland hunters made them but abandoned them. "



#define weapon_fire
weapon_post(6, -40, 5)
player_fire_ext(gunangle+irandom_range(5,-5)*accuracy, wep_toxic_bow, x, y, team, self)