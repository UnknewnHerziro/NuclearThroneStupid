#define init 
global.spr = sprite_add("GoldenPipe.png", 7, 6, 0)

#define weapon_name		return "GOLDEN PIPE"
#define weapon_sprt		return global.spr

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return true
#define weapon_load		return 12
#define weapon_cost		return 0
#define weapon_area		return 20
#define weapon_swap		return sndSwapHammer

#define weapon_gold			return true
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"venuz" : " not ur problem  ", 
	"chicken" : "Well you are a chicken but never a monkey. ", 
	"rogue" : "Wild king. ", 
	"d" : "A golden pipe .It's so light that easy to twirl it. ", 
	}



#define weapon_fire		mod_script_call("weapon", "pipe", "weapon_fire",	argument0)
#define step			mod_script_call("weapon", "pipe", "step",			argument0)