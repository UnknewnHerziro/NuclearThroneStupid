#define init 
global.spr = sprite_add_weapon("BlueRose.png", 0, 4)
global.spr_r = sprite_add_weapon("BlueRose.png", 4, 4)
global.wep_b = 
	{
	wep: mod_current, 
	_ammo: 6, 
	reloading : false, 
	name: "double revolver",
	}

#define weapon_name		return "BLUE ROSE"
#define weapon_sprt		return lq_defget(argument0, "reloading", global.spr) ? global.spr_r : global.spr

#define weapon_type		return 1	//lq_defget(argument0, "reloading", 1) ? 0 : 0
#define weapon_melee	return lq_defget(argument0, "reloading", 0) ? 1 : 0
#define weapon_auto		return lq_defget(argument0, "reloading", 1) ? 0 : 1
#define weapon_load		return lq_defget(argument0, "reloading", 5) ? 8 : 5
#define weapon_cost		return lq_defget(argument0, "reloading", 2) ? 0 : 0
#define weapon_area		return 9
#define weapon_swap		return sndSwapPistol

#define weapon_gold			return false
#define weapon_laser_sight	return false	//lq_defget(argument0, "reloading", 1) ? 0 : 1

#define nts_weapon_examine	return
	"A double-fire revolver. #There is a rose carved on the handle. "



#define weapon_fire
	{
	if(!is_object(wep))
		{wep = lq_clone(global.wep_b)}

	if(wep.reloading){exit}
	if(wep._ammo < 1)
		{
		weapon_post(2, 0, 0)
		exit
		}
	
	with(instance_create(x, y, HeavyBullet))
		{
		direction = other.gunangle+choose(1, -1)
		speed = 15
		image_angle = direction
		
		creator = other
		team = other.team
		typ = 0
		
		if(other.wep._ammo <= 2){with(script_bind_step(scrBulletA, 0, self, creator, team))
			{
			x = other.x
			y = other.y
			}}
		}
	
	wep._ammo --
	if(wep._ammo >= 1)
		{
		sound_play_hit(sndHeavyRevoler, 0.3)
		with(instance_create(x, y, HeavyBullet))
			{
			direction = other.gunangle+choose(2, 0, -2)
			speed = 15
			image_angle = direction
			
			damage *= 2
			creator = other
			team = other.team
		
			if(other.wep._ammo <= 1)
				{
				damage*=2
				with(script_bind_step(scrBulletB, 0, self, creator, team))
					{
					x = other.x
					y = other.y
					}
				}
			}
		wep._ammo --
		}
	
	sound_play_hit(sndHeavyRevoler, 0.3)
	weapon_post(6, 6, 12)
	}

#define scrBulletA(b, c, t)
	{
	if(instance_exists(b))
		{
		x = b.x
		y = b.y
		}
	else{
		for(var i=0; i<360; i+=20){with(instance_create(x, y, Flame))
			{
			direction = i+irandom(10)
			speed = random_range(3, 4)
			image_angle = direction
			
			creator = c
			team = t
			}}
		sound_play_hit(sndFlare, 0.3)
		instance_destroy()
		}
	}

#define scrBulletB(b, c, t)
	{
	if(instance_exists(b))
		{
		x = b.x
		y = b.y
		}
	else{
		with(instance_create(x, y, SmallExplosion))
			{
			direction = random(360)
			
			creator = c
			team = t
			}
		sound_play_hit(sndExplosion, 0.3)
		instance_destroy()
		}
	}

#define weapon_reloaded
	{
	if(argument0)
		{
		if(!is_object(wep))
			{wep = lq_clone(global.wep_b)}
		if(wep.reloading)
			{
			if(ammo[1] >= 1)
				{
				wep.reloading = false
				if(ammo[1] >= 12)
					{
					wep._ammo += 6
					ammo[1] -= 12
					}
				else{
					wep._ammo = ammo[1] div 2
					ammo[1] = ammo[1] mod 2
					}
				}
			}
		else{
			if(wep._ammo <= 0)
				{
				wep.reloading = true
				repeat(6){with(instance_create(x,y,Shell))
					{
					direction = random(360)
					image_angle = direction
					speed = random_range(2, 3)
					}}
				}
			}
		}
	else{
		if(!is_object(bwep))
			{bwep = lq_clone(global.wep_b)}
		if(bwep.reloading)
			{
			if(ammo[1] >= 1)
				{
				bwep.reloading = false
				if(ammo[1] >= 12)
					{
					bwep._ammo += 6
					ammo[1] -= 12
					}
				else{
					bwep._ammo = ammo[1] div 2
					ammo[1] = ammo[1] mod 2
					}
				}
			}
		else{
			if(bwep._ammo <= 0)
				{
				bwep.reloading = true
				repeat(6){with(instance_create(x,y,Shell))
					{
					direction = random(360)
					image_angle = direction
					speed = random_range(2, 3)
					}}
				}
			}
		}
	}

#define step
	{
	if(argument0)
		{
		if(!is_object(wep))
			{wep = lq_clone(global.wep_b)}
		if(wep.reloading)
			{
			wepflip = right
			if(reload>0){wepangle += (right?45:-45)*current_time_scale}
			else{wepangle = right?45:-45}
			}
		}
	else{
		if(!is_object(bwep))
			{bwep = lq_clone(global.wep_b)}
		if(bwep.reloading)
			{
			bwepflip = right
			if(breload>0){bwepangle += (right?45:-45)*current_time_scale}
			else{bwepangle = right?45:-45}
			}
		}
	}
