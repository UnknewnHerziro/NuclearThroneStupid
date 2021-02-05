
#define init 
global.spr = sprite_add_weapon("GammaCannon.png", 6, 3)

#define weapon_name		return "GAMMA CANNON"
#define weapon_sprt		return global.spr

#define weapon_type		return 5
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 6
#define weapon_cost		return 4
#define weapon_area		return 9
#define weapon_swap		return sndSwapEnergy

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A cannon fires large gamma balls. "



#define weapon_fire
	{
	sound_play_hit(sndGammaGutsProc, 0.3)
	weapon_post(10, -2, 1)
	with(mod_script_call("weapon", "gamma pistol", "create_gamma_ext", x+lengthdir_x(32,gunangle), y+lengthdir_y(32,gunangle), [4, 0], [40, 60], 0.5, 0.2, 4))
		{
		image_xscale = 4
		image_yscale = 4
		
		gamma_size	= 1
		
		direction	= random_range(5, -5) * other.accuracy + other.gunangle
		image_angle	= direction
		
		on_destroy = gamma_destroy
		}
	}



#define gamma_destroy
	{
	with(instance_create(x, y, BulletHit))
		{
		sprite_index = sprGuardianBulletHit
		image_angle = other.image_angle
		image_xscale = 2
		image_yscale = 2
		}
	with(instance_create(x, y, GammaBlast))
		{
		creator = other.creator
		team = other.team
		image_xscale = 2
		image_yscale = 2
		}
	
	instance_create(x, y, PortalClear)
	
	for(var i=0; i<8; i++){with(mod_script_call("weapon", "gamma pistol", "create_gamma_ext", x, y, [6, 0], [10, 20], 0.5, 0.2, 6))
		{
		direction	= other.direction + i * 45
		image_angle	= direction
		}}
	}
