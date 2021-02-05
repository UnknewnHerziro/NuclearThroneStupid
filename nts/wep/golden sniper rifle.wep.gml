
#define init 
global.spr = sprite_add("GoldenSniperRifle.png", 7, 5, 5)

#define weapon_name		return "GOLDEN SNIPER RIFLE"
#define weapon_sprt		return global.spr

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 32
#define weapon_cost		return 12
#define weapon_area		return 21
#define weapon_swap		return sndSniperTarget

#define weapon_gold			return true
#define weapon_laser_sight	return true

#define nts_weapon_examine	return
	{
	"crystal" : "Dream became truth. ", 
	"d" : "Slender and large. #Could make incredible damage for a single target. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndSniperFire, 0.3)
	weapon_post(8, 40, 4)
	repeat(3){with(instance_create(x+lengthdir_x(13,gunangle), y+lengthdir_y(13,gunangle), EnemyBullet4))
		{
		speed	= 20
		damage	= 18
		
		direction	= random_range(1, -1) * other.accuracy + other.gunangle
		image_angle	= other.direction
		
		creator	= other
		team	= other.team
		}}
	}