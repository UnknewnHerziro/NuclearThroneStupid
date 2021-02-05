#define init
icon = sprite_duplicate_ext(sprSkillIconHUD, 19, 1)

globalvar icon

#define game_start

#define skill_take
if(instance_exists(LevCont))
	{sound_play(sndMutEagleEyes)}

#define skill_lose
for(i=0; i<4; i++){view_pan_factor[i] = null}

#define step
for(i=0; i<4; i++){view_pan_factor[i] = 2.5}

#define skill_name
return "eagle eye"
#define skill_text
return "watch further#sees in the darkness"
#define skill_tip
return "hyperopia"
#define skill_icon
return icon
#define skill_button
sprite_index = sprSkillIcon
image_index = 19

#define skill_wepspec
return false
#define skill_avail
return true