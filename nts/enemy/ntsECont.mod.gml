#define init
	{

	globalvar ary_ntsc
	
	globalvar sprWimicIdle, sprWimicTell, sprWimicFire, sprWimicHurt, sprWimicDead
	sprWimicIdle = sprite_add("wimic/idle.png", 1, 16, 16)
	sprWimicTell = sprite_add("wimic/tell.png", 12, 16, 16)
	sprWimicFire = sprite_add("wimic/fire.png", 4, 16, 16)
	sprWimicHurt = sprite_add("wimic/hurt.png", 3, 16, 16)
	sprWimicDead = sprite_add("wimic/dead.png", 6, 16, 16)
	
	
	
	globalvar sprEnvoyIdle, sprEnvoyWalk, sprEnvoyHurt, sprEnvoyDead, sprEnvoyWep, sprEnvoyLift, sprEnvoyFly, sprEnvoyLand
	sprEnvoyIdle = sprite_add("envoy/idle.png", 33, 12, 12)
	sprEnvoyWalk = sprite_add("envoy/walk.png", 6, 12, 12)
	sprEnvoyHurt = sprite_add("envoy/hurt.png", 3, 12, 12)
	sprEnvoyDead = sprite_add("envoy/dead.png", 6, 12, 12)
	sprEnvoyWep = sprite_add("envoy/wep.png", 7, 4, 3)
	sprEnvoyLift = sprite_add("envoy/lift.png", 5, 32, 48)
	sprEnvoyFly = sprite_add("envoy/fly.png", 5, 32, 48)
	sprEnvoyLand = sprite_add("envoy/land.png", 4, 32, 48)
	
	globalvar sprGazeIdle, sprGazeWalk, sprGazeHurt, sprGazeDead, sprGazeWep
	sprGazeIdle = sprite_add("gaze/idle.png", 4, 12, 12)
	sprGazeWalk = sprite_add("gaze/walk.png", 6, 12, 12)
	sprGazeHurt = sprite_add("gaze/hurt.png", 3, 12, 12)
	sprGazeDead = sprite_add("gaze/dead.png", 6, 12, 12)
	sprGazeWep = sprite_add("gaze/wep.png", 7, 5, 5)
	
	
	
	globalvar sprFruitIdleR, sprFruitHurtR, sprFruitDeadR, sprFruitIdleB, sprFruitHurtB, sprFruitDeadB, sprFruitIdleG, sprFruitHurtG, sprFruitDeadG
	sprFruitIdleR = sprite_add("fruit/idler.png", 6, 18, 20)
	sprFruitHurtR = sprite_add("fruit/hurtr.png", 3, 18, 20)
	sprFruitDeadR = sprite_add("fruit/deadr.png", 6, 18, 20)
	sprFruitIdleB = sprite_add("fruit/idleb.png", 6, 18, 20)
	sprFruitHurtB = sprite_add("fruit/hurtb.png", 3, 18, 20)
	sprFruitDeadB = sprite_add("fruit/deadb.png", 6, 18, 20)
	sprFruitIdleG = sprite_add("fruit/idleg.png", 6, 18, 20)
	sprFruitHurtG = sprite_add("fruit/hurtg.png", 3, 18, 20)
	sprFruitDeadG = sprite_add("fruit/deadg.png", 6, 18, 20)
	
	
	
	globalvar sprAsnowsinIdle, sprAsnowsinWalk, sprAsnowsinHurt, sprAsnowsinDead, sprAsnowsinWep
	sprAsnowsinIdle = sprite_add("asnowsin/idle.png", 4, 12, 12)
	sprAsnowsinWalk = sprite_add("asnowsin/walk.png", 6, 12, 12)
	sprAsnowsinHurt = sprite_add("asnowsin/hurt.png", 3, 12, 12)
	sprAsnowsinDead = sprite_add("asnowsin/dead.png", 6, 12, 12)
	sprAsnowsinWep = sprite_add("asnowsin/wep.png", 1, 16, 4)
	
	globalvar sprTankFakeIdle, sprTankFakeWake
	sprTankFakeIdle = sprite_add("tankfake/sprTankFakeIdle.png",1,24,24)
	sprTankFakeWake = sprite_add("tankfake/sprTankFakeWake.png",10,24,24)

	globalvar sprRhinoBotIdle, sprRhinoBotFire, sprRhinoBotHurt
	sprRhinoBotIdle = sprite_add("rhinobot/idle.png", 17, 24, 24)
	sprRhinoBotFire = sprite_add("rhinobot/fire.png", 8, 24, 24)
	sprRhinoBotHurt = sprite_add("rhinobot/hurt.png", 3, 24, 24)



	globalvar sprWaiterIdle, sprWaiterWalk, sprWaiterHurt, sprWaiterDead
	sprWaiterIdle = sprite_add("waiter/idle.png", 4, 12, 12)
	sprWaiterWalk = sprite_add("waiter/walk.png", 4, 12, 12)
	sprWaiterHurt = sprite_add("waiter/hurt.png", 3, 12, 12)
	sprWaiterDead = sprite_add("waiter/dead.png", 6, 12, 12)

	globalvar sprManagerIdle, sprManagerWalk, sprManagerHurt
	sprManagerIdle = sprite_add("manager/idle.png", 4, 24, 24)
	sprManagerWalk = sprite_add("manager/walk.png", 4, 24, 24)
	sprManagerHurt = sprite_add("manager/hurt.png", 3, 24, 24)
	
	
	
	globalvar sprBaritoneIdle, sprBaritoneWalk, sprBaritoneHurt, sprBaritoneGameover
	sprBaritoneIdle = sprite_add("baritone/idle.png", 4, 16, 24)
	sprBaritoneWalk = sprite_add("baritone/walk.png", 6, 16, 24)
	sprBaritoneHurt = sprite_add("baritone/hurt.png", 3, 16, 24)
	sprBaritoneGameover = sprite_add("baritone/walk.png", 6, 16, 16)
	
	globalvar sprChickIdle, sprChickWalk, sprChickHurt, sprChickDead, sprChickDance
	sprChickIdle = sprite_add("chick/idle.png", 4, 12, 12)
	sprChickWalk = sprite_add("chick/walk.png", 6, 12, 12)
	sprChickHurt = sprite_add("chick/hurt.png", 3, 12, 12)
	sprChickDead = sprite_add("chick/dead.png", 6, 12, 12)
	sprChickDance = sprite_add("chick/dance.png", 10, 16, 16)
	
	}

#define step
	{
	scrSetBase()
	if(current_time_scale != 1)
		{
		with(instances_matching_ge(Corpse, "sprite_index", 1936))
			{if(image_speed == 0.4){image_speed_raw = 0.4}}
		}
	}

//if(instance_number(enemy) <= GameCont.loops*32){with(found("tankfake")){{if(!waking){sound_play(snd1); waking++; sprite_index=spr_wake; image_index=0; instance_create(x, y, PortalClear)}}}}


//Wimic
#define wimic_set
	{
	spr_idle = sprWimicIdle
	spr_walk = sprWimicFire
	spr_hurt = sprWimicHurt
	spr_dead = sprWimicDead
	spr_tell = sprWimicTell
	spr_shadow = shd24
	spr_shadow_y = -1
	snd_hurt=sndMimicHurt
	snd_dead=sndMimicDead
	snd_mele=sndMimicMelee
	snd_tell = sndMimicSlurp
	hitid = [sprWimicFire, "wimic"]
	nts_color_blood = [make_color_rgb(96, 59, 52), c_black]
	
	basetime = [irandom_range(120,240), 0]
	basetimemax = [240, 32]
	my_health = 9
	maxhealth = my_health
	maxspeed = 2
	raddrop = 6
	meleedamage = 5
	on_step = wimic_step
	on_hurt = common_hurt
	on_death = wimic_death
	}

#define wimic_step
	{
	speed = clamp(speed, 0, maxspeed)
	if(basetime[1])
		{basetime[1] -= current_time_scale}
	else{
		if(timecheck(0))
			{
			sprite_index = spr_tell
			var s = sound_play_hit(snd_tell, 0)
			audio_sound_pitch(s, 2)
			retime(1)
			}
		}
	scrCommonSpr()
	
	}

#define wimic_death
	{
	sound_play_hit(snd_dead, 0.3)
	with(instance_create(x, y, Bandit))
		{nexthurt = current_frame + 6}
	pickup_drop(32, 0, 2)
	}


//Envoy
#define envoy_set
	{
	envoy_set_1()
	my_health = 8
	maxhealth = my_health
	}

#define envoy_set_1
	{
	spr_idle = sprEnvoyIdle
	spr_walk = sprEnvoyWalk
	spr_hurt = sprEnvoyHurt
	spr_dead = sprEnvoyDead
	mask_index = mskBandit
	spr_shadow = shd24
	snd_fire = sndEnemyFire
	snd_hurt = sndRavenDie
	snd_dead = sndRavenDie
	hitid = [sprEnvoyIdle, "envoy"]
	nts_color_blood = [c_aqua, c_white]
	
	wep = sprEnvoyWep
	
	alarm1 = irandom_range(60,90)
	basetime = [0, 0]
	basetimemax = [90*power(2/3,GameCont.loops), 2]
	maxspeed = 3.5
	gunangle = random(360)
	ammo = 0
	wkick = 0
	walk = 0
	raddrop = 8
	on_step = envoy_step
	on_hurt = common_hurt
	on_death = envoy_death
	on_draw = common_dr_wep
	}

#define envoy_step
	{
	ntscheck()
	if(cacheck())
		{
		common_target()
		switch(irandom(11))
			{
			case 0: 
				if(instance_exists(target)){if(!place_meeting(target.x, target.y, Wall))
					{
					sound_play_hit(sndRavenLift, 0.3)
					with(instance_create(x, y, CustomHitme))
						{
						my_health = other.my_health
						dx = other.target.x
						dy = other.target.y
						gunangle = other.gunangle
						wep = other.wep
						team = other.team
						
						ntstype = "envoyStrafe"
						
						image_speed_raw = 0.4
						sprite_index = sprEnvoyLift
						mask_index = mskNone
						depth = -14
						spr_shadow_x = 0
						spr_shadow_y = 0
						snd_fire = sndEnemyFire
						hitid = [sprEnvoyFly, "strafing envoy"]
						
						basetime = [12, 9, 6]
						basetimemax = [12, 9, 6]
						flystep = 0
						wkick = 0
						
						on_step = envoyStrafe_step
						on_draw = envoyStrafe_draw
						envoyStrafe_step()
						}
					instance_delete(self)
					exit
					}}
				break
			
			case 1:
			case 2:
				if(instance_exists(target)){if(!place_meeting(target.x, target.y, Wall))
					{
					sound_play_hit(sndRavenLift, 0.3)
					with(instance_create(x, y, CustomHitme))
						{
						my_health = other.my_health
						dx = other.target.x
						dy = other.target.y
						gunangle = other.gunangle
						team = other.team
						
						ntstype = "envoyNade"
						
						image_speed_raw = 0.4
						sprite_index = sprEnvoyLift
						mask_index = mskNone
						depth = -14
						spr_shadow_x = 0
						spr_shadow_y = 0
						snd_fire = sndEnemyFire
						hitid = [sprEnvoyIdle, "envoy nade"]
						
						flystep = 0
						wkick = 0
						bx = other.x
						by = other.y
						bg = point_distance(bx, by, dx, dy)
						
						on_step = envoyNade_step
						on_draw = envoyNade_draw
						envoyNade_step()
						}
					instance_delete(self)
					exit
					}}
			
			case 3: 
				if(!basetime[0]){retime(0); retime(1); ammo=3}
				break
			
			default: direction=random(360); walk=20; break
			}
		alarm1 = 30
		}
	if(ammo>0 && timecheck(1))
		{
		ammo --
		wkick = 6
		common_fire(EnemyBullet1, gunangle, 10, 5, random_range(10,-10))
		}
	if(basetime[0])
		{basetime[0] -= current_time_scale}
	if(walk > 0)
		{
		speed = maxspeed
		walk -= current_time_scale
		}
	}

#define envoy_death
	{
	sound_play_hit(snd_dead, 0.3)
	pickup_drop(16, 0)
	wep_drop(10, "envoy smg")
	}

#define envoyStrafe_step
	{
	mask_index = mskBandit
	right = (gunangle<90||gunangle>270) ? 1 : -1
	image_xscale = right
	if(wkick){wkick -= current_time_scale}
	spr_shadow = place_meeting(x, y, Floor) ? shd24 : mskNone
	switch(flystep)
		{
		case 0: 
			if(timecheck(0))
				{
				sprite_index = sprEnvoyFly
				image_index = 0
				depth = -14
				flystep = 1
				}
			break
		
		case 1: 
			if(collision_point(dx, dy, self, 0, 0) && place_free(x, y) && place_meeting(x, y, Floor))
				{
				sprite_index = sprEnvoyLand
				image_index = 0
				depth = 1
				speed = 0
				sound_play_hit(sndRavenLand, 0.3)
				flystep = 2
				}
			else{move_towards_point(dx, dy, 5*current_time_scale)}
			if(timecheck(2) && place_meeting(x, y, Floor))
				{
				wkick = 6
				common_fire(EnemyBullet1, gunangle, 10, 3, random_range(3,-3))
				}
			break
		
		case 2: 
			if(timecheck(1))
				{
				with(instance_create(x, y, CustomEnemy))
					{
					my_health = other.my_health
					team = other.team
					gunangle = other.gunangle
					ntstype = "envoy"
					ntsset = true
					PhtmT = true
					envoy_set_1()
					image_speed_raw = 0.4
					}
				instance_destroy()
				exit
				}
			break
		
		default: break
		}
	mask_index = mskNone
	}

#define envoyStrafe_draw
	{
	draw_self()
	dr_wep(x, y-8)
	}

#define envoyNade_step
	{
	mask_index = mskBandit
	right = (gunangle<90||gunangle>270) ? 1 : -1
	image_xscale = right
	spr_shadow = place_meeting(x, y, Floor) ? shd24 : mskNone
	
	var dis = point_distance(x, y, bx, by)
	iy = - 2/bg*sqr(dis) + dis*2
	
	if(collision_point(dx, dy, self, 0, 0) && place_free(x, y) && place_meeting(x, y, Floor))
		{
		with(instance_create(x, y, CustomEnemy))
			{
			my_health = other.my_health
			team = other.team
			ntstype = "envoy"
			ntsset = true
			PhtmT = true
			envoy_set_1()
			image_speed_raw = 0.4
			}
		instance_destroy()
		exit
		}
	else{move_towards_point(dx, dy, 5*current_time_scale)}
	mask_index = mskNone
	}

#define envoyNade_draw
draw_sprite_ext(sprEnvoyLand, 1, x, y-iy, image_xscale, 1, 0, c_white, 1)


//Gaze
#define gaze_set
	{
	spr_idle = sprGazeIdle
	spr_walk = sprGazeWalk
	spr_hurt = sprGazeHurt
	spr_dead = sprGazeDead
	mask_index = mskBandit
	spr_shadow = shd24
	snd_fire = sndRocket
	snd_hurt = sndSniperHit
	snd_dead = sndExplosion
	hitid = [sprGazeIdle, "gaze"]
	nts_color_blood = [make_color_rgb(96, 59, 52), c_black]
	
	wep = sprBazooka
	
	alarm1 = irandom_range(60,90)
	basetime = [0, 0]
	basetimemax = [45, 30]
	my_health = 6
	maxhealth = my_health
	maxspeed = 3.5
	gunangle = random(360)
	ammo = 0
	wkick = 0
	walk = 0
	raddrop = 8
	on_step = gaze_step
	on_hurt = common_hurt
	on_death = gaze_death
	on_draw = common_dr_wep
	}

#define gaze_step
	{
	ntscheck()
	if(ammo > 0)
		{
		if(timecheck(1))
			{
			ammo --
			wkick = 6
			common_fire(Rocket, gunangle, 13, 5, 0)
			retime(1)
			alarm1 = 30
			}
		}
	else{
		if(cacheck())
			{
			common_target()
			switch(irandom(1))
				{
				case 0: 
					if(instance_exists(target) && !basetime[0])
						{
						tx = target.x
						ty = target.y
						if(!collision_line(x, y, tx, ty, Wall, 0, 0))
							{
							retime(1)
							ammo = 1
							sound_play_hit(sndSniperTarget, 0.3)
							script_bind_draw(gaze_sightdraw, -16, self, tx, ty)
							}
						}
					break
				
				default: 
					direction = random(360)
					walking = 20
					break
				}
			alarm1 = 30
			}
		}
	if(basetime[0])
		{basetime[0] -= current_time_scale}
	if(walk > 0)
		{
		speed = maxspeed
		walk -= current_time_scale
		}
	}

#define gaze_death
	{
	with(instance_create(x, y, Explosion))
		{
		creator = self
		hitid = [sprGazeHurt, "gaze"]
		}
	pickup_drop(16, 0)
	wep_drop(10, wep_bazooka)
	}

#define gaze_sightdraw(inst, tx, ty)
	{
	if(instance_exists(inst))
		{
		draw_sprite_ext(sprCrosshair, 2, tx, ty, 2, 2, 0, c_red, 1)
		if(inst.ammo <= 0){instance_destroy()}
		exit
		}
	instance_destroy()
	}


//Fruit
#define fruit_set
	{
	if("color"!in self){color = choose("r", "b", "g")}
	switch(color)
		{
		case "r": spr_idle=sprFruitIdleR; spr_walk=sprFruitIdleR; spr_hurt=sprFruitHurtR; spr_dead=sprFruitDeadR; nts_color_blood = [make_color_rgb(96, 59, 52), c_black]; break
		case "b": spr_idle=sprFruitIdleB; spr_walk=sprFruitIdleB; spr_hurt=sprFruitHurtB; spr_dead=sprFruitDeadB; nts_color_blood = [c_aqua, make_color_rgb(14, 19, 134)]; break
		case "g": spr_idle=sprFruitIdleG; spr_walk=sprFruitIdleG; spr_hurt=sprFruitHurtG; spr_dead=sprFruitDeadG; nts_color_blood = [c_green, make_color_rgb(133, 194, 5)]; break
		default: instance_delete(self); exit; break
		}
	mask_index = mskBandit
	spr_shadow = shd32
	snd_hurt = sndHitFlesh
	snd_dead = sndExploFreakDead
	hitid = [spr_idle, "fruit"]
	
	my_health = 5
	maxhealth = my_health
	maxspeed = 3
	gunangle = random(360)
	wkick = 0
	walk = 0
	raddrop = 10
	on_step = fruit_step
	on_hurt = common_hurt
	on_death = fruit_death
	
	sp = 0
	}

#define fruit_step
	{
	ntscheck()
	if(ntstarget())
		{
		var dx = target.x
		var dy = target.y
		gunangle = point_direction(x, y, dx, dy)
		if(GameCont.loops || my_health<maxhealth)
			{sp += 0.45*current_time_scale}
		else{
			var d = angle_difference(target.gunangle, gunangle)
			if(abs(d) < 90)
				{sp += 0.45*current_time_scale}
			else{sp -= 0.3*current_time_scale}
			}
		sp = clamp(sp, 0, maxspeed)
		mp_potential_step(dx, dy, sp*current_time_scale, 0)
		if(distance_to_object(target) < 16){my_health = 0}
		}
	}

#define fruit_death
	{
	sound_play_hit(snd_dead, 0.3)
	pickup_drop(16, 0)
	switch(color)
		{
		case "r": 
			sound_play_hit(sndExplosion, 0.3);
			var dx = x
			var dy = y
			var crt = self
			var hid = hitid
			wait 9
			repeat(32){with(instance_create(dx, dy, TrapFire)){damage=2; team=1; creator=crt; hitid=hid; direction=random(360); image_angle=direction; speed=3}}; 
			break
		case "b": 
			with(instance_create(x, y, PopoExplosion)){damage=3; team=3; creator=other; hitid=other.hitid; direction=random(360)}; 
			sound_play_hit(sndIDPDNadeExplo, 0.3);
			break
		case "g": 
			with(instance_create(x, y, FrogQueenBall)){team=3; creator=other; hitid=other.hitid; instance_destroy()}; 
			sound_play_hit(sndBallMamaFire, 0.3);
			break
		default: break
		}
	}


//Asnowsin
#define asnowsin_set
	{
	spr_idle = sprAsnowsinIdle
	spr_walk = sprAsnowsinWalk
	spr_hurt = sprAsnowsinHurt
	spr_dead = sprAsnowsinDead
	mask_index = mskBandit
	snd_fire = sndHeavyRevoler
	snd_hurt = sndAssassinHit
	snd_dead = sndAssassinDie
	hitid = [sprAsnowsinIdle, "asnowsin"]
	nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
	
	wep = sprAsnowsinWep
	
	alarm1 = irandom_range(60,90)
	basetime = [0, 0]
	basetimemax = [90*power(2/3,GameCont.loops), 1]
	my_health = 8
	maxhealth = my_health
	maxspeed = 3.5
	gunangle = random(360)
	ammo = 0
	wkick = 0
	walk = 0
	raddrop = 4
	on_step = asnowsin_step
	on_hurt = common_hurt
	on_death = asnowsin_death
	on_draw = common_dr_wep
	}

#define asnowsin_step
	{
	ntscheck()
	if(GameCont.loops){image_alpha = 1}
	else{
		if(ntstarget() && ammo<=0)
			{
			image_alpha = max(96 - distance_to_object(target), 0) / 96 + speed/32
			}
		else{image_alpha = 0.5}}
	if(cacheck() && ammo<=0)
		{
		common_target()
		switch(irandom(7))
			{
			case 0:
				if(instance_exists(target)){if(basetime[0]<=0 && !collision_line(x, y, target.x, target.y, Wall, 0, 0))
					{
					retime(0)
					retime(1)
					ammo = irandom_range(1,3)
					}}
				break
				
			case 2:
			case 3:
			case 4:
				direction = random(360)
				walk = 40
				break
			default: break
			}
		alarm1 = GameCont.loops ? 30 : 60
		}
	if(timecheck(1) && ammo>0)
		{
		ammo --
		wkick = 6
		common_fire(EnemyBullet4, gunangle, 13, 10, 0)
		gunangle += irandom_range(10, -10)
		}
	if(basetime[0] >= 0){basetime[0] -= current_time_scale}
	if(walk > 0)
		{
		speed = maxspeed
		walk -= current_time_scale
		}
	}

#define asnowsin_death
	{
	sound_play_hit(snd_dead, 0.3)
	pickup_drop(16, 0)
	}


//FakeTank
#define tankfake_set
	{
	spr_idle = sprTankFakeIdle
	spr_wake = sprTankFakeWake
	snd1 = sndSnowTankHurt
	snd2 = sndWolfRoll
	snd3 = sndSnowTankPreShoot
	snd4 = sndSnowTankShoot
	
	basetime = [8, 15, 20, 24]
	basetimemax = [8, 15, 20, 24]
	waking = 0
	on_step = tankfake_step
	on_destroy = tankfake_destroy
	}

#define tankfake_step
	{
	if(waking > 0)
		{
		if(timecheck(0) && waking==1){sound_play_hit(snd2, 0.3); waking++}
		if(timecheck(1) && waking==2){sound_play_hit(snd3, 0.3); waking++}
		if(timecheck(2) && waking==3){sound_play_hit(snd4, 0.3); waking++}
		if(timecheck(3)){instance_destroy()}
		}
	else{
		sprite_index = spr_idle
		if(place_meeting(x, y, Player) || !instance_exists(enemy))
			{
			sound_play_hit(snd1, 0.3)
			waking ++
			sprite_index = spr_wake
			image_index = 0
			instance_create(x, y, PortalClear)
			}
		}
	}

#define tankfake_destroy
with(instance_create(x, y, SnowTank)){PhtmT = true}


//RhinoBot
#define rhinobot_set
	{
	rhinobot_set_1()
	my_health = 50
	maxhealth = my_health
	alarm1 = irandom_range(60,90)
	basetime = [0, 0, 0]
	}

#define rhinobot_set_1
	{
	spr_idle = sprRhinoBotIdle
	spr_walk = sprRhinoBotIdle
	spr_fire = sprRhinoBotFire
	spr_hurt = sprRhinoBotHurt
	spr_dead = mskNone
	mask_index = mskRhinoFreak
	spr_shadow = shd48
	snd_fire = sndSnowBotThrow
	snd_mele = sndRhinoFreakMelee
	snd_hurt = sndRhinoFreakHurt
	snd_dead = sndRhinoFreakDead
	hitid = [sprRhinoBotIdle, "rhinobot"]
	nts_color_blood = [make_color_rgb(96, 59, 52), c_black]
	
	basetimemax = [7, 15, 20]
	maxspeed = 2
	gunangle = random(360)
	ammo = 0
	raddrop = 20
	meleedamage = 5
	stored = false
	on_step = rhinobot_step
	on_hurt = common_hurt
	on_death = rhinobot_death
	}

#define rhinobot_step
	{
	scrCommonSpr()
	
	if(ammo > 0)
		{
		if(ammo==1)
			{
			with(instance_nearest(x, y, Freak))
				{if(!(place_meeting(x, y, other))){direction = point_direction(x, y, other.x, other.y)}}
			if(timecheck(0))
				{
				target = instance_nearest(x, y, Freak)
				ammo = 0
				if(instance_exists(target))
					{
					if(place_meeting(x, y, target))
						{
						ammo = 2
						instance_delete(target)
						stored = true
						}
					}
				}
			}
		if(timecheck(1) && ammo==2)
			{
			common_target()
			ammo = 3
			stored = false
			with(instance_create(x+16*right, y-8, CustomProjectile))
				{
				with(instance_create(x, y, PortalClear))
					{
					image_xscale = 0.25
					image_yscale = 0.25
					}
				sprite_index = sprFreak1Walk
				mask_index = mskBandit
				direction = other.gunangle
				image_angle = direction
				speed = 10
				damage = 3
				creator = other
				team = other.team
				hitid = [other.spr_fire, "RhinoBot"]
				typ = 1
				if(direction>90 && direction<270)
					{image_yscale = -1}
				on_destroy = FlyFreak
				}
			}
		if(timecheck(2) && ammo==3)
			{
			ammo = 0
			sprite_index = spr_idle
			image_index = 0
			}
		}
	else{
		if(cacheck())
			{
			if(instance_exists(Freak))
				{
				target = instance_nearest(x, y, Freak)
				if(place_meeting(x, y, target))
					{
					ammo = 1
					retime(0)
					retime(1)
					retime(2)
					sprite_index = spr_fire
					image_index = 0
					sound_play_hit(sndSnowBotPickup, 0.3)
					alarm1 = 30
					exit
					}
				}
			if(GameCont.loops){}
			else{
				repeat(2)
					{
					if(instance_exists(target)){if(!place_meeting(target.x, target.y, Wall))
						{
						sound_play_hit(sndSnowBotPickup, 0.3)
						with(instance_create(x, y, CustomHitme))
							{
							image_speed_raw = 0.4
							sprite_index = other.spr_fire
							mask_index = mskNone
							depth = -14
							spr_shadow_x = 0
							spr_shadow_y = 0
							my_health = other.my_health
							target = other.target
							dx = target.x
							dy = target.y
							gunangle = other.gunangle
							team = other.team
							ntstype = "naderhinobot"
							hitid = [sprRhinoBotIdle, "rhinobot"]
							
							basetime = [3]
							basetimemax = [3]
							flystep = 0
							bx = x
							by = y
							bg = point_distance(bx, by, dx, dy)
							
							on_step = rhinobotNade_step
							on_draw = rhinobotNade_draw
							rhinobotNade_step()
							}
						instance_delete(self)
						exit
						}}
					common_target()
					}
				}
			direction = random(360)
			alarm1 = 30
			}
		}
	with(instance_nearest(x, y, Freak))
		{if(!(place_meeting(x, y, other))){direction = point_direction(x, y, other.x, other.y)}}
	if(stored){script_bind_draw(RhinoBotFreakDraw, depth-1, x, y, right)}
	speed = maxspeed
	}

#define FlyFreak
with(instance_create(x, y, Freak)){PhtmT = true}

#define RhinoBotFreakDraw(dx, dy, right)
draw_sprite_ext(sprFreak1Idle, 1, dx+16*right, dy-8, 1, 1, 0, c_white, 1)
instance_destroy()

#define rhinobot_death
	{
	sound_play_hit(snd_dead, 0.3)
	repeat(3){with(instance_create(x,y,Explosion))
		{
		creator = other
		hitid = [other.spr_hurt, "RhinoBot"]
		direction = random(360)
		}}
	pickup_drop(16, 4, 3)
	}

#define rhinobotNade_step
	{
	mask_index = mskRhinoFreak
	right = (gunangle<90||gunangle>270) ? 1 : -1
	image_xscale = right
	spr_shadow = place_meeting(x, y, Floor) ? shd48 : mskNone
	
	var dis = point_distance(x, y, bx, by)
	iy = - 2/bg*sqr(dis) + dis*2
	
	with(instance_nearest(x, y, Freak))
		{if(!(place_meeting(x, y, other))){direction = point_direction(x, y, other.x, other.y)}}
	
	if(collision_point(dx, dy, self, 0, 0) && place_free(x, y) && place_meeting(x, y, Floor))
		{
		with(instance_create(x, y, CustomEnemy))
			{
			my_health = other.my_health
			team = other.team
			ntstype = "rhinobot"
			ntsset = true
			PhtmT = true
			rhinobot_set_1()
			alarm1 = 30
			basetime = [0, 0, 0]
			target = other.target
			image_speed_raw = 0.4
			sprite_index = spr_walk
			}
		instance_destroy()
		exit
		}
	else{move_towards_point(dx, dy, 4*current_time_scale)}
	mask_index = mskNone
	}

#define rhinobotNade_draw
draw_sprite_ext(sprRhinoBotFire, 1, x, y-iy, image_xscale, 1, 0, c_white, 1)


//RuinsMind
#define ruinsmind_set
	{
	basetime	= [90]
	basetimemax	= [90]
	nts_ruinsmind_stat = 0
	on_step = ruinsmind_step
	}

#define ruinsmind_step
	{
	if(timecheck(0))
		{
		var s = instances_matching(GameObject, "creator", self)
		var es = instances_matching(s, "nts_ruinsmachine", 1)
		var ps = instances_matching(s, "nts_ruinsmachine", 2)
		var lh = 0.12
		switch(nts_ruinsmind_stat)
			{
			case 0: nts_ruinsmind_stat = choose(1, 3); break
			case 1: 
			case 2: 
			case 3: nts_ruinsmind_stat++; break
			case 4: nts_ruinsmind_stat = 1; break
			default: break
			}
		with(ps){nts_ruins_lightc = choose(48896, 12566272, 49087, 12517567)}
		switch(nts_ruinsmind_stat)
			{
			case 0: 
				with(es)
					{nts_ruins_lightc = c_white}
				with(ps)
					{nts_ruins_lightc = 0}
				with(Player)
					{nts_ruins_lightc_3d = 0}
				break
			case 1: 
				with(es)
					{
					nts_ruins_lightc = 48896
					nts_ruins_light = [lh, 64, 32]
					direction = random(360)
					ammo = 15
					reload = 30
					}
				with(Player)
					{nts_ruins_lightc_3d = 48896}
				break
			case 2: 
				with(es)
					{
					nts_ruins_lightc = 12566272
					nts_ruins_light = [lh, 64, 32]
					ammo = 3
					reload = 30
					}
				with(Player)
					{nts_ruins_lightc_3d = 12566272}
				break
			case 3: 
				with(es)
					{
					nts_ruins_lightc = 49087
					nts_ruins_light = [lh, 64, 32]
					reload = 30
					}
				with(Player)
					{nts_ruins_lightc_3d = 49087}
				break
			case 4: 
				with(es)
					{
					nts_ruins_lightc = 12517567
					nts_ruins_light = [lh, 64, 32]
					ammo = 1
					reload = 60
					}
				with(Player)
					{nts_ruins_lightc_3d = 12517567}
				break
			default: break
			}
		with(es)
			{
			common_target()
			nts_ruinsmind_stat = other.nts_ruinsmind_stat
			}
		}
	}


//Waiter
#define waiter_set
	{
	spr_idle = sprWaiterIdle
	spr_walk = sprWaiterWalk
	spr_hurt = sprWaiterHurt
	spr_dead = sprWaiterDead
	mask_index = mskBandit
	spr_shadow = shd32
	snd_fire = sndEnemyFire
	snd_hurt = sndHitMetal
	snd_dead = sndExplosionS
	hitid = [sprWaiterIdle, "waiter"]
	nts_color_blood = [make_color_rgb(96, 59, 52), c_black]
	
	nts_ruinsmachine = 1
	nts_ruinsmind_stat = 0
	
	my_health = 8
	maxhealth = my_health
	maxspeed = 2.5
	gunangle = random(360)
	reload = 0
	ammo = 0
	wkick = 0
	raddrop = 5
	explo = -1
	on_step = waiter_step
	on_hurt = common_hurt
	on_death = waiter_death
	}

#define waiter_step
	{
	ntscheck()
	if(explo > -1)
		{
		nts_ruins_lightc = 12566272
		nts_ruins_light = [0.06, irandom_range(96,100), irandom_range(60,64)]
		if(explo > 0){explo -= current_time_scale}
		else{
			with(instance_create(x, y, Explosion))
				{
				creator = other
				hitid = [other.spr_hurt, "waiter"]
				}
			}
		}
	else{
		if(reload > 0){reload -= current_time_scale}
		switch(nts_ruinsmind_stat)
			{
			case 1: 
				if(reload<=0 && ammo>=0)
					{
					common_target()
					ammo --
					reload = irandom(30)
					common_fire(EnemyBullet1, gunangle, 0, 4, 10)
					}
				speed = maxspeed
				break
				
			case 2: 
				common_target()
				if(instance_exists(target))
					{
					motion_add(gunangle, 3)
					speed = 3
					if(distance_to_object(target) < 32)
						{explo = 15}
					}
				break
				
			case 3: 
				break
				
			case 4: 
				if(reload<=0 && ammo>=0)
					{
					ammo --
					sound_play_hit(sndLaser, 0.3)
					with(instance_create(x, y, Laser))
						{
						team = other.team
						direction = other.gunangle
						creator = other
						hitid = other.hitid
						image_angle = direction
						event_perform(ev_alarm, 0)
						}
					}
				break
			default: break
			}
		}
	}

#define waiter_death
	{
	sound_play_hit(snd_dead, 0.3)
	pickup_drop(16, 0)
	with(instance_create(x, y, Explosion))
		{
		creator = other
		hitid = [other.spr_hurt, "waiter"]
		}
	}


//Manager
#define manager_set
	{
	spr_idle = sprManagerIdle
	spr_walk = sprManagerWalk
	spr_hurt = sprManagerHurt
	spr_dead = mskNone
	mask_index = mskRhinoFreak
	spr_shadow = shd48
	snd_hurt = sndHitMetal
	snd_dead = sndExplosion
	hitid = [sprManagerIdle, "manager"]
	nts_color_blood = [make_color_rgb(96, 59, 52), c_black]
	
	nts_ruinsmachine = 1
	nts_ruinsmind_stat = 0
	
	basetime = []
	basetimemax = []
	my_health = GameCont.loops * 100 + 50
	maxhealth = my_health
	maxspeed = 1.5
	gunangle = random(360)
	reload = 0
	ammo = 0
	wkick = 0
	raddrop = 32
	on_step = manager_step
	on_hurt = common_hurt
	on_death = manager_death
	}

#define manager_step
	{
	ntscheck()
	if(reload > 0){reload -= current_time_scale}
	switch(nts_ruinsmind_stat)
		{
		case 1: 
			if(reload<=0 && ammo>=0)
				{
				ammo --
				reload = 3
				snd_fire = sndTurretFire
				common_fire(EnemyBullet1, gunangle, 0, 8, 0)
				}
			speed = maxspeed
			break
		case 2: 
			if(reload<=0 && ammo>=0)
				{
				ammo --
				reload = 15
				snd_fire = sndFlakCannon
				common_fire(EFlakBullet, gunangle, 0, 8, 0)
				}
			break
		case 3: 
			if(reload <= 0)
				{
				common_target()
				reload = 20
				snd_fire = sndSniperFire
				for(var i=-3; i<=3; i+=3)
					{common_fire(EnemyBullet4, gunangle+i, 0, 12, 0)}
				}
			if(instance_exists(target)){motion_add(gunangle, maxspeed); speed=maxspeed}
			break
		case 4: 
			if(reload<=0 && ammo>=0)
				{
				ammo --
				snd_fire = sndPlasma
				common_fire(PlasmaBall, gunangle, 0, 0, 0)
				}
			break
		default: break
		}
	}

#define manager_death
	{
	sound_play_hit(snd_dead, 0.3)
	pickup_drop(32, 4, 3)
	with(instance_create(x, y, Explosion))
		{
		creator = other
		hitid = [other.spr_hurt, "waiter"]
		}
	with(instances_matching(hitme, "creator", creator)){switch(nts_ruinsmachine)
		{
		case 1: 
			nts_ruins_lightc = c_white
			nts_ruinsmind_stat = 0
			break
		case 2:
			nts_ruins_lightc = 0
			break
		default: break
		}}
	with(instances_matching(Player, "race", "molefish"))
		{nts_ruins_lightc = 0}
	with(creator)
		{
		basetime[0] = GameCont.loops?75:150
		nts_ruinsmind_stat = 0
		}
	}


//Baritone
#define baritone_set
	{
	spr_idle = sprBaritoneIdle
	spr_walk = sprBaritoneWalk
	spr_hurt = sprBaritoneHurt
	spr_dead = mskNone
	mask_index = mskFireBaller
	spr_shadow = shd32
	snd_fire = sndSnowTankShoot
	snd_hurt = sndMolesargeHurt
	snd_dead = sndSuperFlakExplode
	hitid = [sprBaritoneGameover, "baritone"]
	nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
	
	alarm1 = irandom_range(60,90)
	basetime = [0, 0]
	basetimemax = [40, 1]
	my_health = 36
	maxhealth = my_health
	maxspeed = 2
	gunangle = random(360)
	ammo = 0
	walk = 0
	raddrop = 8
	on_step = baritone_step
	on_hurt = common_hurt
	on_death = baritone_death
	}

#define baritone_step
	{
	speed = clamp(speed, 0, maxspeed)
	scrCommonSpr()
	
	if(cacheck() && ammo<=0)
		{
		common_target()
		switch(irandom(3))
			{
			case 0: sound_play_hit(sndSnowTankCooldown, 0.3)
			case 1: 
				if(instance_exists(target)){if(basetime[0]<=0 && !collision_line(x, y, target.x, target.y, Wall, 0, 0) && distance_to_object(target)<160)
					{
					retime(0)
					retime(1)
					ammo = irandom_range(20, 30)
					}}
				break
			
			case 3: 
				direction = random(360)
				walk = 90
				break
			
			default: break
			}
		alarm1 = 60
		}
	if(timecheck(1) && ammo>0)
		{
		ammo --
		common_fire(EnemyBullet4, gunangle, 0, random_range(6, 12), random_range(5, -5))
		gunangle += irandom_range(3, -3)
		}
	if(basetime[0] >= 0){basetime[0] -= current_time_scale}
	if(walk > 0)
		{
		speed = maxspeed
		walk -= current_time_scale
		}
	}

#define baritone_death
	{
	sound_play_hit(snd_hurt, 0.3)
	with(instance_create(x, y, CustomObject))
		{
		sprite_index = other.spr_hurt
		image_speed_raw = 0.4
		team = other.team
		hitid = other.hitid
		ammo = irandom_range(3, 5)
		reload = irandom_range(3, 7)
		snd_dead = other.snd_dead
		on_step = baritone_corpse_step
		on_destroy = baritone_corpse_destroy
		}
	}

#define baritone_corpse_step
	{
	if(reload > 0)
		{reload -= current_time_scale}
	else{
		if(ammo > 0)
			{
			pickup_drop(4, 1)
			with(instance_create(x+random_range(4, -4), y+random_range(4, -4), EFlakBullet))
				{
				direction = random(360)
				creator = other
				//team = other.team
				hitid = other.hitid
				image_angle = direction
				}
			reload = irandom_range(3, 7)
			ammo --
			}
		else{instance_destroy()}
		}
	}

#define baritone_corpse_destroy
	{
	sound_play_hit(snd_dead, 0.3)
	pickup_drop(32, 4)
	for(var i=0; i<360; i+=24){with(instance_create(x, y, EnemyBullet4))
		{
		speed = random_range(8, 12)
		direction = i + random(15)
		creator = other
		team = other.team
		hitid = other.hitid
		image_angle = direction
		}}
	with(instance_create(x, y, EBulletHit))
		{
		sprite_index = sprEFlakHit
		image_xscale = 2
		image_yscale = 2
		}
	instance_create(x, y, MeltSplat)
	}


//Chick
#define chick_set
	{
	spr_idle = sprChickIdle
	spr_walk = sprChickWalk
	spr_hurt = sprChickHurt
	spr_dead = sprChickDead
	mask_index = mskBigRad
	spr_shadow = shd24
	snd_fire = sndPistol
	snd_hurt = sndMutant5Hurt
	snd_dead = sndSaplingSpawn
	hitid = [sprChickDance, "chick"]
	nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
	
	alarm1 = irandom_range(60,90)
	basetime = [0, 0]
	basetimemax = [60*power(2/3,GameCont.loops), 2]
	my_health = 4
	maxhealth = my_health
	maxspeed = 5
	gunangle = random(360)
	ammo = 0
	wkick = 0
	walk = 0
	raddrop = 5
	wep = sprSmg
	on_step = chick_step
	on_hurt = common_hurt
	on_death = chick_death
	on_draw = common_dr_wep
	}

#define chick_step
	{
	ntscheck()
	
	if(cacheck() && ammo<=0)
		{
		var cp = false
		gunangle = random(360)
		if(ntstarget()){if(!collision_line(x, y, target.x, target.y, Wall, 0, 0) && distance_to_object(target)<128)
			{
			gunangle = point_direction(x, y, target.x, target.y)
			var cp = true
			}}
		right = (gunangle<90||gunangle>270) ? 1 : -1
		switch(irandom(3))
			{
			case 0: 
				if(instance_exists(target)){if(basetime[0]<=0 && cp)
					{
					retime(0)
					retime(1)
					ammo = 3
					}}
				break
			
			case 1: 
				direction = random(360)
				walk = 10
				break
			case 2: 
				if(instance_exists(target)){if(basetime[0]<=0 && cp)
					{
					direction = point_direction(x, y, target.x, target.y) + choose(90, -90)
					walk = 10
					retime(0)
					retime(1)
					ammo = 3
					}}
				break
			
			default: break
			}
		alarm1 = 20
		}
	if(timecheck(1) && ammo>0)
		{
		ammo --
		wkick = 4
		common_fire(EnemyBullet1, gunangle, 0, 6, random_range(5, -5))
		}
	if(basetime[0] >= 0){basetime[0] -= current_time_scale}
	if(walk > 0)
		{
		speed = maxspeed
		walk -= current_time_scale
		}
	}

#define chick_death
	{
	sound_play_hit(snd_dead, 0.3)
	pickup_drop(64, 0)
	}


/*
#define _set
	{
	spr_idle = spr
	spr_walk = spr
	spr_hurt = spr
	spr_dead = spr
	mask_index = 
	spr_shadow = 
	snd_fire = snd
	snd_hurt = snd
	snd_dead = snd
	hitid = [, ""]
	nts_color_blood = [, ]
	
	alarm1 = 
	basetime = []
	basetimemax = []
	my_health = 
	maxhealth = my_health
	maxspeed = 
	gunangle = random(360)
	ammo = 0
	wkick = 0
	walk = 0
	raddrop = 
	on_step = 
	on_hurt = 
	on_death = 
	}
*/



#define ntscheck
	{
	speed = clamp(speed, 0, maxspeed)
	if(wkick > 0){wkick = max(wkick-current_time_scale, 0)}
	if(wkick < 0){wkick = min(wkick+current_time_scale, 0)}
	scrCommonSpr()
	}

#define common_hurt(dmg, len, dir)
	{
	my_health -= dmg
	nexthurt = current_frame + 6
	motion_add(dir, len)
	sound_play_hit(snd_hurt, 0.3)
	
	sprite_index = spr_hurt
    image_index = 0
	}

#define ntstarget
	{
	if(instance_exists(Player))
		{target = instance_nearest(x, y, Player)}
	else{target = noone}
	return instance_exists(target)
	}

#define common_target
	{
	if(ntstarget())
		{gunangle = point_direction(x, y, target.x, target.y)}
	else{gunangle = random(360)}
	right = (gunangle<90||gunangle>270) ? 1 : -1
	}

#define common_fire(obj, ga, gr, sp, ac)
	{
	sound_play_hit(snd_fire, 0.3)
	with(instance_create(x+lengthdir_x(gr,ga),y+lengthdir_y(gr,ga), obj))
		{
		speed = sp
		direction = ga + ac
		creator = other
		team = other.team
		hitid = other.hitid
		image_angle = direction
		return self
		}
	}

#define wep_drop(wc, w)
	{
	if(!irandom((wc - 1) * (1 << GameCont.loops)))
		{
		with(instance_create(x, y, WepPickup))
			{
			wep = w
			ammo = irandom(2)
			}
		}
	}

#define scrCommonSpr
	{
	if(sprite_index != spr_hurt)
		{
		if(sprite_index!=spr_idle && sprite_index!=spr_walk && image_index+image_speed_raw<image_number){}
		else{
			if(speed <= 0)
				{sprite_index = spr_idle}
			else{
				if(sprite_index == spr_idle)
					{sprite_index = spr_walk}
				}
			}
		}
	else{
		if(image_index+image_speed_raw < image_number)
			{
			if(nexthurt>current_frame && sprite_index!=spr_hurt)
				{
				sprite_index = spr_hurt
				image_index = 0
				}
			}
		else{sprite_index = spr_idle}
		}
	image_xscale = right
	}

#define cacheck
	{
	if(alarm1 > 0)
		{
		alarm1 -= current_time_scale
		return alarm1<=0
		}
	else{return false}
	}

#define retime(t)
basetime[t] = basetimemax[t]

#define timecheck(t)
	{
	if(basetime[t] > 0)
		{
		basetime[t] -= current_time_scale
		return false
		}
	else{
		basetime[t] = basetimemax[t]
		return true
		}
	}

#define common_dr
draw_self()//draw_sprite_ext(sprite_index, image_index, x, y, right, 1, image_angle, image_blend, image_alpha)

#define common_dr_wep
	{
	if(gunangle < 180)
		{
		dr_wep(x, y)
		common_dr()
		}
	else{
		common_dr()
		dr_wep(x, y)
		}
	}

#define dr_wep(dx, dy)
	{draw_sprite_ext(wep, 0, dx-lengthdir_x(wkick,gunangle), dy-lengthdir_y(wkick,gunangle), 1, right, gunangle, image_blend, image_alpha)}



#define scrSetBase
	{
	ary_ntsc = {}
	with(instances_matching_ne(CustomEnemy, "ntstype", undefined)){scrSetBaseVar()}
	with(instances_matching_ne(CustomProp, "ntstype", undefined)){scrSetBaseVar()}
	with(instances_matching_ne(CustomHitme, "ntstype", undefined)){scrSetBaseVar()}
	with(instances_matching_ne(CustomObject, "ntstype", undefined)){scrSetBaseVar()}
	}

#define scrSetBaseVar
	{
	var v = variable_instance_get(self, "ntstype", "notfromnts")
	lq_set(ary_ntsc, v, array_push(lq_defget(ary_ntsc, v, []), self))
	if("ntsset"!in self && mod_script_exists("mod", mod_current, `${ntstype}_set`))
		{
		image_speed_raw = 0.4
		depth = -2
		script_execute(script_get_index(`${ntstype}_set`))
		ntsset = true
		if(skill_get(mut_scarier_face) && "my_health"in self){my_health = ceil(my_health*0.8)}
		}
	}

#define ref_blank
