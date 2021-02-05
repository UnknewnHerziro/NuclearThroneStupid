
#define init 
global.spr = sprite_add_weapon("GammaPistol.png", 6, 3)

#define weapon_name		return "GAMMA PISTOL"
#define weapon_sprt		return global.spr

#define weapon_type		return 5
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 10
#define weapon_cost		return 1
#define weapon_area		return 1
#define weapon_swap		return sndSwapEnergy

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A pistol fires gamma balls. "



#define weapon_fire
	{
	sound_play_hit(sndGammaGutsProc, 0.3)
	weapon_post(3, -2, 1)
	create_gamma(8, 5, [6, 0], 0.5, 0.2, 6)
	}

#define create_gamma(dis, off, spd, dec, ris, gmx)
with(create_gamma_ext(x+lengthdir_x(dis,gunangle), y+lengthdir_y(dis,gunangle), spd, [10, 20], dec, ris, gmx))
	{
	direction = random_range(off, -off) * other.accuracy + other.gunangle
	return self
	}

#define create_gamma_ext(dx, dy, spd, num, dec, ris, gmx)
	{
	with(instance_create(dx, dy, CustomProjectile))
		{
		sprite_index = sprGammaGuts
		mask_index = mskGuardianBullet
		
		image_angle = direction
		
		creator = other
		team = other.team
		
		speed		= spd[@skill_get(mut_laser_brain)]
		gamma_num	= num[@skill_get(mut_laser_brain)]
		gamma_size	= 0.5
		gamma_decay	= dec
		gamma_rise	= ris
		gamma_max	= gmx
		
		gamma_summon = -1
		
		on_step = gamma_step
		on_hit = gamma_hit
		on_destroy = gamma_destroy
		
		return self
		}
	}

#define gamma_step
	{
	if(gamma_summon == 0)
		{speed = min(gamma_max, speed + gamma_rise * current_time_scale)}
	else{
		if(gamma_summon == 1)
			{speed -= gamma_decay * current_time_scale}
		gamma_summon = 0
		
		sound_play_hit(sndGammaGutsProc, 0.3)
		with(instance_create(x, y, GammaBlast))
			{
			creator = other.creator
			team = other.team
			image_xscale = other.gamma_size
			image_yscale = other.gamma_size
			}
		
		gamma_num --
		if(gamma_num <= 0)
			{instance_destroy()}
		}
	}

#define gamma_hit	gamma_summon = instance_is(other, enemy) ? 1 : -1

#define gamma_destroy
	{
	with(instance_create(x, y, BulletHit))
		{
		sprite_index = sprGuardianBulletHit
		image_angle = other.image_angle
		}
	if(gamma_num <= 0)
		{
		with(instance_create(x, y, GammaBlast))
			{
			creator = other.creator
			team = other.team
			}
		sound_play_hit(sndGammaGutsKill, 0.3)
		}
	}
