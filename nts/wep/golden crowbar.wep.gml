
#define init 
global.spr = sprite_add("GoldenCrowbar.png", 7, 0, 4)

#define weapon_name		return "GOLDEN CROWBAR"
#define weapon_sprt		return global.spr

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return true
#define weapon_load		return 16
#define weapon_cost		return 0
#define weapon_area		return 20
#define weapon_swap		return sndSwapHammer

#define weapon_gold			return true
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "You are not just a thief now. ", 
	"steroids" : "Power of GOLD. ", 
	"chicken" : "A sword maybe. ", 
	"d" : "A lever tool. ", 
	}



#define weapon_fire		mod_script_call("weapon", "crowbar", "weapon_fire",	argument0)
#define step			mod_script_call("weapon", "crowbar", "step",		argument0)