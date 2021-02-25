
#define init
	{
	global.icon = sprite_add("Icon.png", 1, 8, 8)
	global.skill = sprite_add("Skill.png", 1, 12, 16)
	}


#define skill_take
if(instance_exists(LevCont))
	{
	sound_play(sndMut)
	sound_play(sndMutant1Chst)
	repeat(4)
		{
		wait 8
		audio_sound_gain
			(
			audio_play_sound_at
				(
				irandom_range(sndGuitarHit1, sndGuitarHit7), 
				random_range(1, -1), random_range(1, -1), random_range(1, -1), 
				0, 0, 0, 
				false, false
				), 
			0.75, 0
			)
		}
	}




//	#define game_start	skill_set(mod_current, true)

#define step
	{
	if(instance_exists(TopCont))
		{
		with(Player)
			{
			nts_cardiorhythm_value = variable_instance_get(self, "nts_cardiorhythm_value", 0) + current_time_scale
			nts_cardiorhythm_hud_bar_shake		= max(0, variable_instance_get(self, "nts_cardiorhythm_hud_bar_shake",		0) - current_time_scale)
			nts_cardiorhythm_hud_combo_shake	= max(0, variable_instance_get(self, "nts_cardiorhythm_hud_combo_shake",	0) - current_time_scale)
			
			if	(
				!variable_instance_exists(self, "nts_cardiorhythm_beat") || 
				!variable_instance_exists(self, "nts_cardiorhythm_combo") || 
				nts_cardiorhythm_value > beat_off
				)
					{
					beat_reset_ext()
					beat_settle_ext()
					beat_combo_rads(nts_cardiorhythm_multi)
					}
			
			beat_combo_trigger()
			
			if	(
				canfire && button_pressed(index, "fire") && 
				ammo[@weapon_get_type(wep)] > weapon_get_cost(wep)/* && 
				weapon_get_type(wep) != 0 && 
				weapon_get_cost(wep) >= 1
			*/	)
					{
					var _size = lq_size(nts_cardiorhythm_beat)
					
					if(reload > 0)
						{
						if(_size > 0)
							{
							beat_settle()
							var _miss = true
							}
						else{return beat_settle_ext()}
						}
					else{var _miss = false}
					
					if(_size > 1)
						{
						if(_size >= beat_max)
							{
							var _new = {}
							var _sum = lq_get_value(nts_cardiorhythm_beat, 0)[@0]
							
							for(var i=1; i<beat_max; i++)
								{
								var _ary = lq_get_value(nts_cardiorhythm_beat, i)
								lq_set(_new, lq_get_key(nts_cardiorhythm_beat, i), _ary)
								
								if(i < beat_eff)
									{_sum += _ary[@0]}
								}
							
							_sum /= beat_eff
							
							if(_miss)
								{
								var _err = abs(_sum - nts_cardiorhythm_value)
								if(_err < beat_err)
									{
									nts_cardiorhythm_beat = _new
									beat_add_blank(_err)
									}
								else{beat_reset()}
								}
							else{
								var _err = beat_bonus(_sum)
								if(_err < beat_err)
									{
									nts_cardiorhythm_beat = _new
									beat_add(_err, _sum)
									}
								else{beat_reset()}
								}
							}
						else{
							var _sum = 0
							
							for(var i=0; i<_size; i++)
								{_sum += lq_get_value(nts_cardiorhythm_beat, i)[@0]}
							
							_sum /= _size
							
							if(_miss)
								{
								var _err = abs(_sum - nts_cardiorhythm_value)
								if(_err < beat_err)
									{beat_add_blank(_err)}
								else{beat_reset()}
								}
							else{
								var _err = beat_bonus(_sum)
								if(_err < beat_err)
									{beat_add(_err, _sum)}
								else{beat_reset()}
								}
							}
						}
					else{
						for(var i=0; i<_size; i++)
							{lq_set(nts_cardiorhythm_beat, lq_get_key(nts_cardiorhythm_beat, i), [nts_cardiorhythm_value, c_white])}
						beat_add_ext(nts_cardiorhythm_value, c_white)
						nts_cardiorhythm_value = 0
						}
					
				//	trace(nts_cardiorhythm_beat)
					}
			
			script_bind_draw(dr_beats, TopCont.depth, self)
			}
		}
	}

#define beat_add(_err, _sum)
	{
	beat_add_ext(nts_cardiorhythm_value, col_beat[@_err * col_fac])
	nts_cardiorhythm_value = 0
//	sound_play_hit(sndLuckyShotProc, 0)
	}

#define beat_add_blank(_err)
	{
	beat_add_ext(nts_cardiorhythm_value, c_gray)
	nts_cardiorhythm_value = 0
	}

#define beat_add_ext(_val, _col)	lq_set(nts_cardiorhythm_beat, current_frame, [_val, _col])

#define beat_reset
	{
	beat_reset_ext()
	beat_settle_ext()
	beat_combo_rads(nts_cardiorhythm_multi)
	
//	sound_play_hit(sndRecGlandProc, 0)
	nts_cardiorhythm_hud_bar_shake		= 20
	nts_cardiorhythm_hud_combo_shake	= 20
//	draw_bar_effect(sprLuckyShot)
	}

#define beat_reset_ext
	{
	nts_cardiorhythm_beat = {}
	nts_cardiorhythm_value = 0
	}

#define beat_bonus(_sum)	return beat_bonus_ext(_sum, nts_cardiorhythm_value)

#define beat_bonus_ext(_sum, _val)
	{
	var _err = abs(_sum - _val)
	
	if(_err < beat_err)
		{
	/*	if(random(1) < (beat_err - _err) * beat_fac / beat_err)
			{ammo[@weapon_get_type(wep)] += weapon_get_cost(wep)}
	*/	
		var _cost = weapon_get_cost(wep)
		var _rads = weapon_get_rads(wep)
		var _ammo = (beat_err - _err) * beat_fac / beat_err
		
		if(_cost > 0)
			{
			if(_cost <= 1)
				{
				var _r = random(1)
				if(_r < _ammo)
					{ammo[@weapon_get_type(wep)] += 1}
				
			//	trace("perhap", _ammo, _r)
				}
			else{
				_ammo = min(_cost, ceil(_cost * _ammo))
				/*
				_ammo = ceil(_cost * _ammo)
				
				if(_ammo >= _cost)
					{_ammo = ceil(_cost - 1)}
				*/
				ammo[@weapon_get_type(wep)] += _ammo
				
			//	trace(_err, _ammo)
				}
			}
		
		GameCont.rad += max(0, min(_rads, ceil(_rads * _ammo)))
		}
	
	beat_combo(_err, _sum)
	
	return _err
	}

#define beat_combo(_err, _sum)
	{
	beat_combo_ext()
//	beat_combo_trigger()
	nts_cardiorhythm_max = beat_bonus_max - beat_bonus_fac * _err / beat_err * 3
	}

#define beat_combo_trigger
	{
	var _max = variable_instance_get(self, "nts_cardiorhythm_max",		1)
	var _org = variable_instance_get(self, "nts_cardiorhythm_multi",	1)
	
	if(_org > _max)
		{
		nts_cardiorhythm_multi = _max
		nts_cardiorhythm_hud_combo_shake = 10
	//	beat_combo_rads(nts_cardiorhythm_multi)
		}
	
	if(_org < _max)
		{
		if(nts_cardiorhythm_combo & beat_combo_group_and < 1)
			{
			nts_cardiorhythm_multi = min(_max, (nts_cardiorhythm_combo >> beat_combo_group_div) * beat_combo_multi + 1)
		//	beat_combo_rads(nts_cardiorhythm_multi)
			}
		}
	
	beat_combo_rads(nts_cardiorhythm_multi)
	}

#define beat_combo_rads
	{
	with(Rad)
		{beat_combo_rads_ext(argument0)}
	with(BigRad)
		{beat_combo_rads_ext(argument0)}
	}

#define beat_combo_rads_ext(_mult)
	{
	if(variable_instance_get(self, "nts_cardiorhythm_multi", 1) == _mult){exit}
	
	rad = rad * _mult / variable_instance_get(self, "nts_cardiorhythm_multi", 1)
	nts_cardiorhythm_multi = _mult
	}

#define beat_combo_ext		nts_cardiorhythm_combo ++

#define beat_settle
	{
	beat_settle_ext()
	beat_combo_rads(nts_cardiorhythm_multi)
	nts_cardiorhythm_hud_combo_shake = 20
	}

#define beat_settle_ext
	{
	nts_cardiorhythm_combo	= 0
	nts_cardiorhythm_multi	= 1
	nts_cardiorhythm_max	= 1
	}



#define dr_beats
	{
	with(argument0)
		{
		draw_set_visible_all(false)
		draw_set_visible(index, true)
		
		
		
	//	with(Rad){draw_text_nt(x, y, string_format(rad, 1, 1))}
	//	draw_text_nt(view_xview_nonsync+32, view_yview_nonsync+48, `${nts_cardiorhythm_multi} / ${nts_cardiorhythm_max}`)
		
		
		
		var _size	= lq_size(nts_cardiorhythm_beat)
		
		if(_size>0 || nts_cardiorhythm_hud_bar_shake>0 || nts_cardiorhythm_hud_combo_shake>0)
			{
			var _dir	= random(360)
			var _len	= nts_cardiorhythm_hud_bar_shake * hud_bar_shake
			var _scale	= nts_cardiorhythm_hud_bar_shake > 0 ? 1 : 1 - nts_cardiorhythm_value / beat_off
			
			draw_sprite_ext(
				sprReviveBar, 0, 
				hud_xoff + 3 + lengthdir_x(_len, _dir), 
				mean(hud_y[@0], hud_y[@1]+1) + lengthdir_y(_len, _dir), 
				_scale, _scale, 
				90, 
				_size>2 ? lq_get_value(nts_cardiorhythm_beat, _size-1)[@1] : c_white, 	//	col_beat[@lq_get_value(nts_cardiorhythm_beat, _size-1)[@1] * _fac], 
				0.5
				)
			
			
			
			draw_set_alpha(0.5)
			draw_set_color(_size>2 ? lq_get_value(nts_cardiorhythm_beat, _size-1)[@1] : c_white)
			draw_set_font(2)
			draw_set_halign(fa_center)
			draw_set_valign(fa_bottom)
			
			_scale *= 1.5
			
			draw_text_transformed
				(
				hud_xoff + 3, 
				hud_y[@0] - 3, 
				`RADS MULTIPLIER#${string_format(variable_instance_get(self, "nts_cardiorhythm_multi", 1), 1, 1)}`, 
				_scale, _scale, 
				random(nts_cardiorhythm_hud_combo_shake * hud_combo_shake) * choose(1, -1)
				)
			}
		
		
		
		if(_size > 0)
			{
		//	draw_set_alpha(0.5)
			
		//	var _fac	= array_length(col_beat) / beat_err
			var _x
			
			
			
			var _sum = 0
			
			for(var i=0; i<_size; i++)
				{_sum += lq_get_value(nts_cardiorhythm_beat, i)[@0]}
			
			_sum /= _size
			
			var _rate = nts_cardiorhythm_value / _sum
			
			
			
			for(var i=0; i<_size; i++)
				{
				_x = hud_xoff + (current_frame - lq_get_key(nts_cardiorhythm_beat, i)) * hud_factor
				
				draw_set_alpha(hud_alpha * (i + beat_max - _size + 1 - _rate))
			//	draw_set_color(merge_color(col_good, col_bad, lq_get_value(self, i)[@1] / beat_err))
				draw_set_color(lq_get_value(nts_cardiorhythm_beat, i)[@1])	//	(col_beat[@lq_get_value(nts_cardiorhythm_beat, i)[@1] * _fac])
				draw_rectangle(_x, hud_y[@0], _x+hud_x, hud_y[@1], false)
				}
			
			
			
			if(_size > 1)
				{
			//	draw_set_alpha(0.5)
				draw_set_color(c_white)
				
				var _off = current_frame - lq_get_key(nts_cardiorhythm_beat, _size-1)
				
				for(var i=1; i<=beat_pre; i++)
					{
					_x = hud_xoff + (_off - _sum * i) * hud_factor
					
					draw_set_alpha(min(hud_pre * (beat_pre - i + _rate), 0.5))
					draw_rectangle(_x, hud_y[@0], _x+hud_x, hud_y[@1], false)
					}
				}
			}
		
		draw_set_alpha(1)
		draw_set_color(c_white)
		draw_set_font(fntM)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		draw_set_visible_all(true)
		}
	instance_destroy()
	}



#define draw_bar_effect(_spr)					draw_bar_effect_ext(_spr, sprite_get_number(_spr), 0.4*current_time_scale)
#define draw_bar_effect_ext(_spr, _num, _spd)	if(instance_exists(TopCont)){script_bind_draw(draw_bar_effect_1, TopCont.depth-1, self, _spr, _num, _spd)}

#define draw_bar_effect_1(_target, _spr, _num, _spd)
	{
	img = variable_instance_get(self, "img", -_spd) + _spd
	if(img >= _num)
		{
		instance_destroy()
		exit
		}
	
	with(_target)
		{
		draw_set_visible_all(false)
		draw_set_visible(index, true)
		
		draw_sprite_ext(_spr, other.img, hud_xoff+hud_x, hud_y[@0]+16, 1, 1, 0, choose(1, -1), 0.5)
		
		draw_set_visible_all(true)
		exit
		}
	
	instance_destroy()
	}



#macro	beat_max	16
#macro	beat_eff	8
#macro	beat_err	_sum * 0.2	//	3
#macro	beat_off	90
#macro	beat_fac	1.0
#macro	beat_pre	8

#macro	beat_combo_group_and	3
#macro	beat_combo_group_div	2
#macro	beat_combo_multi		0.5
#macro	beat_bonus_fac			0.5
#macro	beat_bonus_max			3.0

#macro	col_good	c_green
#macro	col_bad		c_red
#macro	col_beat	[c_orange, c_green, c_yellow, c_red]
#macro	col_fac		array_length(col_beat) / beat_err

#macro	hud_alpha	0.5 / beat_max
#macro	hud_pre		0.5 / beat_pre
#macro	hud_x		3 - nts_cardiorhythm_value / beat_off * 3
#macro	hud_y		[view_yview_nonsync+game_height*0.5-17, view_yview_nonsync+game_height*0.5+16]
#macro	hud_xoff	view_xview_nonsync + game_width * 0.5
#macro	hud_factor	1.0

#macro	hud_bar_shake		0.5
#macro	hud_combo_shake		0.5



#define skill_name		return "CARDIORHYTHM"
#define skill_text		return "@sRHYTHMICALLY @wFIRES @sGIVE @yAMMOS#@wCOMBOS @sINCREASE @gRADS @wMULTIPLIER@s"
#define skill_tip		return "FROM THE GROUND"
#define skill_icon		return global.icon
#define skill_button	sprite_index = global.skill

#define skill_wepspec	return false
#define skill_avail		return true