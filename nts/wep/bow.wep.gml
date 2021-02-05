
#define init

#define weapon_name		return is_object(argument0) ? "fledgling gun" : (skill_get(5) ? "ally gun" : "bandit gun")
#define weapon_sprt_hud	return skill_get(5) ? sprAllyGunTB : sprBanditGun

#define weapon_sprt
	{
	if(instance_is(self, Player)){if(is_object(argument0)){if(argument0.frame > 0)
		{return mskNone}}}
	return skill_get(5) ? sprAllyGunTB : sprBanditGun
	}

#define weapon_type		return is_object(argument0) ? 3 : 1
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return current_time_scale
#define weapon_cost		return 0
#define weapon_area		return 3
#define weapon_swap		return is_object(argument0) ? sndSwapBow : sndSwapMachinegun

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return	is_object(wep) ? 
	{
	"fish" : "No, you've never seen this. ", 
	"rebel" : "A better way to use them. ", 
	"rogue" : "Primitive camouflage. ", 
	"d" : "Simple and stupid. #But nothing wrong? ", 
	}
 : mod_script_call("weapon", "bandit gun", "nts_weapon_examine")



#define weapon_fire
	{
	if(!is_object(wep))
		{
		wep = 
			{
			wep		: mod_current, 
			name	: "crossbow", 
			drawing	: 0, 
			frame	: 0, 
			draw	: 0, 
			damage	: 0, 
			}
		}
	
	with(wep)
		{scrDrawing()}
	}

#define scrDrawing
	{
	if(frame <= 0){with(other){if(ammo[@3] >= 1){sound_play_hit(sndCrossReload, 0.3)}}}
	drawing = current_time_scale * 2
	if(frame >= 45)
		{
		frame = 45
		damage = 45
		if(random(1) < 0.5*current_time_scale){with(other){instance_create(x, y, Sweat)}}
		exit
		}
	frame += current_time_scale
	if(frame >= 25)
		{
		damage += current_time_scale
		draw += 0.1 * current_time_scale
		if(frame >= 45)
			{
			frame = 45
			damage = 45
			with(other){if(ammo[@3] >= 1)
				{
				with(instance_create(0, 0, WepSwap)){creator = other}
				sound_play_hit(sndSwapGold, 0.3)
				}}
			}
		if(random(1) < 0.5*current_time_scale){with(other){instance_create(x, y, Sweat)}}
		exit
		}
	if(frame >= 15)
		{
		damage += 0.5 * current_time_scale
		draw += 0.1 * current_time_scale
		if(random(1) < 0.05*current_time_scale){with(other){instance_create(x, y, Sweat)}}
		exit
		}
	if(frame >= 5)
		{
		damage += 0.5 * current_time_scale
		draw += 0.2 * current_time_scale
		exit
		}
	damage += current_time_scale
	draw += 1.6 * current_time_scale
	}



#define step
	{
	if(argument0)
		{
		var w = "wep"
		var r = "reload"
		}
	else{
		var w = "bwep"
		var r = "breload"
		}
	var v = variable_instance_get(self, w, undefined)
	if(!is_object(v)){exit}
	
	with(v)
		{
		if(frame <= 0){exit}
		if(drawing > 0)
			{
			drawing -= current_time_scale
			script_bind_draw(draw_bow, -7, other, v)
			}
		else{
			
			if(frame >= 10)
				{
				if(other.ammo[@3] >= 1)
					{
					var c = other
					var os = max(35-frame, 0)*0.5
					with(instance_create(other.x, other.y, Bolt))
						{
						creator = c
						team = c.team
						direction = c.gunangle + random_range(os, -os)
						image_angle = direction
						
						damage = 5 + ceil(other.damage)
						speed = 16 + other.frame * 0.25
						}
					other.ammo[@3] --
					}
				with(other)
					{
					weapon_post(6, 0, other.frame)
					sound_volume(sound_play_hit(sndGuitar, 0.3), other.frame * 0.02)
					}
				}
			frame = 0
			draw = 0
			damage = 0
			
			variable_instance_set(other, w, self)
			}
		}
	}

#define weapon_reloaded

#define draw_bow
	{
	with(argument0)
		{
		var lx = lengthdir_x(argument1.draw, gunangle)
		var ly = lengthdir_y(argument1.draw, gunangle)
		var lr = sqrt(sqr(argument1.draw)*4 + 16) * 0.5
		var dg = radtodeg(arctan(5/argument1.draw))
		var c = merge_color(c_gray, c_white, max(argument1.frame-25, 0)*0.02+0.5)
		draw_sprite_ext(sprLaserSightDark, 0, x-lx, y-ly, lr, 1, gunangle-dg, c, 1)
		draw_sprite_ext(sprLaserSightDark, 0, x-lx, y-ly, lr, 1, gunangle+dg, c, 1)
		draw_sprite_ext(weapon_sprt_hud(), 0, x+lx*0.7, y+ly*0.7, 1, 1, gunangle+90, c_white, 1)
		if(ammo[@3] >= 1){draw_sprite_ext(sprBolt, 1, x-lx*0.2, y-ly*0.2, 1, 1, gunangle, c_white, 1)}
		}
	instance_destroy()
	}
