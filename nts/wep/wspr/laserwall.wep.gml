#define init
global.spr = sprite_add_weapon("laserwall.png",4, 21)
#define weapon_name
return "LASERWALL"
#define weapon_type
return 5;
#define weapon_auto
return 1;
#define weapon_load
return 1;
#define weapon_cost
return 1;
#define weapon_sprt
return global.spr
#define weapon_area
return 24;
#define weapon_swap
return sndSwapEnergy
#define weapon_melee
return 0;
#define weapon_gold
return 0;
#define weapon_laser_sight
return 0;
#define weapon_fire
sound_play_hit(skill_get(17)?sndLaserUpg:sndLaser, 0.3);wkick=random(6);
num = irandom_range(-35,35)
with instance_create(x + lengthdir_x(24,gunangle + num) ,y + lengthdir_y(30,gunangle + num),Laser)
{
	alarm0 = 2 + (skill_get(17));
	image_angle = other.gunangle ;
	image_yscale = 1.6 + (skill_get(17) * 0.6);
    
	team = other.team
	creator = other;
	damage = 1;
}