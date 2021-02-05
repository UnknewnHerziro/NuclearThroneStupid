#define init
global.spr = sprite_add_weapon("shotgod.png",12, 9)
#define weapon_name
return "SHOTGOD"
#define weapon_type
return 2;
#define weapon_auto
return 0;
#define weapon_load
return 45;
#define weapon_cost
return 16;
#define weapon_sprt
return global.spr
#define weapon_area
return 16;
#define weapon_swap
return sndSwapShotgun
#define weapon_melee
return 0;
#define weapon_gold
return 0;
#define weapon_laser_sight
return 0;
#define weapon_fire
weapon_post(6, -12, 12)
sound_play_hit(sndWaveGun, 0.3)
repeat(27)
{
	with instance_create(x + lengthdir_x(31,gunangle - 15) ,
	y + lengthdir_y(31,gunangle - 15 ),Bullet1)
	{
		speed = 10 + irandom_range(-4,2);
		direction = other.gunangle - 15 + + irandom_range(-5,5)
		image_angle = direction;
		team = other.team
		creator = other;
		damage = 1;
	}
}
repeat(27)
{
	with instance_create(x + lengthdir_x(31,gunangle + 15) ,
	y + lengthdir_y(31,gunangle + 15 ),Bullet1)
	{
		speed = 10 + irandom_range(-4,2);
		direction = other.gunangle + 15  + irandom_range(-5,5)
		image_angle = direction;
		team = other.team
		creator = other;
		damage = 1;
	}
}
repeat(20)
{
	with instance_create(x + lengthdir_x(31,gunangle) ,
	y + lengthdir_y(31,gunangle ),FlakBullet)
	{
		speed = 10 + irandom_range(-4,2);
		direction = other.gunangle  + irandom_range(-5,5)
		image_angle = direction;
		team = other.team
		creator = other;
		damage = 1;
	}
}
repeat(80)
{
	with instance_create(x + lengthdir_x(31,gunangle) ,
	y + lengthdir_y(31,gunangle ),Shell)
	{
		speed = random_range(7,12)
		direction = (other.gunangle  + irandom_range(-15,15)) + 180
		image_angle = irandom(360);
		team = other.team
		creator = other;
		
	}
}
motion_add(gunangle, -600);