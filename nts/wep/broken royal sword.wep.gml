#define init 
global.spr = sprite_add("BrokenRoyalSword.png", 7, 6, 8)
global.ldt = sprite_add("BrokenRoyalSwordLoadout.png", 6, 24, 24)

#define weapon_name		return "BROKEN ROYAL SWORD"
#define weapon_sprt		return global.spr
#define weapon_loadout	return global.ldt

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 12
#define weapon_cost		return 0
#define weapon_area		return -1
#define weapon_swap		return sndSwapSword

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A sword made with unknown red metal. #Much lighter than it looks like. "



#define weapon_fire
	{
	weapon_post(-6, 4, 0)
	wepangle = -wepangle
	if(skill_get(13))
		{
		var dis = -30
		var spd = 1
		var ixs = 1.5
		}
	else{
		var dis = -20 + speed
		var spd = 3
		var ixs = 1
		}
	with(instance_create(x+lengthdir_x(dis,gunangle), y+lengthdir_y(dis,gunangle), Slash))
		{
		sprite_index	= sprSlash
		image_blend		= c_red
		speed			= spd
		image_xscale	= ixs
		damage			= 16
		
		direction	= other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	sound_play_hit(sndBlackSword, 0.3)
	}

#define step
if(argument0 && bwep==wep_black_sword && GameCont.area==100 && GameCont.loops)
	{
	sound_play_hit(sndCursedReminder, 0)
	wep = "royal sword"
	}