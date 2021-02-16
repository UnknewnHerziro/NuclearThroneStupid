
#define init
	{
	global.surface_size = 4
	}

#define create
	{
	spr_idle = mskNone
	spr_walk = mskNone
	spr_hurt = mskNone
	spr_dead = mskNone
	spr_sit1 = mskNone
	spr_sit2 = mskNone
	
	MergeEnemy_data = 
		{
		data : {}, 
		
		image_index :	0, 
		image_angle :	image_angle, 
		image_xscale :	image_xscale, 
		image_yscale :	image_yscale, 
		
		angle : angle, 
		
		sprite_state :		"idle", 
		outlines_color :	c_black, 
		}
	
	with(MergeEnemy_data.data)
		{
		data_random("Body")
		data_random("Head")
		data_random("ArmA")
		}
	}

#define step
	{
//	depth = -16
	
	with(MergeEnemy_data)
		{
		image_index		+=	other.image_speed_raw
		image_angle		=	other.image_angle
		image_xscale	=	other.image_xscale
		image_yscale	=	other.image_yscale
		angle			=	other.angle
		}
	}

#define draw_begin
	{
	/*
		Set the sprite_state. 
		
		If it's hurt sprite, exit. 
		If it's hurting, switch the state to hurt. 
		If it's moving, switch the state to walk. 
		Otherwise, switch the state to idle. 
	*/
	with(MergeEnemy_data)
		{
		if(sprite_state=="hurt" && image_index<3)
			{exit}
		if(other.nexthurt > current_frame)
			{
			sprite_state = "hurt"
			image_index = 0
			exit
			}
		if(other.speed > 0)
			{
			if(sprite_state != "walk")
				{
				sprite_state = "walk"
				image_index = 0
				}
			exit
			}
		if(sprite_state != "idle")
			{
			sprite_state = "idle"
			image_index = 0
			exit
			}
		}
	}

#define draw
	{
	/*
		Draw the parts on a surface. 
		Draw the outlines by d3d_set_fog() on another surface. 
		Draw the surface on screen. 
		Free the surfaces. 
	*/
	with(MergeEnemy_data)
		{
		var surA = surface_create_blank()
			draw_part("ArmB")
			draw_part("Body")
			draw_part("Head")
			draw_part("ArmA")
		
		var surB = surface_create_blank()
			if(sprite_state=="hurt" && image_index<1)
				{
				d3d_set_fog(true,	c_white, 0, 0)
					draw_surface(surA, sur_size,	0)
					draw_surface(surA, -sur_size,	0)
					draw_surface(surA, 0,			sur_size)
					draw_surface(surA, 0,			-sur_size)
					draw_surface(surA, 0, 			0)
				d3d_set_fog(false,	c_white, 0, 0)
				}
			else{
				d3d_set_fog(true,	outlines_color, 0, 0)
					draw_surface(surA, sur_size,	0)
					draw_surface(surA, -sur_size,	0)
					draw_surface(surA, 0,			sur_size)
					draw_surface(surA, 0,			-sur_size)
				d3d_set_fog(false,	outlines_color, 0, 0)
					draw_surface(surA, 0, 0)
				}
		
		surface_reset_target()
		//	draw_surface_ext(surB, view_xview_nonsync-sur_offset, view_yview_nonsync-sur_offset, 2, 2, 0, c_white, 1)
			with(other)
				{
				var xos = sur_offset * image_xscale * right
				var yos = sur_offset * image_yscale
				draw_surface_ext(surB, x-xos, y-yos, image_xscale*right/sur_size, image_yscale/sur_size, 0, image_blend, image_alpha)
				}
		
		surface_free(surA)
		surface_free(surB)
		}
	}

#define draw_end



#define draw_part
	{
	if(is_object(lq_get(self.data, argument0)))
		{
		if(argument0 == "Body")
			{
			var xoff = 0
			var yoff = 0
			}
		else{
			with(
				lq_defget(lq_get(data.Body, `spr_${sprite_state}`).Pos, argument0, 
					{
					xoffset : 0, 
					xoffary : false, 
					yoffset : 0, 
					yoffary : false, 
					}
				))
					{
					if(xoffary || yoffary)
						{
						var img = other.image_index
						var length = array_length(xoffary ? xoffset : yoffset)
						while(img < 0)
							{img += length}
						img %= length
						}
					
					var xoff = xoffary ? xoffset[@img] : xoffset
					var yoff = yoffary ? yoffset[@img] : yoffset
					}
			}
		
		with(lq_get(lq_get(self.data, argument0), `spr_${sprite_state}`))
			{
			draw_sprite_lq
				(
				sprite_index, 
				other.image_index, 
				sur_offset, 
				sur_offset, 
				(other.image_angle + other.angle) * sign(other.image_xscale) * sign(other.image_yscale), 
				xoff, 
				yoff, 
				)
			}
		}
	}

#define draw_sprite_lq(spr, img, dx, dy, rot, xo, yo)
	{
	var len = point_distance(0, 0, xo, yo)
	var dir = rot + point_direction(0, 0, xo, yo)
	var xos = lengthdir_x(len, dir)
	var yos = lengthdir_y(len, dir)
	
	with(instance_create(0, 0, GameObject))
		{
		draw_sprite_ext(spr, img, (dx+xos)*sur_size, (dy+yos)*sur_size, sur_size, sur_size, rot, c_white, 1)
		instance_destroy()
		}
	}



#define data_random		variable_instance_set(self, argument0, lq_random(lq_get(data_lib, argument0)))

#define data_random_blank
	{
	var _data = lq_get(data_lib, argument0)
	var _size = lq_size(_data)
	
	var _num = irandom(_size)
	
	variable_instance_set(self, argument0, _num==_size ? null : lq_get_value(_data, _num))
	}

#define lq_random	return lq_get_value(argument0, irandom(lq_size(argument0)-1))



#define surface_create_blank
	{
	var sur = surface_create(sur_canvas*sur_size, sur_canvas*sur_size)
	surface_set_target(sur)
	draw_clear_alpha(0, 0)
	
	return sur
	}



#macro	sur_canvas	128
#macro	sur_offset	64
#macro	sur_size	global.surface_size

#macro	data_self	MergeEnemy_data.data
#macro	data_lib	mod_variable_get("mod", "MergeEnemy_lib", "lwo_data_lib")

#define	skin_race	return 1
