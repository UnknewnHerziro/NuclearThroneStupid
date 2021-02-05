
#define init 
global.spr = sprite_add_weapon("SniperPistol.png", 0, 7)

#define weapon_name		return "SNIPER PISTOL"
#define weapon_sprt		return global.spr

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 18
#define weapon_cost		return 4
#define weapon_area		return 1
#define weapon_swap		return sndSniperTarget

#define weapon_gold			return false
#define weapon_laser_sight	return true

#define nts_weapon_examine	return
	{
	"crystal" : "You don't wanna talk about it. ", 
	"d" : "The snipers left them here. #Could make incredible damage for a single target. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndSniperFire, 0.3)
	weapon_post(8, -20, 4)
	with(instance_create(x, y, EnemyBullet4))
		{
		speed	= 20
		damage	= 18
		
		direction	= random_range(3, -3) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	}
