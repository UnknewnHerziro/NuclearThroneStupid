
#define init 
global.spr = sprite_add("EnvoySmg.png", 7, 4, 3)

#define weapon_name		return "ENVOY SMG"
#define weapon_sprt		return global.spr

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 10
#define weapon_cost		return 3
#define weapon_area		return -1
#define weapon_swap		return sndSwapGold

#define weapon_gold			return false
#define weapon_laser_sight	return true

#define nts_weapon_examine	return
	{
	"fish" : "Maybe a nice choice. ", 
	"crystal" : "There were some sub-machine guns in your room. #You can't call more memories return to your mind. ", 
	"rebel" : "You do not trust in it. ", 
	"rogue" : "Really interesting. ", 
	"envoy" : "Your mission. ", 
	"d" : "Short and light. #There is a name carved on the handle, ENVOY. ", 
	}



#define weapon_fire
repeat(3)
	{
	sound_play_hit(sndEnemyFire, 0.3)
	weapon_post(5, -6, 4)
	with(instance_create(x+lengthdir_x(10,gunangle), y+lengthdir_y(10,gunangle), AllyBullet))
		{
		speed = 9
		
		direction	= random_range(5, -5) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	wait 2
	if(!instance_exists(self)){exit}
	}