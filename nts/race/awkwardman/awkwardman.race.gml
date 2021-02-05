#define init
global.walk = sprite_add("wak.png",4,10,37);
global.hurt = sprite_add("hut.png",3,10,37);
global.idle = sprite_add("wit.png",4,10,37);
global.dead = sprite_add("ded.png",6,10,37);
global.spr_icon = sprite_add("ic.png",1,15,10);
global.spr_port = sprite_add("www.png",1,0,200);
global.chs = [[], []]
for(var ox = -3; ox <= 3; ox ++){for(var oy = -3; oy <= 3; oy ++)
	{
	array_push(global.chs[@0], sprite_add("CharSelect.png", 1, ox, oy))
	array_push(global.chs[@1], sprite_add("CharSelectClear.png", 1, ox, oy))
	}}
global.EG1 = sprite_add("UAA.png", 1, 12, 16);
global.EG2 = sprite_add("UBB.png", 1, 12, 16);
 // Set Ultra Variables:
global.ultra[1] = 0;
global.ultra[2] = 0;
global.kills = 0;
global.killneed = 100;
global.addvalue = 0;
global.showmsg = 0;

#define nts_weapon_examine	return 
	{
	"0":	"Magic. Physically. ", 
	}



#define game_start
with(instances_matching(Player,"race","awkwardman")){bwep=92}; GameCont.hard=13;
#define create
    spr_idle = global.idle; // Idle
	spr_walk = global.walk; // Walk
	spr_hurt = global.hurt; // Hurt
	spr_dead = global.dead;
already = 0;
typ_amax[5] +=global.addvalue;
nts_color_blood = [make_color_rgb(190, 253, 8), make_color_rgb(54, 156, 17)]
#define race_soundbank
return 4;
#define step
if(global.ultra[2] == 1)
{
    if(can_shoot == 0 && wep == 111)
    {
        if(already != 1){if(irandom(1) == 1){ammo[5]+=24;}already = 1;}
    }
    else
    {
        already = 0;
    }
}
with (enemy)
{
    if(my_health <=0)
    {
        global.kills += 1;
        instance_destroy();
    }
}
if(global.kills >= global.killneed)
{
    typ_amax[5] +=1;
    global.kills = 0;
    global.killneed = 100+400*GameCont.loops;
    global.addvalue +=1;
    with(instance_create(x, y, PopupText)){mytext = "AMMOLUST!"}
}
if(GameCont.loops == 3 && global.showmsg == 0)
{
    trace("Welcome,to the awkward man exclusive loop.");
    global.showmsg = 1;
}



#define race_name
return "AWKWARD MAN";
#define race_text
return "META#AMMOLUST#by wspr";
#define race_swep
return 111;
#define race_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock
return "???";
#define race_menu_button
if(race_avail())
	{script_bind_step(race_menu_button_1, 0, self)}
else{sprite_index = 1611; image_index = 16}
#define race_menu_button_1
with(argument0){sprite_index = global.chs[@irandom(1)][@irandom(35)]}
#define race_skins
return 1;
#define race_tb_text
return "USELESS";
#define race_ultra_name
switch(argument0){
	case 1: return "NO RADS"; // Ultra A
	case 2: return "NO AMMO"; // Ultra B
	// Add More Cases For More Ultras
	default: return "";
}
#define race_ultra_button
switch (argument0){
	case 1: sprite_index = global.EG1;break;
	case 2: sprite_index = global.EG2;break;
	default: return ;
}
#define race_ultra_text 
switch (argument0){
	case 1: return "4X RADS MAX"; // Ultra A
	case 2: return "HALF CHANCE TO NOT REDUCE ENERGY WHEN FIRING"; // Ultra B
	// Add More Cases For More Ultras
	default: return "";
}
#define race_ultra_take
global.ultra[argument0] = 1; // Confirm Which Ultra Was Taken
if(global.ultra[1] = 1) {sound_play(sndBasicUltra);GameCont.radmaxextra = 1800;}
 // Ultra B : Half Health, 3 Mutations
if global.ultra[2] = 1{
	sound_play(sndBasicUltra);
}
#define race_mapicon
return global.spr_icon;
#define race_portrait
return global.spr_port;