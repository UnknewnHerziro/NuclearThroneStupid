
#define init 
global.spr = sprite_add_weapon("GammaRifle.png", 6, 3)

#define weapon_name		return "GAMMA RIFLE"
#define weapon_sprt		return global.spr

#define weapon_type		return 5
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 6
#define weapon_cost		return 1
#define weapon_area		return 1
#define weapon_swap		return sndSwapEnergy

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A rifle fires gamma balls. "



#define weapon_fire
	{
	sound_play_hit(sndGammaGutsProc, 0.3)
	weapon_post(6, -2, 1)
	mod_script_call("weapon", "gamma pistol", "create_gamma", 24, 5, [9, 6], 1, 0.5, 9)
	}
