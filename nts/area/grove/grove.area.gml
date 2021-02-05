#define init
mus = sound_add("Summer Area.ogg")
sprf = sprite_add("floor.png",4,0,0)

globalvar mus, sprf

#define area_name
return "gr-"+string(argument0);

#define area_secret
return true

#define area_sprite(q)
switch (q) {
    case sprFloor1: return sprf;
    case sprFloor1B: return sprf;
    case sprFloor1Explo: return sprFloor106Explo;
    case sprWall1Trans: return sprWall106Trans;
    case sprWall1Bot: return sprWall106Bot;
    case sprWall1Out: return sprWall106Out;
    case sprWall1Top: return sprWall106Top;
    case sprDebris1: return sprDebris106;
}

#define area_finish
//if(area = "grove" && subarea<3){lastarea = "grove"; lastsubarea=subarea; subarea+=1}
//else{lastarea = "grove"; lastsubarea=3; area = 6; subarea = 1}
lastarea = "grove"; lastsubarea=1; area = "outlab"; subarea = 1;

//for supporting ntte
#define area_background_color return make_color_rgb(245, 250, 251)
#define area_setup
background_color = area_background_color()
BackCont.shadcol = make_color_rgb(0, 0, 0);
TopCont.darkness = 0;
sound_play_music(mus)
sound_play_ambient(amb105);



#define area_make_floor

instance_create(x, y, Floor);

var turn = irandom(8);
switch(turn)
	{
	case 0: 
		ox = x; oy = y;
		road(4);
		dx = x; dy = y;
		for(xi=-1;xi<2;xi++)
			{
			x=dx+xi*32;
			for(yi=-1;yi<2;yi++)
				{
				y=dy+yi*32; 
				instance_create(x,y,Floor)
				}
			}
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
with(sum(12,"fruit")){color="b"; team=3}
sum(12,Grunt)
sum(36,Shielder)
sum(36,Inspector)

#define sum(rd, obj)
if(!irandom(rd-1))
	{
	if(is_real(obj)){a=instance_create(x+16, y+16, obj)}
	else{a=instance_create(x+16, y+16, CustomEnemy); with(a){ntstype=obj}}
	}
else{a=noone}
return a;

#define area_pop_props
if !irandom(15) instance_create(x+16, y+16, PlantPot)

#define area_start
with(Floor){if !irandom(23) && !place_meeting(x,y,Wall) instance_create(x+16, y+16, IDPDChest)}

#define area_mapdata(lx, ly, lp, ls, ws, ll)
switch(ws)
	{
	case 1: return [81, 9, 1, 1]; break;
	case 2: return [90, 9, 0, 1]; break;
	case 3: return [99, 9, 0, 1]; break;
	default: return [lx+9, 9, 0, 1]; break;
	}
