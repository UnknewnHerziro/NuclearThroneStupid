#define init
	{
	global.spr_idle = sprite_add("idle.png", 4, 12, 12)
	global.spr_walk = sprite_add("walk.png", 6, 12, 12)
	global.spr_hurt = sprite_add("hurt.png", 3, 12, 12)
	global.spr_dead = sprite_add("dead.png", 6, 12, 12)
	global.spr_idleb = sprite_add("idleb.png", 4, 12, 12)
	global.spr_walkb = sprite_add("walkb.png", 6, 12, 12)
	global.spr_hurtb = sprite_add("hurtb.png", 3, 12, 12)
	global.spr_deadb = sprite_add("deadb.png", 6, 12, 12)
	global.portrait = sprite_add("portrait.png", 1, 35, 200)
	global.portraitb = sprite_add("portraitb.png", 1, 36, 236)
	global.mapicon = sprite_add("map.png", 1, 10, 10)
	global.chs = sprite_add("CharSelect.png", 1, 0, 0)
	global.EGI1 = sprite_add("Icon1.png", 1, 9, 9)
	global.EGI2 = sprite_add("Icon2.png", 1, 9, 9)
	global.EG1 = sprite_add("Skill1.png", 1, 12, 16)
	global.EG2 = sprite_add("Skill2.png", 1, 12, 16)
	
	global.AllWep = ds_list_create()
	
	globalvar sprColorlessAmmo, sprColorlessChest, sprColorlessChestOpen, sprColorlessChestBig, sprColorlessChestBigOpen
	sprColorlessAmmo			= sprite_add("ColorlessAmmo.png",			7,	5,	5)
	sprColorlessChest			= sprite_add("ColorlessChest.png",			7,	8,	7)
	sprColorlessChestOpen		= sprite_add("ColorlessChestOpen.png",		1,	8,	7)
	sprColorlessChestBig		= sprite_add("ColorlessChestBig.png",		7,	12,	13)
	sprColorlessChestBigOpen	= sprite_add("ColorlessChestBigOpen.png",	1,	12,	13)
	}

#define clean_up
	{
	ds_list_destroy(global.AllWep)
	}

#define nts_weapon_examine	return 
	{
	"0":	"Heavy justice. ", 
	"13":	"Too new. ", 
	"89":	"Not bad. Just like the old one. ", 
	"92":	"Carry radiation to the Palace... ", 
	}



#define game_start		if(wep=="rusty shovel" && bwep==0){bwep="bullet shotgun"; ammo[2]=24}

#define create
	{
	image_speed_raw = 0.4
	if(bskin)
		{
		spr_idle = global.spr_idleb
		spr_walk = global.spr_walkb
		spr_hurt = global.spr_hurtb
		spr_dead = global.spr_deadb
		spr_sit1 = global.spr_idleb
		spr_sit2 = global.spr_idleb
		}
	else{
		spr_idle = global.spr_idle
		spr_walk = global.spr_walk
		spr_hurt = global.spr_hurt
		spr_dead = global.spr_dead
		spr_sit1 = global.spr_idle
		spr_sit2 = global.spr_idle
		}

	snd_hurt= sndHitPlant
	snd_dead= sndHitFlesh
	snd_lowa= -1
	snd_lowh= -1
	snd_chst= -1
	snd_wrld= -1
	snd_valt= -1
	snd_crwn= -1
	snd_thrn= -1
	snd_spch= -1
	snd_idpd= -1
	snd_cptn= -1
	nts_color_blood = [c_white, c_black]
	}

#define step
	{
	with(Floor){if(distance_to_object(other)<32 && random(1)<0.1*current_time_scale)
		{instance_create(x+random(sprite_width), y+random(sprite_height), RainDrop)}}
	scrReplace(AmmoPickup,		Pickup,		cl_ammo_set,		cl_ammo_step)
	scrReplace(BigCursedChest,	chestprop,	cl_chest_big_set,	cl_chest_big_step)
	scrReplace(BigWeaponChest,	chestprop,	cl_chest_big_set,	cl_chest_big_step)
	scrReplace(WeaponChest,		chestprop,	cl_chest_set,		cl_chest_step)

	if(canspec and button_pressed(index,"spec"))
		{
		sound_play_hit(sndPortalOpen, 0.3)
		with(instance_create(x,y,CustomObject))
			{
			team = other.team
			index = other.index
			
			ntstype = "DiggerGrave"
			nts_dge = []
			nts_dgp = []
			
			sprite_index = sprReviveArea
			mask_index = mskReviveArea
			image_blend = 0
			image_speed = 0.4
			
			on_step = scrGraveAI
			on_draw = scrGraveDraw
			on_destroy = scrGraveDestroy
			}
		}

	if(ultra_get("digger", 1)){with(instance_create(x, y-6, Curse)){image_blend = 0}}
	}



#define scrReplace(obj, new, set, ref)
	{
	with(obj)
		{
		with(instance_create(x, y, new))
			{
			script_execute(set)
			script_bind_step(ref, 0, self)
			}
		instance_delete(self)
		}
	}

#define cl_ammo_set
	{
	sprite_index	= sprColorlessAmmo
	image_speed_raw	= 0.4
	pickup_target	= noone
	}

#define cl_ammo_step
	{
	with(argument0)
		{
		if(speed > 0){exit}
		
		pickup_time = variable_instance_get(self, "pickup_time", 0) + current_time_scale
		
		if(instance_exists(pickup_target))
			{
			move_contact_solid(point_direction(x, y, pickup_target.x, pickup_target.y), 6*current_time_scale)
			if(place_meeting(x, y, pickup_target) || place_meeting(x, y, Portal))
				{
				with(pickup_target)
					{
					pick_say("ALL ++")
					for(var i=1; i<6; i++)
						{ammo[i] = min(ammo[i] + ceil(typ_ammo[i] / (ultra_get("digger",2)?1:2)), typ_amax[i])}
					}
				instance_create(x, y, SmallChestPickup)
				sound_play_hit(sndAmmoPickup, 0)
				instance_destroy()
				break
				}
			}
		else{
			with(instance_nearest(x, y, Player)){if(distance_to_object(other)<=(skill_get(3)?64:16) || instance_exists(Portal) || place_meeting(x, y, other))
				{other.pickup_target = self}}
			}
		
		if(pickup_time >= (skill_get("pw")?420:210))
			{
			if((pickup_time mod 10) <= current_time_scale)
				{image_alpha = !image_alpha}
			if(pickup_time >= (skill_get("pw")?600:300))
				{
				instance_create(x, y, SmallChestFade)
				sound_play_hit(sndPickupDisappear, 0)
				instance_destroy()
				break
				}
			}
		
		exit
		}
	instance_destroy()
	}

#define cl_chest_set
	{
	sprite_index	= sprColorlessChest
	spr_shadow		= shd24
	spr_shadow_x	= 0
	spr_shadow_y	= -1
	}

#define cl_chest_step
	{
	with(argument0)
		{
		if(place_meeting(x, y, Player))
			{
			with(instance_create(x, y, ChestOpen))
				{sprite_index = sprColorlessChestOpen}
			instance_create(x, y, FXChestOpen)
			sound_play_hit(sndCursedReminder, 0)
			
			var a = weapon_get_list(global.AllWep, 3, GameCont.hard+3)
			if(!a){var a = weapon_get_list(global.AllWep, 3, 3)}
			with(instance_create(x, y, WepPickup))
				{
				ammo	= 0
				wep		= ds_list_find_value(global.AllWep, irandom(a-1))
				}
			repeat(2){with(instance_create(x, y, Pickup))
				{
				cl_ammo_set()
				script_bind_step(cl_ammo_step, 0, self)
				}}
			
			instance_destroy()
			break
			}
		exit
		}
	instance_destroy()
	}

#define cl_chest_big_set
	{
	sprite_index	= sprColorlessChestBig
	spr_shadow		= shd32
	spr_shadow_x	= 0
	spr_shadow_y	= 0
	}

#define cl_chest_big_step
	{
	with(argument0)
		{
		if(place_meeting(x, y, Player))
			{
			with(instance_create(x, y, ChestOpen))
				{sprite_index = sprColorlessChestBigOpen}
			instance_create(x, y, FXChestOpen)
			sound_play_hit(sndCursedReminder, 0)
			
			var a = weapon_get_list(global.AllWep, 5, GameCont.hard+5)
			if(!a){var a = weapon_get_list(global.AllWep, 5, 5)}
			repeat(5){with(instance_create(x, y, WepPickup))
				{
				ammo	= 0
				wep		= ds_list_find_value(global.AllWep, irandom(a-1))
				}}
			repeat(5){with(instance_create(x, y, Pickup))
				{
				cl_ammo_set()
				script_bind_step(cl_ammo_step, 0, self)
				}}
			
			instance_destroy()
			break
			}
		exit
		}
	instance_destroy()
	}

#define create_cl_chest_big
	{
	with(instance_create(argument0, argument1, chestprop))
		{
		cl_chest_big_set()
		script_bind_step(cl_chest_big_step, 0, self)
		return self
		}
	}



#define scrGraveAI
	{
	with(enemy){if(object_index!=ScrapBoss and object_index!=LilHunter and object_index!=Nothing and object_index!=Nothing2 and object_index!=FrogQueen and object_index!=HyperCrystal and object_index!=TechnoMancer and object_index!=Last)
		{
		if(place_meeting(x, y, other))
			{move_towards_point(other.x, other.y, (skill_get(5)?4:1) * current_time_scale)}
		if(skill_get(5) and collision_point(other.x, other.y, self, 0, 0))
			{
			var vn = variable_instance_get_names(self)
			var vn_len = array_length(vn)
			with(other)
				{
				var dg_len = array_length(nts_dge)
				nts_dge[dg_len, 0] = other.object_index
				nts_dge[dg_len, 1] = vn
				nts_dge[dg_len, 2] = []
				for(var i=0; i<vn_len; i++)
					{array_push(nts_dge[dg_len][2], variable_instance_get(other, vn[i]))}
				}
			instance_delete(self)
			}
		}}

	if(ultra_get("digger",1))
		{
		image_xscale = 1.5
		image_yscale = 1.5
		with(projectile)
			{
			if(place_meeting(x, y, other))
				{
				var GraveSpeed = (skill_get(5)?5:3) * current_time_scale
				var hole_dr = point_direction(x, y, other.x, other.y);
				x += lengthdir_x(GraveSpeed, hole_dr)
				y += lengthdir_y(GraveSpeed, hole_dr)
				}
			if(skill_get(5) and collision_point(other.x, other.y, self, 0, 0) && (typ==1 || typ==2))
				{
				var vn = variable_instance_get_names(self)
				var vn_len = array_length(vn)
				with(other)
					{
					var dg_len = array_length(nts_dgp)
					nts_dgp[dg_len, 0] = other.object_index
					nts_dgp[dg_len, 1] = vn
					nts_dgp[dg_len, 2] = []
					for(var i=0; i<vn_len; i++)
						{array_push(nts_dgp[dg_len][2], variable_instance_get(other, vn[i]))}
					}
				instance_delete(self)
				}
			}
		}
	
	if(button_pressed(index,"spec"))
		{
		instance_destroy()
		exit
		}
	
	if(!instance_exists(enemy) && !instance_exists(Portal) && array_length(instances_matching_ne(Player, "team", team))==0)
		{instance_destroy()}
	}

#define scrGraveDestroy
	{
	var dge_len = array_length(nts_dge)-1
	var dgp_len = array_length(nts_dgp)-1
	while(dge_len >= 0)
		{
		var vn = nts_dge[dge_len, 1]
		var vn_len = array_length(vn)
		with(instance_create(x,y,nts_dge[dge_len,0]))
			{
			for(var i=0; i<vn_len; i++)
				{
				if(scrNoOnlyRead(vn[i], other.nts_dge[dge_len][2][i]))
					{variable_instance_set(self, vn[i], other.nts_dge[dge_len][2][i])}
				}
			}
		dge_len --
		}
	while(dgp_len >= 0)
		{
		var vn = nts_dgp[dgp_len, 1]
		var vn_len = array_length(vn)
		with(instance_create(x,y,nts_dgp[dgp_len,0]))
			{
			for(var i=0; i<vn_len; i++)
				{
				if(scrNoOnlyRead(vn[i], other.nts_dgp[dgp_len][2][i]))
					{variable_instance_set(self, vn[i], other.nts_dgp[dgp_len][2][i])}
				}
			team = -1
			direction = random(360)
			image_angle = direction
			}
		dgp_len --
		}
	with(instance_create(x,y,ReviveFX)){image_blend=0};
	sound_play_hit(sndPortalOpen, 0.3)
	}

#define scrNoOnlyRead(b, a)
if(a!=undefined && a!=null){return (b!="sprite_width" && b!="sprite_height" && b!="sprite_xoffset" && b!="sprite_yoffset" && b!="image_number" && b!="bbox_left" && b!="bbox_right" && b!="bbox_top" && b!="bbox_bottom" && b!="object_index" && b!="id")}

#define scrGraveDraw
draw_sprite_ext(shd32, 0, x, y, 1, 1, 0, c_white, 1)
draw_self()



#define draw

#define race_name
return "DIGGER";
#define race_text
return "@sGLOOMY @wAND COLORLESS#CAN @sDIG GRAVES";

#define race_portrait
switch(argument1)
	{
	case 0: return global.portrait;break;
	case 1: return global.portraitb;break;
	default: return global.portraitb;break;
	}

#define race_mapicon
return global.mapicon;

#define race_swep
return "rusty shovel";
#define race_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock
return "defeat ??? in 4-?";

#define race_menu_button
sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}
#define race_menu_select
return sndPortalOpen
#define race_menu_confirm
return sndPortalClose

#define race_skins
return 2;
#define race_skin_avail
var a = false
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){a = lq_defget(v.skin, mod_current, false)}
	}
switch(argument0)
	{
	case 0: return true; break;
	case 1: return a; break;
	default: break;
	}
#define race_skin_name
switch(argument0)
	{
	case 0: return "skin a"; break;
	case 1: 
		if(race_skin_avail(1))
			{return "skin b - burier#by yanshan"}
		else{return "reach ???"}
		break
	default: break;
	}
#define race_skin_button
switch(argument0)
	{
	case 0: sprite_index = global.spr_dead; image_index=5; break;
	case 1: sprite_index = global.spr_deadb; image_index=5; break;
	default: break;
	}

#define race_tb_text
return "@sGRAVES ENGOLF @wENEMIES";
#define race_tb_take

#define race_ultra_name
switch(argument0)
	{
	case 1: return "EGOTISM";break;
	case 2: return "GROUPISM";break;
	default: return "";break;
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return "LARGER @sGRAVES#GRAVES TOW @wPROJECTILES";break;
	case 2: return "GETS DOUBLE @sCOLORLESS AMMO";break;
	default: return "";break;
	}

#define race_ultra_button
switch(argument0)
	{
	case 1: sprite_index  =  global.EG1; break;
	case 2: sprite_index  =  global.EG2; break;
	default: break;
	}

#define race_ultra_take
switch(argument0)
	{
	case 1: break;
	case 2: break;
	default: break;
	}

#define race_ultra_icon
switch(argument0)
	{
	case 1: return global.EGI1;break;
	case 2: return global.EGI2;break;
	default: return ;break;
	}

#define race_ttip
return []

#define pick_say
with(instance_create(x, y, PopupText))
	{mytext = argument0}
