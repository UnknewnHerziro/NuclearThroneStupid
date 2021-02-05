#define init 
	{
	globalvar sprTank, sprBullet
	sprTank			= sprite_add("CrystalTank.png",		7,	17,	9)
	//sprTankIdle	= sprite_add("CrystalTank.png",		1,	17,	9)
	//sprTankHurt	= sprite_add("CrystalTankHurt.png",	7,	17,	9)
	sprBullet	= sprite_add("CrystalBullet.png",	1,	0,	3)
	
	globalvar mapSprTank
	
	mapSprTank = ds_map_create()
	}

#define clear_up	ds_map_destroy(mapSprTank)



#define weapon_sprt		return instance_is(self, Player) ? mskNone : sprTank
#define weapon_sprt_hud	return sprTank

#define weapon_name		return "CRYSTAL TANK"

#define weapon_type		return 0
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 48
#define weapon_cost		return 0
#define weapon_area		return GameCont.area==4 ? 20 : -1
#define weapon_swap		return sndCrystalShield

#define weapon_gold			return false
#define weapon_laser_sight	return true
/*
#define nts_weapon_examine	return
	
*/


#define weapon_fire
	{
	if(specfiring){exit}
	weapon_post(8, -16, 16)
	tank_obj_fire(gunangle, self, team)
	}

#define step
	{
	if(argument0)
		{script_bind_draw(dr_wep, -8, self)}
	if(instance_exists(Portal) || my_health<=0)
		{with(Crown){crown_re()}}
	else{
		if(button_pressed(index, "swap")){with(Crown)
			{
			if(argument0)
				{crown_re()}
			else{
				if(spr_idle < 0){continue}
				
				mapSprTank[?spr_idle] = [spr_idle, spr_walk, spr_shadow, spr_shadow_x, spr_shadow_y, mask_index]
				mapSprTank[?-spr_idle] = mapSprTank[?spr_idle]
				spr_idle		= -spr_idle
				spr_walk		= mskNone
				spr_shadow		= shd48
			//	spr_shadow_x	= 
				spr_shadow_y	= -6
				mask_index		= sprTank
				tank_alarm		= 30
				
				script_bind_step(tank_obj_step, 0, self, other.index, other.team).delay = true
				script_bind_end_step(tank_obj_end_step, 0, self, other.index).delay = true
				script_bind_draw(dr_tank, depth, self, other.index).delay = true
				}
			exit
			}}
		}
	}

#define crown_re
	{
	if(spr_idle >= 0){exit}
	if(mapSprTank[?spr_idle] != null)
		{
		spr_idle		= mapSprTank[?spr_idle][@0]
		spr_walk		= mapSprTank[?spr_idle][@1]
		spr_shadow		= mapSprTank[?spr_idle][@2]
		spr_shadow_x	= mapSprTank[?spr_idle][@3]
		spr_shadow_y	= mapSprTank[?spr_idle][@4]
		mask_index		= mapSprTank[?spr_idle][@5]
		}
	}

#define dr_wep
	{
	with(argument0)
		{draw_sprite_ext(sprTank, gunshine, x-lengthdir_x(wkick, gunangle), y-lengthdir_y(wkick, gunangle), 1, right, gunangle, c_white, 1)}
	instance_destroy()
	}

#define dr_tank
	{
	with(argument0)
		{
		if(mapSprTank[?spr_idle] == null)
			{
			with(other)
				{instance_destroy()}
			exit
			}
		var ixs = image_xscale
		
		draw_sprite_ext(sprTank, 0, x, y, ixs, image_yscale, 0, c_white, 1)
		draw_sprite_ext(mapSprTank[?spr_idle][@0], 0, x, y-8*image_yscale, image_xscale, image_yscale, image_angle, c_white, image_alpha)
		}
	
	if(delay)
		{
		delay = false
		exit
		}
	if(button_pressed(argument1, "swap") || instance_exists(Portal))
		{instance_destroy()}
	}

#define tank_obj_step
	{
	if(delay)
		{
		delay = false
		exit
		}
	if(button_pressed(argument1, "swap") || instance_exists(Portal))
		{
		instance_destroy()
		exit
		}
	
	with(argument0)
		{
		with(instance_create(x, y, CustomSlash))
			{
			mask_index = other.mask_index
			image_xscale = other.image_xscale
			image_yscale = other.image_yscale
			
			creator = -4
			team = argument2
			typ = 0
			candeflect = true
			
			on_hit			= ref_instance_destroy
			on_wall			= ref_blank
			on_grenade		= bullet_deflect
			on_projectile	= bullet_deflect
			}
		
		if(tank_alarm > 0)
			{
			tank_alarm -= current_time_scale
			exit
			}
		
		tank_alarm = weapon_load() * 0.5
		
		if(instance_exists(Player))
			{
			var target =  instance_nearest(x, y, enemy)
			if(distance_to_object(target) > 128){target = noone}
			
			if(instance_exists(target))
				{
				with(target)
					{
					var dir = point_direction(other.x, other.y, x, y)
					with(other)
						{
						image_xscale = (dir>90 && dir<270) ? -abs(image_xscale) : abs(image_xscale)
						tank_obj_fire(image_xscale ? 0 : 180, noone, argument2)
						tank_alarm = weapon_load()
						}
					}
				}
			else{
				with(instance_nearest(x, y, Player))
					{
					var dir = point_direction(other.x, other.y, x, y)
					other.image_xscale = (dir>90 && dir<270) ? -abs(other.image_xscale) : abs(other.image_xscale)
					}
				}
			}
		else{
			instance_destroy()
			exit
			}
		}
	}

#define tank_obj_end_step
	{
	if(!instance_exists(Portal))
		{
		with(argument0)
			{
			var len = min(current_time_scale * 3, point_distance(xprevious, yprevious, x, y))
			var dir = point_direction(xprevious, yprevious, x, y)
			
			var dx = xprevious + lengthdir_x(len, dir)
			var dy = yprevious + lengthdir_y(len, dir)
			
			if(place_free(dx, dy) && place_meeting(dx, dy, Floor))
				{
				x = dx
				y = dy
				}
			}
		}
	
	if(delay)
		{
		delay = false
		exit
		}
	if(button_pressed(argument1, "swap") || instance_exists(Portal))
		{instance_destroy()}
	}

#define tank_obj_fire(gunangle, crt, t)
	{
	sound_play_hit(sndCrystalShield, 0.3)
	with(instance_create(x, y, BulletHit))
		{
		sprite_index = sprBulletHit
		image_xscale = 2
		image_yscale = 2
		}
	with(instance_create(x, y, CustomSlash))
		{
		sprite_index = sprBullet
		mask_index = sprBullet
		image_xscale = 2
		speed = 8
		damage = 8
		force = 8
		typ = 0
		candeflect = true
		
		damage_all = 64
		
		direction = gunangle
		image_angle = direction
		image_yscale = image_angle>90 && image_angle<270 ? -2 : 2
		
		creator = crt
		team = t
		
		on_anim			= ref_blank
		on_hit			= bullet_hit
		on_wall			= ref_instance_destroy
		on_grenade		= bullet_deflect
		on_projectile	= bullet_deflect
		on_destroy		= bullet_destroy
		
		return self
		}
	}



#define bullet_hit
	{
	if(projectile_canhit_melee(other))
		{
		damage_all -= min(damage, other.my_health)
		var data = [damage, force, direction]
		if(damage_all <= 0)
			{
			data[@0] = damage * 4
			instance_destroy()
			}
		projectile_hit(other, data[@0], data[@1], data[@2])
		}
	}

#define bullet_deflect	mod_script_call("weapon", "crystal giant sword", "column_deflect")

#define bullet_destroy
	{
	sound_play_hit(sndIcicleBreak, 0.3)
	for(var i=0; i<6; i++){with(instance_create(x, y, CustomProjectile))
		{
		sprite_index = sprHyperCrystalShard
		mask_index = mskBouncerBullet
		image_index = i
		image_xscale = choose(1.5, -1.5)
		image_yscale = choose(1.5, -1.5)
		direction = random(360)
		image_angle = random(360)
		speed = 8
		damage = 4
		force = 4
		typ = 0
		
		damage_all = 8
		bounce = 1
		
		creator = other.creator
		team = other.team
		
		on_step		= shard_step
		on_hit		= bullet_hit
		on_wall		= shard_wall
		on_destroy	= shard_destroy
		}}
	with(instance_create(x, y, BulletHit))
		{
		sprite_index = sprBulletHit
		image_xscale = other.image_xscale * 2
		image_yscale = other.image_yscale * 2
		}
	}

#define shard_step
	{
	image_angle += speed * 5 * current_time_scale
	image_speed = 0
	}

#define shard_wall
	{
	if(bounce > 0)
		{
		move_bounce_solid(true)
		speed -= 2
		bounce --
		exit
		}
	instance_destroy()
	}

#define shard_destroy
	{
	sound_play_hit(sndIcicleBreak, 0.3)
	with(instance_create(x, y, Shell))
		{
		sprite_index = other.sprite_index
		image_index = other.image_index
		image_angle = other.image_angle
		image_xscale = other.image_xscale
		image_yscale = other.image_yscale
		image_speed = 0
		image_alpha = 0.5
		direction = random(360)
		speed = random_range(other.speed, other.speed * 2)
		alarm0 = random_range(15, 30)
		}
	}

#define ref_instance_destroy	instance_destroy()
#define ref_blank
