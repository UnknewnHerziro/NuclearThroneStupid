
#define init
global.spr		= sprite_add("ToxicNukeLauncher.png",	7, 8, 6)
global.sprTN	= sprite_add("sprToxicNuke.png",		1, 6, 8)

#define weapon_name		return "toxic nuke launcher"
#define weapon_sprt		return global.spr

#define weapon_type		return 4
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 50
#define weapon_cost		return 3
#define weapon_area		return 14
#define weapon_swap		return sndSwapExplosive

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A toxic nuke rocket launcher. You believe its creator has dead. "



#define weapon_fire
sound_play_hit(sndNukeFire, 0.3); weapon_post(6, -9, 9);
with(instance_create(x,y,CustomProjectile))
	{
    team = other.team;
	index = other.index; 
    creator = other;
    damage = 60;
    force = 14;
	ff = 0; 
	typ = 1
    direction = other.gunangle;
    sprite_index = global.sprTN;
    on_step = script_ref_create(tnS)
	on_draw = script_ref_create(tnDraw)
    on_destroy = script_ref_create(tnD)
	}
#define tnS
if(speed>=5){speed=5; ff+=0.4; instance_create(x,y,ToxicGas)}else{speed+=0.2}
var dir=point_direction(x,y,mouse_x[index],mouse_y[index])-direction; 

if(abs(dir)>5){direction+=((dir+360)%360<180)? 3 : -3};
image_angle = direction;

#define tnDraw
if(speed>=3){draw_sprite_ext(sprNukeFlame, ff, x, y, 1, 1, image_angle, c_white, 1)}
draw_self()

#define tnD
repeat(8)
	{
	var dir=random(360); var dis=irandom(64); 
	with(instance_create(x+lengthdir_x(dis,dir),y+lengthdir_y(dis,dir),Explosion))
		{
		creator = other.creator; 
		with(instance_create(x,y,ToxicDelay))
			{
			creator = other.creator; 
			event_perform(ev_alarm,0); 
			instance_destroy(); 
			}
		}
	}
sound_play_hit(sndNukeExplosion, 0.3)
