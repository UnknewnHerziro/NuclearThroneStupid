
#define init 

#define weapon_name		return "HUNTER SHOTGUN"
#define weapon_sprt		return sprLilHunterGun2

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 6
#define weapon_cost		return 10
#define weapon_area		return -1
#define weapon_swap		return sndSwapShotgun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"rogue" : "You don't wanna recall your memories back. ", 
	"envoy" : "The attempt to negotiate failed. Clean. ", 
	"d" : "Amazing bouncer shotgun. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndLilHunterBouncer, 0.3)
	weapon_post(6, -12, 8)
	for(var i=-45; i<=45; i+=10){with(instance_create(x+lengthdir_x(8,gunangle), y+lengthdir_y(8,gunangle), LHBouncer))
		{
		speed = 6
		
		direction	= other.gunangle + i
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}}
	}
