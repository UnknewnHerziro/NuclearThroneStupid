
#define weapon_name		return "BIG BANDIT GUN"
#define weapon_sprt		return sprBanditBossGun

#define weapon_type		return 1
#define weapon_melee	return true
#define weapon_auto		return true
#define weapon_load		return 3
#define weapon_cost		return 1
#define weapon_area		return 7
#define weapon_swap		return sndBigBanditShootLaugh

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"rebel" : "You always love to smell the diesel from his big machinegun. ", 
	"rogue" : "A little bit progress. Still a toy. #With much more acrid smell. ", 
	"envoy" : "Head clean. ", 
	"d" : "Wild and ugly, with acrid smell of diesel. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndEnemyFire, 0.3)
	weapon_post(6, -6, 6)
	with(instance_create(x+lengthdir_x(13,gunangle), y+lengthdir_y(13,gunangle), EnemyBullet1))
		{
		direction = other.wepangle + other.gunangle
		creator = other
		team = other.team
		image_angle = direction
		speed = 10
		}
	if(speed == 0)
		{wepangle += random_range(20, -20)}
	else{wepangle += random_range(30, -30)}
	}

#define weapon_reloaded

#define step	mod_script_call("weapon", "bandit gun", "recoil", argument0, 1, 2, 50)
