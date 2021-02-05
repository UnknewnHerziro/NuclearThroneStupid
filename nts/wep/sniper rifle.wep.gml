
#define init 

#define weapon_name		return "SNIPER RIFLE"
#define weapon_sprt		return sprSniperGun

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 40
#define weapon_cost		return 12
#define weapon_area		return 5
#define weapon_swap		return sndSniperTarget

#define weapon_gold			return false
#define weapon_laser_sight	return true

#define nts_weapon_examine	return
	{
	"crystal" : "You used to dream of having a sniper rifle. ", 
	"steroids" : "Hard to hold in one hand. ", 
	"chicken" : "Hawaii and Jungle. #Glasses and Reds. ", 
	"rogue" : "Limit of kinetic energy weapon. ", 
	"digger" : "Not bad. You still remember how to control it. ", 
	"d" : "Slender and large. #Could make incredible damage for a single target. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndSniperFire, 0.3)
	weapon_post(4, -40, 5)
	repeat(3){with(instance_create(x+lengthdir_x(13,gunangle), y+lengthdir_y(13,gunangle), EnemyBullet4))
		{
		speed	= 20
		damage	= 18
		
		direction	= random_range(3,-3) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= self
		team	= other.team
		}}
	}
