
//#define area_transit area=mod_current; hard=5

#define init
globalvar mus, sprf, sprGtop, sprGbot, sprWall, bak

mus = sound_add("sndLEVEL4.ogg")
sprf = sprite_add("floorB.png", 1, 0, 0)
sprGtop = sprite_add("G_top.png", 1, 0, 8)
sprGbot = sprite_add("G_bot.png", 1, 0, 0)
//sprGidle = sprite_add("G_idle.png", 1, 0, 8)
//sprGhurt = sprite_add("G_hurt.png", 3, 0, 0)
sprWall = sprite_add("sprWall.png", 3, 0, 0)
bak = sprite_add("bakSky4.png", 1, 0, 0)

#define area_name
return `vm-${argument0}`

#define area_secret
return true

#define area_sprite(q)
switch (q) {
    case sprFloor1: return sprFloor103
    case sprFloor1B: return sprf
    case sprFloor1Explo: return sprFloor103Explo
    case sprWall1Trans: return mskNone
    case sprWall1Bot: return sprWall103Bot
    case sprWall1Out: return sprWall103Out
    case sprWall1Top: return sprWall103Top
    case sprDebris1: return sprDebris103
}

#define area_finish
//lastarea = mod_current
//lastsubarea = subarea
if(subarea >= 2){area = "helipad"}
subarea ++

//for supporting ntte
#define area_background_color return 15921390
#define area_setup
background_color = area_background_color()
BackCont.shadcol = 1310738
TopCont.darkness = false
sound_play_music(mus)
sound_play_ambient(amb103)



#define area_make_floor
if(goal>100 && goal<150)
	{goal += 50}
instance_create(x, y, Floor)

var turn = irandom(32)
switch(turn)
	{
	case 0: 
		var ox = x
		var oy = y
		for(var i=0; i<8; i++)
			{
			switch(direction)
				{
				case 0: x+=32; break
				case 90: y-=32; break
				case 180: x-=32; break
				case 270: y+=32; break
				default: break
				}
			with(instance_create(x, y, Floor))
				{
				var a = self
				if(i > 4)
					{
					sprite_index = sprf
					styleb = true
					}
				}
			}
		with(a)
			{
			sprite_index = sprFloor103
			styleb = false
			nts_mansion_chest = true
			}
		for(var xi=-2; xi<3; xi++){for(var yi=-2; yi<3; yi++)
			{
			with(instance_create(x + xi*32, y + yi*32, Floor))
				{
				if(abs(xi)<2 || abs(yi)<2)
					{nts_mansion_bridge = true}
				sprite_index = sprf
				styleb = true
				}
			}}
		x = ox
		y = oy
		direction += choose(90, -90)
		break
	case 1: 
	case 2: 
	case 3: 
		direction += choose(90, -90)
	case 4: 
	case 5: 
	case 6: 
		road(1)
		break
	case 17: 
	case 18: 
		direction += choose(90, -90)
		instance_create(x, y, FloorMaker)
		with(instance_create(x, y, Floor))
			{nts_mansion_bridge = true}
		break
	default: 
		if(irandom(1)){direction += choose(90,-90)}
		with(instance_create(x, y, Floor))
			{nts_mansion_bridge = true}
		break
	}

#define road
repeat(argument0)
	{
	repeat(2)
		{
		switch(direction)
			{
			case 0: x+=32; break
			case 90: y-=32; break
			case 180: x-=32; break
			case 270: y+=32; break
			default: break
			}
		with(instance_create(x, y, Floor))
			{nts_mansion_bridge = true}
		}
	}


#define area_pop_enemies
if(GameCont.loops)
	{
	sum(3, "chick")
	sum(16, FireBaller)
	sum(16, "baritone")
	sum(24, SuperFireBaller)
	}
else{
	sum(3, "chick")
	sum(16, "baritone")
	sum(16, FireBaller)
	sum(64, Molesarge)
	}

#define sum(rd, obj)
if(!irandom(rd-1))
	{
	if(is_real(obj)){return instance_create(x+16, y+16, obj)}
	else{with(instance_create(x+16, y+16, CustomEnemy)){ntstype=obj; return self}}
	}
return noone

#define area_pop_props
if(styleb && !variable_instance_get(self, "nts_mansion_chest", true))
	{
	sum(32, YVStatue)
	sum(32, MoneyPile)
	sum(64, GoldBarrel)
	}

#define area_start
	{
	with(Wall)
		{
		if(variable_instance_get(instance_nearest(x, y, Floor), "nts_mansion_bridge", false))
			{
			var d = depth
			/*with(instance_create(x+16, y+16, CustomProp))
				{
				spr_idle = sprGidle
				spr_hurt = sprGhurt
				spr_dead = mskNone
				mask_index = other.mask_index
				spr_shadow = mskNone
				image_speed_raw = 0.4
				snd_hurt = sndHitMetal
				my_health = 4
				team = 0
				depth = other.depth
				ntstype = "GlassWindow"
				}*/
			instance_change(InvisiWall, true)
			sprite_index = sprGbot
			//depth = d
			}
		}
	
	with(instances_matching(Floor, "nts_mansion_chest", true))
		{instance_create(x+16, y+16, GoldChest)}
	
	with(enemy){if(place_meeting(x, y, InvisiWall) || !place_free(x, y)){instance_delete(self)}}
	
	//script_bind_end_step(scrThrInvisi, 0)
	script_bind_end_step(scrColInvisi, 0)
	script_bind_draw(drBackground, 12)
	script_bind_draw(drGlassTop, -7)
	}

#define scrThrInvisi
	{
	with(Corpse){glass_thr()}
	with(Debris){glass_thr()}
	with(Pickup){glass_thr()}
	}

#define glass_thr
	{
	if(place_meeting(x, y, InvisiWall))
		{
		x = (x - xprevious) * 2 + x
		y = (y - yprevious) * 2 + y
		xprevious = x
		yprevious = y
		}
	}

#define scrColInvisi
	{
	with(Top){sprite_index = mskNone}
	with(TopSmall){sprite_index = mskNone}
	with(Wall)
		{
		visible = true
		if("nts_mansion_check"!in self)
			{
			nts_mansion_check = (sprite_index == sprWall103Bot) ? (!position_meeting(x, y+16, Wall) && !position_meeting(x, y+16, Floor)) : false
			if(!instance_exists(GenCont)){if(position_meeting(x, y, InvisiWall)){instance_destroy()}}
			}
		}
	/*with(instances_matching(Wall, "nts_mansion_check", null))
		{
		visible = true
		nts_mansion_check = (sprite_index == sprWall103Bot) ? (!position_meeting(x, y+16, Wall) && !position_meeting(x, y+16, Floor)) : false
		if(position_meeting(x, y, InvisiWall)){instance_destroy()}
		}
	with(Wall)
		{if(position_meeting(x, y, InvisiWall)){instance_destroy()}}*/
	with(InvisiWall)
		{
		visible = true
		if(sprite_index == sprGbot)
			{
			if(place_meeting(x, y, projectile))
				{
				sprite_index = mskNone
				sound_play_hit(sndIcicleBreak, 0.3)
				}
			}
		if(place_meeting(x, y, PortalClear))
			{instance_change(Wall, true)}
		}
	//with(Corpse){void_fall()}
	//with(Debris){void_fall()}
	
	with(projectile){if(distance_to_object(instance_nearest(x, y, Floor)) > 999){instance_destroy()}}
	
	if(instance_exists(GenCont) || instance_exists(BigPortal)){exit}
	
	with(instances_matching(enemy, "canfly", false)){col_invisi()}
	with(Pickup){col_invisi()}
	}

#define void_fall
	{
	if(!position_meeting(x, y, Floor))
		{
		var s = 0.02 * current_time_scale
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

#define col_void
	{
	if(!place_meeting(x, y, Floor))
		{
		x = xprevious * 2 - x
		y = yprevious * 2 - y
		direction += 180
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
		draw_sprite(bak, 0, view_xview_nonsync-xos,		view_yview_nonsync)
		draw_sprite(bak, 0, view_xview_nonsync-xos+640,	view_yview_nonsync)
		}
	draw_set_visible_all(true)
	
	with(instances_matching(Wall, "nts_mansion_check", true))//with(Wall){if(!position_meeting(x, y+16, Wall) && !position_meeting(x, y+16, Floor))//
		{
		visible = true
		draw_sprite(sprWall, image_index, x, y)
		}
	
	with(instances_matching(Floor, "object_index", Floor))
		{draw_sprite_ext(sprite_index, image_index, x, y+32, 1, 0.25, 0, c_gray, 1)}
	
	}



#define drGlassTop
	{
	with(InvisiWall)
		{draw_sprite(sprGtop, 0, x, y)}
	}

#define area_mapdata(lx, ly, lp, ls, ws, ll)
return [ws*9 + 36, 9, ws==1, true]
