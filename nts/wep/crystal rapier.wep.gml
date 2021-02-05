
#define init 
global.spr			= sprite_add("CrystalRapier.png",	7,	4,	7)
global.sprCslash	= sprite_add("CrystalSlash.png",	3,	0,	25)
global.d = [true, true, true, true]

#define weapon_sprt		return global.spr

#define weapon_name		return "crystal rapier"

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 15
#define weapon_cost		return 0
#define weapon_area		return GameCont.area==4 ? 20 : -1
#define weapon_swap		return sndCrystalShield

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"crystal" : "A rapier made with yellow crystals that emitting pink light. #When your emotional energy swimming in it, #the pink laser will be fired. ", 
	"eyes" : "Dreamy. ", 
	"venuz" : "RAPier succs ", 
	"chicken" : "Uses like the black sword. ", 
	"shovel knight" : "Rapier, the weapon of reckless people. ", 
	"d" : "A rapier made with yellow crystals that emitting pink light. #When any form of energy swimming in it, #the pink laser will be fired. ", 
	}



#define weapon_fire
	{
	wepflip = -wepflip
	wepangle = -wepangle
	
	sound_play_hit(sndCrystalShield, 0.3)
	weapon_post(20, 12, 1)
	
	if(skill_get(mut_long_arms))
		{
		var xs	= 2
		var spd	= 4
		}
	else{
		var xs	= 1.5
		var spd	= 2
		}
	
	if(string_pos("crystal", weapon_get_name(bwep)) || my_health==maxhealth)
		{
		var spr	= global.sprCslash
		var isr	= "image_speed_raw"
		sound_play_hit(sndCrystalTB, 0.3)
		with(instance_create(x + lengthdir_x(30, gunangle), y + lengthdir_y(30, gunangle), EnemyLaser))
			{
			speed = 10
			image_xscale = 20
		//	image_yscale = 3
			damage = 2
			
			direction = other.gunangle
			image_angle = direction
			creator = other
			team = other.team
			
			script_bind_end_step(refLaserStep, 0, self).time = 90
			}
		}
	else{
		var spr	= sprSlash
		var isr	= "image_speed"
		}
	
	with(instance_create(x + lengthdir_x(5, gunangle), y + lengthdir_y(5, gunangle), Slash))
		{
		sprite_index = spr
		image_xscale = xs
		image_yscale = choose(1, -1)
		speed = spd
		damage = 12
		
		direction = other.gunangle
		image_angle = direction
		creator = other
		team = other.team
		
		variable_instance_set(self, isr, image_speed)
		}
	
	repeat(3){prt_create(random_range(gunangle+45, gunangle-45), 90, random(1))}
	}

#define step
	{
	var ws = current_time_scale * 4
	if(argument0)
		{
		if(wkick > 0)
			{wkick -= ws}
		if(speed && global.d[@index])
			{
			if(fork())
				{
				var i = index
				wait(5)
				if(instance_exists(self))
					{prt_create(random(360), 30, random(1))}
				global.d[@i] = true
				}
			else{
				global.d[@index] = false
				exit
				}
			}
		}
	else{
		if(bwkick > 0)
			{bwkick -= ws}
		}
	}

#define refLaserStep
	{
	time -= current_time_scale
	with(argument0)
		{
		xstart = x
		ystart = y
		if(!place_meeting(x, y, Wall) && other.time>0)
			{
			image_yscale = 1
			exit
			}
		speed = 0
		}
	instance_destroy()
	}

#define prt_create
	{
	with(instance_create(x, y, CustomObject))
		{
		direction = argument0
		sprite_index = sprLaserCharge
		image_angle = random(360)
		image_speed = 0.4
		speed = argument2
		time = argument1
		on_step = prtStep
		
		return self
		}
	}

#define prtStep
	{
	if(time)
		{
		time -= current_time_scale
		exit
		}
	instance_destroy()
	}
