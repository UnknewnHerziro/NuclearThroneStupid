
#define init 

#define weapon_name		return "M3 SMG"
#define weapon_sprt		return sprRavenGun

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 10
#define weapon_cost		return 3
#define weapon_area		return 3
#define weapon_swap		return sndSwapMachinegun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "Still a nice choice. ", 
	"crystal" : "There were some submachine gun in your room. #You can't call more memories return to your mind. ", 
	"rebel" : "You do not trust in it. ", 
	"rogue" : "Kinds of interesting. ", 
	"envoy" : "Inferior imitation. ", 
	"d" : "Short and light. There is a name be cutted on the handle. #You can't recognize who it is. ", 
	}



#define weapon_fire
repeat(3)
	{
	sound_play_hit(sndEnemyFire, 0.3)
	weapon_post(4, -6, 4)
	with(instance_create(x+lengthdir_x(10,gunangle), y+lengthdir_y(10,gunangle), EnemyBullet1))
		{
		speed = 6
		
		var off = (other.speed>2 ? 5 : 1) * other.wkick + 5
		direction	= random_range(off, -off) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	wait 3
	if(!instance_exists(self)){exit}
	}
