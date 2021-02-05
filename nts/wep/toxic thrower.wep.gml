
#define init

#define weapon_name		return "TOXIC THROWER"
#define weapon_sprt		return sprToxicThrower

#define weapon_type		return 4
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 12
#define weapon_cost		return 1
#define weapon_area		return 9
#define weapon_swap		return sndSwapFlame

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A toxic thrower. #The frogmans made them. "



#define weapon_fire
sound_play_hit(sndFlamerStart, 0)
repeat(22){if(instance_exists(self))
	{
	weapon_post(6, 0, 0)
	with(instance_create(x+lengthdir_x(16,gunangle), y+lengthdir_y(16,gunangle), 278))
		{damage=3; speed=3+random_range(-2,2); direction=other.gunangle+irandom_range(-10,10); image_angle=direction; creator=other}
	}; wait 1}; 
sound_play_hit(sndFlamerStop, 0.3)