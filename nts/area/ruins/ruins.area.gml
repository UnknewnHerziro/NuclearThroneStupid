
#define init
mus = sound_add("Cheap Dream.ogg")
mus_a = sound_add("SHOT.ogg")
mus_b = sound_add("SHAKE IT.ogg")

globalvar mus, mus_a, mus_b

#define area_name
return argument1?`ru-${argument0}`:`ci-${argument0}`

#define area_secret
return true

#define area_sprite(q)
switch (q) {
    case sprFloor1: return sprFloor102;
    case sprFloor1B: return sprFloor102;
    case sprFloor1Explo: return sprFloor106Explo;
    case sprWall1Trans: return sprWall106Trans;
    case sprWall1Bot: return sprWall106Trans;
    case sprWall1Out: return sprWall106Out;
    case sprWall1Top: return sprWall106Top;
    case sprDebris1: return sprDebris102;
}

#define area_finish
//lastarea = "ruins"; lastsubarea = 1; 
area = 3; subarea = 3; 

//for supporting ntte
#define area_background_color return 16513781
#define area_setup
background_color = area_background_color()
BackCont.shadcol = 1179657
TopCont.darkness = GameCont.loops==0 ? true : choose(true, false)
sound_play_music(GameCont.loops==0 ? mus : choose(mus_a, mus_b))
sound_play_ambient(amb106)



#define area_make_floor

goal = 200
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
		with(instance_create(x+16, y+16, BigTV))
			{
			with(BigTV){if(id!=other && distance_to_object(other)<128){instance_delete(self)}}
			spr_idle = sprBigTVOn
			spr_hurt = sprBigTVTurnOn
			maxhealth = 100
			my_health = 100
			raddrop = 32
			size = 2
			nts_ruinsmachine = 2
			nts_ruins_lightc = 0
			nts_ruins_light = [0.2, 128, 64]
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
			case 0: x+=32; instance_create(x,y+32,Floor); instance_create(x,y-32,Floor); break;
			case 90: y-=32; instance_create(x+32,y,Floor); instance_create(x-32,y,Floor); break;
			case 180: x-=32; instance_create(x,y+32,Floor); instance_create(x,y-32,Floor); break;
			case 270: y+=32; instance_create(x+32,y,Floor); instance_create(x-32,y,Floor); break;
			default: break;
			}; 
		with(instance_create(x,y,Floor)){nts_drawline = other.direction}
		}
	}



#define area_pop_enemies
if(GameCont.loops)
	{
	sum(16, "waiter")
	sum(8, Bandit)
	sum(8, Raven)
	sum(16, Sniper)
	}
else{sum(8, "waiter")}

#define sum(rd, obj)
if(!irandom(rd-1))
	{
	if(is_real(obj)){var a=instance_create(x+16, y+16, obj)}
	else{var a=instance_create(x+16, y+16, CustomEnemy); with(a){ntstype=obj}}
	}
else{var a=noone}
return a;

#define area_pop_props

#define scrSumManager
if(!instance_exists(Player)){exit}
var list = ds_list_create()
with(Floor){if(distance_to_object(instance_nearest(x+16, y+16, Player)) > 128){ds_list_add(list, self)}}
ds_list_shuffle(list)
var ia = GameCont.loops+3
var im = ds_list_size(list)
for(var ib=0; ia>0; ia--)
	{
	with(instance_create(0, 0, CustomEnemy))
		{
		ntstype="manager"
		nts_ruinsmachine = 1
		while(ib<im)
			{
			var f = ds_list_find_value(list, ib)
			var fx = f.x+16
			var fy = f.y+16
			ib++
			if(place_free(fx, fy))
				{x=fx; y=fy; break}
			}
		}
	}
ds_list_destroy(list)

#define area_start
with(Floor){if("nts_drawline"in self)
	{
	image_index = 0
	with(instance_create(x+16, y+16, CustomObject))
		{
		sprite_index = sprBigNameFont
		image_index = choose(10, 31)
		image_speed = 0
		image_angle = other.nts_drawline+choose(0, 180)
		x -= lengthdir_x(22, image_angle+313)
		y -= lengthdir_y(22, image_angle+313)
		depth = 9.9
		ntstype = "RuinsLine"
		}
	}}
scrSumManager()

with(instance_create(0, 0, CustomObject))
	{
	ntstype = "ruinsmind"
	with(instances_matching_gt(hitme, "nts_ruinsmachine", 0)){creator = other}
	}

with(instances_matching(Player, "race", "molefish")){nts_ruins_lightc = 48896}

#define area_mapdata(lx, ly, lp, ls, ws, ll)
return [36, 18, 1, 1]
