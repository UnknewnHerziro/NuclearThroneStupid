
#define init
global.spr = sprite_add_weapon("AutoBulletShotgun.png", 3, 0)

#define weapon_name		return "AUTO BULLET SHOTGUN"
#define weapon_sprt		return global.spr

#define weapon_type		return 2
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 4
#define weapon_cost		return 1
#define weapon_area		return 11
#define weapon_swap		return sndSwapShotgun

#define weapon_gold			return false
#define weapon_laser_sight	return false
/*
#define nts_weapon_examine	return
	{
	}
*/


#define weapon_fire
	{
	sound_play_hit(sndDoubleShotgun, 0.3)
	weapon_post(3, -15, 16)
	repeat(5)
		{
		with(instance_create(x+lengthdir_x(4,gunangle), y+lengthdir_y(4,gunangle), Bullet1))
			{
			direction = random_range(15, -15) * other.accuracy + other.gunangle
			image_angle = direction
			speed = random_range(14,18)
			
			creator = other
			team = other.team
			}
		}
	}
