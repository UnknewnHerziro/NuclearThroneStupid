
#define init 
global.spr = sprite_add("RustyShovel.png", 7, 4, 5)

#define weapon_name		return "RUSTY SHOVEL"
#define weapon_sprt		return global.spr

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 40
#define weapon_cost		return 0
#define weapon_area		return -1
#define weapon_swap		return sndSwapHammer

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A digging tool with red rust. #You heard some beat from the deep underground. "



#define weapon_fire
	{
	sound_play_hit(sndShovel, 0.3)
	motion_add(gunangle,4)
	weapon_post(-3, 8, 1)
	wepangle = -wepangle
	if(skill_get(mut_long_arms))
		{
		var dis = 20
		var spd = 4
		}
	else{
		var dis = 5
		var spd = 2
		}
	for(var i=-15; i<=15; i+=15){with(instance_create(x+lengthdir_x(dis,gunangle), y+lengthdir_y(dis,gunangle), Slash))
		{
		speed	= spd
		damage	= 12
		
		direction	= other.gunangle + i
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}}
	}
