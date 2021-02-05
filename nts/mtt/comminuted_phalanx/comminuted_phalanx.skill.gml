
#define init
	{
	global.icon = sprite_add("Icon.png", 1, 8, 8)
	global.skill = sprite_add("Skill.png", 1, 12, 16)
	
	global.mapData = ds_map_create()
	
	
	
	global.mapData[?FrogQueenBall]	= sprFrogQueenBall
	global.mapData[?LHBouncer]		= sprLHBouncer
	
	global.mapData[?BouncerBullet]	= sprBouncerBullet
	global.mapData[?Bullet1]		= sprBullet1
	global.mapData[?AllyBullet]		= sprAllyBullet
	global.mapData[?UltraBullet]	= UltraBullet
	global.mapData[?HeavyBullet]	= sprHeavyBullet
	
	global.mapData[?Bullet2]		= sprBullet2
	global.mapData[?FlameShell]		= sprFireShell
	global.mapData[?HeavySlug]		= sprHeavySlug
	global.mapData[?UltraShell]		= sprUltraShell
	global.mapData[?Slug]			= sprSlugBullet
	global.mapData[?HyperSlug]		= sprHyperSlug
	
	global.mapData[?EnemyBullet1]	= sprEnemyBullet1
	global.mapData[?FireBall]		= sprFireBall
	global.mapData[?EnemyBullet2]	= sprScorpionBullet
	global.mapData[?EnemyBullet3]	= sprEBullet3
	global.mapData[?EnemyBullet4]	= sprEnemyBullet4
	global.mapData[?GuardianBullet]	= sprGuardianBullet
	
	global.mapData[?PopoSlug]		= sprPopoSlug
	global.mapData[?IDPDBullet]		= sprIDPDBullet
	
//	global.mapData[?HorrorBullet]	= sprHorrorBullet
	}

#define clear_up
	{
	ds_map_destroy(global.mapData)
	}

#define game_start

#define skill_take
if(instance_exists(LevCont))
	{
	sound_play(sndBecomeNothingHurt)
	sound_play(sndMutant14Dead)
	}

#define skill_lose

#define step
	{
	var lo = {}
	with(Player){if(!lq_exists(lo, `team_${team}`))
		{
		lq_set(lo, `team_${team}`, true)
		with(instances_matching(projectile, "team", team))
			{
		//	if(sprite_index==global.mapData[?object_index] && variable_instance_get(self, "nts_cp_copy", true))
			if(is_real(global.mapData[?object_index]) && variable_instance_get(self, "nts_cp_copy", true))
				{
				nts_cp_copy	= false
				damage		= ceil(damage * 0.7)
				
				with(instance_copy(false))
					{scrRandomCopy()}
				scrRandomCopy()
				
				with(creator)
					{
					instance_create(x, y, RecycleGland)
					sound_play(sndRecGlandProc)
					}
				}
			}
		}
	}}

#define scrRandomCopy
	{
	speed		*=	random_range(0.8, 1.2)
	direction	+=	random_range(5, -5)
	image_angle	=	direction
	}



#define skill_name		return "COMMINUTED PHALANX"
#define skill_text		return "@sDOUBLE @wBULLETS @sAND @wSHELLS#@sBUT MAKE LESS @wDAMAGE@s"
#define skill_tip		return "PHANLAX HURTS"
#define skill_icon		return global.icon
#define skill_button	sprite_index = global.skill

#define skill_wepspec	return true
#define skill_avail		return true


