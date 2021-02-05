
#define init 

#define weapon_name		return "IDPD BATON"
#define weapon_sprt		return sprEnergyBaton

#define weapon_type		return 5
#define weapon_melee	return true
#define weapon_auto		return true
#define weapon_load		return 12
#define weapon_cost		return 1
#define weapon_area		return -1
#define weapon_swap		return sndSwapEnergy

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"eyes" : "An energy baton made with some hard black metal. #Ingenious. ", 
	"rogue" : "The batons of elite inspectors are the symbols of power. ", 
	"d" : "An energy baton made with some hard black metal that be designed #to be powerfully use by the people who more constancy. ", 
	}



#define weapon_fire
	{
	weapon_post(30, 4, 1)
	wepangle = -wepangle
	if(skill_get(13))
		{var b=20; var c=4}
	else{var b=5; var c=2}
	sound_play_hit(sndEliteInspectorFire, 0.3)
	with(instance_create(x+lengthdir_x(b,gunangle),y+lengthdir_y(b,gunangle),EnergySlash))
		{
		sprite_index = sprPopoSlash
		direction = other.gunangle
		image_angle = direction
		speed = c
		
		creator = other
		team = other.team
		damage = 12
		}
	}

#define step	mod_script_call("weapon", "pipe", "recoil", argument0, 4)