
#define init 

#define weapon_name		return "HUNTER RIFLE"
#define weapon_sprt		return sprLilHunterGun

#define weapon_type		return 1
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 6
#define weapon_cost		return 10
#define weapon_area		return -1
#define weapon_swap		return sndSwapPistol

#define weapon_gold			return false
#define weapon_laser_sight	return true

#define nts_weapon_examine	return
	{
	"rogue" : "You don't wanna recall your memories back. ", 
	"envoy" : "The attempt to negotiate failed. Clean. ", 
	"d" : "Amazing sniper rifle. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndLilHunterSniper, 0.3)
	weapon_post(6, -12, 6)
	repeat(10){with(instance_create(x+lengthdir_x(4,gunangle), y+lengthdir_y(4,gunangle), EnemyBullet1))
		{
		speed = random_range(10, 24)
		
		direction	= other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}}
	}