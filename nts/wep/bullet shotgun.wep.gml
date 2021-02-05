#define init
global.spr = sprite_add_weapon("BulletShotgun.png", 3, 0)

#define weapon_name		return "BULLET SHOTGUN"
#define weapon_sprt		return global.spr

#define weapon_type		return 2
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 16
#define weapon_cost		return 1
#define weapon_area		return 5
#define weapon_swap		return sndSwapShotgun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"chicken" : "You saw some amazing vision. Some... #Demons with white suit in Palace? So weird. ", 
	"digger" : "Killing tool. ", 
	"d" : "A shotgun with two muzzles that fire bullets. #You've heard of some tales about it, #like an Armored Chicken Head Crazy killed all demons in the Palace #by this kind of shotgun. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndDoubleShotgun, 0.3)
	weapon_post(8, -15, 16)
	repeat(6)
		{
		with(instance_create(x+lengthdir_x(4,gunangle), y+lengthdir_y(4,gunangle), Bullet1))
			{
			direction = random_range(12, -12) * other.accuracy + other.gunangle
			image_angle = direction
			speed = random_range(14,18)
			
			creator = other
			team = other.team
			}
		}
	}
