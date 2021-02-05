#define init
//global.portrait	= sprite_duplicate_ext(sprBigPortrait,	0,			1)
global.mapicon	= sprite_duplicate_ext(sprSkillIconHUD,	mut_stress,		1)
global.loadout	= [global.mapicon, sprite_duplicate_ext(sprMutant1Dead, 5, 1)]
global.spr_dead	= sprite_duplicate_ext(sprSkillIconHUD,	mut_last_wish,	1)

#define clear_up



	#define skin_race	return char_fish
	#define skin_name	return skin_avail() ? `@3(sprMutant1Idle)@3(1473:${mut_stress})` : `@3(1473:${mut_extra_feet})@3(1473:${mut_last_wish})@3(1473:${mut_stress})@3(1473:${mut_sharp_teeth})@3(1473:${mut_strong_spirit})`
	
//	#define skin_race_name		return ``
	#define skin_race_text		return `@2(sprSkillIconHUD:4)@2(sprAmmo)##@1(sprWolfFire)`
	#define skin_race_tb_text	return `@2(sprFishBoost)@3(sprWolfFire)`
	
	#define skin_portrait	return sprBigPortrait
	#define skin_mapicon	return global.mapicon
	#define skin_button		sprite_index = global.loadout[@!skin_avail()]
	
	#define skin_avail	//return true
	if(mod_exists("mod", "ntsCont"))
		{
		var v = mod_variable_get("mod", "ntsCont", "nts_save")
		if(is_object(v)){return lq_defget(v.skin, mod_current, false)}
		}



#define create
spr_dead = global.spr_dead
pictographic_sprite_index = sprite_index
pictographic_frame_fire = 0
pictographic_frame_hurt = 0

#define step
if(button_check(index, "fire"))	{pictographic_frame_fire = 9}else{pictographic_frame_fire -= current_time_scale}
if(lsthealth > my_health)		{pictographic_frame_hurt = 9}else{pictographic_frame_hurt -= current_time_scale}

#define draw_begin
	{
	pictographic_sprite_index = sprite_index
	sprite_index = mskNone
	}

#define draw
	{
	if(roll==0 && pictographic_sprite_index!=spr_idle)
		{
		var shake	= (roll==0 && speed>3) ? [random(2)-1, random(2)-1] : [0, 0]
		draw_sprite_ext(1473, mut_extra_feet, x+(right?1:-1)+shake[@0], y+6+shake[@1], (direction==90 || direction==270) ? -right : ((direction>90 && direction<270) ? 1 : -1), 1, 0, c_white, 1)
		}
	else{draw_sprite_ext(1473, mut_last_wish, x, y, right?1.2:-1.2, 1.2, angle_fin, c_white, 1)}
	}

#define draw_end
	{
	if(roll != 0){exit}
	if(pictographic_frame_hurt > 0)
		{draw_sprite_ext(1473, mut_stress, x+(right?-2:2)+random_range(1,-1), y-5+random(2), right, random_range(0.8,1.25), angle_fin, c_white, 1)}
	else{
		if(pictographic_frame_fire > 0)
			{draw_sprite_ext(1473, mut_recycle_gland, x+(right?2:-2)+random_range(1,-1), y-5+random(2), -right, 1, angle_fin, c_white, 1)}
		else{
			if(pictographic_sprite_index != spr_idle)
				{draw_sprite_ext(1473, (my_health>4)?mut_sharp_teeth:((canspirit&&skill_get(mut_strong_spirit))?mut_strong_spirit:mut_stress), x, y-4, right, 1, angle_fin, c_white, 1)}
			}
		}
	}

#macro	angle_fin	angle + image_angle + sprite_angle
