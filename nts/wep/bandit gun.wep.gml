
#define weapon_name		return "BANDIT GUN"
#define weapon_sprt		return sprBanditGun

#define weapon_type		return 1
#define weapon_melee	return true
#define weapon_auto		return true
#define weapon_load		return 5
#define weapon_cost		return 1
#define weapon_area		return 0
#define weapon_swap		return sndSwapMachinegun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "You used to fight with some bandits #who use this kind of guns. ", 
	"rebel" : "He made them. Don't forget why you left. ", 
	"rogue" : "Primitive toy. No reason to use it. ", 
	"d" : "Simple and stupid. #Inaccurate if you keep shooting while running. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndEnemyFire, 0.3)
	weapon_post(6, -6, 3)
	with(instance_create(x+lengthdir_x(13,gunangle),y+lengthdir_y(13,gunangle),EnemyBullet1))
		{
		direction = other.wepangle + other.gunangle
		creator = other
		team = other.team
		image_angle = direction
		speed = 5
		}
	if(speed == 0)
		{wepangle += random_range(20,-20)}
	else{wepangle += random_range(30,-30)}
	}

#define weapon_reloaded

#define step	recoil(argument0, 2, 3, 90)

#define recoil
	{
	var a = (speed ? argument1 : argument2) * current_time_scale
	if(argument0)
		{
		wepflip = (gunangle<90 || gunangle>270) ? 1 : -1
		if(wepangle>a){wepangle-=a};if(wepangle<a){wepangle+=a}
		wepangle = min(max(wepangle, -argument3), argument3)
		}
	else{
		bwepflip = (gunangle<90 || gunangle>270) ? 1 : -1
		if(bwepangle>a){bwepangle-=a};if(bwepangle<a){bwepangle+=a}
		bwepangle = min(max(bwepangle, -argument3), argument3)
		}
	}
