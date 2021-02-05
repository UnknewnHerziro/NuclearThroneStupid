#define init
global.spr_idle = sprite_add("idle.png", 4, 12, 12);
global.spr_walk = sprite_add("walk.png", 6, 12, 12);
global.spr_hurt = sprite_add("hurt.png", 3, 12, 12);
global.spr_dead = sprite_add("dead.png", 6, 12, 12);

global.idpdlist =
	[
		[Grunt,				Molefish		],
		[Shielder,			Jock			],
		[Inspector,			Molesarge		],
		[EliteGrunt,		Turtle			],
		[EliteShielder,		FireBaller		],
		[EliteInspector,	SuperFireBaller	]
	]

#define create 
spr_idle = global.spr_idle
spr_walk = global.spr_walk
spr_hurt = global.spr_hurt
spr_dead = global.spr_dead
spr_sit1 = global.spr_idle
spr_sit2 = global.spr_idle
//mapicon = global.mapicon
//loadout = global.loadout
snd_hurt = sndMolefishHurt;
snd_dead = sndMolefishDead;
snd_lowa = -1;
snd_lowh = -1;
snd_chst = -1;
snd_wrld = -1;
snd_valt = -1;
snd_crwn = -1;
snd_thrn = -1;
snd_spch = -1;
snd_idpd = -1;
snd_cptn = -1;

mask_index=mskDebris
maxhealth=10
canaim = 0; canwalk = 0
nts_ruins_lightc = 48896

vertangle = 0
walkangle = 0

#define step
/*
var len=array_length(global.idpdlist)
for(var i=0; i<len; i++){with(global.idpdlist[i,0]){repeat(3){instance_create(x,y,global.idpdlist[i,1])}; instance_delete(self)}}
if(("molefishgrunt"+string(index))!in TopCont){instance_create(x,y,WantPopo); variable_instance_set(TopCont, "molefishgrunt"+string(index), 1)}
if(GameCont.area=106){GameCont.area=103}
*/

if(button_check(index,"spec"))
	{
	if(reload<=0)
		{
		wkick=-6; wepangle = -wepangle; motion_add(gunangle,4); 
		if(skill_get(5)){reload+=20; var d=Slash; var e=sndChickenSword}
		else{reload+=10; var d=Shank; var e=sndScrewdriver}
		if(skill_get(13)){var b=10; var c=4}else{var b=5; var c=2}
		with(instance_create(x+lengthdir_x(b,gunangle),y+lengthdir_y(b,gunangle),d))
			{
			speed=c; direction=other.gunangle; creator=other; team=other.team;
			sound_play(e);
			image_angle=direction; damage=8; 
			}
		}
	}

with(AmmoPickup){alarm0=2}
with(HPPickup){alarm0=2}
with(RoguePickup){alarm0=2}



#define draw

#define race_name
return "molefish";
#define race_text
return "from gun godz#sees closely#venuz knife";

#define race_portrait
return ;
#define race_mapicon
return ;

#define race_swep
return "molefish pistol";

#define race_avail
if(player_is_active(1)){return 0}
else{with(Campfire){if("RaceSave"in self){return string_pos("1	molefish",RaceSave)}}}
#define race_lock
if(player_is_active(1)){return "single game only"}
else{return "reach dungeon"};

#define race_menu_button
sprite_index  =  1611; 
if("RaceSave"in Campfire){if(!string_pos("1	",Campfire.RaceSave) || player_is_active(1)){image_index = 16;}}
#define race_menu_select
return sndMolefishHurt;
#define race_menu_confirm
return sndMolefishHurt;
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
return "sword attack";
#define race_tb_take

#define race_ultra_name
switch(argument0)
	{
	case 1: return "the matrix";break;
	case 2: return "rain man";break;
	default: return "";break;
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return "perceive projectiles";break;
	case 2: return "remember the map";break;
	default: return "";break;
	}
/*
#define race_ultra_button
switch(argument0)
	{
	case 1: sprite_index  =  ;
	case 2: sprite_index  =  ;
	default: sprite_index  =  ;
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
	case 1: return ;break;
	case 2: return ;break;
	default: return ;break;
	}
*/
#define race_ttip
return [];
