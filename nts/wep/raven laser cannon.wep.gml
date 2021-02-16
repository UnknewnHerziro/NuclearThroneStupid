#define init
	{
	global.spr			= sprite_add("RavenLaserCannon.png",	7,	8,	12)
	global.sprCLC_idle	= sprite_add("sprCLCidle.png",	5,	24,	24)
	global.sprCLC_fire	= sprite_add("sprCLCfire.png",	2,	24,	24)
	global.sprCL		= sprite_add("sprCL.png",	1,	2,	4)
	}

#define weapon_name		return "@dRAVEN @wLASER @sCANNON"
#define weapon_sprt		return global.spr

#define weapon_type		return 5
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 60
#define weapon_cost		return 12
#define weapon_area		return GameCont.area==3 ? 13 : -1
#define weapon_swap		return sndRavenLand

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"You do not understand. "



#define weapon_fire
	{
	sound_play_hit(sndLaserCrystalCharge, 0.3)
	weapon_post(8, -16, 32)
	
	with(instance_create(x + lengthdir_x(13, gunangle), y + lengthdir_y(13, gunangle), CustomProjectile))
		{
		sprite_index	= global.sprCLC_idle
		mask_index		= mskLaserCrystal
		image_speed_raw	= 0.4
		speed			= 5
		
		damage	= 20
		force	= 3
		
		direction		= other.gunangle + random_range(5, -5)*other.accuracy
		image_angle		= direction - 90
		
		creator	= other
		team	= other.team
		
		nts_rlc_alarm	= 20
		nts_rlc_times	= 8
		
		on_step		= step_rlc
		on_hit		= hit_rlc
		on_destroy	= destroy_rlc
		}
	}



#define step_rlc
	{
	image_angle = direction - 90
	move_bounce_solid(false)
	
	nts_rlc_alarm -= current_time_scale
	
	if(nts_rlc_alarm <= 0)
		{
		sprite_index	=	global.sprCLC_fire
		nts_rlc_alarm	=	3
		nts_rlc_times	--
		
		create_cl(4)
		
		if(nts_rlc_times < 0)
			{return instance_destroy()}
		}
	
	speed = max(0, speed - current_time_scale * 0.1)
	}

#define hit_rlc
	{
	nts_rlc_alarm = min(nts_rlc_alarm, 1)
	projectile_hit(other, damage)
	}

#define destroy_rlc
	{
	sound_play_hit(sndRavenDie, 0.3)
	create_cl(skill_get(mut_laser_brain) ? 12 : 8)
	}



#define create_cl
	{
	var _laser = skill_get(mut_laser_brain)
	
	sound_play_hit(_laser ? sndLaserUpg : Laser, 0.3)
	
	repeat(argument0){with(instance_create(x, y, EnemyLaser))
		{
		if(_laser)
			{image_yscale = 1.5}
		
		sprite_index = global.sprCL
		
		direction	= random(360)
		image_angle	= direction
		
		team = other.team
		
		event_perform(ev_alarm, 0)
		}}
	}


