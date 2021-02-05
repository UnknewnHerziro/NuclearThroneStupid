
#define init 

#define weapon_name		return "TRIPLE MACHINEGUN"
#define weapon_sprt		return sprTripleMachinegun

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 6
#define weapon_cost		return 3
#define weapon_area		return 12
#define weapon_swap		return sndSwapMachinegun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A large machinegun with three muzzles. #Not a popular weapon before. "



#define weapon_fire
sound_play_hit(sndTripleMachinegun, 0.3)
weapon_post(3, -9, 8)
for(var i=-20; i<=20; i+=20){with(instance_create(x+lengthdir_x(8,gunangle+b), y+lengthdir_y(8,gunangle+b), Bullet1))
	{
	speed = 15
	
	direction	= other.gunangle
	image_angle	= direction
	
	creator	= other
	team	= other.team
	}}
