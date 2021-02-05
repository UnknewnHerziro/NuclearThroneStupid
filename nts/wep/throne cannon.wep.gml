
#define init 

#define weapon_name		return "THRONE CANNON"
#define weapon_sprt		return instance_is(self, Player) ? mskNone : sprNothingMiddle
#define weapon_sprt_hud	return sprNothingMiddle

#define weapon_type		return 0
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return GameCont.rad>=BeamR ? BeamT : 1
#define weapon_cost		return 0
#define weapon_area		return -1
#define weapon_swap		return sndBecomeNothingStartup

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"The engine of the Throne with great recoil force. "



#define weapon_fire
	{
	sound_play_hit(sndBecomeNothingStartup, 0.3)
	motion_add(gunangle+180, 3)
	if(GameCont.rad >= BeamR)
		{
		weapon_post(12, 0, 12)
		GameCont.rad -= BeamR
		with(instance_create(x, y, CustomObject))
			{
			creator	= other
			team	= other.team
			on_step	= beamer_step
			
			with(instance_create(x, y, NothingBeam))
				{
				creator	= other
				team	= other.team
				other.beam = self
				}
			}
		}
	else{
		weapon_post(3, 0, 3)
		var dir = point_direction(x, y+32, mouse_x[index], mouse_y[index])
		with(instance_create(x + lengthdir_x(8, dir), y + lengthdir_y(8, dir) + 60, CustomProjectile))
			{
			sprite_index	= sprNothingBeamStop
			mask_index		= sprNothingBeamStop
			
			speed	= 10
			damage	= 20
			
			direction	= dir
			image_angle	= direction - 90
			
			creator	= other
			team	= other.team
			
			on_step		= fire_step
			on_anim		= fire_anim
			on_destroy	= fire_destroy
			}
		}
	}

#define beamer_step
	{
	if(instance_exists(beam)){with(creator)
		{
		other.x = x
		other.y = y + 32
		exit
		}}
	instance_destroy()
	}

#define fire_step	damage = ceil(20 / (image_index + 1))
#define fire_anim	instance_destroy()
#define fire_destroy
	{
	with(instance_create(x+lengthdir_x(32,direction), y+lengthdir_y(32,direction), BulletHit))
		{
		sprite_index = sprNothingBeamHit
		image_angle = image_angle + 180
		}
	}

#define step
if(argument0)
	{
	if(button_pressed(index,"fire")){sound_play_hit(sndNothingBeamStart, 0.3)}
	if(button_released(index,"fire")){sound_play_hit(sndNothingBeamEnd, 0.3)}
	script_bind_draw(WepDraw, depth, self)
	}



#define WepDraw
with(argument0)
	{draw_sprite_ext(sprNothingMiddle, 0, x, y + 28, 1, 1, 0, c_white, 1)}
instance_destroy()

#macro BeamR 30
#macro BeamT 90