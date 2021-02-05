#define init
icon = sprite_add("Icon.png", 1, 8, 8)
skill = sprite_add("Skill.png", 1, 12, 16)

globalvar icon, skill

#define skill_take
if(instance_exists(LevCont))
	{sound_play(sndRavenLand)}

#define step
var r = instances_matching_ne(Rad, "image_blend", 16776960)
var len = array_length(r)
for(var i=0; len-i>=mcrF; i+=mcrF)
	{
	with(r[i]){with(instance_create(x, y, BigRad))
		{
		speed = other.speed
		}}
	for(var ia=0; ia<mcrF; ia++)
		{with(r[i+ia]){instance_delete(self)}}
	}
with(instances_matching_ne(Pickup, "image_blend", 16776960)){if(!instance_is(self, WepPickup)){scrColor()}}
with(instances_matching(EatRad, "sprite_index", sprEatBigRad)){image_blend = 16776960}

#define scrColor
image_blend = 16776960
alarm0 *= 2
if(object_index == BigRad){rad *= 1.5}



#define skill_name
return "Radium Wings"
#define skill_text
return "@wpickups @sexist longer,#@wget more @(color:16776960)rads"
#define skill_tip
return "@(color:16776960)shining feather"
#define skill_icon
return icon
#define skill_button
sprite_index = skill

#define skill_wepspec
return false
#define skill_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, "envoy", false)}
	}

#macro mcrF 9