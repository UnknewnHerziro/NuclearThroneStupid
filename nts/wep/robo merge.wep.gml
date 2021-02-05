
#define init
global.mc = mod_current 
global.sprt = 
	[
		[sprite_add("RoboMergePistol.png", 7, 2, 1),		sndSwapPistol], 
		[sprite_add("RoboMergeRifle.png", 7, 8, 2),			sndSwapMachinegun], 
		[sprite_add("RoboMergeSmg.png", 7, 8, 6),			sndSwapPistol], 
		[sprite_add_weapon("RoboMergeShotgun.png", 4, 4),	sndSwapShotgun], 
		[sprite_add("RoboMergeLauncher.png", 7, 8, 6),		sndSwapExplosive], 
		[sprite_add("RoboMergeThrower.png", 7, 8, 6),		sndSwapEnergy], 
	]

#define weapon_name		return lq_defget(argument0, "name", "hyper pistol")
#define weapon_sprt		return global.sprt[lq_defget(argument0, "sprt", 0), 0]

#define weapon_type		return lq_defget(argument0, "type", 1)
#define weapon_melee	return false
#define weapon_auto		return lq_defget(argument0, "auto", false)
#define weapon_cost		return lq_defget(argument0, "cost", 1)
#define weapon_rads		return lq_defget(argument0, "rads", 0)
#define weapon_area		return -1
#define weapon_swap		return global.sprt[@lq_defget(argument0, "sprt", 0)][@1]

#define weapon_gold			return false
#define weapon_laser_sight	return lq_defget(argument0, "laser_sight", false)

#define weapon_load
if(string_pos("crystal", weapon_name(mod_current)))
	{
	if(string_pos("crystal",weapon_get_name(bwep)) or my_health==maxhealth)
		{return ceil(lq_defget(argument0, "load", 3)*0.6); exit}
	}
return lq_defget(argument0, "load", 3)

#define nts_weapon_examine	return
	{
	"robo" : "Technological. ", 
	"coward" : "Not from the same forge. ", 
	"d" : "A merged weapon looks like a hyper weapon. ", 
	}



#define weapon_fire
if(is_object(wep))
	{
	repeat(wep.times)
		{
		if(instance_exists(self))
			{
			weapon_post(6, -6, 6)
			sound_play_hit(wep.sound, 0.3)
			for(var i=-wep.angletimes; i<=wep.angletimes; i++)
				{
				repeat(wep.shottimes)
					{
					with(instance_create(x,y,wep.proj))
						{
						team = other.team
						creator = other
						
						damage = other.wep.energy ? other.wep.damage*(skill_get(17)*0.5+1) : other.wep.damage
						speed = other.wep.pspeed
						direction = other.gunangle
						if(other.wep.smart)
							{
							with(instance_nearest(x+lengthdir_x(80, direction), y+lengthdir_y(80, direction), enemy))
								{
								var dir = point_direction(other.x, other.y, x, y)
								if(direction < dir+60)
									{
									if(!collision_line(x, y, other.x, other.y, Wall, false, true))
										{other.direction = dir}
									}
								}
							}
						direction += other.wep.angleaccuracy*i + irandom_range(other.wep.shotaccuracy, -other.wep.shotaccuracy) + irandom_range(other.wep.accuracy, -other.wep.accuracy)*other.accuracy
						
						if(other.wep.shottimes){speed+=random_range(1,-1)}
						if(other.wep.molefish){force = 0}
						if(other.wep.golden){switch(other.wep.proj)
							{
							case Bolt: sprite_index = sprBoltGold; break
							case Grenade: sprite_index = sprGoldGrenade; break
							case Disc: sprite_index = sprGoldDisc; speed *= 2; break
							default: break
							}}
						if(other.wep.ultra){switch(other.wep.proj)
							{
							case Seeker: image_xscale*=0.5; image_yscale*=0.5; break;
							case EnemyLaser: image_yscale = 1.5+skill_get(17)*0.5; break;
							case HyperSlug: sprite_index=sprUltraShell; with(script_bind_step(PC, 0, self, damage, team)){x=other.x; y=other.y}; break;
							case Disc: with(script_bind_step(UD, 0, self, damage, team)){x=other.x; y=other.y}; break;
							case Nuke: if("index"in other){index=other.index}; break;
							case PlasmaBall: image_xscale*=2; image_yscale*=2; break;
							default: break
							}}
						
						image_angle = direction
						
						if(other.wep.laser)
							{event_perform(ev_alarm, 0)}
						else{if(other.wep.lightning)
								{
								ammo = other.wep.lightning
								visible = false
								with(instance_create(x,y,LightningSpawn)){image_angle=other.image_angle}
								event_perform(ev_alarm, 0)
								}
							else{if(other.wep.hyper){image_xscale*=2}}}
						if(other.wep.bproj != 0)
							{
							with(script_bind_step(B, 0, self)){team=other.team; x=other.x; y=other.y; creator=other.creator; bproj=creator.wep.bproj; bdamage=creator.wep.bdamage; bspeed=creator.wep.bspeed; btimes=creator.wep.btimes}
							if(object_index==Bolt || object_index==HeavyBolt || object_index==UltraBolt)
								{nts_alarmed = true}
							}
						}
					}
				}
			}
		wait 2
		}
	}


#define B(crt)
if(instance_exists(crt)){x=crt.x; y=crt.y}else
	{
	repeat(btimes){with(instance_create(x, y, bproj))
		{
		if(object_index != ToxicGas){team = other.team}
		direction = random(360)
		image_angle = direction
		damage = other.bdamage
		if(object_index == MeatExplosion)
			{
			x += random_range(8,-8)
			y += random_range(8,-8)
			}
		else{speed = other.bspeed+random_range(-1,1)}
		}}
	instance_destroy()
	}
#define PC(crt, dmg, team)
if(instance_exists(crt)){x=crt.x; y=crt.y; direction=crt.direction}else{with(instance_create(x,y,PortalClear)){image_xscale=1.5; image_yscale=1.5}; with(hitme){if(distance_to_object(other)<48){with(other){if(team!=other.team){projectile_hit_push(other, dmg, 32)}}}}; instance_destroy()}
#define UD(crt, dmg, team)
if(instance_exists(crt)){x=crt.x; y=crt.y; with(crt){with(hitme){if(place_meeting(x,y,other)){with(other){if(team!=other.team){projectile_hit(other, dmg)}}}}}}else{instance_destroy()}