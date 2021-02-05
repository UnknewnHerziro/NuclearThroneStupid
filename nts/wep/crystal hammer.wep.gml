
#define init 
global.spr		= sprite_add("CrystalHammer.png",		7,	8,	7)
global.sprPi	= sprite_add("CrystalPlasmaImpact.png",	7,	16,	16)
global.sprCslash	= mod_variable_get("weapon", "crystal rapier", "sprCslash")

#define weapon_sprt		return global.spr

#define weapon_name		return "crystal hammer"

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 30
#define weapon_cost		return 0
#define weapon_area		return mod_script_call("weapon", "crystal rapier", "weapon_area")
#define weapon_swap		return sndCrystalShield

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"crystal" : "A hammer made with yellow crystals that emitting pink light. #When your emotional energy swimming in it, #the pink impact will be fired. ", 
	"d" : "A hammer made with yellow crystals that emitting pink light. #When any form of energy swimming in it, #the pink impact will be fired. ", 
	}



#define weapon_fire
	{
	wepflip = -wepflip
	wepangle = -wepangle
	
	sound_play_hit(sndEnergyHammerUpg, 0.3)
	weapon_post(20, 12, 1)
	
	if(skill_get(mut_long_arms))
		{
		var dis	= 20
		var spd	= 4
		}
	else{
		var dis	= 5
		var spd	= 2
		}
	
	var can = string_pos("crystal", weapon_get_name(bwep)) || my_health==maxhealth
	
	with(instance_create(x + lengthdir_x(dis, gunangle), y + lengthdir_y(dis, gunangle), Slash))
		{
		sprite_index = global.sprCslash
		image_speed_raw = can ? 0.25 : 0.4
		speed = spd
		damage = 24
		
		direction = other.gunangle
		image_angle = direction
		creator = other
		team = other.team
		}
	
	with(instance_create(x + lengthdir_x(dis + 11, gunangle), y + lengthdir_y(dis + 11, gunangle), PlasmaImpact))
		{
		sprite_index = global.sprPi
		image_yscale = choose(1, -1)
		depth = -8
		mask_index = sprPlasmaImpact
		speed = spd
		damage = 5
		
		direction = other.gunangle
		image_angle = direction
		creator = other
		team = other.team
		
		if(can)
			{
			image_xscale = 1.5
			image_yscale = 1.5
			image_speed_raw = 0.2
			}
		else{image_speed_raw = 0.4}
		}
	
	repeat(10){prt_create(random_range(gunangle+45, gunangle-45), 90, random_range(1,2))}
	}

#define step		mod_script_call("weapon", "crystal rapier", "step", argument0)
#define prt_create	mod_script_call("weapon", "crystal rapier", "prt_create", argument0, argument1, argument2)
