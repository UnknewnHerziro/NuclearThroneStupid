
#define init
	{
	
	}



#define _1
	{
	var r = random(1)
	
	if(GameCont.subarea == 2)
		{
		if(GameCont.loops == 0)
			{
			var ary = instances_matching(Floor, "styleb", true)
			if(array_length(ary) > instance_number(Floor)*0.4)
				{
				ev_neodevon(ary, c_gray)
				return true
				}
			}
		if(r < 0.4)
			{
			if(r < 0.2)
				{ev_max_party()}
			else{
				ev_pumpkiller()
				ev_rain()
				}
			return true
			}
		}
	else{
		if(r < 0.2)
			{
			if(r<0.1 && !(GameCont.loops>0 && GameCont.subarea==3))
				{ev_rain()}
			else{ev_permafrost(c_orange)}
			return true
			}
		}
	return false
	}

#define _2
	{
	if(random(1) < 0.2)
		{ev_frog_radchest()}
	}

#define _3
	{
	var r = random(1)
	
	if(GameCont.subarea != 3)
		{
		if(r < 0.2)
			{
			ev_conflagr()
			return true
			}
		}
	}

#define _4
	{
	
	}

#define _5
	{
	
	}

#define _6
	{
	
	}

#define _7
	{
	
	}




#define ev_neodevon
	{
	with(Floor)
		{image_blend = argument1}
	with(argument0)
		{
		sprite_index = sprFloor101B
		image_blend = c_white
		}
	with(Detail)
		{sprite_index = sprDetail101}
	
	with(Cactus)
		{instance_change(WaterPlant, true)}
	
	with(Scorpion)
		{
		instance_change(Crab, true)
		snd_hurt = sndScorpionHit
		snd_dead = sndScorpionDie
		snd_mele = sndScorpionMelee
		}
	with(RadChest)
		{
		with(instance_create(x, y, OasisBoss))
			{my_health *= 0.5}
		}
	
	script_bind_step(step_neodevon, 0, GameCont.area)
	}

#define ev_max_party	if noNT3D
	{
	ev_firetrap([sprSpookyBanditIdle, `@(color:${c_orange})PUMPKIN#@wMAX PARTY`])
	var n = instance_number(Bandit) * 0.25
	with(Bandit)
		{
		if(instance_number(Car) >= 8){exit}
		if(random(n) < 1)
			{
			instance_create(x, y, Car)
			
			spr_idle = sprSpookyBanditIdle
			spr_walk = sprSpookyBanditWalk
			spr_hurt = sprSpookyBanditHurt
			spr_dead = sprSpookyBanditDead
			
			my_health *= 3
			
			hitid = [spr_idle, `@(color:${c_orange})PUMPKIN#@wMAX PARTY`]
			
			nts_color_blood = [c_orange, c_orange]
			
			script_bind_step(step_pumpkinmax, 0, self)
			}
		}
	}

#define ev_firetrap
	{
	with(wall_alone){if(point_distance(x, y, 10016, 10016) > 64)
		{instance_create(x, y, Trap).hitid = argument0}}
	}

#define ev_pumpkiller	if noNT3D
	{
	with(chestprop){repeat(3)
		{
		with(instance_create(x, y, MeleeBandit))
			{
			image_alpha = 0
			spr_idle = sprSpookyBanditIdle
			spr_walk = sprSpookyBanditWalk
			spr_hurt = sprSpookyBanditHurt
			spr_dead = sprSpookyBanditDead
			
		//	my_health *= 2
			
			hitid = [spr_idle, `@(color:${c_orange})PUMPKIN@wLLER`]
			
			nts_color_blood = [c_orange, c_orange]
			
			script_bind_end_step(end_step_pumpkiller, 0, self).walk = false
			script_bind_draw(draw_pumpkiller, depth, self)
			}
		}}
	}

#define ev_rain			if noNT3D
	{
	TopCont.darkness = GameCont.loops == 0
	script_bind_step(step_rain, 0)
	}

#define ev_permafrost
	{
	with(instances_matching(Floor, "mask_index", mskFloor))
		{
		sprite_index = sprFloor5B
		image_index = irandom(7)
		image_blend = argument0
		depth = 7
		styleb = true
		traction = 0.05
		area = 5
		}
	}

#define ev_frog_radchest
	{
	with(RadChest)
		{
		instance_change(RadChest, false)
		
		spr_idle = sprRadChestBig
		spr_hurt = sprRadChestBigHurt
		spr_dead = sprRadChestBigDead
		
		team = 1
		raddrop = 0
		
		with(script_bind_end_step(end_step_frog_radchest, 0, self))
			{
			dx = other.x
			dy = other.y
			}
		}
	}

#define ev_conflagr		if noNT3D
	{
	TopCont.fog = sprFog102
	BackCont.alarm0 = -1
	
	with(Floor)
		{
		image_blend = c_orange
		if(!styleb && mask_index==mskFloor && place_free(x, y))
			{
			with(instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), GroundFlame))
				{alarm0 = -1}
			}
		}
	
	with(wall_alone){if(point_distance(x, y, 10016, 10016) > 64)
		{create_HammerTrap(x+8, y, topspr, topindex, outspr, outindex)}}
	
	with(Trap)
		{
		with(collision_rectangle(x, y, x+16, y, Wall, false, false))
			{create_HammerTrap(x+8, y, topspr, topindex, outspr, outindex)}
		instance_destroy()
		}
	with(TrapScorchMark)
		{instance_destroy()}
	
	with(Tires)
		{
		var del = true
		with(instance_create(x, y, Chandelier))
			{
			if(place_free(x, y))
				{
				my_health = 10
				spr_shadow_y = 5
				}
			else{
				instance_delete(self)
				del = false
				}
			}
		if(del)
			{instance_delete(self)}
		}
	
	with(Bandit)
		{
		spr_idle = sprSpookyBanditIdle
		spr_walk = sprSpookyBanditWalk
		spr_hurt = sprSpookyBanditHurt
		spr_dead = sprSpookyBanditDead
		
		my_health *= 3
		
		hitid = [spr_idle, `@(color:${c_orange})PUMPKIN@wDLE`]
		
		nts_color_blood = [c_orange, c_orange]
		
		script_bind_step(step_pumpkinmax, 0, self)
		script_bind_draw(draw_pumpkindle, depth, self)
		}
	
	script_bind_step(step_conflagr, 0, self)
	}



#define step_neodevon
	{
	if(GameCont.area != argument0)
		{return instance_destroy()}
	if(instance_exists(PortalClear))
		{
		script_bind_end_step(step_neodevon_1, 0, GameCont.area)
		GameCont.area = 101
		}
	}

#define step_neodevon_1
	{
	GameCont.area = argument0
	instance_destroy()
	}

#define step_rain
	{
	with(Floor){if(random(100) < current_time_scale)
		{instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), RainDrop)}}
	}

#define step_conflagr
	{
	if(instance_exists(Portal))
		{
		with(GroundFlame)
			{alarm0 = random(90)}
		BackCont.alarm0 = 1
		instance_destroy()
		}
	}



#define step_pumpkinmax
	{
	with(argument0)
		{
		alarm1 = min(4, alarm1)
		exit
		}
	instance_destroy()
	}

#define end_step_pumpkiller
	{
	if(instance_exists(Player)){with(argument0)
		{
		if(walk > 0)
			{other.walk = true}
		if(other.walk)
			{walk = 30}
		wepflip = 0
		exit
		}}
	instance_destroy()
	}

#define draw_pumpkiller
	{
	with(argument0)
		{
		var angle = gunangle + wepangle
		if((angle + 360) mod 360 < 180)
			{
			draw_sprite_ext(sprWrench, 0, x, y, image_xscale, image_yscale, angle, image_blend, 1)
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*right, image_yscale, image_angle, image_blend, 1)
			}
		else{
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*right, image_yscale, image_angle, image_blend, 1)
			draw_sprite_ext(sprWrench, 0, x, y, image_xscale, image_yscale, angle, image_blend, 1)
			}
		exit
		}
	instance_destroy()
	}

#define end_step_frog_radchest
	{
	with(argument0)
		{
		other.dx = x
		other.dy = y
		exit
		}
	
	var fx = dx
	var fy = dy
	
	instance_create(dx, dy, PortalClear)
	instance_destroy()
	
	repeat(8)
		{
		with(instance_create(fx+random_range(16, -16), fy+random_range(16, -16), FrogEgg))
			{
			my_health = 20
			raddrop = 5
			alarm0 = random_range(30, 60)
			}
		}
	}

#define draw_pumpkindle
	{
	with(argument0)
		{
		draw_sprite_ext(sprGroundFlameBig, image_index, x, y-12, 3, 3, 0, c_white, 1)
		exit
		}
	instance_destroy()
	}



#define create_HammerTrap(dx, dy, tspr, timg, ospr, oimg)
	{
	with(instance_create(dx, dy, CustomHitme))
		{
		sprite_index	= choose(sprHammer, sprSword, sprWrench)
		mask_index		= sprPipe
		image_angle		= random(360)
		image_speed		= 0
		image_xscale	= 2
		image_yscale	= choose(2, -2)
		depth			= -8
		
		snd_hurt = sndHitMetal
		snd_dead = sndHitMetal
		
		my_health	= 32
		damage		= 16
		force		= 8
		team		= 1
		hitid		= [sprite_index, `@(color:${c_orange})PUMP@wULUM`]
		
		rotspeed		= 0.5
		nts_color_blood	= [make_color_rgb(96, 59, 52),	c_black]
		
		topspr			= tspr
		topimg			= timg
		outspr			= ospr
		outimg			= oimg
		
		on_hurt		= hit_stand
		on_step		= step_HammerTrap
		on_end_step	= end_step_HammerTrap
		on_destroy	= destroy_HammerTrap
		on_draw		= draw_HammerTrap
		}
	}

#define end_step_HammerTrap
	{
	if(!collision_point(xstart, ystart, Wall, false, false))
		{return instance_destroy()}
	x = xstart
	y = ystart
	if(my_health > 8){with(Player){if(place_meeting(x, y, other)){with(other){if(projectile_canhit_melee(other))
		{projectile_hit(other, damage, force, image_angle + 90 * sign(image_yscale))}}}}}
	else{
		if(nexthurt <= current_frame)
			{
			if(my_health <= -8)
				{return instance_destroy()}
			projectile_hit(self, 3, 0)
			}
		}
	}

#define destroy_HammerTrap	with(instance_create(x, y, Car)){my_health = 0}

#define step_HammerTrap		image_angle += sign(image_yscale) * my_health * rotspeed * current_time_scale
#define draw_HammerTrap
	{
	draw_sprite_ext(sprite_index, (nexthurt-6)>current_frame, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	draw_sprite_ext(outspr, outimg, x-8, y, 1, 1, 0, c_white, 1)
	draw_sprite_ext(topspr, topimg, x-8, y-8, 1, 1, 0, c_white, 1)
	}



#define hit_stand
	{
	sound_play_hit(snd_hurt, 0.3)
	my_health -= argument0
	nexthurt = current_frame + 9
	}



#macro	wall_alone		wall_alone_1()
#define wall_alone_1
	{
	var ary = []
	with(Wall)
		{
		if(!collision_rectangle(bbox_left-1, bbox_top-1, bbox_right+1, bbox_bottom+1, Wall, false, true))
			{array_push(ary, self)}
		}
	return ary
	}



#macro	noNT3D	!mod_exists("mod", "NT3D")


