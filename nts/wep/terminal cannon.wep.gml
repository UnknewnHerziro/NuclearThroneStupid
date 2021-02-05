
#define init 

#define weapon_name		return "MOBILE SPACE-BASED TERMINAL"
#define weapon_sprt		return sprIonCannon

#define weapon_type		return 5
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 15
#define weapon_cost		return 2
#define weapon_area		return 5
#define weapon_swap		return sndSwapEnergy

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"Who fired the laser beams from the space? "



#define weapon_fire
	{
	sound_play_hit(sndPlasma, 0.3)
	wkick = 3
	with(instance_create(x, y, CustomProjectile))
		{
		mask_index	= mskEnemyBullet1
		speed		= 12
		
		direction	= other.gunangle
		image_angle	= direction - 90
		
		creator	= other
		team	= other.team
		
		on_hit		= refBlank
		on_step		= proj_step
		on_destroy	= proj_destroy
		}
	}

#define proj_step
with(instance_create(x, y, PlasmaTrail))
	{
	direction = random(360)
	speed = random(2)
	}

#define proj_destroy
with(instance_create(x, y, IonBurst))
	{
	creator	= other.creator
	team	= other.team
	}

#define refBlank
