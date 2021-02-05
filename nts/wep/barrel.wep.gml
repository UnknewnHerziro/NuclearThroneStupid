
#define weapon_name		return "BARREL"
#define weapon_sprt		return sprBarrel

#define weapon_type		return 0
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 29
#define weapon_cost		return 0
#define weapon_area		return -1
#define weapon_swap		return sndSwapFlame

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "Your officer will fly into a rage #because your stupid doing. ", 
	"melting" : "So warm. So tired. #Wanna sleep forever. ", 
	"venuz" : "u disdin 2 use it bcauz u had better 1 ", 
	"chicken" : "Roast turkey? ", 
	"rebel" : "Remember the warm old days? ", 
	"rogue" : "Why don't them make a campfire? #A kind of ritual? ", 
	"digger" : "Stupid doing. ", 
	"d" : "Explosive. #How could the bandits keep warm with this dangerous stuff? ", 
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
		mask_index = sprBarrel
		creator = other
		team = other.team
		spr_idle = sprBarrel
		spr_walk = sprBarrel
		spr_hurt = sprBarrel
		spr_dead = sprBarrelDead
		hitid = [sprBarrel, "BARREL"]
		}
	}
