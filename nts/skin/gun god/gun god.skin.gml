#define init
global.portrait	= [sprite_add("background2.png", 1, 0, 220), sprite_add("background2.png", 1, -54, 220)]
global.mapicon	= sprite_add("mapicon.png",		1,	10,	10)
global.loadout	= sprite_add("button.png",		2,	16,	12)
globalvar sprGod
sprGod = mod_variable_get("area", "helipad", "sprGod")

#define clear_up



	#define skin_race	return char_venuz
	#define skin_name	return skin_avail() ? `gun god` : `defeat ???`
	
	#define skin_race_name		return `G.G.`
//	#define skin_race_text		return ``
//	#define skin_race_tb_text	return ``
	
	#define skin_portrait	return global.portrait[@mod_variable_get("mod", "ntsUI", "WideScreen")]
	#define skin_mapicon	return global.mapicon
	#define skin_button		sprite_index = global.loadout; image_index = skin_avail()
	
	#define skin_avail
	if(mod_exists("mod", "ntsCont"))
		{
		var v = mod_variable_get("mod", "ntsCont", "nts_save")
		if(is_object(v)){return lq_defget(v.skin, mod_current, false)}
		}



#define create
	{
	spr_idle = sprGod.sprite.spr_idle
	spr_walk = sprGod.sprite.spr_walk
	spr_hurt = sprGod.sprite.spr_hurt
	spr_dead = sprGod.sprite.spr_execute
	}

#define draw_begin
model_index = [sprite_index, image_index]
sprite_index = mskNone

#define draw
sprite_index = model_index[@0]
image_index = model_index[@1]
mod_script_call("area", "helipad", "mdl_god_ext", x, y, lq_defget(sprGod.map, string(sprite_index), "spr_idle"), gunangle, image_xscale * 0.8, image_yscale * 0.8)


