#define init
icon = sprite_add("Icon.png", 1, 8, 8)
skill = sprite_add("Skill.png", 1, 12, 16)

globalvar icon, skill

#define skill_take
sound_play(sndMutant15Crwn)

#define step
with(instances_matching(Player, "notoxic", false))
	{notoxic = true}
with(ToxicGas){with(instance_nearest(x, y, Player)){if(other.team != team)
	{
	other.team = team
	with(instance_create(0, 0, Drip))
		{
		depth = other.depth-1
		image_speed = random_range(0.3, 0.5)
		script_bind_step(scrDripBind, 0, self, other, random_range(-8, 8), random_range(4,8))
		}
	}}}
if(instance_exists(enemy)){with(ToxicGas)
	{
	var h = instance_nearest(x, y, enemy)
	motion_add(point_direction(x, y, h.x, h.y), 0.1*current_time_scale)
	if(distance_to_object(h) < speed*2)
		{
		projectile_hit_raw(h, damage, 1)
		instance_destroy()
		}
	}}

#define scrDripBind(a, b, dx, dy)
if(instance_exists(a)){with(b)
	{
	a.x = x + dx
	a.y = bbox_bottom + dy
	}}
else{instance_destroy()}

#define skill_name
return "poisoned lungs"
#define skill_text
return "@sFLUID @gTOXIC GAS@w,#YOU TAKE NO DAMAGE @sFROM @gTOXIC GAS@s"

#define skill_tip
return "@gDEEP BREATH@s"
#define skill_icon
return icon
#define skill_button
sprite_index = skill

#define skill_wepspec
return true
#define skill_avail
return true