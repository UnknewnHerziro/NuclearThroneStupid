#define init
global.icon = sprite_add("Icon.png", 1, 8, 8)
global.skill = sprite_add("Skill.png", 1, 12, 16)
global.sprPurge = sprite_add("purge.png", 5, 4, 4)

#define game_start

#define skill_take
if(instance_exists(LevCont))
	{sound_play(sndUncurse)}

#define skill_lose

#define step
	{
	with(Player)
		{
		if(!instance_exists(variable_instance_get(self, "nts_pd_defmem", noone)))
			{
			nts_pd_cd = variable_instance_get(self, "nts_pd_cd", 0) - current_time_scale
			if(nts_pd_cd <= 0)
				{create_defmem()}
			}
		}
	}

#define create_defmem
	{
	with(instance_create(x, y, CustomSlash))
		{
		other.nts_pd_defmem = self
		
		image_xscale = 2
		image_yscale = 2
		
		creator	= other
		team	= other.team
		
		typ = 0
		candeflect = true
		
		on_anim		= ref_none
		on_draw		= ref_none
		on_step		= step_defmem
		on_destroy	= des_defmem
		
		on_wall			= ref_none
		on_hit			= ref_none
		on_grenade		= proj_defmem
		on_projectile	= proj_defmem
		}
	
	}

#define step_defmem
	{
	with(creator)
		{
		other.sprite_index = mask_index
		other.mask_index = mask_index
		other.x = x
		other.y = y
		other.direction = direction
		other.speed = speed
		
		with(instance_create(x, y, Curse))
			{sprite_index = global.sprPurge}
	/*	
		script_bind_end_step(es_mask, 0, self, mask_index)
		mask_index = mskNone
	*/	
		exit
		}
	instance_destroy()
	}

#define es_mask
	{
	with(argument0)
		{mask_index = argument1}
	instance_destroy()
	}

#define des_defmem
	{
	with(creator)
		{
		nts_pd_defmem = noone
		nts_pd_cd = 30
		}
	}

#define proj_defmem
	{
	var proj = other
	var defmem = self
	
	with(creator)
		{
		with(proj)
			{
			switch(typ)
				{
				case 1: 
					{
					var dir = direction
					
					team		= other.team
					direction	= point_direction(other.x, other.y, x, y)
					image_angle	= image_angle + direction - dir
					
					with(instance_create(x, y, Deflect))
						{image_angle = other.direction}
					
					break
					}
				case 2: 
					{
					instance_destroy()
					break
					}
				default: exit
				}
			
			with(defmem)
				{
				sound_play_hit(sndCrystalRicochet, 0.3)
				with(instance_create(x, y, CustomSlash))
					{
					sprite_index	= sprRogueExplosion
					mask_index		= mskExplosion
					image_speed		= 0.4
					image_index		= 1
					
					creator	= other.creator
					team	= other.team
					
					typ = 0
					candeflect = true
					
				//	on_anim		= ref_destroy
					on_draw		= ref_none
					on_step		= step_wave
					
					on_wall			= ref_none
					on_hit			= ref_none
					on_grenade		= proj_wave
					on_projectile	= proj_wave
					}
				instance_destroy()
				}
			}
		}
	}

#define step_wave
	{
	with(creator)
		{
		other.x = x
		other.y = y
		other.direction = direction
		other.speed = speed
		
		exit
		}
	instance_destroy()
	}

#define proj_wave
	{
	with(other)
		{
		switch(typ)
			{
			case 1: 
				{
				var dir = direction
				
				team = other.team
				
				with(other.creator)
					{other.direction = point_direction(x, y, other.x, other.y)}
				image_angle	= image_angle + direction - dir
				
				with(instance_create(x, y, Deflect))
					{image_angle = other.direction}
				
				break
				}
			case 2: 
				{
				instance_destroy()
				break
				}
			default: exit
			}
		}
	sound_play_hit(sndCrystalRicochet, 0.3)
	}

#define ref_none



#define skill_name		return `PURGED DHATUYO`
#define skill_text		return `@sDEFENSIVE MEMBRANE#RECHARGES PER SECOND`
#define skill_tip		return []
#define skill_icon		return global.icon
#define skill_button	sprite_index = global.skill

#define skill_wepspec	return false
#define skill_avail		return variable_instance_get(GameCont, instance_exists(LevCont) ? "lastarea" : "area", 0) == 104