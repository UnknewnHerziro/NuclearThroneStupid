
#define init
	{
	global.icon = sprite_add("icon.png", 0, 12, 16)
	global.lock = sprite_add("lock.png", 0, 12, 16)
	global.spr_idle = sprite_add("idle.png", 1, 8, 8)
	global.spr_walk = sprite_add("walk.png", 6, 8, 8)
	}

#define crown_name			return "Crown of "
#define crown_text_base		return ""
#define crown_text_unlock	return ""
#define crown_tip			return ""

#define crown_button		sprite_index = global.icon
#define crown_button_lock	sprite_index = global.lock

#define crown_avail			return GameCont.loops



#define crown_take
	{
	
	}



#define step
	{
	if(!instance_exists(Crown))
		{instance_create(10016, 10016, Crown)}
	with(Crown)
		{
		spr_idle = global.spr_idle
		spr_walk = global.spr_walk
		}
	}



#define nts_guard_text		return ""
#define nts_guard_tb_text	return ""

#define nts_guard_ultra
	{
	
	}



#define crown_text
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){if(!lq_defget(v.crown, mod_current, false))
		{
		return `${crown_text_base()}#@sunlock: ${crown_text_unlock()}`
		}}
	}
return crown_text_base()