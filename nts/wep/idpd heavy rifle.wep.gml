
#define init 

#define weapon_name		return "IDPD HEAVY RIFLE"
#define weapon_sprt		return sprPopoHeavyGun

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 2
#define weapon_cost		return 1
#define weapon_area		return -1
#define weapon_swap		return sndSwapMachinegun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"crystal" : "Just like minigun but much stabler. ", 
	"rogue" : "You never planed to defect with a heavy rifle. #But it's still a nice choice. ", 
	"d" : "An auto rifle be designed to be stably use #by the people who behind the bunkers. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndGruntFire, 0.3)
	weapon_post(3, -6, 4)
	with(instance_create(x+lengthdir_x(4,gunangle), y+lengthdir_y(4,gunangle), IDPDBullet))
		{
		speed = 15
		
		direction	= random_range(7, -7) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	}
