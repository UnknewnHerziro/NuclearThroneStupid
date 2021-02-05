
#define init 

#define weapon_name		return "THRONE SCYTHE"
#define weapon_sprt		return sprNothingLeg

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 60
#define weapon_cost		return 0
#define weapon_area		return -1
#define weapon_swap		return sndSwapMotorized

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"Just one of the legs of Throne. "



#define weapon_fire
	{
	sound_play_hit(sndShovel, 0.3)
	weapon_post(60, 8, 2)
	
	if(skill_get(mut_long_arms))
		{
		var dis = 30
		var spd = 4
		}
	else{
		var dis = 15
		var spd = 2
		}
	
	with(instance_create(x+lengthdir_x(dis,gunangle), y+lengthdir_y(dis,gunangle), Slash))
		{
		sprite_index = sprSlash
		image_xscale = 1.5
		image_yscale = 1.5
		
		speed	= spd
		damage	= 32
		
		direction	= other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	}

#define step
if(argument0)
	{wkick	= max(wkick		- 4 * current_time_scale, 30)}
else{bwkick	= max(bwkick	- 4 * current_time_scale, 30)}