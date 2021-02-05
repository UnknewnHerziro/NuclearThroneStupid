#define init
global.spr = sprite_add_weapon("ppnshot.png",11, 7)
#define weapon_name
return "PPNSHOT"
#define weapon_type
return 4;
#define weapon_auto
return 0;
#define weapon_load
return 15;
#define weapon_cost
return 20;
#define weapon_sprt
return global.spr
#define weapon_area
return 22;
#define weapon_swap
return sndSwapExplosive
#define weapon_melee
return false
#define weapon_gold
return false
#define weapon_laser_sight
return false
#define weapon_fire
sound_play_hit(sndGrenadeShotgun, 0.3)
weapon_post(6, -12, 12)
repeat(30)
{
	with instance_create(x + lengthdir_x(35,gunangle) ,
	y + lengthdir_y(35,gunangle ),PopoNade)
	{
		speed = 10 + irandom_range(-4,2);
		direction = other.gunangle + irandom_range(-15,15)
		image_angle = direction;
		team = other.team
		creator = other;
	}
}
repeat(5)
{
	with instance_create(x + lengthdir_x(35,gunangle) ,
	y + lengthdir_y(35,gunangle ),PlasmaBig)
	{
		speed = 6 + irandom_range(-1,2);
		direction = other.gunangle + irandom_range(-15,15)
		image_angle = direction;
		team = other.team
		creator = other;
	}
}

