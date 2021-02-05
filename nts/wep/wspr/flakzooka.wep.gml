#define init
global.spr = sprite_add_weapon("Flakzooka.png",9, 6)
global.flsa = sprite_add("flakdan.png",1,18,8)
#define weapon_name
return "FLAKZOOKA"
#define weapon_type
return 2
#define weapon_auto
return false
#define weapon_load
return 60
#define weapon_cost
return 48
#define weapon_sprt
return global.spr
#define weapon_area
return 20
#define weapon_swap
return sndSwapShotgun
#define weapon_melee
return false
#define weapon_gold
return false
#define weapon_laser_sight
return false
#define weapon_fire
sound_play_hit(sndSuperFlakCannon, 0.3)
weapon_post(6, -12, 12)
with instance_create(x + lengthdir_x(34,gunangle),y + lengthdir_y(34,gunangle),CustomProjectile)
{
    team = other.team;
    creater = other.id;
    damage = 1;
    force = 10;
    speed = 3;
    direction = other.gunangle;
    image_angle = direction;
    sprite_index = global.flsa;
    ff = current_frame;
    on_step = script_ref_create(stepp)
    on_hit = script_ref_create(hhh)
    on_wall = script_ref_create(hhh)
}
#define stepp
if((current_frame - ff) mod 10 == 0)
{
    with instance_create(x,y,SuperFlakBullet)
    {
        team = other.team;
        creater = other.id;
        speed = 10;
        direction = irandom(360);
    }
}
#define hhh
repeat(12)
{
    instance_create(x + irandom_range(-30,30),y + irandom_range(-30,30),Explosion);
}
for(i = 0;i < 5;i++)
{
    with instance_create(x,y,SuperFlakBullet)
    {
        team = other.team;
        creater = other.id;
        speed = 10;
        direction = other.i*(360/5);
    }
}
instance_destroy();