
#define init
mus = sound_add("The Ode to the Id 2.ogg")

globalvar mus

#define area_name
return "ol-"+string(argument0);

#define area_secret
return false

#define area_sprite(q)
switch (q) {
    case sprFloor1: return sprFloor5;
    case sprFloor1B: return sprFloor5;
    case sprFloor1Explo: return sprFloor6Explo;
    case sprWall1Trans: return sprWall6Trans;
    case sprWall1Bot: return sprWall6Trans;
    case sprWall1Out: return sprWall6Out;
    case sprWall1Top: return sprWall6Top;
    case sprDebris1: return sprDebris6;
}

#define area_finish
lastarea = "outlab"; lastsubarea=1; area = 6; subarea = 1; 
//if(area = "outlab" && subarea<3){lastarea = "outlab"; lastsubarea=subarea; subarea+=1}
//else{lastarea = "outlab"; lastsubarea=3; area = 6; subarea = 1; }

//for supporting ntte
#define area_background_color return make_color_rgb(9, 28, 32)
#define area_setup
background_color = area_background_color()
BackCont.shadcol = 0;
TopCont.darkness = 0;
sound_play_music(mus)
sound_play_ambient(amb5);



#define area_make_floor

instance_create(x, y, Floor);
if(GameCont.loops)
	{
	var turn = irandom(2);
	switch(turn)
		{
		case 0:
			instance_create(x, y, FloorMaker)
			break;
		case 1:
			direction+=choose(90,-90)
		default: 
			break;
		}
	instance_create(x, y, Floor);
	}
else{
	var turn = irandom(4);
	switch(turn)
		{
		case 1: 
			road(4);
			//road(1); instance_create(x, y, Wall); instance_create(x+16, y, Wall); instance_create(x, y+16, Wall); instance_create(x+16, y+16, Wall); road(1); 
			direction+=90;road(1);
			repeat(3){direction-=90; road(1); instance_create(x+16, y+16, WeaponChest); road(1)}
			direction-=90;road(1);
			direction+=90;road(1);
			break;
		case 2:
			road(4); d=choose(90,90);
			repeat(3){direction+=d; road(4); instance_create(x+16, y+16, WeaponChest)}
			break;
		case 3:
			instance_create(x, y, FloorMaker)
			instance_create(x, y, Floor);
			break;
		default: 
			if(irandom(1)){direction+=choose(90,-90)}
			if(irandom(3)){instance_create(x, y, FloorMaker)}
			instance_create(x, y, Floor); 
			break;
		}
	}

#define road
repeat(argument0)
	{
	switch(direction)
		{
		case 0: x+=32; break;
		case 90: y-=32; break;
		case 180: x-=32; break;
		case 270: y+=32; break;
		default: break;
		}; 
	instance_create(x,y,Floor)
	}



#define area_pop_enemies
if(GameCont.loops)
	{
	sum(32, Necromancer)
	sum(24, RhinoFreak)
	sum(32, ExploFreak)
	sum(1, "asnowsin")
	if(!irandom(15)){with(instance_create(x+16, y+16, CustomObject)){ntstype="tankfake"}}
	sum(16, "rhinobot")
	sum(128, GoldSnowTank)
	}
else{
	sum(2, Freak)
	with(sum(4,"fruit")){color=choose("r","g")}
	sum(4, "asnowsin")
	if(!irandom(7)){with(instance_create(x+16, y+16, CustomObject)){ntstype="tankfake"}}
	sum(16, "rhinobot")
	sum(32, "wimic")
	}

#define sum(rd, obj)
if(!irandom(rd-1))
	{
	if(is_real(obj)){a=instance_create(x+16, y+16, obj)}
	else{a=instance_create(x+16, y+16, CustomEnemy); with(a){ntstype=obj}}
	}
else{a=noone}
return a;

#define area_pop_props
sum(32, MutantTube)

#define area_start
with(Floor){if !irandom(63) && point_distance(x,y,10000,10000)>128 && !place_meeting(x,y,Wall) instance_create(x+16, y+16, WeaponChest)}

#define area_mapdata(lx, ly, lp, ls, ws, ll)
return [99, -9, 0, 1]
/*switch(ws)
	{
	case 1: return [81, -9, 1, 1]; break;
	case 2: return [90, -9, 0, 1]; break;
	case 3: return [99, -9, 0, 1]; break;
	default: return [lx+9, -9, 0, 1]; break;
	}*/
