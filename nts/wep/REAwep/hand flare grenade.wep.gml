#define init 
global.spr = sprite_add_weapon("HandFlareGrenade.png", 8, 12)
global.spr_hg = sprite_add("HandFlareGrenade.png", 1, 12, 12)
global.wep_b = 
	{
	wep: mod_current, 
	ammo: 12, 
	name: "flare", 
	}
#define weapon_name
return "hand flare grenade"
#define weapon_type
return 0;
#define weapon_auto
return 0;
#define weapon_load
return 10;
#define weapon_cost
return 0;
#define weapon_sprt
return global.spr
#define weapon_area
return 0;
#define weapon_swap
return sndSwapExplosive
#define weapon_melee
return 1;
#define weapon_gold
return 0;
#define weapon_laser_sight
return 0;
#define weapon_fire
if(is_object(wep))
	{
	if(wep.ammo >= 1)
		{
		sound_play_hit(sndFlare, 0.3)
		with(instance_create(x, y, Flare))
			{
			sprite_index = global.spr_hg
			direction = other.gunangle
			speed = 10
			//image_angle = direction
			
			creator = other
			team = other.team
			}
		weapon_post(9, -16, 0)
		wep.ammo--
		motion_add(gunangle, maxspeed)
		if(wep.ammo <= 0)
			{
			wep = 0
			curse = 0
			}
		}
	}

#define step
if(argument0){if(!is_object(wep))
	{wep = lq_clone(global.wep_b)}}
else{if(!is_object(bwep))
	{bwep = lq_clone(global.wep_b)}}
with(instances_matching(WepPickup, "wep", mod_current)){if(scrPick(other)){sound_play_hit(sndSwapExplosive, 0.3); instance_delete(self)}}

#define scrPick(a)
if(place_meeting(x, y, a))
	{
	if(is_object(a.wep)){if(a.wep.wep == mod_current){a.wep.ammo+=12; return 1; exit}}
	if(is_object(a.bwep)){if(a.bwep.wep == mod_current){a.bwep.ammo+=12; return 1; exit}}
	}



