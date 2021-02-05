#define init
global.spr_idle = sprite_add("idle.png", 33, 12, 12);
global.spr_walk = sprite_add("walk.png", 6, 12, 12);
global.spr_hurt = sprite_add("hurt.png", 3, 12, 12);
global.spr_dead = sprite_add("dead.png", 6, 12, 12);
//global.mapicon = sprite_add("mapicon.png", 1, 10, 10);
global.chs = sprite_add("CharSelect.png", 1, 0, 0);
global.EGI1 = sprite_add("Icon1.png", 1, 9, 9);
global.EGI2 = sprite_add("Icon2.png", 1, 9, 9);
global.EG1 = sprite_add("Skill1.png", 1, 12, 16);
global.EG2 = sprite_add("Skill2.png", 1, 12, 16);
sprEnvoyLift = sprite_add("EnvoyLift.png", 5, 32, 48);
sprEnvoyFly = sprite_add("EnvoyFly.png", 5, 32, 48);
sprEnvoyLand = sprite_add("EnvoyLand.png", 4, 32, 48);
sprEnvoyIdle = global.spr_idle
globalvar sprEnvoyLift, sprEnvoyFly, sprEnvoyLand, sprEnvoyIdle

#define nts_weapon_examine	return 
	{
	"0":	"Your weak wings. You can't hurt enemies by it. ", 
	"81":	"Commandeered. ", 
	"115":	"Incomprehensible. ", 
	"120":	"Disgusting. ", 
	"127":	"Leave it. Now. ", 
	"wand":	"Illegible. ", 
	}



#define create
image_speed_raw = 0.4
spr_idle = global.spr_idle
spr_walk = global.spr_walk
spr_hurt = global.spr_hurt
spr_dead = global.spr_dead
spr_sit1 = global.spr_idle
spr_sit2 = global.spr_idle

snd_hurt= sndRavenHit
snd_dead= sndRavenDie
snd_lowa= sndRavenScreech
snd_lowh= sndRavenScreech
snd_chst= sndRavenScreech
snd_wrld= sndRavenScreech
snd_valt= sndRavenScreech
snd_crwn= sndRavenScreech
snd_thrn= sndRavenScreech
snd_spch= sndRavenScreech
snd_idpd= sndRavenScreech
snd_cptn= sndRavenScreech
nts_color_blood = [c_aqua, c_white]

maxspeed -= 0.5

envoyflying = false
flycd = 0

#define game_start

#define step
	{
	if(button_pressed(index,"horn"))
		{sound_play_hit(sndRavenScreech, 0.3)}
	
	if(mod_exists("mod", "NT3D"))
		{step_3d()}
	else{step_normal()}
	}

#define step_normal
	{
	if(canspec && button_pressed(index,"spec") && image_alpha==1 && flycd<=0)
		{
		if	(
				(
					skill_get(5)
				||	(
						!skill_get(5)
					&&	place_meeting(mouse_x[index], mouse_y[index], Floor)
					&&	place_free(mouse_x[index], mouse_y[index])
					)
				)
			&& (array_length(instances_matching_ne(hitme, "team", team)) || instance_exists(Portal))
			)
			{
			with(instance_create(x,y,CustomObject))
				{
				sprite_index = sprEnvoyLift
				mask_index = mskPlayer
				depth = -12
				image_speed_raw = 0.4
				spr_shadow_x = 0
				spr_shadow_y = 0
				shd_depth = 0
				
				creator = other
				index = other.index
				dx = mouse_x[index]
				dy = mouse_y[index]
				
				ntstype = "EnvoyFlying"
				Lifting = true
				Flying = false
				Landing = false
				on_step = EnvoyFly
				on_draw = EnvoyDr
				on_destroy = EnvoyLand
				EnvoyFly()
				}
			sound_play_hit(sndRavenLift, 0.3)
			}
		else{sound_play_hit(sndRavenScreech, 0.3)}
		}
	
	if(flycd>0 && !envoyflying)
		{
		image_alpha = 0.8
		flycd -= current_time_scale
		if(flycd <= 0)
			{image_alpha = 1}
		}
	if(!array_length(instances_matching(CustomObject,"ntstype","EnvoyFlying")))
		{envoyflying = false}
	}

#define step_3d
	{
	if(canspec && button_check(index,"spec"))
		{
		var rate = 0.1 * current_time_scale
		z = z*(1-rate) + 64*rate
		fall = 0
		
		if(!skill_get(5))
			{
			speed = 5
			direction = gunangle
			}
		
		if(ultra_get("envoy", 1) && z<32){with(projectile){if(distance_to_object(other)<=128)
			{
			var envoy_dr = point_direction(x, y, other.x, other.y)
			var envoy_sp = (skill_get(5) ? 5 : 3) * current_time_scale
			x += lengthdir_x(envoy_sp, envoy_dr)
			y += lengthdir_y(envoy_sp, envoy_dr)
			}}}
		}
	
	if(z>32 && !skill_get(5))
		{direction = gunangle}
	
	if(ultra_get("envoy", 1) && fall<0){with(projectile){if(distance_to_object(other)<=128)
		{
		var envoy_dr = point_direction(x, y, other.x, other.y) + 180
		var envoy_sp = (skill_get(5) ? 5 : 3) * current_time_scale
		x += lengthdir_x(envoy_sp, envoy_dr)
		y += lengthdir_y(envoy_sp, envoy_dr)
		}}}
	
	canfire = z<32 || ultra_get(mod_current, 2)
	}



#define EnvoyFly
	{
	if(!skill_get(5) && !Landing)
		{script_bind_draw(EnvoyD, -2, index+1, dx, dy)}
	
	gunangle = point_direction(x, y, mouse_x[index], mouse_y[index])
	right = (gunangle<90 || gunangle>270) ? 1 : -1
	image_xscale = right
	fspeed = min(point_distance(x, y, mouse_x[index], mouse_y[index]), 5*current_time_scale)
	
	gx = x + lengthdir_x(fspeed, gunangle)
	gy = y + lengthdir_y(fspeed, gunangle)
	
	fd = ultra_get("envoy", 1) ? 16 : 32
	spr_shadow = place_meeting(x, y, Floor) ? shd24 : mskNone
	with(creator)
		{
		x = other.x
		y = other.y
		mask_index = mskNone
		envoyflying = true
		if(ultra_get("envoy", 2))
			{
			image_alpha = 0
			spr_shadow = mskNone
			//if(other.Flying){script_bind_draw(EnvoyW, other.depth+(gunangle<180?0.1:-0.1), weapon_get_sprt(wep), self, weapon_is_melee(wep)?gunangle+wepangle:gunangle)}
			}
		else{visible = false}
		}
	
	flycd = variable_instance_get(self, "flycd", 0) + current_time_scale
	if(flycd>180 && (flycd mod 20)<current_time_scale){with(instances_matching(Player, "index", index))
		{
		my_health -= 1
		sound_play_hit(snd_hurt, 0.3)
		lasthit=[sprRavenFeather, "punishment"]
		}}
	if((flycd mod 20)<current_time_scale && flycd>120 && skill_get(5) && !Landing){with(instance_create(x, y-16, AssassinNotice))
		{
		depth = -14
		image_xscale = 2
		image_yscale = 2
		}}

	if(Lifting)
		{
		if(image_index+image_speed_raw >= 5)
			{
			sprite_index = sprEnvoyFly
			image_index = 0
			Lifting = false
			Flying = true
			}
		if(ultra_get("envoy", 1)){with(projectile){if(distance_to_object(other)<=128)
			{
			var envoy_dr = point_direction(x, y, other.x, other.y)
			var envoy_sp = (skill_get(5) ? 5 : 3) * current_time_scale
			x += lengthdir_x(envoy_sp, envoy_dr)
			y += lengthdir_y(envoy_sp, envoy_dr)
			}}}
		}
	if(Flying)
		{
		if	(
				(
					(!skill_get(5) && (collision_point(dx,dy,self,0,0) || button_pressed(index,"spec")))
				||	(skill_get(5) && !button_check(index,"spec"))
				)
			&&	place_free(x,y)
			&&	place_meeting(gx,gy,Floor)
			)
			{
			speed = 0
			sprite_index = sprEnvoyLand
			image_index = 0
			Flying = false
			Landing = true
			sound_play_hit(sndRavenLand, 0.3)
			}
		else{
			if(skill_get(5))
				{
				direction = gunangle
				speed_raw = fspeed
				}
			else{move_towards_point(dx, dy, 5*current_time_scale)}
			}
		if(skill_get(5) && !place_meeting(gx, gy, Floor))
			{
			var nf = instance_nearest(x,y,Floor)
			var dis = distance_to_point(nf.x,nf.y) / 24 * current_time_scale
			var dir = point_direction(x, y, nf.x, nf.y)
			x += lengthdir_x(dis, dir)
			y += lengthdir_y(dis, dir)
			}
		if(instance_exists(Portal)){if(Portal.endgame < 30)
			{
			speed = 0
			image_index = 0
			Flying = false
			Landing = true
			sound_play_hit(sndRavenLand, 0.3)
			}}
		}
	if(Landing)
		{
		if(ultra_get("envoy", 1)){with(projectile){if(distance_to_object(other)<=128)
			{
			var envoy_dr = point_direction(x, y, other.x, other.y) + 180
			var envoy_sp = (skill_get(5) ? 5 : 3) * current_time_scale
			x += lengthdir_x(envoy_sp, envoy_dr)
			y += lengthdir_y(envoy_sp, envoy_dr)
			}}}
		if(image_index+image_speed_raw >= 4){instance_destroy()}
		}
	
	if(instance_exists(self)){with(creator){if(my_health<=0 && candie){with(other){instance_destroy()}}}}
	}

#define EnvoyD(index, dx, dy )
draw_sprite_ext(sprPlayerIndicator, index, dx, dy, 1, 1, 0, c_white, 1);
instance_destroy();

#define EnvoyDr
if(ultra_get("envoy", 2) && Flying)
	{
	if(gunangle < 180)
		{
		with(creator){draw_sprite_ext(weapon_get_sprt(wep), 0, x, y-8-wkick, 1, right, weapon_is_melee(wep)?gunangle+wepangle:gunangle, c_white, 1)}
		draw_self()
		}
	else{
		draw_self()
		with(creator){draw_sprite_ext(weapon_get_sprt(wep), 0, x, y-8-wkick, 1, right, weapon_is_melee(wep)?gunangle+wepangle:gunangle, c_white, 1)}
		}
	}
else{draw_self()}

#define EnvoyW(spr, a, rot)
with(a){draw_sprite_ext(spr, 0, x, y-8, 1, right, rot, c_white, 1)}
instance_destroy()

#define EnvoyLand
	{
	with(creator)
		{
		mask_index = mskPlayer
		envoyflying = false
		speed = 0
		if(ultra_get("envoy", 2))
			{
			image_alpha = 1
			spr_shadow = shd24
			}
		else{visible = true}
		flycd = min(other.flycd/2,90)
		}
	}



#define draw

#define race_name
return "ENVOY";
#define race_text
return "IS SLOWER#CAN'T PUNCH#CAN FLY";
//#define race_portrait
//return ;
#define race_swep
return "envoy smg";

#define race_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock
return "reach ???";

#define race_mapicon
//return global.mapicon;

#define race_menu_button
sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}
#define race_menu_select
return sndRavenLand;
#define race_menu_confirm
return sndRavenLift;
/*
#define race_skins
return 2;
#define race_skin_button
switch(argument0)
	{
	case 0: sprite_index = global.spr_dead; image_index=5; break;
	case 1: sprite_index = global.spr_deadb; image_index=5; break;
	default: break;
	}
*/
#define race_tb_text
return "CONTROL FLYING";
#define race_tb_take

#define race_ultra_name
switch(argument0)
	{
	case 1: return "ATAVISM";break;
	case 2: return "EVOLUTION";break;
	default: return "";break;
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return "AIRFLOW STORM";break;
	case 2: return "FIRE WHEN FLYING";break;
	default: return "";break;
	}

#define race_ultra_button
switch(argument0)
	{
	case 1: sprite_index  =  global.EG1; break;
	case 2: sprite_index  =  global.EG2; break;
	default: break;
	}

#define race_ultra_take
switch(argument0)
	{
	case 1: break;
	case 2: break;
	default: break;
	}

#define race_ultra_icon
switch(argument0)
	{
	case 1: return global.EGI1;break;
	case 2: return global.EGI2;break;
	default: return ;break;
	}

#define race_ttip
return [];
