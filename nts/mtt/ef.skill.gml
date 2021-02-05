#define init
icon = sprite_duplicate_ext(sprSkillIconHUD, 2, 1)

globalvar icon

#define game_start

#define skill_take
sound_play(sndMutExtraFeet)

#define step
with(instances_matching(Player,"speed",0))
	{
	wait 1; 
	if(instance_exists(self)){if(speed>0){EF_SpeedStartUp=6}}
	}
with(instances_matching_lt(Player,"speed",2))
	{speed=0}
with(instances_matching_gt(Player,"EF_SpeedStartUp",0))
	{
	x+=lengthdir_x(EF_SpeedStartUp, direction)
	y+=lengthdir_y(EF_SpeedStartUp, direction)
	instance_create(x,y,Dust)
	speed=maxspeed; nexthurt=current_frame+1; 
	EF_SpeedStartUp-=0.3; 
	}

#define skill_name
return "extra feet";
#define skill_text
return "@wsquat start rush#@wno damage taken @sduring @wrushing";
#define skill_tip
return "like wheels";
#define skill_icon
return icon;
#define skill_button
sprite_index=sprSkillIcon;
image_index=2;

#define skill_wepspec
return 0;
#define skill_avail
return 1;