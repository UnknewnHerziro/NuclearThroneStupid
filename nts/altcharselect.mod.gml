#define init
	global.charpage = 0;
	global.charwidth = game_width;
	global.charamt = floor(global.charwidth/20) - 1;
	
	 // RESET CHAR SELECTS
	if(instance_exists(Menu)) Menu.mode = 0;
	
#define step
	if(global.charpage > 0 and !instance_exists(Menu)) global.charpage = 0;
	if(global.charwidth != game_width) {
		global.charwidth = game_width;
		global.charamt = floor(global.charwidth/20) - 1;
		 // RESET CHAR SELECTS
		if(instance_exists(Menu)) Menu.mode = 0;
		
		with(CharSelect) {
			charadj = 1;
			xstart = 8 + (20 * (index mod (global.charamt - 2))) + ((global.charwidth + 30) * floor(index/(global.charamt - 2)));
			global.charpage = 0;
			
			if(variable_instance_exists(self, "charshift") and charshift > 0) {
				ystart = floor(ystart - charshift/2);
				charshift = floor(charshift/2);
				
				if(!charshift) sound_play_pitch(sndAppear, 1 - ((index mod (global.charamt - 2)/20)) + random(0.2));
			}
		}
	}
	
	with(instances_matching(Menu, "altchar", null)) {
		script_bind_draw(altchar_menu, object_get_depth(Menu) - 1);
		altchar = true;
	}

	if(instance_exists(CharSelect)) {
		with(CharSelect) {
			if(!variable_instance_exists(self, "charadj")) { 
				charadj = 1;
				xstart = 8 + (20 * (index mod (global.charamt - 2))) + ((global.charwidth + 30) * floor(index/(global.charamt - 2)));
				global.charpage = 0;
			}
			
			if(variable_instance_exists(self, "charshift") and charshift > 0) {
				ystart = floor(ystart - charshift/2);
				charshift = floor(charshift/2);
				
				if(!charshift) sound_play_pitch(sndAppear, 1 - ((index mod (global.charamt - 2)/20)) + random(0.2));
			}
		}
		
		for (var p = 0; p < maxp; p++) {
			var _x = game_width - 42,
				_y = game_height - 26, 
				_w = 12,
				_h = 12;
			
			 // FORWARD
			if(global.charpage < floor(instance_number(CharSelect)/(global.charamt - 1.5)) and (button_pressed(p, "sout") or (button_pressed(p, "fire") and point_in_rectangle(mouse_x[p] - view_xview[p], 
																		mouse_y[p] - view_yview[p], 
																		_x - (_w), 
																		_y + 8, 
																		_x + (_w), 
																		_y + _h + 8)))) {
				global.charpage++;
				if(global.charpage < floor(instance_number(CharSelect)/(global.charamt - 1.5))) sound_play(sndSlider);
				sound_play_pitch(sndClick, 1.4 - (global.charpage/5) + random(0.2));
				with(CharSelect) {
					if(variable_instance_exists(self, "charshift")) {
						ystart -= charshift;
						charshift = 0;
					}
					xstart -= global.charwidth + 30;
					charshift = ((index mod (global.charamt - 2)) * 20) + 5;
					ystart += charshift;
				}
			}
			
			 // BACK
			if(global.charpage > 0 and (button_pressed(p, "nort") or (button_pressed(p, "fire") and point_in_rectangle(mouse_x[p] - view_xview[p], 
																		mouse_y[p] - view_yview[p],
																		_x - (_w), 
																		_y - 8, 
																		_x + (_w), 
																		_y + _h - 8)))) {
				global.charpage--;
				sound_play_pitch(sndClickBack, 1 + (global.charpage/5) + random(0.2));
				with(CharSelect) {
					if(variable_instance_exists(self, "charshift")) {
						ystart -= charshift;
						charshift = 0;
					}
					xstart += global.charwidth + 30;
					charshift = ((index mod (global.charamt - 2)) * 20) + 5;
					ystart += charshift;
				}
			}
		}
	}
	
#define altchar_menu
	var _tc = c_gray,
		_thover = 0;
	
	var _bc = c_gray,
		_bhover = 0;
	
	
	for (var p = 0; p < maxp; p++) {
		var _x = view_xview[p] + game_width - 42,
			_y = view_yview[p] + game_height - 26, 
			_w = 12,
			_h = 12;
		
		if(point_in_rectangle(mouse_x[p] - view_xview[p], 
							  mouse_y[p] - view_yview[p], 
							  _x - view_xview[p] - (_w), 
							  _y - view_yview[p] + 8, 
							  _x - view_xview[p] + (_w), 
							  _y - view_yview[p] + _h + 8)) {
			_tc = c_white;
			_thover = 1;
		}
		
		if(point_in_rectangle(mouse_x[p] - view_xview[p], 
							  mouse_y[p] - view_yview[p], 
							  _x - view_xview[p] - (_w), 
							  _y - view_yview[p] - 8, 
							  _x - view_xview[p] + (_w), 
							  _y - view_yview[p] + _h - 8)) {
			_bc = c_white;
			_bhover = 1;
		}
		
		draw_set_visible_all(0);
		draw_set_visible(p, 1);
		
		if(global.charpage < floor(instance_number(CharSelect)/(global.charamt - 1.5))) {
			draw_sprite_ext(sprLoadoutArrow, 0, _x, _y + 12 - (_thover), 1, -1, 6, _tc, 1);
		}
		
		if(global.charpage > 0) {
			draw_sprite_ext(sprLoadoutArrow, 0, _x - 1, _y + (_bhover), -1, 1, 6, _bc, 1);
		}
		
		draw_sprite_ext(sprLoadout, 0, _x + 20, _y - 4, 1, 1, 0, c_gray, 1);
		
		draw_set_visible_all(1);
	}
	
#define cleanup
	 // RESET CHAR SELECTS
	if(instance_exists(Menu)) Menu.mode = 0;