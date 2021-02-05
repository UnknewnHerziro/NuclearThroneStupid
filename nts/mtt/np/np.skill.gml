#define init
icon = sprite_add("Icon.png", 1, 8, 8)
skill = sprite_add("Skill.png", 1, 12, 16)

globalvar icon, skill

#define skill_take
if(instance_exists(LevCont))
	{sound_play_pitch(sndAllySpawn, 0.5)}

#define step
for(var i=0; i<maxp; i++){with(instances_matching(Player, "index", i))
	{
	if(fork())
		{
		var h = my_health
		wait current_time_scale
		if(!instance_exists(self)){exit}
		if(my_health > h)
			{
			with(instance_create(x, y, Ally))
				{
				creator = other
				team = other.team
				}
			}
		exit
		}
	}}


#define skill_name
return "neoplasia"
#define skill_text
return "@wsummon allies#@safter @wregenerate @rhp"
#define skill_tip
return "what's the time?"
#define skill_icon
return icon
#define skill_button
sprite_index = skill

#define skill_wepspec
return false
#define skill_avail
return true