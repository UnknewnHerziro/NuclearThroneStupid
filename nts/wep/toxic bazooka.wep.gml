
#define init
global.spr = sprite_add_weapon("ToxicBazooka.png", 12, 7)

#define weapon_name		return "toxic bazooka"
#define weapon_sprt		return global.spr

#define weapon_type		return 4
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 45
#define weapon_cost		return 1
#define weapon_area		return 9
#define weapon_swap		return sndSwapExplosive

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A toxic rocket launcher. "



#define weapon_fire
sound_play_hit(sndRocket, 0.3); weapon_post(6, -9, 9); 
with(instance_create(x,y,CustomProjectile))
	{
    team = other.team;
	index = other.index; 
    creator = other;
    damage = 20;
    force = 10;
	typ = 1
	ff = 0; 
    direction = other.gunangle; 
	image_angle=direction; 
    sprite_index = sprRocket;
    on_step = tnS
	on_draw = tnDraw
    on_destroy = tnD
	}
#define tnS
if(speed>=8){speed=8-0.5*current_time_scale; ff+=0.4; instance_create(x,y,ToxicGas)}else{speed+=0.5*current_time_scale}

#define tnDraw
if(speed>=5){draw_sprite_ext(sprRocketFlame, ff, x, y, 1, 1, image_angle, c_white, 1)}
draw_self()

#define tnD
with(instance_create(x,y,Rocket)){instance_destroy()}
with(instance_create(x,y,ToxicDelay))
	{
	creator = other.creator; 
	event_perform(ev_alarm,0); 
	instance_destroy(); 
	}
sound_play_hit(sndExplosion, 0.3)
