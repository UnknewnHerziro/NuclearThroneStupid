#define init
	{
	globalvar snd, sprfg, sprfge, sprwb, /*sprwo,*/ sprwt, sprdx, sprdxh, sprdy, sprdyh, mskdy//, sprb, sprbd
	
	snd = sound_add("sndLEVEL1.ogg")
	sprfg	= sprite_add("sprFloorG1.png",		4,	0,	0)
	sprfge	= sprite_add("sprFloorG1Explo.png",	8,	0,	0)
	sprwb	= sprite_add("sprWallG1Bot.png",	6,	0,	0)
	//sprwo	= sprite_add("sprWallG1Out.png",	1,	2,	2)
	sprwt	= sprite_add("sprWallG1Top.png",	8,	0,	0)

	sprdx	= sprite_add("sprDoorX.png",		1,	16,	16)
	sprdxh	= sprite_add("sprDoorXHurt.png",	1,	16,	16)
	sprdy	= sprite_add("sprDoorY.png",		1,	16,	16)
	sprdyh	= sprite_add("sprDoorYHurt.png",	1,	16,	16)
	mskdy	= sprite_add("mskDoorY.png",		1,	16,	16)

	//sprb = sprite_add("sprBar.png",1,16,16)
	//sprbd = sprite_add("sprBarDead.png",1,16,16)
	}

#define area_name		return "sj-" + string(argument0)

#define area_secret		return false

#define area_sprite(q)
switch (q) {
    case sprFloor1: return sprfg
    case sprFloor1B: return sprfg
    case sprFloor1Explo: return sprfge
    case sprWall1Trans: return sprwt
    case sprWall1Bot: return sprwb
//    case sprWall1Out: return sprwo
    case sprWall1Out: return mskNone
    case sprWall1Top: return sprwt
    case sprDebris1: return sprDebris0
}

#define area_finish
	{
	/*
	if(area = "dungeon" && subarea<3){lastarea = "dungeon"; lastsubarea=subarea; subarea+=1}
	else{lastarea = "dungeon"; lastsubarea=3; area = 2; subarea = 1;  GameCont.hard-=3;}
	*/
	lastarea = "dungeon"
	lastsubarea = 1
	area = 2
	subarea = 1
	GameCont.hard --
	}

//for supporting ntte
#define area_background_color return make_color_rgb(99, 125, 156)

#define area_setup
	{
	background_color = area_background_color()
	BackCont.shadcol = make_color_rgb(18, 0, 20)
	TopCont.darkness = true
	TopCont.fog = sprFog2
	sound_play_music(snd)
	sound_play_ambient(amb7)
	}

#define area_make_floor
	{
	instance_create(x, y, Floor)
	var turn = irandom(16)
	switch(turn)
		{
		case 0: 
			ox = x; oy = y;
			road(4);
			dx = x; dy = y;
			for(xi=-1;xi<2;xi++)
				{
				x=dx+xi*32;
				for(yi=-1;yi<2;yi++){y=dy+yi*32; instance_create(x,y,Floor)}
				}
			x=dx; y=dy;
			instance_create(x+16, y+16, WeaponChest);
			x=ox; y=oy;
			direction+=choose(90,-90);
			instance_create(x, y, FloorMaker);
			break;
		case 2:
			dx=x; dy=y;
			road(4);
			instance_create(x+16, y+16, WeaponChest);
			x=dx; y=dy;
			direction+=180;
			break;
		case 3:
			instance_create(x, y, FloorMaker)
			instance_create(x, y, Floor);
			break;
		default: 
			if(!irandom(3)){direction+=choose(90,-90)}; 
			instance_create(x, y, Floor); 
			break;
		}
	}

#define road
repeat(argument0)
	{
	repeat(2)
		{
		switch(direction)
			{
			case 0: x+=32; break;
			case 90: y-=32; break;
			case 180: x-=32; break;
			case 270: y+=32; break;
			default: break;
			}; 
		instance_create(x,y,Floor);
		}
	if(direction==0 || direction=180){Door(0)}else{Door(1)}; 
	}

#define Door
with(instance_create(x+16, y+16, CustomProp))
	{
	spr_idle = sprdy
	spr_hurt = sprdyh; 
	if(argument0)
		{
		mask_index = mskdy
		type = 1
		spr_shadow = shd48
		}
	else{
		if(!mod_exists("mod", "NT3D"))
			{
			spr_idle = sprdx
			spr_hurt = sprdxh
			}
		mask_index = sprdx
		type = 0
		}
	image_speed_raw=0.4; snd_hurt = sndHitMetal; my_health=12; solid=1; team=0; depth=-2; start=0; ntstype="Door"; hitid=55;
	on_step = script_ref_create(DoorClose)
	on_death = script_ref_create(DoorDestroy)
	}

#define DoorClose
sprite_index = spr_idle
if(instance_exists(Wall)&&start)
	{
	if(type){if(!(place_meeting(x+1,y,Wall)||place_meeting(x-1,y,Wall))){my_health=0}}
	else{if(!(place_meeting(x,y+1,Wall)||place_meeting(x,y-1,Wall))){my_health=0}}
	}

#define DoorDestroy
with(instance_create(x,y,Explosion)){hitid = other.hitid}
if(!irandom(3)){instance_create(x, y, AmmoPickup)}
sound_play_hit(sndExplosion, 0)



#define area_pop_enemies
if(GameCont.loops)
	{
	if !irandom(3) instance_create(x+16, y+16, Molefish);
	if !irandom(3) instance_create(x+16, y+16, Bandit);
	if !irandom(31) instance_create(x+16, y+16, Molesarge);
	if !irandom(31) instance_create(x+16, y+16, Gator);
	if !irandom(63) instance_create(x+16, y+16, BuffGator);
	if !irandom(23) instance_create(x+16, y+16, FireBaller);
	if !irandom(47) instance_create(x+16, y+16, SuperFireBaller);
	if !irandom(63) instance_create(x+16, y+16, Jock);
	}
else{
	if(!place_meeting(x, y, CustomProp))
		{
		if !irandom(2) instance_create(x+16, y+16, Molefish);
		if !irandom(2) instance_create(x+16, y+16, Bandit);
		if !irandom(23) instance_create(x+16, y+16, Molesarge);
		if !irandom(23) instance_create(x+16, y+16, Gator);
		if !irandom(31) with(instance_create(x+16, y+16, CustomEnemy)){ntstype="wimic"}
		}
	}
#define area_pop_props
if !irandom(17) && point_distance(x,y,10000,10000)>128 instance_create(x+16, y+16, MeleeFake);
if !irandom(15) instance_create(x+16, y+16, BonePile)
//if !irandom(15) instance_create(x+16, y+16, PlantPot)
if !irandom(23) with(instance_create(x+16, y+16, Corpse)){sprite_index = choose(sprBanditDead, sprMeleeDead, sprGatorDead, sprBuffGatorDead, sprMolefishDead, sprMolesargeDead)}

#define area_start
with(instances_matching(CustomProp,"ntstype","Door"))
	{
	start=1;
	if(type)
		{if(!(place_meeting(x+1,y,Wall)||place_meeting(x-1,y,Wall))||point_distance(x,y,10016,10016)<96){instance_delete(self)}}
	else{if(!(place_meeting(x,y+1,Wall)||place_meeting(x,y-1,Wall))||point_distance(x,y,10016,10016)<96){instance_delete(self)}}
	}
with(Floor){if !irandom(31) && point_distance(x,y,10000,10000)>128 && !place_meeting(x,y,Wall) instance_create(x+16, y+16, WeaponChest)}
if(GameCont.loops){with(instance_furthest(10000, 10000, Floor)){with(instance_create(x, y, CustomEnemy))
	{
	mod_script_call("area", "helipad", "God_create")
	snd_dead = sndMutant6Dead
	on_death = god_death
	spr_dead = mod_variable_get("area", "helipad", "sprGod").sprite.spr_execute
	}}}

#define god_death
	{
	sound_play_hit(snd_dead, 0)
	instance_create(x, y, VenuzAmmoSpawn)
	}



#define area_mapdata(lx, ly, lp, ls, ws, ll)
/*
switch(ws)
	{
	case 1: return [9, -9, 1, 1]; break;
	case 2: return [18, -9, 0, 1]; break;
	case 3: return [27, -9, 0, 1]; break;
	default: return [lx+9, -9, 0, 1]; break;
	}
*/

return [27, -9, 1, 1]; 
