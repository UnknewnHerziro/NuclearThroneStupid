#define init
global.MNPCTypeBase=["fish", "crystal", "eyes", "melting", "plant", "venuz", "steroids", "robot", "chicken", "rebel", "horror", "rogue", "skeleton", "frog", "cuz", "end"]
global.MNPCType=ds_list_create(); for(i=0;global.MNPCTypeBase[i]!="end";i++){ds_list_add(global.MNPCType,global.MNPCTypeBase[i])}
global.MNPCList=ds_list_create()

#define area_name
return "$m$";

#define area_sprite(q)
switch (q) {
    case sprFloor1: return sprFloor107;
    case sprFloor1B: return sprFloor107;
    case sprFloor1Explo: return sprFloor107Explo;
    case sprWall1Trans: return sprWall107Trans;
    case sprWall1Bot: return sprWall107Bot;
    case sprWall1Out: return sprWall107Out;
    case sprWall1Top: return sprWall107Top;
    case sprDebris1: return sprDebris107;
}

#define area_finish
area = areaM; subarea = areaMs; 
ds_list_clear(global.MNPCList);

//for supporting ntte
#define area_background_color return make_color_rgb(238, 240, 242)
#define area_setup
background_color = area_background_color()
BackCont.shadcol = make_color_rgb(18, 0, 20);
TopCont.fog = -1;
sound_play_music(choose(musThemeP, musCredits));
novans=1;
safespawn=0;
ds_list_clear(global.MNPCList)

#define area_make_floor
BornX=x;BornY=y;
for(xi=0;xi<20;xi++){
	for(yi=0;yi<12;yi++)
		{
		instance_create(x, y, Floor);
		if(xi>3 && xi<19 && yi>1 && yi<11)
			{
			if(instance_exists(CustomObject))
				{
				if(instance_number(CustomObject)<8)
					{
					a=instance_nearest(x+16,y+16,CustomObject);
					if(point_distance(x,y,a.x,a.y)>172){summonable=1}else{summonable=0}
					}else{summonable=0}
				}
			else{summonable=1};
			if(distance_to_point(BornX,BornY)<128 and irandom(15)){summonable=0}
			if(summonable)
				{
				with(instance_create(x+16,y+16,CustomObject))
					{
					ntstype="MarketNPC";
					Num=irandom(array_length(global.MNPCTypeBase)-2);
					do{Num++;if(Num>=(array_length(global.MNPCTypeBase)-1)){Num=0}}
					until(global.MNPCTypeBase[Num]!="steroids" && global.MNPCTypeBase[Num]!="robot" && global.MNPCTypeBase[Num]!="rogue" && ds_list_find_index(global.MNPCList,Num)==-1)
					ds_list_add(global.MNPCList,Num)
					if(Num=14){instance_create(x,y-48,VenuzCouch);instance_delete(YungCuz)}
					}
				instance_create(x,y,VenuzCarpet)
				}
			}
		y+=32;
		}
	y-=32*yi;x+=32;
	}
instance_destroy();
#define area_pop_enemies
//n=irandom(35);
//for(i=0;i<n;i++) instance_create(x + 16, y + 16, Bandit);

#define area_pop_props
//if (random(4) < 1) instance_create(x + 16, y + 16, NightCactus);

#define area_start
with(RadChest){instance_delete(self)};
with(RogueChest){instance_delete(self)};
with(HealthChest){instance_delete(self)};
with(instance_create(Player.x,Player.y,CustomObject)){ntstype="MarketCar"};


#define area_mapdata(lx, ly, lp, ls, ws, ll)
return [lx, -18];
