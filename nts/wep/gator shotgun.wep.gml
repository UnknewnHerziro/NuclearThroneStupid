
#define init 

#define weapon_name		return "SHOTGUN"
#define weapon_sprt		return sprGatorShotgun

#define weapon_type		return 2
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 6
#define weapon_cost		return 1
#define weapon_area		return 3
#define weapon_swap		return sndSwapShotgun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "Even the worst shotgun ever in your office #is still much better than this trash. ", 
	"eyes" : "Gators. Disgusting. ", 
	"coward" : "Shotgun but imitation. #Feels cold when touching it. ",
	"d" : "Gators create this type of shotguns #that can use two kinds of ammo. #They prefer smaller ones. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndShotgun, 0.3)
	weapon_post(3, -4, 4)
	repeat(irandom_range(12, 24)){with(instance_create(x+lengthdir_x(13,gunangle), y+lengthdir_y(13,gunangle), EnemyBullet3))
		{
		speed = random_range(8, 15)
		
		direction	= random_range(30, -30) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}}
	}