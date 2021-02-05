
#define init 

#define weapon_name		return "GATOR FLAK"
#define weapon_sprt		return sprBuffGatorFlakCannon

#define weapon_type		return 2
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 20
#define weapon_cost		return 1
#define weapon_area		return 6
#define weapon_swap		return sndSwapShotgun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"eyes" : "Gators. Hatred. ", 
	"d" : "Looks like the cannonballs always burst on the target's face. #It's more like a slugger but not a common flak cannon. ", 
	}



#define weapon_fire
repeat(2)
	{
	motion_add(gunangle+180, 4)
	sound_play_hit(sndFlakCannon, 0.3)
	weapon_post(3, -4, 4)
	with(instance_create(x, y, EFlakBullet))
		{
		speed = random_range(8, 12)
		
		direction	= random_range(5, -5) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	wait 5
	if(!instance_exists(self)){exit}
	}