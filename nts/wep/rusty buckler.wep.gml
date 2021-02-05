#define init 
global.spr = sprite_add_weapon("RustyBuckler.png", 1, 9)

#define weapon_name		return "rusty buckler"
#define weapon_sprt		return global.spr

#define weapon_type		return 5
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 20
#define weapon_cost		return 1
#define weapon_area		return GameCont.level==10 ? 0 : -1
#define weapon_swap		return sndSwapHammer

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"Ancient smells. "




#define weapon_fire
	{
	sound_play_hit(sndCrystalJuggernaut, 0.3)
	weapon_post(-20, 8, 4)
	var d = skill_get(mut_long_arms) ? 32 : 16
	with(instance_create(x+lengthdir_x(d,gunangle), y+lengthdir_y(d,gunangle), GuardianDeflect))
		{
		image_speed = skill_get(mut_laser_brain) ? 0.3 : 0.5
		force = 16
		
		creator	= other
		team	= other.team
		
		if(other.speed<other.maxspeed || !place_free(x, y))
			{
			image_xscale = 2.5
			image_yscale = 2.5
			with(other){for(var i=-10; i<=10; i+=5)
				{
				with(instance_create(x+lengthdir_x(16,gunangle), y+lengthdir_y(16,gunangle), EnemyBullet2))
					{
					creator	= other
					team	= other.team
					
					motion_add(other.gunangle+i, 17)
					image_angle = direction
					}
				}}
			}
		else{
			image_xscale = 1.5
			image_yscale = 1.5
			
			motion_add(other.gunangle, 5)
			
			with(other){for(var i=-30; i<=30; i+=15)
				{
				with(instance_create(x+lengthdir_x(16,gunangle), y+lengthdir_y(16,gunangle), EnemyBullet2))
					{
					creator	= other
					team	= other.team
					
					motion_add(other.gunangle+i, 8)
					image_angle = direction
					}
				}}
			}
		}
	}
