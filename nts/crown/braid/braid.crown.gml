
#define init
	{
	global.icon = sprite_add("icon.png", 0, 12, 16)
	global.lock = sprite_add("lock.png", 0, 12, 16)
	global.spr_idle = sprite_add("idle.png", 1, 8, 8)
	global.spr_walk = sprite_add("walk.png", 6, 8, 8)
	}

#define crown_name			return "Ring of Braid"
#define crown_text_base		return "SLOW DOWN VICINITY"
#define crown_text_unlock	return "@sCOMPLETE @wFROZEN CITY"
#define crown_tip			return "I miss her"

#define crown_button		sprite_index = global.icon
#define crown_button_lock	sprite_index = global.lock

#define crown_avail			return GameCont.loops == 0



#define crown_take
	{
	sound_play(sndMenuCrown)
	sound_play(sndHyperCrystalSpawn)
	}



#define step
	{
	if(!instance_exists(Crown))
		{instance_create(10016, 10016, Crown)}
	with(Crown)
		{
		spr_idle = global.spr_idle
		spr_walk = global.spr_walk
		
		if("nts_ring_slow"!in self)
			{
			nts_ring_slow = 1
			nts_ring_slowtime = 32
			nts_ring_slowtimemax = 32
			}
		
		if(instance_exists(Player) ? instance_nearest(x, y, Player).speed > 0 : false)
			{
			nts_ring_slow = nts_ring_slow*(1 - 0.1*current_time_scale) + 0.025*current_time_scale
			if(nts_ring_slowtime > 0)
				{nts_ring_slowtime = max(0, nts_ring_slowtime-current_time_scale)}
			}
		else{
			nts_ring_slow = nts_ring_slow*(1 - 0.05*current_time_scale) + 0.05*current_time_scale
			if(nts_ring_slowtime < nts_ring_slowtimemax)
				{nts_ring_slowtime = min(nts_ring_slowtimemax, nts_ring_slowtime+current_time_scale)}
			}
		
		var range = nts_ring_slowtimemax - nts_ring_slowtime + 32
		with(Floor){if(distance_to_object(other)<range && random(1)<0.02*current_time_scale){instance_create(x+random(sprite_width), y+random(sprite_height), SnowFlake)}}
		
		script_bind_draw(scrDrawTimeSlow, -14, self)
		}
	}

#define scrDrawTimeSlow
	{
	with(argument0)
		{
		draw_set_color(c_white)
		
		var range = nts_ring_slowtimemax - nts_ring_slowtime + 32
		var tim = 1 - nts_ring_slow
		
		//with(Player){scrTimeSlow(range, tim)}
		
		with(enemy){scrTimeSlow(range, tim)}
		
		with(projectile)
			{
			var dis = distance_to_object(other)
			if(dis < range)
				{
				var d = (range - dis / 2) / range * tim
				image_index -= image_speed_raw * d
				if(instance_is(self, Laser) || instance_is(self, EnemyLaser) || instance_is(self, HyperGrenade) || instance_is(self, HyperSlug)){continue}
				x = x + (xprevious - x) * d
				y = y + (yprevious - y) * d
				}
			}
		
		with(Car){scrTimeSlow(range, tim)}
		
		draw_set_alpha(tim * 0.25)
		draw_circle(x, y, range, 0)
		draw_circle(x, y, range*0.5, 0)
		draw_set_alpha(1)
		}
	instance_destroy()
	}

#define scrTimeSlow(range, tim)
	{
	var dis = distance_to_object(other)
	if(dis < range)
		{
		var d = (range - dis / 2) / range * tim
		x = x + (xprevious - x) * d
		y = y + (yprevious - y) * d
		image_index -= image_speed_raw * d
		}
	}



#define nts_guard_text		return "@wCONTROL CROWN@s"
#define nts_guard_tb_text	return "@wTELEPORT CROWN@s"

#define nts_guard_ultra
	{
	if(skill_get(mut_throne_butt))
		{
		with(Crown)
			{
			if(button_pressed(other.index, "spec"))
				{
				if(place_free(mouse_x[other.index], mouse_y[other.index]) && place_meeting(mouse_x[other.index], mouse_y[other.index], Floor))
					{
					sound_play_hit(sndCrystalTB, 0.3)
					x = mouse_x[other.index]
					y = mouse_y[other.index]
					}
				}
			if(button_check(other.index, "spec"))
				{script_bind_end_step(nts_guard_es, 0, self, x, y)}
			}
		}
	else{
		if(button_check(index, "spec"))
			{
			with(Crown)
				{
				if(point_distance(x, y, mouse_x[other.index], mouse_y[other.index]) > 8)
					{
					direction = point_direction(x, y, mouse_x[other.index], mouse_y[other.index])
					speed = 6
					}
				else{script_bind_end_step(nts_guard_es, 0, self, x, y)}
				}
			}
		}
	
	return true
	}

#define nts_guard_es
	{
	with(argument0)
		{
		x = argument1
		y = argument2
		speed = 0
		}
	instance_destroy()
	}



#define crown_text
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){if(!lq_defget(v.crown, mod_current, false))
		{
		return `${crown_text_base()}#@sunlock: ${crown_text_unlock()}`
		}}
	}
return crown_text_base()