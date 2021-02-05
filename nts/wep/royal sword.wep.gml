
#define init 
global.spr = sprite_add("RoyalSword.png", 7, 6, 8)

#define weapon_name		return "ROYAL SWORD"
#define weapon_sprt		return global.spr

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 12
#define weapon_cost		return 0
#define weapon_area		return -1
#define weapon_swap		return sndSwapSword

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A sword made with unknown red metal. #Much lighter than it looks like. "



#define weapon_fire
wepangle = -wepangle
weapon_post(20, 3, 2)
sound_play_hit(sndBlackSwordMega, 0.3)

var dis	= -28 - 4 * chickendeaths

with(instance_create(x+lengthdir_x(dis,gunangle), y+lengthdir_y(dis,gunangle), Slash))
	{
	sprite_index	= sprMegaSlash
	mask_index		= mskMegaSlash
	image_blend		= c_red
	speed			= skill_get(mut_long_arms) ? 4 : 1
	damage			= 16
	
	image_xscale	= other.chickendeaths / 12 + 1
	direction		= other.gunangle
	image_angle		= direction
	
	creator	= other
	team	= other.team
	}


#define step	mod_script_call("weapon", "pipe", "recoil", argument0, 4)