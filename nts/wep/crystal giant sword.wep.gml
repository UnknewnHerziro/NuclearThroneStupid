#define init 
global.spr		= sprite_add("CrystalGiantSword.png",		7,	5,	7)

global.sprColAppear		= sprite_add("CrystalColumnAppear.png",			8,	5,	23)
global.sprColDisappear	= sprite_add("CrystalColumnDisappear.png",		3,	5,	23)
global.sprColChange		= sprite_add("CrystalColumnChangeCross.png",	8,	13,	42)
global.sprCroDisappear	= sprite_add("CrystalCrossDisappear.png",		3,	13,	42)

global.sprCslash	= mod_variable_get("weapon", "crystal rapier", "sprCslash")

#define weapon_sprt		return global.spr

#define weapon_name		return "crystal claymore"

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 45
#define weapon_cost		return 0
#define weapon_area		return mod_script_call("weapon", "crystal rapier", "weapon_area")
#define weapon_swap		return sndCrystalShield

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"crystal" : "A giant sword made with yellow crystals that emitting pink light. #When your emotional energy swimming in it, #the pink plasma ball will be fired. ", 
	"chicken" : "Uses like the royal sword. ", 
	"d" : "A giant sword made with yellow crystals that emitting pink light. #When any form of energy swimming in it, #the pink plasma ball will be fired. ", 
	}



#define weapon_fire
	{
	wepflip = -wepflip
	wepangle = -wepangle
	
	sound_play_hit(sndCrystalShield, 0.3)
	weapon_post(20, 12, 1)
	
	with(instances_matching(CustomSlash, "CrystalColumn", index))
		{instance_destroy()}
	
	if(skill_get(mut_long_arms))
		{
		var dis	= 10
		var spd	= 2
		}
	else{
		var dis	= 0
		var spd	= 0
		}
	
	if(string_pos("crystal", weapon_get_name(bwep)) || my_health==maxhealth)
		{
		var iys	= 2
		var cro	= true
		}
	else{
		var iys	= 1.5
		var cro	= false
		}
	
	with(instance_create(x + lengthdir_x(dis, gunangle), y + lengthdir_y(dis, gunangle), Slash))
		{
		sprite_index = global.sprCslash
		image_yscale = choose(iys, -iys)
		image_speed_raw = 0.4
		speed = spd
		damage = 36
		
		direction = other.gunangle
		image_angle = direction
		creator = other
		team = other.team
		}
	
	with(script_bind_step(refColumnCreator, 0, self, cro, gunangle))
		{
		ove = choose(2, -2)
		num = - (ove + sign(ove))
		t	= 1
		}
	
	repeat(3){prt_create(random_range(gunangle+45, gunangle-45), 90, random(1))}
	}

#define refColumnCreator
	{
	if(instance_exists(argument0))
		{
		if(t > 0)
			{
			t -= current_time_scale
			exit
			}
		if(ove ? (num < ove) : (num > ove))
			{
			num += ove ? 1 : -1
			t += 1
			with(instance_create(0, 0, CustomSlash))
				{
				spr_com = global.sprColAppear
				spr_dis = global.sprColDisappear
				image_speed_raw = 0.4
				depth = -8
				damage = 4
				typ = 0
				candeflect = true
				
				cross			= argument1
				true_creator	= argument0
				var angle		= argument2 + other.num * 45
				var dis			= (cross ? 32 : 24) + (skill_get(mut_long_arms) ? 8 : 0)
				off_x			= lengthdir_x(dis, angle)
				off_y			= lengthdir_y(dis, angle)
				
				on_anim			= column_anim
				on_hit			= column_hit
				on_grenade		= column_deflect
				on_projectile	= column_deflect
				on_end_step		= column_end_step
				on_destroy		= column_destroy
				
				column_current()
				sound_play_hit(sndCrystalShield, 0.3)
				exit
				}
			}
		}
	instance_destroy()
	}

#define column_anim
	{
	if(cross)
		{
		spr_com = global.sprColChange
		spr_dis = global.sprCroDisappear
		cross = false
		}
	else{instance_destroy()}
	}

#define column_hit	//if(projectile_canhit_melee(other)){projectile_hit(other, damage, 0, 0)}

#define column_deflect
	{
	with(other)
		{
		switch(typ)
			{
			case 1: 
				var dir = direction
				direction = point_direction(other.x, other.y, x, y)
				image_angle += direction - dir
				team = other.team
				sound_play_hit(sndCrystalRicochet, 0.3)
				exit
				
			case 2: 
				sound_play_hit(sndCrystalRicochet, 0.3)
				instance_destroy()
				exit
				
			default: exit
			}
		}
	}

#define column_end_step
	{
	sprite_index = spr_com
	with(column_current()){exit}
	instance_destroy()
	}

#define column_current
	{
	with(true_creator)
		{
		other.creator		= self
		other.team			= team
		other.CrystalColumn	= index
		
		other.x = x + other.off_x
		other.y = y + other.off_y
		
		return self
		}
	return -4
	}

#define column_destroy
	{
	with(instance_create(x, y, MeleeHitWall))
		{
		sprite_index = other.spr_dis
		image_speed_raw = 0.4
		}
	}


#define step		mod_script_call("weapon", "crystal rapier", "step", argument0)
#define prt_create	mod_script_call("weapon", "crystal rapier", "prt_create", argument0, argument1, argument2)
