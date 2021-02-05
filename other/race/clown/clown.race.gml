#define init
	{
	set=
		[
		//	[idle],									[walk],									[hurt],									[dead],									[hurt],									[dead],									[lowa],											[lowh],											[chst],											[wrld],											[valt],											[crwn],											[thrn],											[spch],											[idpd],											[cptn]											[swep]
			[sprite_add("Aidle.png", 15, 12, 12),	sprite_add("Awalk.png", 6, 12, 12),		sprite_add("Ahurt.png", 3, 12, 12),		sprite_add("Adead.png", 6, 12, 12),		[sndGruntHurtF,		sndGruntHurtM],		[sndGruntDeadF,		sndGruntDeadM],		[sndGruntEnterF,		sndGruntEnterM],		[sndGruntEnterF,		sndGruntEnterM],		[sndGruntEnterF,		sndGruntEnterM],		[sndGruntEnterF,	sndGruntEnterM],			[sndGruntEnterF,		sndGruntEnterM],		[sndGruntEnterF,		sndGruntEnterM],		[sndGruntEnterF,		sndGruntEnterM],		[sndGruntEnterF,		sndGruntEnterM],		[sndGruntEnterF,		sndGruntEnterM],		[sndGruntEnterF,		sndGruntEnterM],		sprPopoGun				],
			[sprite_add("Aidle2.png", 15, 12, 12),	sprite_add("Awalk2.png", 6, 12, 12),	sprite_add("Ahurt2.png", 3, 12, 12),	sprite_add("Adead2.png", 6, 12, 12),	sndEliteGruntHurt,						sndEliteGruntDead,						sndEliteGruntEnter,								sndEliteGruntEnter,								sndEliteGruntEnter,								sndEliteGruntEnter,								sndEliteGruntEnter,								sndEliteGruntEnter,								sndEliteGruntEnter,								sndEliteGruntEnter,								sndEliteGruntEnter,								sndEliteGruntEnter,								sprElitePopoGun			],
			[sprite_add("Bidle.png", 15, 12, 12),	sprite_add("Bwalk.png", 6, 12, 12),		sprite_add("Bhurt.png", 3, 12, 12),		sprite_add("Bdead.png", 6, 12, 12),		[sndShielderHurtF,	sndShielderHurtM],	[sndShielderDeadF,	sndShielderDeadM],	[sndShielderShieldF,	sndShielderShieldM],	[sndShielderShieldF,	sndShielderShieldM],	[sndShielderEnterF,		sndShielderEnterM],		[sndShielderEnterF,	sndShielderEnterM],			[sndShielderEnterF,		sndShielderEnterM],		[sndShielderEnterF,		sndShielderEnterM],		[sndShielderEnterF,		sndShielderEnterM],		[sndShielderEnterF,		sndShielderEnterM],		[sndShielderShieldF,	sndShielderShieldM],	[sndShielderEnterF,		sndShielderEnterM],		sprPopoHeavyGun			],
			[sprite_add("Bidle2.png", 15, 12, 12),	sprite_add("Bwalk2.png", 6, 12, 12),	sprite_add("Bhurt2.png", 3, 12, 12),	sprite_add("Bdead2.png", 6, 12, 12),	sndEliteShielderHurt,					sndEliteShielderDead,					sndEliteShielderEnter,							sndEliteShielderEnter,							sndEliteShielderEnter,							sndEliteShielderEnter,							sndEliteShielderEnter,							sndEliteShielderEnter,							sndEliteShielderEnter,							sndEliteShielderEnter,							sndEliteShielderEnter,							sndEliteShielderEnter,							sprPopoPlasmaMinigun	],
			[sprite_add("Cidle.png", 15, 12, 12),	sprite_add("Cwalk.png", 6, 12, 12),		sprite_add("Churt.png", 3, 12, 12),		sprite_add("Cdead.png", 6, 12, 12),		[sndInspectorHurtF,	sndInspectorHurtM],	[sndInspectorDeadF,	sndInspectorDeadM],	[sndInspectorStartF,	sndInspectorStartM],	[sndInspectorEndF,	sndInspectorEndM],			[sndInspectorEnterF,	sndInspectorEnterM],	[sndInspectorEnterF,	sndInspectorEnterM],	[sndInspectorEnterF,	sndInspectorEnterM],	[sndInspectorEnterF,	sndInspectorEnterM],	[sndInspectorEnterF,	sndInspectorEnterM],	[sndInspectorEnterF,	sndInspectorEnterM],	[sndInspectorEnterF,	sndInspectorEnterM],	[sndInspectorEnterF,	sndInspectorEnterM],	sprPopoSlugger			],
			[sprite_add("Cidle2.png", 15, 12, 12),	sprite_add("Cwalk2.png", 6, 12, 12),	sprite_add("Churt2.png", 3, 12, 12),	sprite_add("Cdead2.png", 6, 12, 12),	sndEliteInspectorHurt,					sndEliteInspectorDead,					sndEliteInspectorStart,							sndEliteInspectorAlarmed,						sndEliteInspectorEnter,							sndEliteInspectorEnter,							sndEliteInspectorEnter,							sndEliteInspectorAlarmed,						sndEliteInspectorAlarmed,						sndEliteInspectorEnter,							sndEliteInspectorAlarmed,						sndEliteInspectorEnd,							sprEnergyBaton			]
		]
	pcdx = [0,0,0,0]
	pcdy = [0,0,0,0]
	
	globalvar set, pcdx, pcdy
	
	global.chs = sprite_add("CharSelect.png", 1, 0, 0)
	}

#define popo(a)
	{
	po = a
	image_speed_raw = 0.4
		
	spr_idle = set[a,0]
	spr_walk = set[a,1]
	spr_hurt = set[a,2]
	spr_dead = set[a,3]
	spr_sit1 = set[a,0]
	spr_sit2 = set[a,0]
	if(a mod 2)
		{
		snd_hurt = set[a,4]
		snd_dead = set[a,5]
		snd_lowa = set[a,6]
		snd_lowh = set[a,7]
		snd_chst = set[a,8]
		snd_wrld = set[a,9]
		snd_valt = set[a,10]
		snd_crwn = set[a,11]
		snd_thrn = set[a,12]
		snd_spch = set[a,13]
		snd_idpd = set[a,14]
		snd_cptn = set[a,15]
		}
	else{
		gd=irandom(1)
		snd_hurt = set[a,4][gd]
		snd_dead = set[a,5][gd]
		snd_lowa = set[a,6][gd]
		snd_lowh = set[a,7][gd]
		snd_chst = set[a,8][gd]
		snd_wrld = set[a,9][gd]
		snd_valt = set[a,10][gd]
		snd_crwn = set[a,11][gd]
		snd_thrn = set[a,12][gd]
		snd_spch = set[a,13][gd]
		snd_idpd = set[a,14][gd]
		snd_cptn = set[a,15][gd]
		}
	spr_swep = set[a,16]
	}

#define create
	{
	maxhealth -= 4
	popo(irandom(2)*2)
	GameCont.CMcommand[index] = 2
	global.targeta[index] = noone
	}

#define step
	{
	with(instances_matching(enemy, "pcd", undefined))
		{
		raddrop = raddrop>>1
		pcd = true
		}
	scrPopoSpawn()
	scrPopoMark()
	scrPopoSkill()
	scrPopoList()
	with(instances_matching(CustomObject,"ntstype","ClownMark")){if(GameCont.CMcommand[index] == 1){instance_destroy()}}
	with(instances_matching(CustomObject,"ntstype","ClownMarkFire")){if(GameCont.CMcommand[index] == 1){instance_destroy()}}
	}

#define scrPopoSpawn
	{
	if(variable_instance_get(TopCont, `PCsummon_${index}`, true) && GameCont.area!="market")
		{
		if(ultra_get("clown",2))
			{repeat(GameCont.loops*2 + 5){popof(irandom(2)*2+1, maxhealth)}}
		else{
			if(GameCont.level == 10)
				{repeat(GameCont.loops*2 + 5){popof(irandom(5), maxhealth)}}
			else{repeat(GameCont.level/2 + 5){popof(irandom(2)*2, maxhealth)}}
			}
		with(enemy){with(instance_create(x, y, object_index))
			{
			var vn = variable_instance_get_names(other)
			var vn_len = array_length(vn)
			for(var i=0; i<vn_len; i++)
				{
				var v = variable_instance_get(other, vn[i], null)
				if(scrNoOnlyRead(vn[i], v))
					{variable_instance_set(self, vn[i], v)}
				}
			}}
		variable_instance_set(TopCont, `PCsummon_${index}`, false)
		}
	
	with(RadChest)
		{
		instance_create(x, y, RogueChest)
		instance_delete(self)
		}
	with(RogueChest)
		{
		if(distance_to_object(instance_nearest(x, y, Player)) <= 4)
			{
			event_perform(ev_collision, Player)
			with(other)
				{
				if(ultra_get("clown",2))
					{repeat(GameCont.loops*2 + 5){popof(irandom(2)*2+1, maxhealth)}}
				else{
					if(GameCont.level == 10)
						{repeat(GameCont.loops*2 + 5){popof(irandom(5), maxhealth)}}
					else{repeat(GameCont.level/2 + 5){popof(irandom(2)*2, maxhealth)}}
					}
				}
			}
		}
	}

#define scrNoOnlyRead(b, a)
if(a!=undefined && a!=null){return (b!="sprite_width" && b!="sprite_height" && b!="sprite_xoffset" && b!="sprite_yoffset" && b!="image_number" && b!="bbox_left" && b!="bbox_right" && b!="bbox_top" && b!="bbox_bottom" && b!="object_index" && b!="id")}

#define scrPopoMark
	{
	if(button_pressed(index,"spec") && canspec)
		{
		if(GameCont.CMcommand[index] == 2)
			{
			with(instances_matching(CustomObject, "ntstype", "ClownMark"))
				{if(index == other.index){instance_destroy()}}
			with(instance_create(mouse_x[index], mouse_y[index], CustomObject))
				{
				ntstype = "ClownMark"
				creator = other
				index = other.index
				sprite_index = sprEmoteIndicator
				image_index = 2
				image_speed = 0
				image_xscale = 2
				image_yscale = 2
				depth = -17
				}
			}
		if(GameCont.CMcommand[index] == 4)
			{
			with(instances_matching(CustomObject, "ntstype", "ClownMarkFire"))
				{if(index == other.index){instance_destroy()}}
			with(instance_create(mouse_x[index], mouse_y[index], CustomObject))
				{
				ntstype = "ClownMarkFire"
				creator = other
				index = other.index
				sprite_index = sprEmoteIndicator
				image_index = 4
				image_speed = 0
				image_xscale = 2
				image_yscale = 2
				depth = -17
				}
			}
		}
	}

#define scrPopoSkill
	{
	if(skill_get(5))
		{
		scrPopoSkill_p()
		scrPopoSkill_c()
		GameCont.CMcommand[index] = 1
		}
	else{for(var Ki=1; Ki<5; Ki++){if(button_released(index, `key${Ki}`)){GameCont.CMcommand[index] = Ki}}}
	}

#define scrPopoSkill_p
	{
	if(button_pressed(index, "spec") && canspec){switch(po*2 + ultra_get("clown",2))
		{
		case 0: 
			with(instance_create(x, y, PopoExplosion))
				{
				direction = random(360)
				creator = other
				team = other.team
				hitid = [other.spr_hurt, other.alias]
				}
			sound_play_hit(sndIDPDNadeExplo, 0.3)
			my_health -= 1
			lasthit = [spr_hurt, alias]
			break
		
		case 1: 
			with(instance_create(x,y,PopoExplosion))
				{
				direction = random(360)
				creator = other
				team = other.team
				hitid = [other.spr_hurt, other.alias]
				image_xscale *= 2
				image_yscale *= 2
				damage *= 2
				}
			sound_play_hit(sndIDPDNadeExplo, 0.3)
			my_health -= 1
			lasthit = -1
			break
		
		case 2: 
			with(instance_create(x, y, PopoRocket))
				{
				direction = other.gunangle
				creator = other
				index = other.index
				team = other.team
				hitid = [other.spr_hurt, other.alias]
				}
			sound_play_hit(sndEliteGruntRocketFire, 0.3)
			my_health -= 1
			lasthit = [spr_hurt, alias]
			break
		
		case 3: 
			with(instance_create(x, y, PopoRocket))
				{
				direction = other.gunangle
				creator = other
				index = other.index
				team = other.team
				hitid = [other.spr_hurt, other.alias]
				damage *= 10
				}
			sound_play_hit(sndEliteGruntRocketFire, 0.3)
			my_health -= 1
			lasthit = [spr_hurt, alias]
			break
		
		case 4: 
			if(array_length(instances_matching(PopoShield,"index",index)))
				{
				with(instance_create(x,y,PopoShield))
					{
					creator = other
					team = other.team
					index = other.index
					}
				sound_play_hit(sndShielderDeflect, 0.3)
				}
			break
			
		case 5: 
			if(array_length(instances_matching(PopoShield,"index",index)))
				{
				with(instance_create(x,y,PopoShield))
					{
					creator = other
					team = other.team
					index = other.index
					}
				sound_play_hit(sndShielderDeflect, 0.3)
				}
			break
			
		case 6: 
			if(array_length(instances_matching(PopoShield,"index",index)))
				{
				if(place_meeting(mouse_x[index], mouse_y[index], Floor) && !place_meeting(mouse_x[index], mouse_y[index], Wall))
					{
					x = mouse_x[index]
					y = mouse_y[index]
					}
				with(instance_create(x, y, PopoShield))
					{
					creator = other
					team = other.team
					index = other.index
					}
				sound_play_hit(sndShielderDeflect, 0.3)
				}
			break
			
		case 7: 
			if(array_length(instances_matching(PopoShield, "index", index)))
				{
				if(place_meeting(mouse_x[index], mouse_y[index], Floor) && !place_meeting(mouse_x[index], mouse_y[index], Wall))
					{
					x = mouse_x[index]
					y = mouse_y[index]
					}
				with(instance_create(x, y, PopoShield))
					{
					creator = other
					team = other.team
					index = other.index
					}
				sound_play_hit(sndShielderDeflect, 0.3)
				}
			break
			
		default: break
		}}
	}

#define scrPopoSkill_c
	{
	if(button_check(index,"spec")&&canspec){switch(po*2+ultra_get("clown",2))
		{
		case 8: 
			with(projectile){var a=point_direction(x,y,other.x,other.y); x+=lengthdir_x(speed/4, a+90); y+=lengthdir_y(speed/4, a+90);}
			break;
		case 9: 
			with(projectile){var a=point_direction(x,y,other.x,other.y); x+=lengthdir_x(speed/2, a+90); y+=lengthdir_y(speed/2, a+90);}
			break;
		case 10: 
			with(projectile){var a=point_direction(x,y,other.x,other.y); x+=lengthdir_x(speed/2, a-90); y+=lengthdir_y(speed/2, a-90);}
			break;
		case 11: 
			with(projectile){var a=point_direction(x,y,other.x,other.y); x+=lengthdir_x(speed, a-90); y+=lengthdir_y(speed, a-90);}
			break;
		default: break;
		}}
	}

#define scrPopoList
	{
	var list = ds_list_create()
	
	with(instances_matching(CustomProp, "ntstype", "PopoClown"))
		{ds_list_add(list, self)}
	
	var listsize = ds_list_size(list)
	
	if((my_health<=0 && candie) || (button_check(index, "pick") && button_pressed(index, "swap")))
		{
		if(listsize > 0)
			{
			var c = ds_list_find_value(list, irandom(listsize - 1))
			popof(po, my_health)
			x = c.x
			y = c.y
			popo(c.po)
			my_health = c.my_health
			instance_delete(c)
			}
		else{sound_play_hit(snd_lowh, 0.3)}
		}
	
	with(instances_matching(PopoRocket, "index", index))
		{
		image_angle = direction
		if(ultra_get("clown",2)){with(instance_nearest(x, y, enemy))
			{other.direction = point_direction(other.x, other.y, x, y)}}
		}
	with(instances_matching(PopoShield, "index", index))
		{
		with(creator){if(place_free(other.x, other.y)){with(other)
			{
			direction = other.direction
			speed = other.speed
			if(!ultra_get("clown",2)){speed /= 2}
			}}
		else{with(other)
			{
			speed = 0
			with(instance_create(x, y, CrystalShieldDisappear))
				{sprite_index = sprShielderShieldDisappear}
			instance_destroy()
			}}}
		}
	
	// - There to test
	//if(button_pressed(index,"horn")){popof(5,maxhealth)}
	
	global.targeta[index] = noone
	if(!(instance_exists(Generator) && instance_exists(Nothing)))
		{global.targeta[index] = instance_nearest(mouse_x[index], mouse_y[index], enemy)}
	with(instances_matching(CustomObject, "ntstype", "ClownMarkFire")){global.targeta[index] = self}

	ds_list_destroy(list)
	}

#define popof
	{
	with(instance_create(x, y, CustomProp))
		{
		mask_index = mskPlayer
		depth = -2
		
		creator = other
		index = other.index
		team = other.team
		my_health = argument1
		maxhealth = other.maxhealth
		
		popo(argument0)
		
		ntstype = "PopoClown"
		
		spr_shadow = shd24
		spr_shadow_x = 0
		spr_shadow_y = 0
		wkick = 0
		gunangle = 0
		target = noone
		wepangle = (po==5) ? 120 : random(360)
		rl = 0
		popat = 0
		on_step = PCAI
		return self
		}
	}

#define PCAI
	{
	if(wkick>=0){wkick = max(wkick - current_time_scale, 0)}
	if(wkick<=0){wkick = min(wkick + current_time_scale, 0)}
	if(rl >= 0){rl -= current_time_scale}
	
	target = global.targeta[index]
	if(instance_exists(projectile) && po==5)
		{
		var dis = 256
		with(instances_matching_ne(projectile, "team", team))
			{
			var d = distance_to_object(other)
			if(d < dis)
				{
				other.target = self
				dis = d
				}
			}
		}
	
	if(instance_exists(creator))
		{
		popath()
		switch(GameCont.CMcommand[index])
			{
			case 2: 
				maxspeed = 4
				speed += 2 * current_time_scale
				if(distance_to_point(dx, dy) > 16)
					{mp_potential_step(dx, dy, speed, 0)}
				break
			
			case 3: 
				maxspeed = 0
				break
			
			default: 
				maxspeed = 4
				speed += 2 * current_time_scale
				if(instance_exists(creator)){if(distance_to_point(dx, dy) > 64)
					{mp_potential_step(dx, dy, speed, 0)}}
				break
			}
		}
	
	if(instance_exists(target)){if(!collision_line(x, y, target.x, target.y, Wall, false, false))
		{
		gunangle = point_direction(x, y, target.x, target.y)
		pofire()
		}}
	else{gunangle = direction}
	right = (gunangle<90||gunangle>270) ? 1 : -1

	speed = clamp(speed, 0, maxspeed)
	
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
	script_bind_draw(dr_wep, (gunangle<180)?depth-0.1:depth+0.1, self)
	}

#define popath
	{
	if(popat > 0){popat -= current_time_scale}
	else{
		popat = 30
		var cm = false
		with(instances_matching(instances_matching(CustomObject, "ntstype", "ClownMark"), "index", index))
			{
			pcdx[index] = x
			pcdy[index] = y
			cm = true
			}
		if(cm)
			{
			dx = pcdx[index]
			dy = pcdy[index]
			}
		else{
			dx = x
			dy = y
			if(instance_exists(creator))
				{
				dx = creator.x + random_range(-32,32)
				dy = creator.y + random_range(-32,32)
				}
			}
		}
	}

#define pofire
	{
	if(rl <= 0)
		{
		switch(po)
			{
			case 0: 
				popo_fire(IDPDBullet, 3, 15, 4, 6, 3, sndGruntFire)
				break
			case 1: 
				popo_fire(IDPDBullet, 5, 15, 3, 4, 3, sndGruntFire)
				break
			case 2: 
				popo_fire(IDPDBullet, 15, 15, 3, 4, 3, sndGruntFire)
				break
			case 3: 
				with(popo_fire(PopoPlasmaBall, 3, 1, 6, 9, 3, sndEliteShielderFire))
					{if(skill_get(17)){damage = 6}}
				break
			case 4: 
				with(popo_fire(PopoSlug, 0, 20, 9, 18, 6, sndGruntFire))
					{damage = 22}
				break
			case 5: 
				with(popo_fire(EnergySlash, 0, skill_get(13)?4:2, 9, 12, 0, sndEliteInspectorFire))
					{damage = 12}
				break
			default: break
			}
		}
	}

#define popo_fire(obj, ac, sp, rle, rmo, wk, snd)
	{
	rl = ultra_get("clown",1) ? rle : rmo
	sound_play_hit(snd, 0.3)
	wkick = wk
	with(instance_create(x, y, obj))
		{
		direction = random_range(ac, -ac) + other.gunangle
		image_angle = direction
		speed = sp
		creator = other
		team = other.team
		hitid = [other.spr_idle, "popo clown"]
		return self
		}
	}

#define dr_wep(a)
with(a){draw_sprite_ext(spr_swep, 0, x-lengthdir_x(wkick,gunangle), y-lengthdir_y(wkick,gunangle), 1, right, gunangle, image_blend, image_alpha)}
instance_destroy()



#define draw

#define race_name
return "clown";
#define race_text
return "hard game with team work#e+space to switch#1234 key to command";
/*
#define race_portrait
return global.portrait;
#define race_mapicon
return global.mapicon;
*/
#define race_swep
return 13;

#define race_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock
return "defeat captain";

#define race_menu_button
sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}
#define race_menu_select
var a=set[irandom(5)][irandom_range(6,15)]
if(array_length(a)){return a[irandom(1)]}
else{return a}
#define race_menu_confirm
var a=set[irandom(5)][irandom_range(6,15)]
if(array_length(a)){return a[irandom(1)]}
else{return a}
/*
#define race_skins
return 2;
#define race_skin_button
switch(argument0)
	{
	case 0: sprite_index = global.spr_dead; image_index=5; break;
	case 1: sprite_index = global.spr_deadb; image_index=5; break;
	default: break;
	}
*/
#define race_tb_text
return "use diffrent ability#no command";
#define race_tb_take

#define race_ultra_name
switch(argument0)
	{
	case 1: return "anarchism";break;
	case 2: return "centralism";break;
	default: return "";break;
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return "stronger team rate";break;
	case 2: return "stronger partner#powerful throne butt";break;
	default: return "";break;
	}

#define race_ultra_button
switch(argument0)
	{
	case 1: return ;break;
	case 2: return ;break;
	default: return ;break;
	}

#define race_ultra_take
switch(argument0)
	{
	case 1: break;
	case 2: break;
	default: break;
	}
/*
#define race_ultra_icon
switch(argument0)
	{
	case 1: sprite_index  =  ;
	case 2: sprite_index  =  ;
	default: sprite_index  =  ;
	}
*/
#define race_ttip
return [];
