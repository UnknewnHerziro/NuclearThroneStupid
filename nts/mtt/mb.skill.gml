#define init
icon = sprite_duplicate_ext(sprSkillIconHUD, 28, 1)

globalvar icon

#define skill_take
if(instance_exists(LevCont))
	{sound_play(sndMutOpenMind)}

#define step

var gd = 90

with(Player)
	{
	with(instances_matching_ne(projectile, "team", team))
		{
		var dir = (direction+360) % gd
		if(dir)
			{
			var d = (gd-dir) * ((dir>gd*0.5) ? 1 : -1)
			direction += d
			image_angle += d
			}
		}
	with(instances_matching_ne(enemy, "team", team))
		{
		var dir = (direction+360) % gd
		if(dir)
			{
			var d = (gd-dir) * ((dir>gd*0.5) ? 1 : -1)
			direction += d
			}
		if("gunangle"in self)
			{
			var dir = (gunangle+360) % gd
			if(dir)
				{
				var d = (gd-dir)*((dir>gd*0.5) ? 1 : -1)
				gunangle += d
				}
			}
		}
	}


#define skill_name
return "mental box"
#define skill_text
return "@wenemy projectiles#@sfollow @wbroken line path"
#define skill_tip
return "gears"
#define skill_icon
return icon
#define skill_button
sprite_index = sprSkillIcon
image_index = 28

#define skill_wepspec
return false
#define skill_avail
return true