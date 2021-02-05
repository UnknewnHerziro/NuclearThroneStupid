
#define init 

#define weapon_name		return "IDPD PLASMA MINIGUN"
#define weapon_sprt		return sprPopoPlasmaMinigun

#define weapon_type		return 5
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 6
#define weapon_cost		return 1
#define weapon_area		return -1
#define weapon_swap		return sndSwapEnergy

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"crystal" : "An plasma minigun made with some hard black metal. #Awesome. ", 
	"rogue" : "Large and heavy. Powerful. ", 
	"d" : "An plasma minigun made with some hard black metal that be designed #to be stably use by the people who behind the fortresses. #The muzzle looks like the dragon head. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndEliteShielderFire, 0.3)
	weapon_post(3, -6, 4)
	with(instance_create(x+lengthdir_x(4,gunangle), y+lengthdir_y(4,gunangle), PopoPlasmaBall))
		{
		if(skill_get(mut_laser_brain))
			{damage = 6}
		
		direction	= random_range(3, -3) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	}
