
//#define area_transit area=mod_current

#define init
globalvar mus, sprPad, sprWallBot, sprWallTop, bak, bak_n

mus = sound_add("sndBOSS2.ogg")
sprPad = sprite_add("tilBak5.png", 1, 256, 256)
sprWallBot = sprite_add("sprWallBot.png", 1, 0, 0)
sprWallTop = sprite_add("sprWallTop.png", 1, 0, 0)
bak = mod_variable_get("area", "mansion", "bak")
bak_n = sprite_add("bakSkyNight.png", 1, 0, 0)

globalvar sprHeliIdle, sprHeliChrg, sprHeliFire, sprHeliHurt, sprHeliDead, mskHeli
sprHeliIdle = sprite_add("sprHelicopter.png",		2, 64, 64)
sprHeliChrg = sprite_add("sprHelicopterOpen.png",	8, 64, 64)
sprHeliFire = sprite_add("sprHelicopterFire.png",	9, 64, 64)
sprHeliHurt = sprite_add("sprHelicopterHit.png",	3, 64, 64)
sprHeliDead = sprite_add("sprHelicopterDeath.png",	2, 64, 64)
mskHeli		= sprite_add("mskHelicopter.png",		1, 24, 24)

globalvar sprGod, mskGod
sprGod = {sprite:{}, model:{}, map:{}}
sprite_add_god("spr_idle",		"",				15)
sprite_add_god("spr_walk",		"Walk",			6)
sprite_add_god("spr_hurt",		"Hit",			5)
sprite_add_god("spr_dead",		"Die2",			12)
sprite_add_god("spr_execute",	"Death",		19)
sprite_add_god("spr_fire_p",	"Fire",			8)
sprite_add_god("spr_fire_b",	"FireBazooka",	8)
sprite_add_god("spr_fire_s",	"FireShotgun",	8)
mskGod = sprite_add("mskGod.png",		1, 16, 16)

#define sprite_add_god(field, value, frame)
	{
	var spr = sprite_add(`sprGod${value}.png`, frame, 16, 16)
	lq_set(sprGod.sprite, field, spr)
	
	wait 15
	var sf = surface_create(32 * frame, 32)
	surface_set_target(sf)
	draw_clear_alpha(0, 0)
	for(var i=0; i<frame; i++)
		{draw_sprite_part(spr, i, 0, 0, 16, 32, i * 32, 0)}
	surface_save(sf, "spr_0.png")
	draw_clear_alpha(0, 0)
	for(var i=0; i<frame; i++)
		{draw_sprite_part(spr, i, 16, 0, 16, 32, i * 32 + 16, 0)}
	surface_save(sf, "spr_1.png")
	draw_clear_alpha(0, 0)
	surface_reset_target()
	surface_free(sf)
	
	wait file_load("spr_0.png")
	wait file_load("spr_1.png")
	lq_set(sprGod.model, field, [sprite_add("spr_0.png", frame, 16, 16), sprite_add("spr_1.png", frame, 16, 16)])
	lq_set(sprGod.map, string(spr), field)
	
	}



#define area_name
return `vm-3`

#define area_mapdata(lx, ly, lp, ls, ws, ll)
return [63, 9, true, true]

#define area_sprite(q)
switch (q) {
    case sprFloor1: return sprFloor107
    case sprFloor1B: return sprFloor107
    case sprFloor1Explo: return mskNone
    case sprWall1Trans: return mskNone
    case sprWall1Bot: return sprWallBot
    case sprWall1Out: return mskNone
    case sprWall1Top: return sprWallTop
    case sprDebris1: return sprDebris1
}

#define area_finish
area = 5
subarea = 1

//for supporting ntte
#define area_background_color return make_color_rgb(238, 240, 242)
#define area_setup
background_color = area_background_color()
BackCont.shadcol = make_color_rgb(18, 0, 20)
TopCont.fog = -1
sound_play_music(-1)
sound_play_ambient(amb0b)
goal = 1

#define area_make_floor
instance_create(x, y, Floor)
/*with(instance_create(x, y, Floor))
	{
	sprite_index = sprPad
	mask_index = sprPad
	}*/

#define area_start
	{
	with(RadChest){instance_delete(self)}
	with(Wall){instance_destroy()}
	with(Top){instance_destroy()}
	with(TopSmall){instance_destroy()}
	with(Floor){instance_destroy()}
	
	instance_create(0, 0, becomenemy)
	with(instance_create(10016, 10016, Floor))
		{
		sprite_index = sprPad
		mask_index = sprPad
		for(var i=bbox_left; i<bbox_right; i+=16)
			{
			instance_create(i, bbox_top-24, InvisiWall)
			instance_create(i, bbox_bottom-4, InvisiWall)
			}
		for(var i=bbox_top-24; i<bbox_bottom+8; i+=16)
			{
			instance_create(bbox_left-16, i, InvisiWall)
			instance_create(bbox_right, i, InvisiWall)
			}
		}
	wall_create(9920, 9920)
	wall_create(9952, 9920)
	wall_create(9920, 9952)
	
	wall_create(10080, 9920)
	wall_create(10048, 9920)
	wall_create(10080, 9952)
	
	wall_create(9920, 10080)
	wall_create(9952, 10080)
	wall_create(9920, 10048)
	
	wall_create(10080, 10080)
	wall_create(10048, 10080)
	wall_create(10080, 10048)
	
	script_bind_end_step(scrEndstep, 0)
	with(script_bind_draw(drBackground, 12))
		{
		alpha = 0
		with(script_bind_step(scrSummonGunGod, 0, self))
			{
			delay_sky = 90
			alarm_sky = 100
			delay_boss = 60
			boss = noone
			}
	//	with(instance_create(10016, 9800, CustomEnemy)){Heli_create(); alarm1 = 60}
	//	with(instance_create(10016, 9900, CustomHitme)){GodIntro_create()}
	//	with(instance_create(10016, 9900, CustomEnemy)){God_create(); alarm1 = 90}
		}
	}

#define wall_create
	{
	var a
	array_push(a, wall_create_1(argument0,		argument1))
	array_push(a, wall_create_1(argument0+16,	argument1))
	array_push(a, wall_create_1(argument0,		argument1+16))
	array_push(a, wall_create_1(argument0+16,	argument1+16))
	return a
	}

#define wall_create_1
	{
	with(instance_create(argument0, argument1, CustomObject))
		{
		mask_index = mskWall
		delay = 150
		on_step = wall_create_step
		instance_create(x, y, Wall)
		}
	}

#define wall_create_step
	{
	if(!position_meeting(x, y, Wall))
		{
		if(delay > 0)
			{
			if(delay < 30){if(distance_to_object(instance_nearest(x, y, Player))<16 || distance_to_object(instance_nearest(x, y, enemy))<16)
				{exit}}
			delay -= current_time_scale
			}
		else{
			if(!place_meeting(x, y, Player))
				{
				instance_create(x, y, Wall)
				sound_play_hit(sndWallBreakRock, 0.3)
				delay = 150
				}
			}
		}
	}

#define scrEndstep
	{
	with(projectile){if(distance_to_object(instance_nearest(x, y, Floor)) > 999){instance_destroy()}}
	speedup(ScrapBossMissile, 1, false)
	speedup(JockRocket, 0.2, true)
	
	with(Tangle)
		{
		if(!position_meeting(x, y, Floor))
			{
			if(abs(image_xscale) > 0.5)
				{
				var s = 0.02 * current_time_scale
				depth = -9
				}
			else{
				var s = 0.01 * current_time_scale
				depth = 1
				image_angle += 10 * current_time_scale
				mask_index = mskNone
				}
			if(abs(image_xscale)<s || abs(image_yscale)<s)
				{
				instance_destroy()
				exit
				}
			image_xscale = sign(image_xscale) * (abs(image_xscale) - s)
			image_yscale = sign(image_yscale) * (abs(image_yscale) - s)
			image_alpha = abs(image_xscale) * 2
			}
		}
	with(TangleSeed)
		{
		if(!position_meeting(x, y, Floor))
			{
			var s = (abs(image_xscale) > 0.5 ? 0.05 : 0.02) * current_time_scale
			if(abs(image_xscale)<s || abs(image_yscale)<s)
				{
				instance_destroy()
				exit
				}
			image_xscale = sign(image_xscale) * (abs(image_xscale) - s)
			image_yscale = sign(image_yscale) * (abs(image_yscale) - s)
			image_alpha = abs(image_xscale) * 2
			}
		}
	with(Corpse){void_fall()}
	with(Debris){void_fall()}
	with(Shell){void_fall()}
	with(Scorch){instance_destroy()}
	with(ScorchGreen){instance_destroy()}
	with(ScorchTop){instance_destroy()}
	
	if(instance_exists(GenCont) || instance_exists(BigPortal)){exit}
	
	with(instances_matching(enemy, "canfly", false)){col_invisi()}
	with(Pickup)
		{
		col_invisi()
		if(!instance_is(self, WepPickup)){void_fall()}
		}
	}

#define speedup
	{
	with(argument0)
		{
		var dx = (x - xprevious) * argument1 + x
		var dy = (y - yprevious) * argument1 + y
		if(argument2 ? true : place_meeting(x, y, Floor) && place_free(dx, dy))
			{
			x = dx
			y = dy
			}
		}
	}

#define void_fall
	{
	if(!position_meeting(x, y, Floor))
		{
		mask_index = mskNone
		var s = (abs(image_xscale) > 0.5 ? 0.02 : 0.01) * current_time_scale
		if(abs(image_xscale)<s || abs(image_yscale)<s)
			{
			instance_destroy()
			exit
			}
		speed = 0
		image_xscale = sign(image_xscale) * (abs(image_xscale) - s)
		image_yscale = sign(image_yscale) * (abs(image_yscale) - s)
		image_angle += 10 * current_time_scale
		image_alpha = abs(image_xscale) * 2
		}
	}

#define col_invisi
	{
	if(place_meeting(x, y, InvisiWall))
		{
		x = xprevious * 2 - x
		y = yprevious * 2 - y
		direction += 180
		}
	}

#define drBackground
	{
	for(var i=0; i<maxp; i++)
		{
		var xos = (current_frame + view_xview_nonsync) mod 640
		draw_set_visible_all(false)
		draw_set_visible(i, true)
		draw_sprite_ext(bak, 0, view_xview_nonsync-xos,			view_yview_nonsync, 1, 1, 0, c_white, 1-alpha)
		draw_sprite_ext(bak, 0, view_xview_nonsync-xos+640,		view_yview_nonsync, 1, 1, 0, c_white, 1-alpha)
		draw_sprite_ext(bak_n, 0, view_xview_nonsync-xos,		view_yview_nonsync, 1, 1, 0, c_white, alpha)
		draw_sprite_ext(bak_n, 0, view_xview_nonsync-xos+640,	view_yview_nonsync, 1, 1, 0, c_white, alpha)
		}
	draw_set_visible_all(true)
	}

#define scrSummonGunGod
	{
	if(delay_sky > 0)
		{
		delay_sky -= current_time_scale
		exit
		}
	if(alarm_sky > 0)
		{
		alarm_sky -= current_time_scale
		with(argument0)
			{alpha += 0.01 * current_time_scale}
		exit
		}
	/*if(delay_boss > 0)
		{
		delay_boss -= current_time_scale
		exit
		}*/
	with(instance_create(10016, 9900, CustomHitme))
		{HeliIntro_create()}
	instance_destroy()
	}



#define HeliIntro_create
	{
	sprite_index = sprHeliIdle
	mask_index = mskNone
	image_speed_raw = 0.4
	depth = 11
	spr_shadow = mskNone
	right = 1
	team = 1
	wave = 0.4
	stat = 0
	alarm_boss = 30
	on_step = HeliIntro_step
	on_hurt = HeliIntro_hit
	}

#define HeliIntro_step
	{
	if(y>9800 && stat==0)
		{
		y -= current_time_scale
		if(y <= 9800)
			{
			sound_play_hit(sndMutant6Wrld, 0)
			stat = 1
			mask_index = mskHeli
			}
		exit
		}
	scrHeliWave()
	if(alarm_boss > 0)
		{
		alarm_boss -= current_time_scale
		exit
		}
	with(instance_create(x, y, CustomEnemy))
		{Heli_create()}
	sound_play_music(mus)
	instance_destroy()
	}

#define HeliIntro_hit	sound_play_hit(sndHitMetal, 0.3)



#define Heli_create
	{
	//regular
	image_speed_raw = 0.4
	spr_idle = sprHeliIdle
	spr_walk = spr_idle
	spr_hurt = sprHeliHurt
	spr_dead = sprHeliDead
	spr_chrg = sprHeliChrg
	spr_fire = sprHeliFire
	mask_index = mskHeli
	depth = -8
	spr_shadow = mskNone
	snd_hurt = sndHitMetal
	snd_dead = sndExplosionL
	snd_fire = sndSnowTankShoot
	snd_mele = sndImpWristKill
	hitid = [sprHeliIdle, "gun god"]
	my_health = boss_hp(450)
	maxhealth = my_health
	meleedamage = 10
	raddrop = 0
	canfly = true
	
	//effect
	drawspr = null
	drawimg = 9
	wave = variable_instance_get(other, "wave", 0.4)
	taunt = 30
	sndtaunt = sndMutant6IDPD
	sndhalfhp = sndMutant6LowH
	
	//action	- [OpenMinigun, Minigun, Rocket, Missile]
	alarm1 = 10
	basetime = [0, 0, 0, 0]
	basetimemax = [20, 1, 8, 10]
	gunangle = 270
	seek = false
	ammo_minigun = 0
	ammo_rocket = 0
	ammo_missile = 0
	
	//move
	path_point = null
	hdir = 1
	heli_speed = 4
	
	//script
	on_step = Heli_step
	on_end_step = Heli_end_step
	on_hurt = Heli_hit
	on_death = Heli_death
	on_draw = Heli_draw
	
	//set
	scrCall_e("scrCommonSpr")
	}

#define Heli_step
	{
	scrCall_e("scrCommonSpr")
	speed = 0
	scrHeliWave()
	if(is_real(drawspr))
		{
		var d = drawimg
		drawimg += image_speed_raw
		if(drawimg >= sprite_get_number(drawspr))
			{
			if(drawspr == spr_chrg)
				{drawimg = d}
			else{drawspr = null}
			}
		}
	if(is_array(path_point))
		{
		with(instance_create(x, y, PortalClear))
			{
			mask_index = other.mask_index
			speed = other.heli_speed * 2
			direction = point_direction(other.x, other.y, other.path_point[@0], other.path_point[@1])
			}
		if(point_distance(x, y, path_point[@0], path_point[@1]) < heli_speed)
			{
			x = path_point[@0]
			y = path_point[@1]
			path_point = null
			}
		else{
			move_towards_point(path_point[@0], path_point[@1], heli_speed * current_time_scale)
			exit
			}
		}
	if(instance_exists(Player))
		{
		if(cacheck)
			{
			alarm1 = 30
			drawspr = null
			
			switch(irandom(2))
				{
				case 0: 
					hdir = choose(1, -1)
					path_point = [hdir * 200 + 10016, 9800]
					retime(0)
					retime(1)
					ammo_minigun = 24
					drawimg = 0
					
					alarm1 = 0
					snd_fire = sndSnowTankShoot
					heli_speed = min(16, GameCont.loops + 8)
					scrHeliSeek()
					exit
				
				case 1: 
					hdir = choose(1, -1)
				//	path_point = [hdir * 200 + 10016, 9800]
					retime(2)
					ammo_rocket = 4
					
					alarm1 = 0
					snd_fire = sndRocket
					heli_speed = min(16, GameCont.loops + 8)
					scrHeliSeek()
					break
				
				case 2: 
					ammo_missile = irandom_range(1, 3)
					retime(3)
					
					snd_fire = sndBigDogMissile
					scrHeliSeek()
					break
				
				default: break
				}
			}
		}
	else{
		if(taunt > 0)
			{
			taunt -= current_time_scale
			if(taunt <= 0)
				{sound_play_hit(sndtaunt, 0)}
			}
		}
	if(basetime[@0] > 0)
		{
		drawspr = spr_chrg
		if(basetime[@0] == basetimemax[@0])
			{sound_play_hit(sndVanOpen, 0.3)}
		basetime[@0] -= current_time_scale
		}
	}

#define Heli_end_step
	{
	if(basetime[@0] <= 0)
		{
		gunangle = 270
		if(seek){with(target){other.gunangle = point_direction(other.x, other.y, x, y)}}
		
		if(ammo_minigun > 0)
			{
			scrHeliWave()
			scrHeliHmove(-9)
			motion_set(hdir * 90 + 90, 9)
			drawspr = spr_fire
			if(drawimg >= 2)
				{drawimg = drawimg mod 2}
			if(timecheck(1))
				{
				ammo_minigun --
				repeat(seek ? 1 : 2)
					{
					with(common_fire(EnemyBullet4, gunangle, 0, min(15, GameCont.loops + 7)+random(1), random_range(15, -15)))
						{
						y += 32
						depth = -9
						}
					}
				if(ammo_minigun <= 0)
					{
					path_point = [10016, 9800]
					heli_speed = min(16, GameCont.loops + 6)
					alarm1 = 10
					}
				}
			}
		
		if(ammo_rocket > 0)
			{
			scrHeliWave()
			if(timecheck(2))
				{
				scrHeliHmove(-2)
				ammo_rocket --
				var type_rocket = seek ? JockRocket : Rocket
				with(common_fire(type_rocket, gunangle, 16, 0, random_range(5, -5)))
					{
					x += 16
					sprite_index = sprRocket
					depth = -9
					damage = 2
					event_perform(ev_alarm, 1)
					}
				with(common_fire(type_rocket, gunangle, 16, 0, random_range(5, -5)))
					{
					x -= 16
					sprite_index = sprRocket
					depth = -9
					damage = 2
					event_perform(ev_alarm, 1)
					}
				if(ammo_rocket <= 0)
					{
					path_point = [10016, 9800]
					heli_speed = min(16, GameCont.loops + 6)
					alarm1 = 10
					}
				}
			else{scrHeliHmove(-6)}
			}
		
		if(ammo_missile)
			{
			if(timecheck(3))
				{
				alarm1 = 30
				ammo_missile --
				repeat(GameCont.loops + 1)
					{
					with(common_fire(ScrapBossMissile, gunangle, 0, 0, random_range(45, -45)))
						{
						x += 16
						xprevious = x
						depth = -9
						canfly = true
						}
					with(common_fire(ScrapBossMissile, gunangle, 0, 0, random_range(45, -45)))
						{
						x -= 16
						xprevious = x
						depth = -9
						canfly = true
						}
					}
				}
			}
		
		}
	}

#define Heli_hit(dmg, len, dir)
	{
	var hh = maxhealth * 0.5
	var a = my_health > hh
	my_health -= dmg
	if(my_health<hh && a){sound_play_hit(sndhalfhp, 0)}
	nexthurt = current_frame + 6
	sound_play_hit(snd_hurt, 0.3)
	sprite_index = spr_hurt
    image_index = 0
	}

#define Heli_death
	{
	sound_play_hit(snd_dead, 0.3)
	with(instance_create(10016, 9900, CustomHitme))
		{GodIntro_create()}
	}

#define Heli_draw
	{
	Heli_draw_1()
	if(sprite_index == spr_hurt){draw_self()}
	}

#define Heli_draw_1
	{
	if(drawspr == null){return draw_self()}
	return draw_sprite(drawspr, drawimg, x, y)
	
	if(is_array(path_point)){return draw_self()}
	if(basetime[@0] > 0){return draw_sprite(spr_chrg, drawimg, x, y)}
	if(drawspr == spr_fire){return draw_sprite(spr_fire, drawimg, x, y)}
	draw_self()
	}



#define scrHeliWave
	{
	if(abs(wave) > 0.2)
		{wave = (abs(wave)-0.01 * current_time_scale) * sign(wave)}
	else{wave = -0.4 * sign(wave)}
	y += wave * current_time_scale
	}

#define scrHeliHmove	x += argument0 * hdir * current_time_scale
#define scrHeliSeek		seek = ntstarget ? irandom(1) : false



#define GodIntro_create
	{
	sprite_index = sprGod.sprite.spr_hurt
	model_index = "spr_idle"
	image_index = 3
	mask_index = mskNone
	image_speed_raw = 0
	depth = 11
	spr_shadow = mskNone
	team = 1
	target = noone
	gunangle = 270
	alarm_turn = 0
	turn_angle = 270
	turn_rot = 0
	turn_max = 360
	yspeed = 0
	stat = 0
	alarm_boss = 45
	on_step = GodIntro_step
	on_hurt = GodIntro_hit
	on_draw = GodIntro_draw
	}

#define GodIntro_step
	{
	if(array_equals(instances_matching(Corpse, "sprite_index", sprHeliDead), []))
		{
		if(alarm_boss > 30)
			{
			alarm_boss -= current_time_scale
			exit
			}
		if(y>9825 && stat==0)
			{
			y += yspeed * current_time_scale
			yspeed -= 0.2 * current_time_scale
			if(y <= 9825)
				{
				image_index = 4
				depth = -2
				stat = 1
				sound_play_hit(sndMutant6LowA, 0)
				}
			exit
			}
		if(y<9875 && stat==1)
			{
			y += yspeed * current_time_scale
			yspeed += 0.5 * current_time_scale
			if(y >= 9875)
				{
				sprite_index = sprGod.sprite.spr_idle
				mask_index = mskGod
				image_speed_raw = 0.4
				stat = 2
				}
			exit
			}
		if(alarm_boss > 20)
			{
			alarm_boss -= current_time_scale
			exit
			}
		if(alarm_boss > 0)
			{
			alarm_boss -= current_time_scale
			god_turn(ntstarget)
			gunangle = (gunangle mod 360 + 360) mod 360
			exit
			}
		with(instance_create(x, y, CustomEnemy))
			{God_create()}
		instance_destroy()
		}
	}

#define GodIntro_hit	sound_play_hit(sndHitFlesh, 0.3)

#define GodIntro_draw	return (alarm_boss > 20) ? draw_self() : mdl_god()



#define God_create
	{
	//regular
	image_speed_raw = 0.4
	model_index = variable_instance_get(other, "model_index", "idle")
	spr_idle = sprGod.sprite.spr_idle
	spr_walk = sprGod.sprite.spr_walk
	spr_hurt = sprGod.sprite.spr_hurt
	spr_dead = sprGod.sprite.spr_dead
	spr_fire = [sprGod.sprite.spr_fire_p, sprGod.sprite.spr_fire_b, sprGod.sprite.spr_fire_s]
	mask_index = mskGod
	depth = -2
	spr_shadow = mskNone
	right = 1
	snd_hurt = sndMutant6Hurt
	snd_dead = sndMutant6Hurt
	snd_fire = sndPistol
	hitid = [spr_idle, "gun god"]
	my_health = boss_hp(200)
	maxhealth = my_health
	maxspeed = GameCont.loops ? 6 : 5
	raddrop = 0
	
	//effect
	alarm_turn = variable_instance_get(other, "alarm_turn", 30)
	turn_angle = variable_instance_get(other, "turn_angle", 0)
	turn_rot = variable_instance_get(other, "turn_rot", 0)
	turn_max = 360
	taunt = 30
	sndtaunt = sndMutant6IDPD
	sndhalfhp = sndMutant6LowH
	
	//action	- [Pistol, Bazooka, Shotgun]
	basetime = [0]
	basetimemax = [GameCont.loops ? 10 : 20]
	ary_sndfire = [sndPistol,	sndRocket,	sndShotgun]
	ary_scrpref = [God_pref_0,	God_pref_1,	God_pref_2]
	ary_scrfire = [God_fire_0,	God_fire_1,	God_fire_2]
	firing = false
	ammo = 0
	type = -1
	walk = 0
	alarm1 = 10
	gunangle = variable_instance_get(other, "other.gunangle", turn_angle)
	
	//script
	on_step = God_step
	on_hurt = God_hurt
	on_death = God_death
	on_draw = mdl_god
	
	//set
	scrCall_e("scrCommonSpr")
	}

#define God_step
	{
	scrCall_e("scrCommonSpr")
	
	if(firing)
		{
		if(ammo > 0)
			{
			snd_fire = ary_sndfire[@type]
			script_execute(ary_scrpref[@type])
			if(cacheck)
				{
				ammo --
				sprite_index = spr_fire[@type]
				image_index = 0
				script_execute(ary_scrfire[@type])
				}
			}
		else{firing = false}
		}
	else{
		if(instance_exists(Player))
			{
			var turn = god_turn(ntstarget)
			switch(turn)
				{
				case 0: //TurnBreak
					break
				
				case 1: //TurnRight
					if(walk <= -15)
						{walk = 30}
					walk = 0
					break
				
				case 2: //TurnSetRot
					break
				
				case 3: //Turning
					break
				
				case 4: //TurnEnd
					turn_max = 360
					turn_rot = 0
					alarm_turn = random_range(10, 15)
					motion_set(random(360), maxspeed)
					walk = 15
					type = irandom(2)
					if(basetime[@0] <= 0)
						{
						ammo = irandom_range(5, 8)
						alarm1 = 10
						firing = true
						}
					break
				
				default: break
				}
			}
		else{
			if(taunt > 0)
				{
				taunt -= current_time_scale
				if(taunt <= 0)
					{sound_play_hit(sndtaunt, 0)}
				}
			}
		}
	
	if(walk > 0)
		{motion_add(direction, 2)}
	walk -= current_time_scale
	
	if(basetime[@0] > 0)
		{basetime[@0] -= current_time_scale}
	
	speed = clamp(speed, 0, maxspeed)
	gunangle = (gunangle mod 360 + 360) mod 360
	model_index = lq_defget(sprGod.map, string(sprite_index), "spr_idle")
	}

#define God_pref_0
	{
	if(ntstarget)
		{
		with(target)
			{
			var angle = point_direction(other.x, other.y, x, y)
			other.turn_angle = angle + sign(angle_difference((other.turn_angle==other.gunangle)?angle:other.turn_angle, other.gunangle)) * (speed/4) * (distance_to_object(other)-128) / 32 * 5
			}
		turn_rot = sign(angle_difference(turn_angle, gunangle)) * 10
	//	script_bind_draw(dr_lines, -16, self, 128, [angle, turn_angle])
		if(turn_rot != 0)
			{god_turn()}
		}
	}
#define God_fire_0
	{
	common_fire(EnemyBullet1, gunangle, 0, GameCont.loops?16:12, 0)
	if(ammo > 0){alarm1 = random_range(2, 6)}
	}

#define God_pref_1
	{
	if(turn_rot != 0)
		{god_turn()}
	}
#define God_fire_1
	{
	ammo -= 3
	var norocket = true
	with(norocket)
		{
		norocket = collision_line(x, y, other.x, other.y, Wall, false, false)
		other.turn_angle = point_direction(other.x, other.y, x, y)
		other.turn_rot = sign(angle_difference(other.turn_angle, other.gunangle)) * 5
		}
	if(irandom(ammo) || norocket)
		{
		with(common_fire(ScrapBossMissile, gunangle, 0, 0, random_range(15, -15)))
			{canfly = true}
		if(ammo > 0){alarm1 = random_range(8, 16)}
		}
	else{
		with(common_fire(Rocket, gunangle, 0, 0, random_range(5, -5)))
			{damage = 2}
		if(ammo > 0){alarm1 = random_range(16, 32)}
		}
	}

#define God_pref_2
	{
	if(turn_rot != 0)
		{god_turn()}
	}
#define God_fire_2
	{
	ammo -= irandom(1)
	with(target)
		{
		other.turn_angle = point_direction(other.x, other.y, x, y)
		other.turn_rot = sign(angle_difference(other.turn_angle, other.gunangle)) * 5
		}
	repeat(irandom_range(5, 10)){common_fire(EnemyBullet3, gunangle, 0, random_range(5, 10), random_range(45, -45))}
	repeat(irandom(5)){common_fire(EnemyBullet3, gunangle, 8, random_range(12, 15), random_range(20, -20))}
	if(ammo > 0){alarm1 = random_range(3, 6)}
	}

#define God_hurt(dmg, len, dir)
	{
	var hh = maxhealth * 0.5
	var a = my_health > hh
	common_hurt(dmg, len, dir)
	model_index = "spr_hurt"
	if(my_health<hh && a){sound_play_hit(sndhalfhp, 0)}
	col_invisi()
	}

#define God_death
	{
	sound_play_hit(snd_dead, 0)
	with(instance_create(x, y, CustomEnemy))
		{GodExecute_create()}
	instance_create(x, y, VenuzAmmoSpawn)
	sound_play_music(-1)
	instance_delete(self)
	}

#define GodExecute_create
	{
	sprite_index = sprGod.sprite.spr_dead
	image_index = 0
	mask_index = mskGod
	image_speed_raw = 0.4
	spr_dead = sprGod.sprite.spr_execute
	depth = -2
	spr_shadow = mskNone
	team = 1
	alarm_boss = 45
	on_step = GodExecute_step
	on_hurt = GodExecute_hit
	on_death = GodExecute_death
	}

#define GodExecute_step
	{
	x = xstart
	y = ystart
	speed = clamp(speed, 0, 4)
	alarm_boss -= current_time_scale
	if(image_index + image_speed_raw > image_number)
		{image_speed = 0}
	}

#define GodExecute_hit
	{
	sound_play_hit(sndMutant6Hurt, 0.3)
	if(alarm_boss <= 0)
		{my_health = 0}
	}

#define GodExecute_death
	{
	sound_play_hit(sndMutant6Dead, 0)
	image_speed_raw = 0.4
	instance_create(x, y, VenuzWeaponSpawn)
	mod_script_call("mod", "ntsCont", "scrSkinUnlock", "Gun God", " of Vung Venuz'")
	script_bind_step(GodPortal, 0).alarm_portal = 90
	}

#define GodPortal
	{
	alarm_portal -= current_time_scale
	if(alarm_portal <= 0)
		{
		instance_create(10016, 10016, Portal)
		instance_destroy()
		}
	}



#define god_turn
	{
	if(gunangle != turn_angle)
		{
		if(turn_rot == 0)
			{
			turn_rot = choose(1, -1) * (GameCont.loops ? random_range(15, 30) : random_range(15, 20))
			return 2
			}
		else{
			var ta = turn_rot * current_time_scale
			var angle = gunangle + ta
			turn_max -= abs(ta)
			if(turn_max <= 0)
				{
				turn_angle = gunangle
				return 4
				}
			if(abs(turn_angle - angle) <= abs(turn_rot))
				{
				gunangle = turn_angle
				return 4
				}
			else{
				gunangle = angle
				return 3
				}
			}
		}
	if(alarm_turn > 0)
		{
		alarm_turn -= current_time_scale
		return 0
		}
	with(target)
		{
		other.turn_angle = point_direction(other.x, other.y, x, y)
		return 1
		}
	}

#define mdl_god		return mdl_god_ext(x, y, model_index, gunangle, image_xscale, image_yscale)

#define mdl_god_ext(mx, dy, model, dir, w, h)
	{
	var my = dy - 16
	var spr = lq_get(sprGod.model, model)
	if(is_undefined(sprite)){exit}
	var sprite = spr[@0]
	
	var ary = []
	repeat(2)
		{
		repeat(2)
			{
			var ldx = lengthdir_x(w * 16, dir)
			var ldy = lengthdir_y(h * 8, dir)
			array_push(ary, [sprite, ldx, ldy])
			dir += 90
			}
		var sprite = spr[@1]
		dir -= 180
		}
	var order = dir div 90
	for(var i=7; i>3; i--)
		{
		var s = (i-order) mod 4
		draw_sprite_pos(ary[@s][@0], image_index, mx - ary[@s][@1], my - ary[@s][@2], mx + ary[@s][@1], my + ary[@s][@2], mx + ary[@s][@1], my + ary[@s][@2] + h * 32, mx - ary[@s][@1], my - ary[@s][@2] + h * 32, 1)
	//	draw_line_width_color(mx - ary[@s][@1], my - ary[@s][@2], mx + ary[@s][@1], my + ary[@s][@2], 1, c_red, c_yellow)
		}
	return true
	}



#define boss_hp(_hp)
	{	//stole from NT:TE
	var _players = 0
	for(var i = 0; i < maxp; i++)
		{
		_players += player_is_active(i)
		}
	return round(_hp * (1 + (1/3 * GameCont.loops)) * (1 + (0.5 * (_players - 1))))
	}



#define dr_lines
with(argument0)
	{
	var len = min(array_length(argument2), array_length(mcrLineColor), 5)
	for(var i=0; i<len; i++)
		{draw_line_color(x, y, x+lengthdir_x(argument1, argument2[@i]), y+lengthdir_y(argument1, argument2[@i]), mcrLineColor[@i][@0], mcrLineColor[@i][@1])}
	}
instance_destroy()

#macro	mcrLineColor	[[c_red, c_orange], [c_yellow, c_green], [c_blue, c_purple]]



#define	scrCall_e		return	mod_script_call("mod", "ntsECont", argument0)
#macro	cacheck			scrCall_e("cacheck")
#macro	ntstarget		scrCall_e("ntstarget")
#define	retime			return	mod_script_call("mod", "ntsECont", "retime", argument0)
#define	timecheck		return	mod_script_call("mod", "ntsECont", "timecheck", argument0)
#define common_hurt		return	mod_script_call("mod", "ntsECont", "common_hurt", argument0, argument1, argument2)
#define	common_fire		return	mod_script_call("mod", "ntsECont", "common_fire", argument0, argument1, argument2, argument3, argument4)