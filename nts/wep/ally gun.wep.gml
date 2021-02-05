
#define weapon_name		return "ALLY GUN"
#define weapon_sprt		return sprAllyGunTB

#define weapon_type		return 1
#define weapon_melee	return true
#define weapon_auto		return true
#define weapon_load		return 5
#define weapon_cost		return 1
#define weapon_area		return skill_get(5) ? 4 : -1
#define weapon_swap		return sndSwapMachinegun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"rebel" : "You made them. Forget the old ones. ", 
	"envoy" : "Dawn. ", 
	"clown" : "Revolutionary. ", 
	"d" : "Familiar. Someone made it. "
	}



#define weapon_fire
	{
	sound_play_hit(sndEnemyFire, 0.3)
	weapon_post(3, -6, 4)
	with(instance_create(x+lengthdir_x(13,gunangle), y+lengthdir_y(13,gunangle), AllyBullet))
		{
		direction = other.gunangle + other.wepangle
		image_angle = direction
		speed = 5
		
		creator = other
		team = other.team
		}
	wepangle += random_range(15, -15)
	}

#define weapon_reloaded

#define step	mod_script_call("weapon", "bandit gun", "recoil", argument0, 1, 2, 30)
