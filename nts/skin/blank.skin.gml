#define init
global.portrait	= sprite_add("portrait.png",	1,	35,	200)
global.mapicon	= sprite_add("mapicon.png",		1,	10,	10)
global.loadout	= sprite_add("button.png",		2,	16,	16)

#define clear_up



	#define skin_race	return char_
	#define skin_name	return skin_avail() ? `` : ``
	
	#define skin_race_name		return ``
	#define skin_race_text		return ``
	#define skin_race_tb_text	return ``
	
	#define skin_portrait	return global.portrait
	#define skin_mapicon	return global.mapicon
	#define skin_button		sprite_index = global.loadout; image_index = skin_avail()
	
	#define skin_avail	return true
	if(mod_exists("mod", "ntsCont"))
		{
		var v = mod_variable_get("mod", "ntsCont", "nts_save")
		if(is_object(v)){return lq_defget(v.skin, mod_current, false)}
		}



#define game_start

#define create

#define step

#define draw_begin

#define draw

#define draw_end
