
#define init 
global.spr = sprite_add_weapon("StrikeGun.png", 12, 16)


#define weapon_name		return "STRIKE GUN"
#define weapon_sprt		return global.spr

#define weapon_type		return 5
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 30
#define weapon_cost		return 5
#define weapon_area		return 10
#define weapon_swap		return sndRogueCanister

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"rogue" : "When did they batch production it? ", 
	"phantom" : "Let us show the magic. ", 
	"d" : "Clearly, remade from the backpack of someone. #It's better at blast a deep hole. ", 
	}



#define weapon_fire
with(instance_create(x, y, RogueStrike))
	{
	image_angle = other.gunangle; 
	x += lengthdir_x(158, image_angle)
	y += lengthdir_y(158, image_angle)
	}
wkick = 8