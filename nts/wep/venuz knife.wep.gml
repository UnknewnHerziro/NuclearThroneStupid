
#define init 
global.spr = sprite_add("VenuzKnife.png", 7, 0, 2)

#define weapon_name		return "VENUZ KNIFE"
#define weapon_sprt		return global.spr

#define weapon_type		return 0
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 5
#define weapon_cost		return 0
#define weapon_area		return GameCont.area==103 ? 0 : -1
#define weapon_swap		return sndSwapSword

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"venuz" : " S H A M E  ", 
	"chicken" : "Feels like a wolf. ", 
	"tricker" : "Stole it from an old friend. ", 
	"d" : "Not a toothbrush. #Too sharp to deflect bullets. ", 
	}



#define weapon_fire
weapon_post(-6, 12, 1)
motion_add(gunangle, 4)
sound_play_hit(sndScrewdriver, 0.3)
if(skill_get(13))
	{var b=10; var c=4}
else{var b=5; var c=2}
with(instance_create(x+lengthdir_x(b,gunangle), y+lengthdir_y(b,gunangle), CustomProjectile))
	{
	image_speed = 0.4
	
	sprite_index = sprShank
	mask_index = sprShank
	speed = c
	direction = other.gunangle
	image_angle = direction
	
	creator = other
	team = other.team
	
	damage = 8
	force = 6
	typ = 0
	
	on_hit = scrHit
	on_anim = scrDestroy
	on_wall = scrNone
	}

#define scrNone
#define scrDestroy	instance_destroy()
#define scrHit
if(projectile_canhit_melee(other))
	{projectile_hit(other, damage, force, direction)}