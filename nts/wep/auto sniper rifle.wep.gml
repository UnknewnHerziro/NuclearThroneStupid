
#define init 
global.spr = sprite_add("AutoSniperRifle.png", 7, 14, 4)

#define weapon_name		return "AUTO SNIPER RIFLE"
#define weapon_sprt		return global.spr

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 14
#define weapon_cost		return 12
#define weapon_area		return 11
#define weapon_swap		return sndSniperTarget

#define weapon_gold			return false
#define weapon_laser_sight	return true

#define nts_weapon_examine	return
	"An black auto sniper rifle. Not so accurate. #Could make incredible damage for a single target. "



#define weapon_fire
	{
	sound_play_hit(sndSniperFire, 0.3)
	repeat(3){with(instance_create(x+lengthdir_x(13,gunangle),y+lengthdir_y(13,gunangle),EnemyBullet4))
		{
		direction = (random_range(5,-5)+random_range(5,-5))*other.accuracy + other.gunangle
		image_angle = direction
		speed = 20
		creator = self
		team = other.team
		damage = 18
		}}
	weapon_post(4, -40, 5)
	}
