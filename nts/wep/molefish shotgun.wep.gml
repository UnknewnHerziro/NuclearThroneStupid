
#define init 

#define weapon_name		return "MOLEFISH SHOTGUN"
#define weapon_sprt		return sprMolesargeGun

#define weapon_type		return 2
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 12
#define weapon_cost		return 1
#define weapon_area		return 2
#define weapon_swap		return sndSwapShotgun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "A shotgun looks like the police shotgun, #but the bullets' direction were so weird. ", 
	"venuz" : "venuz succ shotgun", 
	"robot" : "Tastes like Golden Weapon but not all. ", 
	"rogue" : "Not be made with Earth technology. #The Captain was trying to find out the source of these weirdo weapons. ", 
	"d" : "A dark grey shotgun. #You suddenly want to make some beat with it. ", 
	}



#define weapon_fire
	{
	sound_play_hit(sndMolefishFire, 0.3)
	weapon_post(2, -6, 4)
	for(var i=-30; i<=30; i+=15){with(instance_create(x+lengthdir_x(8,gunangle), y+lengthdir_y(8,gunangle), EnemyBullet3))
		{
		speed	= 12
		damage	= 5
		force	= 0
		
		direction	= other.gunangle + i
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}}
	}
