#define init
global.spr = sprite_add_weapon("Bouncerka.png", 32, 16)

#define weapon_name		return "bouncerka"
#define weapon_sprt		return global.spr

#define weapon_type		return 4
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 32
#define weapon_cost		return 1
#define weapon_area		return 10
#define weapon_swap		return sndSwapExplosive

#define weapon_gold			return false
#define weapon_laser_sight	return false
/*
#define nts_weapon_examine	return
	
*/


#define weapon_fire
	{
	sound_play_hit(sndRocket, 0.3)
	weapon_post(6, -9, 9)
	with(instance_create(x, y, CustomProjectile))
		{
		team = other.team
		index = other.index
		creator = other
		damage = 27
		force = 10
		typ = 1
		sprite_index = sprRocket
		mask_index = mskBouncerBullet
		direction = other.gunangle
		image_angle = direction
		rot = image_angle
		image_yscale = choose(1, -1)
		bounce = 2
		on_step = tnS
		on_wall = tnWall
		on_draw = tnDraw
		on_destroy = tnD
		}
	}

#define tnS
if(speed >= 8)
	{
	rot += image_yscale * 36 * current_time_scale
	speed = 8
	}
else{speed += 0.5 * current_time_scale}

#define tnWall
if(bounce > 0)
	{
	move_bounce_solid(true)
	speed = 0
	image_angle = direction
	rot = image_angle
	sound_play_hit(sndBouncerBounce, 0.3)
	bounce --
	}
else{instance_destroy()}

#define tnDraw
if(speed >= 5){draw_sprite_ext(sprRocketFlame, current_frame, x, y, image_xscale, image_yscale, rot, c_white, 1)}
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, rot, c_white, 1)

#define tnD
with(instance_create(x, y, Rocket)){instance_destroy()}
