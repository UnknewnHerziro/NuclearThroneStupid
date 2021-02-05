#define init
global.spr = sprite_add("Camera.png", 11, 12, 16)
globalvar sf

global.sndlist = 
	[
	[sndCursedPickup,	1],
	[sndCursedChest,	1],
	[sndBigCursedChest,	2],
	[sndCrownCurses,	2],
	]

#define weapon_name		return "CAMERA"
#define weapon_sprt		return global.spr

#define weapon_type		return 5 
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 30 
#define weapon_cost		return 2 
#define weapon_area		return 12 
#define weapon_swap		return sndMutant8Slct

#define weapon_gold			return false
#define weapon_laser_sight	return true

#define nts_weapon_examine	return
	{
	"robo" : "!!! ERROR result ERROR !!! #DO NOT TELL YOUR FRIENDS WHERE THE OLD ROBOT GONE #F O R E V E R ", 
	"d" : "Looks similar. ", 
	}



#define weapon_fire
	{
	if(!skill_get(17)){sound_play_hit(sndSniperTarget, 0.3); gunshine=12; wait 11}
	if(!instance_exists(self)){exit}
	weapon_post(3, 0, 4)
	gunshine = 13

	var c = 0

	with(instances_matching_gt(Player,		"curse",	0)){c+=curse;	curse=0}
	with(instances_matching_gt(WepPickup,	"curse",	0)){c+=curse;	curse=0}
	with(instances_matching_gt(Player,		"bcurse",	0)){c+=bcurse;	bcurse=0}
	with(InvCrystal){c++}
	with(InvSpider){c++}
	with(InvLaserCrystal){c++}
	var mf = race=="molefish"
	var gl = GameCont.level*16
	with(instances_matching_ne(hitme, "team", team)){if(im(mf, gl)){if(!collision_line(x, y, other.x, other.y, Wall, true, true))
		{
		projectile_hit_raw(self, 10+c, 1)
		if(c > 0){instance_create(x, y, ReviveFX)}
		}}}

	if(c > 0)
		{
		var cs = global.sndlist[irandom(array_length(global.sndlist)-1)]
		var s = sound_play_hit(cs[0], 0)
		audio_sound_pitch(s,cs[1])
		}
	else{
		var s = sound_play_hit(sndUseCar, 0)
		audio_sound_pitch(s,4)
		}

	wait 2

	if(!instance_exists(self)){exit}

	sf = surface_create(game_screen_get_width_nonsync(), game_screen_get_height_nonsync())
	surface_screenshot(sf)
	script_bind_draw(A, -20, c)
	}



#define im(mf, gl)
if(mf){return point_distance(x,y,other.x,other.y) < (gl+64)}
else{return point_distance(x,y,mouse_x[other.index],mouse_y[other.index]) < gl}



#define A
if("t"!in self){t=1}
if(t>0)
	{
	draw_set_projection(0)
/*	if(argument0 > 0)
		{
		draw_set_alpha(t*0.5)
		draw_set_color(0)
		draw_rectangle(0, 0, game_width, game_height, 0)
		}
*/	
	draw_set_alpha(t*0.5)
	draw_set_color(argument0>0 ? 0 : c_white)
	draw_rectangle(0, 0, game_width, game_height, 0)
	
	draw_set_alpha(1)
	draw_set_color(c_white)
	draw_surface_ext(sf, 0, 0, game_width/game_screen_get_width_nonsync(),game_height/game_screen_get_height_nonsync(), 0, c_white, t*0.5)
	draw_reset_projection()
	t -= 0.05 * current_time_scale
	}
else{instance_destroy()}
