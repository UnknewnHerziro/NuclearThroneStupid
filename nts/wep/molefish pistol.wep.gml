
#define init 

#define weapon_name		return "MOLEFISH PISTOL"
#define weapon_sprt		return sprMolefishGun

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 5
#define weapon_cost		return 1
#define weapon_area		return 1
#define weapon_swap		return sndSwapPistol

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "A pistol looks like the police pistol but even better than that. #Maybe you will kill the bandits with it. So satirical. ", 
	"venuz" : "venuz succ pisto ", 
	"steroids" : "You found some sentence on the gun. #Some character be writen in unknown language so you can't read it. ", 
	"rogue" : "Not be made with Earth technology. #The Captain was trying to find out the source of these weirdo weapons. ", 
	"d" : "A dark grey pistol. #You suddenly want to make some beat with it. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndMolefishFire, 0.3)
	weapon_post(2, -6, 4)
	with(instance_create(x+lengthdir_x(2,gunangle), y+lengthdir_y(2,gunangle), EnemyBullet1))
		{
		speed	= 20
		force	= 0
		
		direction	= random_range(1, -1) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	}
