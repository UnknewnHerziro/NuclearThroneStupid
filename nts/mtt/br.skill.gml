#define init
icon = sprite_duplicate_ext(sprSkillIconHUD, 10, 1);

globalvar icon

#define skill_take
sound_play(sndMutBackMuscle)

#define step
with(instances_matching_gt(Player,"my_health",0))
	{
	var h=my_health; wait 1; 
	if(instance_exists(self)){if(my_health<h){player_fire(); reload=0}}
	}

#define skill_name
return "biceps reflex";
#define skill_text
return "@wfire @sand @wreload#@swhen taken damage";
#define skill_tip
return "bold";
#define skill_icon
return icon;
#define skill_button
sprite_index = sprSkillIcon
image_index = 10

#define skill_wepspec
return 0;
#define skill_avail
return 1;