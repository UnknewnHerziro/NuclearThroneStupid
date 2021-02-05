
#define init 

#define weapon_name		return "ULTRA CHOPPER"
#define weapon_sprt		return sprUltraShotgun

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return GameCont.rad >= 6
#define weapon_load		return GameCont.rad<6 ? 16 : 8
#define weapon_cost		return 0
#define weapon_rads		return GameCont.rad<6 ? 0 : 6
#define weapon_area		return 21
#define weapon_swap		return sndSwapSword

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"chicken" : "You saw some amazing vision. A... #Tall man with motorcycle helmet were waving a chopper #and throwing a knife at you? So horrible. ", 
	"pumpking" : "Endless killing. ", 
	"d" : "An earthy color chopper with radiation green light. #Light but powerful. ", 
	}



#define weapon_fire
weapon_post(30, 4, 1)
wepangle = -wepangle
if(skill_get(mut_long_arms) || GameCont.rad>=6)
	{
	var dis = 20
	var spd = 4
	}
else{
	var dis = 5
	var spd = 2
	}
if(GameCont.rad < 6)
	{
	sound_play_hit(sndBlackSword, 0.3)
	var spr = sprSlash
	var dmg = 6
	}
else{
	sound_play_hit(sndUltraShovel, 0.3)
	var spr = sprUltraSlash
	var dmg = 18
	}
with(instance_create(x+lengthdir_x(dis,gunangle), y+lengthdir_y(dis,gunangle), Slash))
	{
	sprite_index = spr
	
	speed	= spd
	damage	= dmg
	
	direction	= other.gunangle
	image_angle	= direction
	
	creator	= other
	team	= other.team
	}

#define step	mod_script_call("weapon", "pipe", "recoil", argument0, 4)
