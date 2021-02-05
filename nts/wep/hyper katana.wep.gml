
#define init 
global.spr = sprite_add("HyperKatana.png", 7, 4, 0)

#define weapon_name		return "HYPER KATANA"
#define weapon_sprt		return global.spr

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 35
#define weapon_cost		return 0
#define weapon_area		return 10
#define weapon_swap		return sndSwapSword

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A sword made with unknown black metal. #Much lighter than it looks like. "



#define weapon_fire
	{
	wkick = -45
	wepangle = -wepangle
	sound_play_hit(sndEnergySwordUpg, 0.3)
	with(instance_create(x+lengthdir_x(5,gunangle), y+lengthdir_y(5,gunangle), Slash))
		{
		sprite_index	= sprMegaSlash
		mask_index		= mskMegaSlash
		image_blend		= c_aqua
		
		speed	= 2
		damage	= 24
		
		direction	= other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	}


#define step
if(argument0)
	{
	if(wkick < 15){wkick += 6*current_time_scale}
	if(wkick >= 15){wkick = 15}
	wepflip = right
	}