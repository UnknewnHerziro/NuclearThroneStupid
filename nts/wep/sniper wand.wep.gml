
#define init 
global.spr = sprite_add_weapon("SniperWand.png", 14, 4)

#define weapon_name		return "SNIPER WAND"
#define weapon_sprt		return global.spr

#define weapon_type		return 5
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 18 - GameCont.level
#define weapon_cost		return 1
#define weapon_area		return -1
#define weapon_swap		return sndSniperTarget

#define weapon_gold			return false
#define weapon_laser_sight	return true

#define nts_weapon_examine	return
	"A sniper-rifle-like wand that fires fireballs. "




#define weapon_fire
	{
	sound_play_hit(sndOasisCrabAttack, 0.3)
	wkick = 7
	repeat(6 + GameCont.level * 1.5){with(instance_create(x+lengthdir_x(13,gunangle), y+lengthdir_y(13,gunangle), FireBall))
		{
		speed	= 15
		damage	= 1
		
		direction	= random_range(3,-3) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		
		}}
	}
