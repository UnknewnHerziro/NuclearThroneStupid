
#define init
	{
	global.spr_idle		= sprite_add("idle.png",		4,	12,	20)
	global.spr_walk		= sprite_add("walk.png",		6,	12,	20)
	global.spr_hurt		= sprite_add("hurt.png",		3,	12,	20)
	global.spr_dead		= sprite_add("dead.png",		14,	32,	48)/*
	global.spr_idleb	= sprite_add("idleb.png",		4,	12,	12)
	global.spr_walkb	= sprite_add("walkb.png",		6,	12,	12)
	global.spr_hurtb	= sprite_add("hurtb.png",		3,	12,	12)
	global.spr_deadb	= sprite_add("deadb.png",		6,	12,	12)
	global.portrait		= sprite_add("portrait.png",	1,	35,	200)
	global.portraitb	= sprite_add("portraitb.png",	1,	36,	236)*/
	global.mapicon		= sprite_add("mapicon.png",		1,	10,	10)
	global.chs			= sprite_add("CharSelect.png",	1,	0,	0)
	global.EGI1			= sprite_add("Icon1.png",		1,	9,	9)
	global.EGI2			= sprite_add("Icon2.png",		1,	9,	9)/*
	global.EG1			= sprite_add("Skill1.png",		1,	12,	16)
	global.EG2			= sprite_add("Skill2.png",		1,	12,	16)*/
	
	global.mapUBtext = ds_map_create()
		global.mapUBtext[?crwn_death]		= "@sALL @wEXPLOSION @sBECOME @gDEFENCE@s"
		global.mapUBtext[?crwn_life]		= "@wHARD TO BE KILLED@s"
		global.mapUBtext[?crwn_haste]		= "@wATTRACT DROPS @sAND @gRADS@s"
		global.mapUBtext[?crwn_guns]		= "@wGROUND FIRE@s"
		global.mapUBtext[?crwn_hatred]		= "@sDEAL DAMAGE TO @wENEMIES#@sWHEN GETTING @gRADS@s"
		global.mapUBtext[?crwn_blood]		= "@wENEMIES @gEXPLODE @sON DEATH"
		global.mapUBtext[?crwn_destiny]		= "@sLESS @wBOSSES' @rHEALTH@s"
		global.mapUBtext[?crwn_love]		= "@sPEACEFUL @gGUARDIANS@s"
		global.mapUBtext[?crwn_luck]		= "@sCHANCE TO @wAVOID DEATH@s"
		global.mapUBtext[?crwn_curses]		= "@sAUTO @pCRYSTAL @sSHIELD"
		global.mapUBtext[?crwn_risk]		= "@sSOME @gRADS @wREGENRATE @rHP@s"
		global.mapUBtext[?crwn_protection]	= "@gDEFEND @sWHEN HURTING"
	
	global.mapUBtext_tb = ds_map_create()
		global.mapUBtext_tb[?crwn_life]			= `${race_tb_text_common}#@wLESS DEATH COST@s`
		global.mapUBtext_tb[?crwn_guns]			= `@sHIGHER @wGROUND RATE@s`
		global.mapUBtext_tb[?crwn_hatred]		= `${race_tb_text_common}#@sMORE @gRADS @wDAMAGE@s`
		global.mapUBtext_tb[?crwn_blood]		= `${race_tb_text_common}#@sBIGGER @gDEFENCE EXPLODE@s`
		global.mapUBtext_tb[?crwn_destiny]		= `${race_tb_text_common}#@sEVEN LESS @wBOSSES' @rHEALTH@s`
		global.mapUBtext_tb[?crwn_luck]			= `${race_tb_text_common}#@sMORE CHANCE TO @wAVOID DEATH@s`
		global.mapUBtext_tb[?crwn_curses]		= `${race_tb_text_common}#@wEMERGENCY TELEPORTATION@s`
		global.mapUBtext_tb[?crwn_risk]			= `${race_tb_text_common}#@sMORE CHANCE TO @wREGENRATE @rHP@s`
		global.mapUBtext_tb[?crwn_protection]	= `${race_tb_text_common}#@sLONGER HURTING @gDEFEND@s`
	}

#define clear_up
	{
	ds_map_destroy(global.mapUBtext)
	ds_map_destroy(global.mapUBtext_tb)
	}

#define nts_weapon_examine	return 
	{
	"0":	"Thy fists. Bring punishment. ", 
	}



#define game_start
	{
	for(var i=0; i<13; i++)
		{global.aryUltra[i]=0}
	GameCont.norads = max(GameCont.norads, 1)
	}

#define create
	{
	image_speed_raw = 0.4
	spr_idle = global.spr_idle
	spr_walk = global.spr_walk
	spr_hurt = global.spr_hurt
	spr_dead = global.spr_dead
	spr_sit1 = global.spr_idle
	spr_sit2 = global.spr_idle
	snd_hurt = sndHitRock
	snd_dead = sndScorpionDie
	snd_lowa = sndScorpionMelee
	snd_lowh = sndScorpionMelee
	snd_chst = -1
	snd_wrld = sndScorpionMelee
	snd_valt = sndScorpionMelee
	snd_crwn = sndScorpionMelee
	snd_thrn = -1
	snd_spch = -1
	snd_idpd = -1
	snd_cptn = -1
	nts_color_blood = [make_color_rgb(190, 253, 8),	make_color_rgb(54, 156, 17)]
	
	nts_guard_deflect = false
	nts_guard_deflect_cd = 40
	
	}

#define step
	{
	GameCont.norads = max(GameCont.norads, 1)
	with(GuardianStatue){instance_create(x, y, OldGuardianStatue); instance_delete(self)}
	with(CrownGuardian){instance_create(x, y, CrownGuardianOld); instance_delete(self)}
	
	if(ultra_get(mod_current, 1))
		{
		
		}
	
	if(ultra_get(mod_current, 2))
		{
		if(is_string(crown_current) ? mod_script_call("crown", crown_current, "nts_guard_ultra") : mod_script_call("race", mod_current, `ub_${crown_current}`))
			{exit}
		else{}
		}
	
	guard_spec()
	}



#define guard_spec	if canspec
	{
	nts_guard_deflect_cd = max(0, nts_guard_deflect_cd-current_time_scale)
	if(nts_guard_deflect_cd <= 5)
		{
		if(button_check(index, "spec"))
			{nts_guard_deflect = true}
		if(nts_guard_deflect && nts_guard_deflect_cd<=0)
			{
			with(instance_create(x, y, GuardianDeflect))
				{
				direction	= other.gunangle
				image_speed	= 0.4
				creator		= other
				team		= other.team
				
				if(skill_get(mut_throne_butt))
					{
					image_xscale = 2
					image_yscale = 2
					other.nts_guard_deflect_cd = 40
					var len = 32
					}
				else{
					other.nts_guard_deflect_cd = 20
					var len = 16
					}
				
				script_bind_end_step(end_step_deflect, 0, self, other, lengthdir_x(len, other.gunangle), lengthdir_y(len, other.gunangle))
				}
			
			sound_play_hit(sndScorpionMelee, 0.3)
			
			nts_guard_deflect = false
			}
		}
	}

#define end_step_deflect(def, crt, xos, yos)
	{
	with(crt){with(def)
		{
		x = crt.x + xos
		y = crt.y + yos
		exit
		}}
	instance_destroy()
	}



#define ub_2	//DEATH
	{
	with(Explosion)
		{
		var scale = ub_2a()
		instance_change(GuardianDeflect, true)
		image_xscale = scale
		image_yscale = scale
		team	= other.team
		force	= 16
		}
	
	return false
	}
#define ub_2a
	{
	switch(object_index)
		{
		case Explosion: return 1.5
		case GreenExplosion: return 2
		case SmallExplosion: return 1
		case PopoExplosion: return 3
		default: return 0
		}
	}


#define ub_3	//LIFE
	{
	var cost = skill_get(mut_throne_butt) ? 1 : 2
	
	while(my_health<=0 && maxhealth>cost)
		{
		maxhealth -= cost
		chickendeaths += cost
		my_health += cost
		}
	
	return false
	}


#define ub_4	//HASTE
	{
	if(instance_exists(Portal))
		{return false}
	
	with(instance_create(x, y, GameObject))
		{
		instance_change(Portal, false)
		mask_index = mskNone
		type = 1
		endgame = 100
		timer = 0
		script_bind_end_step(ub_4_es, 0, self)
		}
	
	return false
	}
#define ub_4_es
	{
	with(argument0)
		{instance_destroy()}
	instance_destroy()
	}


#define ub_5	//GUNS
	{
	var ox	= x
	var oy	= y
	var w	= wep
	var r	= reload
	var h	= my_health
	var wa	= wepangle
	var wk	= wkick
	var wf	= wepflip
	var cs	= can_shoot
	var dir	= direction
	var spd	= speed
	
	wepangle = 0
	
	with(WepPickup)
		{
		if(variable_instance_get(self, "nts_guard_ub_fail", false))
			{continue}
		
		nts_guard_ub_reload = variable_instance_get(self, "nts_guard_ub_reload", 30) - current_time_scale
		
		if(!other.canspec)
			{continue}
		
		if(point_seen(x, y, other.index))
			{
			if	(
				(button_pressed(other.index, "spec") || (button_check(other.index, "spec") && weapon_get_auto(wep))) && 
				other.ammo[@weapon_get_type(wep)] >= weapon_get_cost(wep) && 
				GameCont.rad >= weapon_get_rads(wep)
				)	{
					with(other)
						{
						var rot = other.rotation
						
						if(canaim)
							{other.rotation = point_direction(other.x, other.y, mouse_x[index], mouse_y[index])}
						
						if(other.nts_guard_ub_reload <= 0)
							{
							x			= other.x
							y			= other.y
							wep			= other.wep
							gunangle	= other.rotation
							
							direction	= other.direction
							speed		= other.speed
							
							specfiring	= true
							
							try	{
								player_fire()
								if(wep == wep_none)
									{
									with(other)
										{instance_destroy()}
									}
								else{
									other.wep = wep
									other.nts_guard_ub_reload = weapon_get_load(wep) * (skill_get(mut_throne_butt) ? 0.5 : 1)
									}
								}
							catch(error)
								{
								other.nts_guard_ub_fail = true
								other.rotation = rot
								}
							}
						}
					}
			}
		
		}
	
	x			= ox
	y			= oy
	wep			= w
	reload		= max(r, 0)
	my_health	= h
	wepangle	= wa
	wkick		= wk
	wepflip		= wf
	can_shoot	= cs
	direction	= dir
	speed		= spd
	
	return true
	}


#define ub_6	//HATRED
	{
	script_bind_end_step(ub_6_es, 0, index, GameCont.rad, team)
	
	return false
	}
#define ub_6_es
	{
	var r	= GameCont.rad - argument1
	var dmg	= skill_get(mut_throne_butt) ? 2 : 1
	
	with(instances_matching_ne(enemy, "team", argument2))
		{
		if(r <= 0)
			{break}
		if(point_seen(x, y, argument0))
			{
			projectile_hit_raw(self, dmg, 1)
			r --
			}
		}
	instance_destroy()
	}


#define ub_7	//BLOOD
	{
	var p = self
	with(instances_matching_le(enemy, "my_health", 0))
		{
		with(instance_create(x, y, GuardianDeflect))
			{
			if(!skill_get(mut_throne_butt))
				{
				image_xscale = 0.5
				image_yscale = 0.5
				}
			direction = random(360)
			force = 16
			
			creator	= p
			team	= p.team
			}
		}
	
	return false
	}


#define ub_8	//DESTINY
	{
	with(instances_matching(instances_matching_ne(enemy, "intro", null), "nts_guard_destiny", null))
		{
		my_health *= skill_get(mut_throne_butt) ? 0.6 : 0.8
		nts_guard_destiny = true
		}
	
	return false
	}


#define ub_9	//LOVE
	{
	with(Guardian){alarm1 = -1}
	with(ExploGuardian){alarm1 = -1}
	with(DogGuardian){alarm1 = -1}
	
	return false
	}


#define ub_10	//LUCK
	{
	if(my_health <= 0)
		{
		if(random(1) > (skill_get(mut_throne_butt) ? 0.75 : 0.5))
			{
			my_health = 1
			sound_pitch(sound_play_hit(sndStrongSpiritGain, 0), 0.5)
			}
		}
	
	return false
	}


#define ub_11	//CURSES
	{
	if(!instance_exists(variable_instance_get(self, "nts_guard_shield", noone)))
		{
		with(instance_create(x, y, CustomSlash))
			{
			other.nts_guard_shield = self
			
			mask_index = mskShield
			
			creator	= other
			team	= other.team
			typ		= 0
			
			candeflect	= true
			noshield	= false
			
			on_anim		= ref_none
			on_draw		= ref_none
			on_step		= ub_11_step
			
			on_wall			= ref_none
			on_hit			= ref_none
			on_grenade		= ub_11_proj
			on_projectile	= ub_11_proj
			}
		}
	
	return false
	}
#define ub_11_step
	{
	noshield = false
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
#define ub_11_proj
	{
	if(noshield)
		{exit}
	
	var type = other.typ
	with(creator)
		{
		switch(type)
			{
			case 1: 
			case 2: 
				{
				if(array_length(instances_matching(CrystalShield, "creator", self)) == 0)
					{
					other.noshield = true
					script_bind_step(ub_11_bs, 0, self)
					}
				exit
				}
			default: exit
			}
		}
	}
#define ub_11_bs
	{
	with(argument0)
		{
		with(instance_create(x, y, CrystalShield))
			{
			creator	= other
			team	= other.team
		//	walk	= skill_get(mut_throne_butt)
			time	= 45
			}
		}
	instance_destroy()
	}


#define ub_12	//RISK
	{
	script_bind_end_step(ub_12_es, 0, self, GameCont.rad)
	
	return false
	}
#define ub_12_es
	{
	if(GameCont.rad > argument1)
		{
		with(argument0)
			{
			repeat(GameCont.rad - argument1)
				{
				if(random(1) < (skill_get(mut_throne_butt) ? 0.015 : 0.01))
					{
					my_health += 1
					instance_create(x, y, FrogHeal)
					sound_play_hit(sndBloodlustProc, 0.3)
					
					if(my_health >= maxhealth)
						{
						my_health = maxhealth
						with(instance_create(x, y, PopupText))
							{mytext = "@gMAX HP"}
						break
						}
					else{
						with(instance_create(x, y, PopupText))
							{mytext = "@g+1 HP"}
						}
					}
				}
			}
		}
	
	instance_destroy()
	}


#define ub_13	//PROTECTION
	{
	script_bind_end_step(ub_13_es, 0, self, my_health)
	
	return false
	}
#define ub_13_es
	{
	with(argument0){if(my_health < argument1)
		{
		with(instance_create(x, y, GuardianDeflect))
			{
			image_xscale	= 4
			image_yscale	= 4
			direction		= other.gunangle
			image_speed		= skill_get(mut_throne_butt) ? 0.3 : 0.4
			creator			= other
			team			= other.team
			
			script_bind_end_step(end_step_deflect, 0, self, other, 0, 0)
			}
		
		sound_play_hit(sndScorpionMelee, 0.3)
		}}
	instance_destroy()
	}


#define ref_none



#define race_name
return "GUARD"
#define race_text
return "@wBIG @gRAD @wCHEST#CAN @gDEFEND@w"
/*
#define race_portrait
return global.portrait*/
#define race_mapicon
return global.mapicon

#define race_swep
return "rusty buckler"

#define race_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock
return "defeat ???"

#define race_menu_button
sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}
#define race_menu_select
return sndScorpionMelee
#define race_menu_confirm
return sndScorpionMelee
/*
#define race_skins
return 2
#define race_skin_name(skin)
switch(argument0)
	{
	case 0: return 
	case 1: return 
	default: break
	}
#define race_skin_button
switch(argument0)
	{
	case 0: sprite_index = ; break
	case 1: sprite_index = ; break
	default: break
	}
*/
#define race_tb_text
	{
	if(ultra_get(mod_current, 2))
		{
		if(is_string(crown_current))
			{var str = mod_script_call("crown", crown_current, "nts_guard_tb_text")}
		else{var str = global.mapUBtext_tb[?crown_current]}
		
		if(is_string(str))
			{return str}
		}
	return race_tb_text_common
	}

#macro	race_tb_text_common		"@gDEFENCE @sBIGGER AND SLOWER"

#define race_ultra_name
switch(argument0)
	{
	case 1: return "UNCROWNED KING"
	case 2: return "UNLIMITED LORD"
	default: return ""
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return "@sFREE @gMUTATION@s"
	case 2: 
		{
		if(ultra_get(mod_current, argument0))
			{
			if(is_string(crown_current))
				{var str = mod_script_call("crown", crown_current, "nts_guard_text")}
			else{var str = global.mapUBtext[?crown_current]}
			
			if(is_string(str))
				{return `@sABILITY DECIDED BY @wCROWN#@s${str}`}
			}
		return "@sABILITY DECIDED BY @wCROWN"
		}
	default: return ""
	}

#define race_ultra_button
sprite_index = sprCrownSelect
switch(argument0)
	{
	case 1: image_index = 1; exit
	case 2: image_index = 0; exit
	default: exit
	}

#define race_ultra_take
switch(argument0)
	{
	case 1: GameCont.skillpoints++; break
	case 2: break
	default: break
	}

#define race_ultra_icon
switch(argument0)
	{
	case 1: return global.EGI1
	case 2: return global.EGI2
	default: return -1
	}

#define race_ttip
return []
