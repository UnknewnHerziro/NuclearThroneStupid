
#define weapon_name		return "PIPE"
#define weapon_sprt		return sprPipe

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return true
#define weapon_load		return 15
#define weapon_cost		return 0
#define weapon_area		return 4
#define weapon_swap		return sndSwapHammer

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"eyes" : "Assassin. Dexterous. ", 
	"d" : "A copper pipe. It's so light that easy to keep waving it. ", 
	}


#define weapon_fire
	{
	sound_play_hit(sndWrench, 0.3)
	weapon_post(30, 4, 1)
	wepangle = -wepangle
	if(skill_get(mut_long_arms))
		{var b=20; var c=4}
	else{var b=5; var c=2}
	with(instance_create(x+lengthdir_x(b,gunangle), y+lengthdir_y(b,gunangle), Slash))
		{
		sprite_index	= sprSlash
		speed			= c
		direction		= other.gunangle
		image_angle		= direction
		damage			= 5
		
		creator	= other
		team	= other.team
		}
	}

#define step	recoil(argument0, 4)

#define recoil
	{
	if(argument0)
		{
		if(wkick > 0)
			{wkick -= argument1 * current_time_scale}
		}
	else{
		if(bwkick > 0)
			{bwkick -= argument1 * current_time_scale}
		}
	}
