
#define init 

#define weapon_name		return "TURTLE"
#define weapon_sprt		return sprTurtleFire

#define weapon_type		return 0
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 10
#define weapon_cost		return 0
#define weapon_area		return -1
#define weapon_swap		return sndTurtleMelee

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	"Turtle pulled his head and feet inside his shell. "



#define weapon_fire
if(!is_object(wep))
	{
	wep = 
		{
		wep: mod_current, 
		ammo: 1, 
		name: " ", 
		}
	}

if(wep.ammo >= 1)
	{
	sound_play_hit(sndTurtleMelee, 0.3)
	with(instance_create(x,y,CustomProjectile))
		{
		sprite_index = sprTurtleFire
		direction = other.gunangle
		speed = 10
		image_angle = direction
		if(image_angle>90 && image_angle<270)
			{image_yscale = -1}
		
		creator = other
		team = other.team
		damage = 10
		force = 3
		typ = 1
		
		collided = false
		
		on_hit = scrHit
		on_wall = scrCollide
		on_destroy = scrTurtle
		on_step = scrSlowdown
		}
	weapon_post(-6, -6, 0)
	wep.ammo--
	if(wep.ammo <= 0)
		{
		wep = 0
		curse = 0
		}
	}

#define step
if(wep==mod_current && bwep==mod_current)
	{
	wep = 
		{
		wep: mod_current, 
		ammo: 2, 
		name: " ", 
		}
	bwep = 0
	}
with(instances_matching(WepPickup, "wep", mod_current)){if(scrTurtlePick(other)){sound_play_hit(sndTurtleMelee, 0.3); instance_delete(self)}}

#define scrHit
collided = true
script_bind_step(scrHitStep, 0, other, damage, force, direction, x, y).nts_turtle_times = speed
direction = random(360)

#define scrHitStep(a, dmg, fc, dir, dx, dy)
if(nts_turtle_times<=0 || !instance_exists(a))
	{
	instance_destroy()
	exit
	}
nts_turtle_times -= 1*current_time_scale
if((current_frame mod 1) < current_time_scale)
	{
	projectile_hit(a, dmg, fc, dir)
	sound_play_hit(sndTurtleMelee, 0.3)
	with(instance_create(dx,dy,Dust))
		{speed = random(5)}
	view_shake_at(dx, dy, nts_turtle_times)
	}

#define scrCollide
collided = true
direction = random(360)
sound_play_hit(sndWallBreak, 0.3)
with(instance_create(x,y,Dust))
	{speed = random(5)}
view_shake_at(x, y, speed)

#define scrTurtle
if(place_meeting(x, y, PopoExplosion))
	{
	repeat(2)
		{
		with(instance_create(x,y,WepPickup))
			{
			speed = other.speed * 2
			rotation = other.image_angle
			wep = mod_current
			}
		sound_play_hit(irandom_range(566, 569), 0.3)
		}
	}
else{
	with(instance_create(x,y,WepPickup))
		{
		speed = other.speed
		rotation = other.image_angle
		wep = mod_current
		}
	sound_play_hit(sndTurtleHurt, 0.3)
	}
instance_delete(self)

#define scrSlowdown
image_speed = speed_raw
with(instance_create(x, y, Dust))
	{sprite_index = sprExtraFeetDust}
if(collided)
	{
	speed-=0.05*current_time_scale
	if(scrTurtlePick(creator)){sound_play_hit(sndTurtleMelee, 0.3); instance_delete(self); exit}
	}
else{
	with(instance_nearest(x, y, enemy)){with(other)
		{
		if(distance_to_object(other) < 8)
			{direction = point_direction(x, y, other.x, other.y)}
		}}
	}
if(speed<=0 || place_meeting(x, y, Portal))
	{
	with(instance_create(x, y, WepPickup))
		{
		rotation = image_angle
		wep = mod_current
		}
	instance_delete(self)
	exit
	}
var dx = x
var dy = y
var ia = image_angle
if(instance_exists(PortalClear)){exit}
wait 1
if(!instance_exists(self) && instance_exists(PortalClear))
	{
	with(instance_create(dx, dy, WepPickup))
		{
		rotation = ia
		wep = mod_current
		}
	}

#define scrTurtlePick(a)
if(instance_exists(a))
	{
	if(distance_to_object(a) < 32 + speed){direction = point_direction(x, y, a.x, a.y)}
	if(place_meeting(x, y, a))
		{
		if(is_object(a.wep)){if(a.wep.wep == mod_current){a.wep.ammo++; return 1; exit}}
		if(is_object(a.bwep)){if(a.bwep.wep == mod_current){a.bwep.ammo++; return 1; exit}}
		if(a.wep == mod_current)
			{
			a.wep = 
				{
				wep: mod_current, 
				ammo: 2, 
				name: " ", 
				}
			return 1; exit
			}
		if(a.bwep == mod_current)
			{
			a.bwep = 
				{
				wep: mod_current, 
				ammo: 2, 
				name: " ", 
				}
			return 1; exit
			}
		if(a.wep == 0)
			{a.wep = mod_current; return 1; exit}
		if(a.bwep == 0)
			{a.bwep = mod_current; return 1; exit}
		}
	}


