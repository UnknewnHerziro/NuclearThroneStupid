
#define init
	{
	global.icon = sprite_add("icon.png", 0, 12, 16)
	global.spr_idle = sprite_add("idle.png", 1, 8, 8)
	global.spr_walk = sprite_add("walk.png", 6, 8, 8)
	}

#define crown_name			return "Crown of Destimy"
#define crown_text			return "@sFREE @gMUTATION#@sNARROW FUTURE"
#define crown_tip			return "@w* L O L *"

#define crown_button		sprite_index = global.icon

#define crown_avail			return false



#define crown_take
	{
	GameCont.skillpoints++
	sound_play(sndPartyHorn)
	sound_play(sndHPMimicTaunt)
	}

#define step
	{
	if(!instance_exists(Crown))
		{instance_create(10016, 10016, Crown)}
	if(!skill_get(19)){with(SkillIcon){skill=19; sprite_index=sprSkillIcon; image_index=19; name="@qCROWN OF MIMIC"; text="@q@pIT'S CURSED!"}}
	with(Crown)
		{
		spr_idle = global.spr_idle
		spr_walk = global.spr_walk
		with(instance_nearest(x, y, Player))
			{other.image_xscale = (point_direction(other.x, other.y, x, y) + 270) % 360 < 180 ? 1 : -1}
		}
	}



#define nts_guard_text		return "MORE MIMIC"

#define nts_guard_ultra
	{
	with(AmmoChest)
		{
		instance_create(x, y, Mimic)
		instance_delete(self)
		}
	
	if(button_pressed(index, "spec") || button_pressed(index, "horn"))
		{sound_play_hit(sndPartyHorn, 0.3)}
	}



