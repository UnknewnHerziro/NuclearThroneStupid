
#define init 
global.spr = sprite_add_weapon("FleshArm.png",0,5)

#define weapon_name		return "FLESH ARM"
#define weapon_sprt		return global.spr

#define weapon_type		return 0
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 20
#define weapon_cost		return 0
#define weapon_area		return -1
#define weapon_swap		return sndSwapCursed

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A wriggling meat. "



#define weapon_fire
	{
	sound_play_hit(sndBloodLauncher, 0.3)
	weapon_post(6, -8, 8)
	repeat(12)
		{
		with(instance_create(x+lengthdir_x(4,gunangle), y+lengthdir_y(4,gunangle), CustomSlash))
			{
			sprite_index	= sprBloodStreak
			image_speed		= 0.4
			speed			= random_range(2, 4)
			damage			= 2
			candeflect		= false
			
			direction	= random_range(30,-30) * other.accuracy + other.gunangle
			image_angle	= direction
			
			creator	= other
			team	= other.team
			
		//	on_step = blood
			on_anim = destroy
			}
		}
	}

#define destroy		instance_destroy()
