
#define init 

#define weapon_name		return "STUPID GUN"
#define weapon_sprt		return sprSmartGun

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 15
#define weapon_cost		return 8
#define weapon_area		return 10
#define weapon_swap		return sndSwapMachinegun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A smart rifle fires smart rifles. "



#define weapon_fire
	{
	sound_play_hit(sndSmartgun, 0.3)
	wkick = 6
	with(instance_create(x+lengthdir_x(4,gunangle), y+lengthdir_y(4,gunangle), SentryGun))
		{
		sprite_index	= sprSmartGun
		image_speed		= 0
		
		spr_idle = sprSmartGun
		spr_walk = sprSmartGun
		spr_hurt = sprSmartGun
		
		speed		= 10
		direction	= other.gunangle
		
		ammo = 8
		
		creator	= other
		team	= other.team
		}
	}
