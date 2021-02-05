
#define init 

#define weapon_name		return "IDPD SLUGGER"
#define weapon_sprt		return sprPopoSlugger

#define weapon_type		return 2
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 12
#define weapon_cost		return 1
#define weapon_area		return -1
#define weapon_swap		return sndSwapShotgun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"eyes" : "Your mental force will effect a change of #the power of the slugger. ", 
	"rogue" : "You used to watch her training #when she exercising shotgun and slugger. ", 
	"d" : "An auto slugger be designed #to be powerfully use by the people who soberer. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndGruntFire, 0.3)
	weapon_post(3, -6, 4)
	with(instance_create(x+lengthdir_x(4,gunangle), y+lengthdir_y(4,gunangle), PopoSlug))
		{
		speed	= 20
		damage	= 22
		
		direction	= other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	}
