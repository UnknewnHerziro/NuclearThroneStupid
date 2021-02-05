
#define init
	{
//Blood
	globalvar sprBloodstain, surBlood, BloodData, BloodData_corpse, BloodListMap, BloodCount
	
	sprBloodstain = sprite_add("Bloodstain.png", 4, 0, 0)
	surBlood = -4
	BloodData = ds_map_create()
	BloodData_corpse = ds_map_create()
	scrBloodData()
	BloodListMap = ds_map_create()
	BloodCount = 0
	}

#define clean_up
	{
	if(surface_exists(surBlood))
		{surface_free(surBlood)}
	ds_map_destroy(BloodData)
	ds_map_destroy(BloodData_corpse)
	ds_map_destroy(BloodListMap)
	}

#define step	if(mod_exists("mod", "nts"))
	{
	
//okay, it's 010921 i'm trying to code for corpse erupt blood and i totally forgot which value in the data array means what and i only could guess what it is, my holy higher-narrated-level entity it's so hard why didn't i write ANY notes for it ughhhhh
//fine, i guess it's [count, x, y, image_scale, hspeed, vspeed, image_angle, color_array, color_ratio, image_index, image_alpha, always_delay, delay]
	
	if(instance_exists(GenCont))
		{
		if(surface_exists(surBlood))
			{surface_free(surBlood)}
		ds_map_clear(BloodListMap)
		}
	else{
		if(BloodMax > 0)
			{
			if(!instance_exists(Portal))
				{
				with(instances_matching_gt(hitme, "nexthurt", current_frame+4))
					{scrAddBlood(variable_instance_get(self, "nts_color_blood", BloodData[?object_index==Player ? race : object_index]))}
				}
		/*	if(ruleCorpseBlood)
				{
				with(instances_matching_gt(Player, "speed", 2))
					{
					if(place_meeting(x, y, Corpse))
						{
						with(instance_nearest(x, y, Corpse))
							{
							if(BloodData_corpse[?sprite_index] != null)
								{
								var dir = random(360)
								BloodListMap[?BloodCount] = 
									[
										3, 
										x, 
										y, 
										1, 
										lengthdir_x(16, dir), 
										lengthdir_y(16, dir), 
										dir, 
										BloodData_corpse[?sprite_index], 
										random_range(-0.5, 0.5), 
										irandom(2), 
										1, 
										true, 
										3, 
									]
								BloodCount = (BloodCount+1) & BloodMax
								}
							}
						}
					}
				}
		*/	script_bind_draw(scrDrBlood, 6)
			}
		if(ruleStayBlood)
			{script_bind_draw(scrDrBloodSur, 6)}
		}
	}



#define scrAddBlood(color)
	{
	if(!is_undefined(color) && visible)
		{
		var pd = scrAddBloodProj()
		var dir = pd[0]
		var hs = pd[1] * 10
		var vs = pd[2] * 10
		var sd = pd[3]
		
		BloodListMap[?BloodCount] = 
			[
				sd + irandom_range(1, 2), 
				x, 
				y, 
				1.5, 
				hs, 
				vs, 
				dir, 
				color, 
				random_range(-0.5, 1), 
				irandom(2), 
				1, 
				false, 
				3, 
			]
		BloodCount = (BloodCount+1) & BloodMax
		
		if(!my_health){repeat(size)
			{
			BloodListMap[?BloodCount] = 
				[
					sd + irandom_range(3, -my_health), 
					x, 
					y, 
					1.5, 
					hs, 
					vs, 
					dir + random_range(-15, 15), 
					color, 
					random_range(-0.5, 1), 
					0, 
					1, 
					true, 
					1, 
				]
			BloodCount = (BloodCount+1) & BloodMax
			}}
		}
	}

#define scrAddBloodProj
	{
	with(instances_matching_ne(PlasmaImpact, "team", team))
		{
		if(!place_meeting(x, y, other)){continue}
		var dir = point_direction(x, y, other.x, other.y)
		var sd = (object_index == SmallExplosion) ? 2 : 4
		var hs = lengthdir_x(sd, dir)
		var vs = lengthdir_y(sd, dir)
		return [dir, hs, vs, sd*2]
		exit
		}
	with(instances_matching_ne(Explosion, "team", team))
		{
		if(!place_meeting(x, y, other)){continue}
		var dir = point_direction(x, y, other.x, other.y)
		var sd = (object_index == SmallExplosion) ? 2 : 4
		var hs = lengthdir_x(sd, dir)
		var vs = lengthdir_y(sd, dir)
		return [dir, hs, vs, sd*2]
		exit
		}
	with(instances_matching_ne(MeatExplosion, "team", team))
		{
		if(!place_meeting(x, y, other)){continue}
		var dir = point_direction(x, y, other.x, other.y)
		var sd = 1
		var hs = lengthdir_x(sd, dir)
		var vs = lengthdir_y(sd, dir)
		return [dir, hs, vs, sd*2]
		exit
		}
	with(instances_matching_ne(GammaBlast, "team", team))
		{
		if(!place_meeting(x, y, other)){continue}
		var dir = point_direction(x, y, other.x, other.y)
		var sd = 1
		var hs = lengthdir_x(sd, dir)
		var vs = lengthdir_y(sd, dir)
		return [dir, hs, vs, sd*2]
		exit
		}
	with(instances_matching_ne(projectile, "team", team))
		{
		if(!place_meeting(x, y, other)){continue}
		var name = object_get_name(object_index)
		if(string_pos("Slash", name) || string_pos("Bolt", name))
			{
			var dir = direction + random_range(45,-45)
			var sd = 4
			}
		else{
			//var dir = direction + random_range(-10, 10)
			var sd = (speed > 0) ? clamp(speed*0.2, 2, 4) : 0
			}
		var hs = lengthdir_x(1, dir)
		var vs = lengthdir_y(1, dir)
		return [dir, hs, vs, sd]
		exit
		}
	var dir = random(360)
	var sd = 0
	var hs = lengthdir_x(1, dir)
	var vs = lengthdir_y(1, dir)
	return [dir, hs, vs, sd]
	}



#define scrDrBlood
	{
	if(!surface_exists(surBlood))
		{surface_reset_blood()}
	
	var m = BloodListMap
	var a = BloodCount
	for(var i=0; i<BloodMax; i++){if(is_array(m[?i]))
		{
		if(m[?i][@12])
			{
			m[?i][@12] --
			BloodCount = (BloodCount+1) & BloodMax
			}
		else{
			var col = collision_point(m[?i][@1], m[?i][@2], Floor, false, false)
			if(col && (ruleStayBlood ? (m[?i][@8]<1.5 && random(1)>0.02) : m[?i][@10]>0))
				{
				draw_sprite_ext(sprBloodstain, /*m[?i][@0]*/m[?i][@9], m[?i][@1], m[?i][@2], m[?i][@3], m[?i][@3], m[?i][@6], merge_color(m[?i][@7][0], m[?i][@7][1], clamp(m[?i][@8], 0, 1)), m[?i][@10])
				if(m[?i][@0] > 2)
					{
					var s = 1 / (m[?i][@0]-2)
					m[?BloodCount] = 
						[
							m[?i][@0] - 2, 
							m[?i][@1] + m[?i][@4] * s, 
							m[?i][@2] + m[?i][@5] * s, 
							m[?i][@3] + 0.08, 
							m[?i][@4], 
							m[?i][@5], 
							m[?i][@6], 
							m[?i][@7], 
							m[?i][@8] - BloodSpeed*30, 
							irandom(2), 
							m[?i][@10], 
							m[?i][@11], 
							m[?i][@11] ? 0 : 3, 
						]
					BloodCount = (BloodCount+1) & BloodMax
					m[?i][@0] = 1
					}
				if(m[?i][@8] < 1.5)
					{m[?i][@8] += BloodSpeed*10}
				else{m[?i][@10] -= BloodSpeed*10}
				m[?i][@3] += 0.002//BloodSpeed
				}
			else{
				if(ruleStayBlood && col)
					{
					draw_sprite_ext(sprBloodstain, /*m[?i][@0]*/m[?i][@9], m[?i][@1], m[?i][@2], m[?i][@3], m[?i][@3], m[?i][@6], merge_color(m[?i][@7][0], m[?i][@7][1], clamp(m[?i][@8], 0, 1)), m[?i][@10])
					surface_set_target(surBlood)
					draw_sprite_ext(sprBloodstain, /*m[?i][@0]*/m[?i][@9], m[?i][@1]-mcrBlood_offset, m[?i][@2]-mcrBlood_offset, m[?i][@3], m[?i][@3], m[?i][@6], merge_color(m[?i][@7][0], m[?i][@7][1], clamp(m[?i][@8], 0, 1)), m[?i][@10])
					surface_reset_target()
					}
				ds_map_delete(m, i)
				}
			}
		if(!BloodCount && BloodCount!=a){break}
		}}
	instance_destroy()
	}

#define scrDrBloodSur
	{
	if(surface_exists(surBlood))
		{
		surface_set_target(surBlood)
		
		if(ruleCorpseBlood){scrDrBlood_corpse()}
		scrDrBlood_other()
		scrDrBloodSur_clear()
		
		surface_reset_target()
		draw_surface(surBlood, mcrBlood_offset, mcrBlood_offset)
		}
	else{surface_reset_blood()}
	instance_destroy()
	}

#define scrDrBlood_corpse
	{
	with(instances_matching_gt(Corpse, "speed", 0))
		{
		if(BloodData_corpse[?sprite_index] != null)
			{draw_sprite_ext(sprBloodstain, irandom(2), x-mcrBlood_offset, y-mcrBlood_offset, random_range(0.5, 1.5), random_range(0.5, 1.5), direction, BloodData_corpse[?sprite_index][@0], 1)}
		}
	
	with(Tangle)
		{
		if(place_meeting(x, y, Corpse))
			{
			with(instance_nearest(x, y, Corpse)){if(BloodData_corpse[?sprite_index] != null)
				{draw_sprite_ext(sprBloodstain, irandom(2), x-mcrBlood_offset, y-mcrBlood_offset, random_range(0.5, 1.5), random_range(0.5, 1.5), random(360), BloodData_corpse[?sprite_index][@0], 1)}}
			}
		}
	
	with(Player)
		{
		if(speed>2 && place_meeting(x, y, Corpse))
			{
			with(instance_nearest(x, y, Corpse)){if(BloodData_corpse[?sprite_index] != null)
				{draw_sprite_ext(sprBloodstain, irandom(2), x-mcrBlood_offset, y-mcrBlood_offset, random_range(0.5, 1.5), random_range(0.5, 1.5), random(360), BloodData_corpse[?sprite_index][@1], 1)}}
			}
		if(bleed > 0)
			{draw_sprite_ext(sprBloodstain, irandom(2), x-mcrBlood_offset, y-mcrBlood_offset, random_range(1.5, 2), random_range(1.5, 2), random(360), variable_instance_get(self, "nts_blood_color", c_blood)[@0], 1)}
		if(!canrogue)
			{draw_sprite_ext(sprBloodstain, irandom(2), x-mcrBlood_offset, y-mcrBlood_offset, random_range(1.5, 2), random_range(1.5, 2), random(360), c_fuel[@1], 1)}
		}
	}

#define scrDrBlood_other
	{
	with(instances_matching(MeatExplosion, "sprite_index", sprMeatExplosion))
		{draw_sprite_ext(sprBloodstain, irandom(2), x-mcrBlood_offset, y-mcrBlood_offset, 1.5, 1.5, random(360), merge_color(c_red, 2305158, random(1)), 1)}
	}

#define scrDrBloodSur_clear
	{
	draw_set_blend_mode(bm_subtract)
	
	with(Player)
		{
		if(roll > 0)
			{draw_self_blood()}
		if(race=="eyes" && ultra_get("eyes", 2))
			{draw_circle(x-mcrBlood_offset, y-mcrBlood_offset, skill_get(5) ? 32 : 16, false)}
		}
	
	with(RainSplash)
		{draw_circle(x-mcrBlood_offset, y-mcrBlood_offset, random(8), false)}
	with(MeatExplosion)
		{draw_self_blood()}//{draw_circle(x-mcrBlood_offset, y-mcrBlood_offset, 8, false)}
//	draw_clear_blood(RainSplash, 8)
//	draw_clear_blood(MeatExplosion, 16)

	draw_set_blend_mode(bm_normal)
	}



#define draw_self_blood()				draw_sprite_ext(sprite_index, image_index, x-mcrBlood_offset, y-mcrBlood_offset, image_xscale, image_yscale, image_angle, c_white, 1)

#define draw_clear_blood(obj, size)		draw_clear_blood_ext(obj, size, x-mcrBlood_offset, y-mcrBlood_offset)

#define draw_clear_blood_ext(obj, size, dx, dy)
	{
	with(obj)
		{draw_circle(dx, dy, random(size), false)}
	}



#define surface_reset_blood
	{
	surBlood = surface_create(4096, 4096)
	surface_set_target(surBlood)
	draw_clear_alpha(c_black, 0)
	surface_reset_target()
	}

#define scrBloodData
	{
	var q = BloodData
	var a = c_acid
	var b = c_blood
	var c = c_curse
	var f = c_fuel
	var o = c_oil
	var r = c_rad
	
	q[?RadMaggot]=r
	q[?GoldScorpion]=a
	q[?MaggotSpawn]=b
	q[?BigMaggot]=r
	q[?Scorpion]=r
	q[?Bandit]=b
	q[?SuperFrog]=a
	q[?Exploder]=a
	q[?Gator]=b
	q[?BuffGator]=b
	q[?Ratking]=a
	q[?GatorSmoke]=b
	q[?Rat]=b
	q[?FastRat]=a
	q[?RatkingRage]=a
	q[?MeleeBandit]=b
	q[?MeleeFake]=b
	q[?SuperMimic]=b
	q[?Sniper]=o
	q[?Raven]=b
	q[?Salamander]=o
	q[?Spider]=c
	q[?LaserCrystal]=c
	q[?LightningCrystal]=f
	q[?SnowTank]=o
	q[?GoldSnowTank]=o
	q[?SnowBot]=o
	q[?CarThrow]=o
	q[?Wolf]=o
	q[?SnowBotCar]=o
	q[?RhinoFreak]=c
	q[?Freak]=b
	q[?Turret]=o
	q[?ExploFreak]=o
	q[?Necromancer]=b
	q[?ExploGuardian]=r
	q[?DogGuardian]=r
	q[?GhostGuardian]=r
	q[?Guardian]=r
	q[?CrownGuardianOld]=r
	q[?CrownGuardian]=r
	q[?Molefish]=b
	q[?FireBaller]=b
	q[?SuperFireBaller]=b
	q[?Jock]=b
	q[?Molesarge]=b
	q[?Turtle]=b
	q[?Van]=f
	q[?Grunt]=f
	q[?EliteGrunt]=f
	q[?Shielder]=f
	q[?EliteShielder]=f
	q[?Inspector]=f
	q[?EliteInspector]=f
	q[?Crab]=a
	q[?OasisBoss]=b
	q[?BoneFish]=b
	q[?InvLaserCrystal]=c
	q[?InvSpider]=c
	q[?JungleAssassin]=b
	q[?JungleFly]=b
	q[?JungleAssassinHide]=b
	q[?JungleBandit]=b
	q[?EnemyHorror]=r
	
	q[?BanditBoss]=b
	q[?FrogQueen]=a
	q[?FrogEgg]=a
	q[?HyperCrystal]=c
	q[?LilHunter]=r
	q[?TechnoMancer]=c
	q[?Last]=f
	
	q[?Sapling]=b
	q[?Ally]=b
	q[?DogMissile]=o
	
	q[?Car]=o
	q[?CarVenus]=o
	q[?CarVenusFixed]=o
	q[?CarVenus2]=o
	q[?MutantTube]=r
	q[?Cocoon]=c
	q[?SnowMan]=r
	
	q[?RadChest]=r
	q[?RadMaggotChest]=r
	
	q[?"fish"]=b
	q[?"crystal"]=c
	q[?"eyes"]=b
	q[?"melting"]=b
	q[?"plant"]=r
	q[?"venuz"]=[c_white, c_black]
	q[?"steroids"]=b
	q[?"chicken"]=b
	q[?"rebel"]=b
	q[?"horror"]=r
	q[?"rogue"]=f
	q[?"skeleton"]=b
	q[?"frog"]=a
	q[?"cuz"]=[c_white, c_black]
	
//	q[?"PopoClown"]=f
	
	
	
	var q = BloodData_corpse
	
	q[?sprBoneFish1Dead]=b
	q[?sprCrabDead]=a
	q[?sprOasisBossDead]=b
	q[?sprMSpawnDead]=b
	q[?sprBigMaggotDead]=r
	q[?sprGoldScorpionDead]=a
	q[?sprRadMaggotDead]=r
	q[?sprScorpionDead]=a
	q[?sprSnowBanditDead]=b
	q[?sprSpookyBanditDead]=[c_orange, c_orange]
	q[?sprBanditDead]=b
	q[?sprSniperDead]=o
	q[?sprSalamanderDead]=o
	q[?sprRavenDead]=b
	q[?sprMeleeDead]=b
	q[?sprLaserCrystalDead]=c
	q[?sprSpiderDead]=c
	q[?sprLightningCrystalDead]=c
	q[?sprWolfDead]=o
	q[?sprSnowTankDead]=o
	q[?sprSnowBotDead]=o
	q[?sprGoldTankDead]=o
	q[?sprFreak1Dead]=b
	q[?sprRhinoFreakDead]=c
	q[?sprExploFreakDead]=o
	q[?sprNecromancerDead]=b
	q[?sprTurretDead]=o
/*	q[?sprDogGuardianDead]=r
	q[?sprGhostGuardianDead]=r
	q[?sprExploGuardianDead]=r
	q[?sprGuardianDead]=r
*/	q[?sprInspectorDead]=f
	q[?sprShielderDead]=f
	q[?sprGruntDead]=f
	q[?sprEliteGruntDead]=f
	q[?sprEliteShielderDead]=f
	q[?sprEliteInspectorDead]=f
	q[?sprVanDead]=f
	q[?sprPopoFreakDead]=f
	q[?sprFireBallerDead]=b
	q[?sprEnemyHorrorDead]=r
	q[?sprTurtleDead]=b
	q[?sprMolesargeDead]=b
	q[?sprMolefishDead]=b
	q[?sprSuperFireBallerDead]=b
	q[?sprJockDead]=b
	q[?sprMimicDead]=b
	q[?sprSuperMimicDead]=b
//	q[?sprCrownGuardianDead]=r
//	q[?sprOldGuardianDead]=r
//	q[?sprFastRatDead]=a
	q[?sprGatorDead]=b
	q[?sprSuperFrogDead]=a
	q[?sprExploderDead]=a
	q[?sprRatkingDead]=a
	q[?sprRatDead]=b
	q[?sprBuffGatorDead]=b
	q[?sprInvSpiderDead]=c
	q[?sprInvLaserCrystalDead]=c
	q[?sprJungleBanditDead]=b
	q[?sprJungleFlyDead]=b
	q[?sprJungleAssassinDead]=b
	
	q[?sprAllyDead]=b
	q[?sprSaplingDead]=r
	
	q[?sprLilHunterDead]=r
	q[?sprBanditBossDead]=b
	q[?sprScrapBossDead]=o
	q[?sprFrogQueenDead]=a
	q[?sprFrogEggDead]=a
	q[?sprHyperCrystalDead]=c
	q[?sprTechnoMancerDead]=c
	q[?sprTechnoMancerLastDead]=c
	q[?sprLastDeath]=f
	}



#macro mcrBlood_offset	7952

/* 
#macro c_acid	[make_color_rgb(133, 249, 26),	make_color_rgb(133, 194, 5)]
#macro c_blood	[make_color_rgb(174, 58, 45),	make_color_rgb(134, 44, 35)]
#macro c_curse	[make_color_rgb(136, 36, 174),	make_color_rgb(103, 27, 131)]
#macro c_fuel	[make_color_rgb(0, 255, 255),	make_color_rgb(46, 194, 250)]
#macro c_oil	[make_color_rgb(96, 59, 52),	make_color_rgb(49, 18, 12)]
#macro c_rad	[make_color_rgb(190, 253, 8),	make_color_rgb(72, 253, 8)]
 */
#macro c_acid	[c_green,						make_color_rgb(133, 194, 5)]
#macro c_blood	[c_red,							make_color_rgb(134, 44, 35)]
#macro c_curse	[make_color_rgb(136, 36, 174),	make_color_rgb(103, 27, 131)]
#macro c_fuel	[c_aqua,						make_color_rgb(14,	19,	134)]
#macro c_oil	[make_color_rgb(96, 59, 52),	c_black]
#macro c_rad	[make_color_rgb(190, 253, 8),	make_color_rgb(54, 156, 17)]



#macro ruleStayBlood	mod_variable_get("mod", "nts", "ruleStayBlood")
#macro ruleCorpseBlood	mod_variable_get("mod", "nts", "ruleCorpseBlood")

#macro BloodMax		mod_variable_get("mod", "nts", "BloodMax")
#macro BloodSpeed	mod_variable_get("mod", "nts", "BloodSpeed")