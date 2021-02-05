
#define init 
global.spr = sprite_add_weapon("ToxicHammer.png", 7, 8)

#define weapon_name		return "toxic hammer"
#define weapon_sprt		return global.spr

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 35
#define weapon_cost		return 0
#define weapon_area		return 8
#define weapon_swap		return sndSwapHammer

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A hammer that releases toxic gas. "



#define weapon_fire
sound_play_hit(sndHammer, 0.3); weapon_post(4, 8, 1);; wepangle = -wepangle; 
if(skill_get(13)){var b=20; var c=4}else{var b=5; var c=2}
with(instance_create(x+lengthdir_x(b,gunangle),y+lengthdir_y(b,gunangle),Slash))
	{speed=c; direction=other.gunangle; image_angle=direction; creator=other; team=other.team; sprite_index=sprHeavySlash; damage=24; }
with(instance_create(x+lengthdir_x(b+48,gunangle),y+lengthdir_y(b+48,gunangle),ToxicDelay)){creator = other}