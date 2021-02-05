#define init
icon = sprite_add("Icon.png", 1, 8, 8)
skill = sprite_add("Skill.png", 1, 12, 16)

lrad = 0

globalvar icon, skill, lrad

#define game_start
lrad = 0

#define skill_take
if(instance_exists(LevCont))
	{sound_play(sndMutant11Thrn)}

#define skill_lose

#define step
if(skill_get(3))
	{
	if(instance_exists(Player))
		{
		with(Rad){syn()}
		with(BigRad){syn()}
		}
	}
else{
	with(Rad){speed = 0}
	with(BigRad){speed = 0}
	}
with(GameCont)
	{
	if(rad > lrad)
		{
		var r = (rad - lrad)*5
		with(instances_matching(Player, "visible", true))
			{
			reload = max(0, reload-r)
			breload = max(0, breload-r)
			}
		}
	lrad = rad
	}

#define syn
	{
	var a = instance_nearest(x, y, Player)
	if(distance_to_object(a)<128){speed = 0; exit}
	if(place_meeting(x, y, a) || place_meeting(x, y, ProtoStatue) || place_meeting(x, y, Portal))
		{speed = 0}
	else{
		motion_add(point_direction(x, y, a.x, a.y), 1)
		speed = min(speed, 8)
		image_angle = direction
		}
	}

#define skill_name
return "Radiation Jaw"
#define skill_text
return `@grads @slower your @wreload time#${(skill_get(3) && skill_get("rj")) ? "@wsynergy-plutonium hunger#attract @grads" : "@grads @sbe attract more easily"}`
#define skill_tip
return "@gsoft and warm@s"

#define skill_icon
return icon
#define skill_button
sprite_index = skill

#define skill_wepspec
return false
#define skill_avail
return true