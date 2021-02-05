
#define init
global.spr = sprite_add_weapon("NukeBazooka.png", 32, 16)

#define weapon_name		return "nuke bazooka"
#define weapon_sprt		return global.spr

#define weapon_type		return 4
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 40
#define weapon_cost		return 2
#define weapon_area		return 8
#define weapon_swap		return sndSwapExplosive

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A unstable devastating bomb launcher. "



#define weapon_fire
	{
	sound_play_hit(sndNukeFire, 0.3)
	weapon_post(10, -40, 8)
	with(instance_create(x, y, Nuke))
		{
		damage	= 40
		force	= 12
		
		direction	= other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		//index	= other.index
		
		script_bind_step(scrAlarmExplo, 0, self).t = 32
		}
	}

#define scrAlarmExplo
	{
	t -= current_time_scale
	if(t<=0)
		{
		with(argument0){instance_destroy()}
		instance_destroy()
		}
	}
