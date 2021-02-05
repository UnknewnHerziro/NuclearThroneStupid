#define init
musb = sound_add("Falling Paradise.ogg")
sprfg = sprite_add("sprFloorP3.png",4,0,0)
sprfge = sprite_add("sprFloorP3Explo.png",4,1,1)
sprwb = sprite_add("sprWallP3Bot.png",4,0,0)
sprwo = sprite_add("sprWallP3Out.png",3,4,4)
sprwto = sprite_add("sprWallP3Top.png",4,0,0)
sprwtr = sprite_add("sprWallP3Trans.png",3,0,0)
sprdc = sprite_add("sprP3Decal.png",2,8,24)
sprd3 = sprite_add("sprDebrisP3.png",4,4,4)

globalvar musb, sprfg, sprfge, sprwb, sprwo, sprwto, sprwtr, sprd3, sprdc, sprd3

#define area_name
return "pa-"+string(argument0);

#define area_secret
return true

#define area_sprite(q)
switch (q) {
    case sprFloor1: return sprfg;
    case sprFloor1B: return sprFloor3B;
    case sprFloor1Explo: return sprfge;
    case sprWall1Trans: return sprwtr;
    case sprWall1Bot: return sprwb;
    case sprWall1Out: return sprwo;
//  case sprWall1Out: return mskNone;
    case sprWall1Top: return sprwto;
    case sprDebris1: return sprd3;
}

#define area_finish
if(area = "parad" && subarea<3){lastarea = "parad"; lastsubarea=subarea; subarea+=1}
else{lastarea = "parad"; lastsubarea=3; area = 3; subarea = 3}

//for supporting ntte
#define area_background_color return make_color_rgb(200, 200, 200)
#define area_setup
background_color = area_background_color()
BackCont.shadcol = make_color_rgb(255, 255, 255);
//global.b=irandom(1)
TopCont.darkness = 0;
sound_play_music(musb)
sound_play_ambient(amb7);
mod_script_call("mod", "ntsCont", "scrCharUnlock", "Envoy")



#define area_make_floor

instance_create(x, y, Floor);

var turn = irandom(8);
switch(turn)
	{
	case 0: 
		ox = x; oy = y;
		road(4);
		dx = x; dy = y;
		for(xi=-2;xi<3;xi++)
			{
			x=dx+xi*32;
			for(yi=-2;yi<3;yi++)
				{
				y=dy+yi*32; 
				instance_create(x,y,Floor)
				}
			}
		x=dx; y=dy;
		with(instance_create(x+16, y+16, chestprop)){ntstype="ColorlessChestBig"}
		x=ox; y=oy;
		direction+=choose(90,-90);
		break;
	case 3:
		instance_create(x, y, FloorMaker)
		instance_create(x, y, Floor);
		break;
	default: 
		if(!irandom(1)){direction+=choose(90,-90)}; 
		instance_create(x, y, Floor); 
		break;
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
	}



#define area_pop_enemies
sum(2, Bandit)
sum(3, "envoy")
sum(3, "gaze")

#define sum(rd, obj)
if(!irandom(rd-1))
	{
	if(is_real(obj)){instance_create(x+16, y+16, obj)}
	else{with(instance_create(x+16, y+16, CustomEnemy)){ntstype=obj}}
	}

#define area_pop_props
if !irandom(31) instance_create(x+16, y+16, BonePile)

#define area_start
with(Floor){if !irandom(95) && !place_meeting(x,y,Wall) mod_script_call("race", "digger", "create_cl_chest_big", x+16, y+16)}
with(Wall){if !irandom(63) with(instance_create(x, y, TopDecalDesert)){sprite_index=sprdc}}

#define area_mapdata(lx, ly, lp, ls, ws, ll)
switch(ws)
	{
	case 1: return [lx+9, 9, 1, 1]; break;
	case 2: return [lx+9, 9, 0, 1]; break;
	case 3: return [lx+9, 9, 0, 1]; break;
	default: return [lx+9, 9, 0, 1]; break;
	}
