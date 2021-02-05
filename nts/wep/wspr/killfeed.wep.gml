#define init
global.spr = sprite_add_weapon("awp.png",14,11)
global.fire = sound_add("fire.ogg")
#define weapon_name
return "The Even Evener Longerer Longiest Longestedded Killfeed"
#define weapon_type
return 1
#define weapon_auto
return false
#define weapon_load
return 60
#define weapon_cost
return 100
#define weapon_sprt
if(instance_is(self, Player))
	{return mskNone}
if(instance_is(self, WepPickup))
	{depth = -8}
return global.spr
#define weapon_sprt_hud
return global.spr
#define weapon_area
return -1
#define weapon_swap
return sndSwapPistol
#define weapon_melee
return false
#define weapon_gold
return false
#define weapon_laser_sight
return false
#define weapon_fire
sound_play_hit(global.fire, 0.3)
weapon_post(90, -180, 999)
with instance_create(x + lengthdir_x(103,gunangle), y+ lengthdir_y(103,gunangle), Bullet1)
	{
    team = other.team
    creater = other
    damage = 999
    force = 10
    speed = 12
    direction = other.gunangle
    image_angle = direction
	}

#define step
script_bind_draw(dr_awp, -7, other, argument0)

#define dr_awp
with(argument0)
	{
	var data = argument1 ? [wkick] : [bwkick]
	var lx = lengthdir_x(data[@0], gunangle)
	var ly = lengthdir_y(data[@0], gunangle)
	draw_sprite_ext(weapon_sprt_hud(), gunshine, x-lx, y-ly, 1, right, gunangle, c_white, 1)
	}
instance_destroy()
