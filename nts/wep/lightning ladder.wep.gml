
#define init 
global.spr = sprite_add("LightningLadder.png", 7, 15, 10)

#define weapon_name		return "LIGHTNING LADDER"
#define weapon_sprt		return global.spr

#define weapon_type		return 5
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 30
#define weapon_cost		return 4
#define weapon_area		return 12
#define weapon_swap		return sndSwapEnergy

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"rogue" : "Some lunatics turned the scientific artworks into weapons. ", 
	"d" : "The lightning will be fired and existing for a while. ", 
	}



#define weapon_fire
	{
	weapon_post(15, 30, 12)
	sound_play_hit(sndLightningRifleUpg, 0.3)
	with(instance_create(x+lengthdir_x(5,gunangle), y+lengthdir_y(5,gunangle), LightningSlash))
		{
		speed = 2
		
		direction	= other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	with(instance_create(x, y,CustomProjectile))
		{
		mask_index	= mskDebris
		speed		= skill_get(mut_long_arms) ? 5 : 7
		
		direction	= other.gunangle
		creator		= other
		team		= other.team
		
		time	= 5
		ctime	= 0
		
		on_hit	= non
		on_step	= proj_step
		}
	}

#define non
#define proj_step
	{
	time	-= current_time_scale
	ctime	+= current_time_scale
	if(time <= 0)
		{
		with(instance_create(x, y, LightningSlash))
			{
			speed	= 5
			damage	= 6
			
			direction	= other.direction
			image_angle	= direction
			
			creator	= other.creator
			team	= other.team
			}
		sound_play_hit(sndLightningHit, 0.3)
		time = irandom_range(5, 10)
		}
	if(ctime >= 30){instance_destroy()}
	}
