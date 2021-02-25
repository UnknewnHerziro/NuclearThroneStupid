
#define init
	{
	global.wep_default = 
		{
		wep: mod_current, 
		ammolist: [[sprDebris1, 0, 1]], 
		ammo: 1, 
		}
	
	global.mapSpr = ds_map_create()
	}

#define clear_up	ds_map_destroy(global.mapSpr)

#define weapon_name			return "ROCK"

#define weapon_type		return 0
#define weapon_melee	return true
#define weapon_auto		return false
#define weapon_load		return 5
#define weapon_cost		return 0
#define weapon_area		return 0
#define weapon_swap		return sndSwapHammer

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"Just rocks. "



#define weapon_sprt
	{
	var _ary = lq_defget(argument0, "ammolist", global.wep_default.ammolist)[@0]
	var _key = _ary[@0]
	var _spr = global.mapSpr[?_key]
	
	if(array_length(_spr) > _ary[@1])
		{
		if(is_real(_spr[@_ary[@1]]))
			{return _spr[@_ary[@1]]}
		}
	
	_spr = []
	
	var _len = sprite_get_number(_ary[@0])
	for(var i=0; i<_len; i++)
		{array_push(_spr, sprite_duplicate_ext(_ary[@0], i, 1))}
	global.mapSpr[?_key] = _spr
	
	try{return _spr[@_ary[@1]]}catch(_error){trace(_ary[@1])}
	}


#define weapon_fire
if(is_object(wep))
	{
	wep.ammo = array_length(wep.ammolist)
	if(wep.ammo >= 1)
		{
		with(instance_create(x, y, CustomProjectile))
			{
			sprite_index	= other.wep.ammolist[@0][@0]
			image_index		= other.wep.ammolist[@0][@1]
			image_xscale	= other.wep.ammolist[@0][@2]
			image_yscale	= image_xscale
			direction		= other.gunangle
			image_angle		= direction
			
			creator	= other
			team	= other.team
			
			image_speed	= 0
			speed		= 16
			
			damage	= 16
			force	= 4
			typ		= 1
			
			on_destroy = debris_create
			}
		
		sound_play_hit(sndSwapHammer, 0.3)
		weapon_post(9, -16, 0)
		motion_add(gunangle, maxspeed)
		
		wep.ammolist = array_slice(wep.ammolist, 1, array_length(wep.ammolist))
		wep.ammo --
		if(wep.ammo <= 0)
			{
			wep		= 0
			curse	= 0
			}
		}
	}

#define debris_create
	{
	with(instance_create(x, y, Debris))
		{
		sprite_index = other.sprite_index
		image_index = other.image_index
		image_xscale = other.image_xscale
		image_yscale = image_xscale
		}
	}



#define step
	{
	var _target = argument0 ? "wep" : "bwep"
	
	if(!is_object(variable_instance_get(self, _target, {})))
		{
		var _spr = scrSprArea(GameCont.area)
		
		variable_instance_set(self, _target, lq_clone(global.wep_default))
		
		with(variable_instance_get(self, _target, {}))
			{
			ammolist = []
			repeat(irandom_range(3, 7))
				{array_push(ammolist, [_spr, irandom(sprite_get_number(_spr)-1), random_range(1, 1.5)])}
			}
		}
	
	with(variable_instance_get(self, _target, {}))
		{ammo = array_length(ammolist)}
	
	with(instances_matching_le(Debris, "speed", 2))
		{
		with(scrPick(other))
			{
			array_push(ammolist, [other.sprite_index, floor(other.image_index)%sprite_get_number(other.sprite_index), other.image_xscale])
			with(other)
				{
				with(instance_create(x, y, PopupText))
					{mytext = "+1 ROCK"}
				sound_play_hit(sndSwapHammer, 0.3)
				instance_delete(self)
				}
			}
		}
	}

#define scrSprArea(_area)
	{
	if(is_real(_area))
		{
		var _spr = asset_get_index(`sprDebris${_area}`)
		if(_spr != -1)
			{return _spr}
		}
	
	if(is_string(_area))
		{
		var _spr = mod_script_call("area", _area, "area_sprite", sprDebris1)
		if(is_real(_spr) && _spr!=mskNone)
			{return _spr}
		}
	
	return sprDebris1
	}

#define scrPick(_picker)
	{
	if(place_meeting(x, y, _picker))
		{
		if(is_object(_picker.wep	)){if(_picker.wep.wep	== mod_current){return _picker.wep	}}
		if(is_object(_picker.bwep	)){if(_picker.bwep.wep	== mod_current){return _picker.bwep	}}
		}
	return noone
	}
