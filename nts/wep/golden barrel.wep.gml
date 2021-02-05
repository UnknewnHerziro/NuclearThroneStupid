
#define init 

#define weapon_name		return "GOLDEN BARREL"
#define weapon_sprt		return sprGoldBarrel

#define weapon_type		return 0
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 29
#define weapon_cost		return 0
#define weapon_area		return -1
#define weapon_swap		return sndSwapGold

#define weapon_gold			return -1
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "Now you are much rich than your officer. ", 
	"melting" : "So warm. So tired. #Wanna sleep forever. ", 
	"venuz" : "zere it iz ", 
	"rogue" : "Extravagant hobby... #Even the silly bandits are much wise than the owner of the mansion. ", 
	"d" : "So shiny... ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndSwapFlame, 0.3)
	motion_add(gunangle, 4)
	weapon_post(0, -6, 0)
	wep = 0
	curse = 0
	with(instance_create(x, y, CarThrow))
		{
		direction = other.gunangle
		image_angle = direction
		speed = 7
		mask_index = sprGoldBarrel
		creator = other
		team = other.team
		spr_idle = sprGoldBarrel
		spr_walk = sprGoldBarrel
		spr_hurt = sprGoldBarrel
		spr_dead = sprGoldBarrelDead
		hitid = [sprGoldBarrel, "GOLDEN BARREL"]
		}
	}
