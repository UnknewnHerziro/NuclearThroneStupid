
#define init 
global.spr = sprite_add("Crowbar.png",7,0,4)
global.snd = sound_add("crowbar.ogg")

#define weapon_name		return "CROWBAR"
#define weapon_sprt		return global.spr

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return true
#define weapon_load		return 18
#define weapon_cost		return 0
#define weapon_area		return 1
#define weapon_swap		return sndSwapHammer

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "You are the thief now. ", 
	"steroids" : "Power of SCIENCE. ", 
	"chicken" : "A sword too. ", 
	"rogue" : "Ancient wisdom. ", 
	"shovel knight" : "You respect the users of offbeat weapons. ", 
	"d" : "A perfect lever tool. ", 
	}



#define weapon_fire
	{
	sound_play_hit(global.snd, 0.3)
	weapon_post(12, 4, 0)
	wepangle = -wepangle
	
	if(skill_get(mut_long_arms))
		{
		var dis = 20
		var spd = 4
		}
	else{
		var dis = 5
		var spd = 2
		}
	
	with(instance_create(x+lengthdir_x(dis,gunangle), y+lengthdir_y(dis,gunangle), Slash))
		{
		sprite_index	= sprSlash
		speed			= spd
		damage			= 6
		
		direction	= other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	}


#define step	mod_script_call("weapon", "pipe", "recoil", argument0, 1)