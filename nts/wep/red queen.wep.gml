
#define init 
global.spr = sprite_add_weapon("RedQueen.png", 8, 8)
global.spr_r = sprite_add_weapon("RedQueen_1.png", 5, 8)
global.spr_rqs = sprite_add("RedQueenSlash.png", 3, 0, 32)
global.wep_b = 
	{
	wep: mod_current, 
	_ammo: 3, 
	name: "flame sword",
	reload: 0,
	}

#define weapon_name		return "RED QUEEN"
#define weapon_sprt		return global.spr	//lq_defget(argument0, "_ammo", global.spr) ? global.spr_r : global.spr

#define weapon_type		return 4
#define weapon_melee	return true
#define weapon_auto		return lq_defget(argument0, "_ammo", 1) ? true : false
#define weapon_load		return lq_defget(argument0, "_ammo", 8) ? 8 : 24
#define weapon_cost		return 0	//lq_defget(argument0, "_ammo", 6) ? 0 : 0
#define weapon_area		return 9
#define weapon_swap		return sndSwapMotorized

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"A gaint sword runs by gasoline. "



#define weapon_fire
if(is_object(wep))
	{
	var dx = skill_get(13) ? x : x-lengthdir_x(16, gunangle)
	var dy = skill_get(13) ? y : y-lengthdir_y(16, gunangle)
	if(wep._ammo >= 1)
		{
		sound_play_hit(sndFlare, 0.3)
		with(instance_create(dx, dy, Slash))
			{
			direction = other.gunangle+irandom_range(10, -10)
			image_angle = direction
			
			//sprite_index = global.spr_rqs
			sprite_index = sprMegaSlash
			mask_index = mskMegaSlash
			image_blend = c_red
			
			creator = other
			team = other.team
			damage = 24
			image_speed = skill_get(mut_boiling_veins) ? 0.2 : 0.4
			}
		wep.reload = 6
		wep._ammo --
		weapon_post(-6, -12, 0)
		}
	else{
		with(instance_create(dx, dy, Slash))
			{
			direction = other.gunangle
			image_angle = direction
			
			//sprite_index = global.spr_rqs
			sprite_index = sprMegaSlash
			mask_index = mskMegaSlash
			
			creator = other
			team = other.team
			damage = 18
			}
		wepangle = -wepangle
		weapon_post(6, -12, 0)
		}
	var s = sound_play_hit(sndBlackSword, 0)
	audio_sound_pitch(s, 0.5)
	motion_add(gunangle, maxspeed)
	}

#define weapon_reloaded
	{
	if(argument0)
		{
		if(!is_object(wep))
			{wep = lq_clone(global.wep_b)}
		if(wep._ammo >= 1)
			{}
		else{
			if(ammo[4] >= 6)
				{
				wep._ammo += 3
				ammo[4] -= 6
				scrRQ_reflame()
				sound_play_hit(sndSwapMotorized, 0.3)
				}
			else{
				if(ammo[4] >= 2)
					{
					wep._ammo = ammo[4] div 2
					ammo[4] = ammo[4] mod 2
					}
				else{}
				}
			}
		}
	else{
		if(!is_object(bwep))
			{bwep = lq_clone(global.wep_b)}
		if(bwep._ammo >= 1)
			{}
		else{
			if(ammo[4] >= 6)
				{
				bwep._ammo += 3
				ammo[4] -= 6
				scrRQ_reflame()
				sound_play_hit(sndSwapMotorized, 0.3)
				}
			else{
				if(ammo[4] >= 2)
					{
					bwep._ammo = ammo[4] div 2
					ammo[4] = ammo[4] mod 2
					}
				else{}
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
		wepflip = right
		if(wep.reload>0)
			{
			wepangle += (right?-45:45)*current_time_scale
			//scrRQ_motorflame(wep.reload)
			wep.reload -= 1*current_time_scale
			}
		else{wepangle = sign(wepangle)?120:-120}
		}
	else{
		if(!is_object(bwep))
			{bwep = lq_clone(global.wep_b)}
		bwepflip = right
		if(bwep.reload>0)
			{
			bwepangle += (right?-45:45)*current_time_scale
			//scrRQ_motorflame(bwep.reload)
			bwep.reload -= 1*current_time_scale
			}
		else{bwepangle = sign(bwepangle)?120:-120}
		}
	}

#define scrRQ_motorflame(a)
repeat(3){with(instance_create(x,y,TrapFire))
	{
	direction = other.gunangle + a*60 + random(20)
	speed = irandom_range(3, 4)
	image_angle = direction
	
	creator = other
	team = other.team
	}}

#define scrRQ_reflame
for(var i=0; i<360; i+=20){with(instance_create(x, y, Flame))
	{
	direction = i+irandom(10)
	speed = random_range(3, 4)
	image_angle = direction
	
	creator = other
	team = other.team
	damage = 24
	}}