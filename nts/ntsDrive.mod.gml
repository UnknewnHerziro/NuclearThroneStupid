
#define init
	{
	globalvar gvCDsLen, gvChestsLen, gvOnamesLen, gvCBsLen, gvChestMountsLen, mapMountOffsetY, mapNames
	gvCDsLen = array_length(mcrCDs)
	gvChestsLen = array_length(mcrChests)
	gvOnamesLen = array_length(mcrOnames)
	gvCBsLen = array_length(mcrCBs)
	gvChestMountsLen = array_length(mcrChestMounts)
	mapMountOffsetY = ds_map_create()
	mapMountOffsetY[?RadChest] = -12
	mapMountOffsetY[?RogueChest] = -12
	mapMountOffsetY[?Barrel] = -12
	mapMountOffsetY[?GoldBarrel] = -12
	mapMountOffsetY[?ToxicBarrel] = -12
	mapMountOffsetY[?Bandit] = -6
	mapMountOffsetY[?BigMaggot] = -10
	mapMountOffsetY[?Scorpion] = -10
	mapMountOffsetY[?GoldScorpion] = -10
	mapMountOffsetY[?BanditBoss] = -12
	mapMountOffsetY[?Gator] = -6
	mapMountOffsetY[?BuffGator] = -8
	mapMountOffsetY[?Exploder] = -12
	mapMountOffsetY[?SuperFrog] = -12
	mapMountOffsetY[?Ratking] = -10
	mapMountOffsetY[?RatkingRage] = -10
	mapMountOffsetY[?Salamander] = -10
	mapMountOffsetY[?Car] = -10
	mapMountOffsetY[?BecomeScrapBoss] = -8
	mapMountOffsetY[?ScrapBoss] = -12
	mapMountOffsetY[?ScrapBossMissile] = -8
	mapMountOffsetY[?BigDogExplo] = -12
	mapMountOffsetY[?Salamander] = -10
	mapMountOffsetY[?Spider] = -8
	mapMountOffsetY[?InvSpider] = -8
	mapMountOffsetY[?SnowTank] = -16
	mapMountOffsetY[?GoldSnowTank] = -16
	mapMountOffsetY[?SnowTankExplode] = -16
	mapMountOffsetY[?JungleBandit] = -6
	mapMountOffsetY[?JungleFly] = -12
	mapMountOffsetY[?Nothing] = -24
	mapNames = ds_map_create()
	}

#define clear_up
ds_map_destroy(mapMountOffsetY)
ds_map_destroy(mapNames)

#define step
if(GameCont.loops <= variable_instance_get(GameCont, "nts_RideEnable", 0))
	{
	scrArrays(mcrCDs, gvCDsLen)
	scrArrays(mcrChests, gvChestsLen)
	scrArrays(mcrOnames, gvOnamesLen)
	scrArrays(mcrCBs, gvCBsLen)
	
	scrDrive(Sniper, ScrapBoss)
	scrDrive(Sniper, BecomeScrapBoss)
	scrDrive(Ally, Car)
	scrDrive(BanditBoss, Car)
	scrDrive(MeleeBandit, Car)
	for(var ia=0; ia<gvChestsLen; ia++)
		{
		for(var ib=0; ib<gvChestMountsLen; ib++)
			{scrDrive_chest(mcrChests[@ia], mcrChestMounts[@ib])}
		}
	for(var ia=0; ia<gvCDsLen; ia++)
		{
		scrDrive(mcrCDs[@ia], Car)
		for(var ib=0; ib<gvCBsLen; ib++)
			{scrDrive(mcrCDs[@ia], mcrCBs[@ib])}
		}
	scrDrive(Bandit, ScrapBossMissile)
	scrDrive(Maggot, BigMaggot)
	scrDrive(Maggot, BanditBoss)
	scrDrive(Maggot, Bandit)
	scrDrive(Sniper, BigDogExplo)
	
	with(Car)
		{
		if("nts_turn"!in self){nts_turn = 0}
		image_angle = (image_angle>90 && image_angle<=270) ? 180 : 0
		if(!variable_instance_get(self, "ntsDrive_CB", true))
			{continue}
		if(!instance_exists(variable_instance_get(self, "ntsDrive_Driver", noone)))
			{continue}
		image_angle = direction
		image_yscale = (image_angle>90 && image_angle<=270) ? -1 : 1
		instance_create(x, y, Smoke)
		switch(ntsDrive_Driver.object_index)
			{
			case Ally: 
				scrSearchRush(enemy)
				break
			case BanditBoss: 
			case MeleeBandit: 
				scrSearchRush(Player)
				break
			case BuffGator: 
			case JungleBandit: 
				{
				rush(0.5, 4)
				if(scrCarTurn(10))
					{direction = ntsDrive_Driver.gunangle + random_range(30, -30)}
				}
				break
			case Gator: 
			case Sniper: 
			case Bandit: 
				rush(0.5, 3.5)
				break
			default: break
			}
		motion_add(direction, 1.2*current_time_scale)
		}
	}



#define scrArrays(mcr, len)
	{
	for(var i=0; i<len; i++)
		{
		if(mapNames[?mcr[@i]] == undefined)
			{mapNames[?mcr[@i]] = ds_list_create()}
		ds_list_clear(mapNames[?mcr[@i]])
		with(instances_matching(mcr[@i], "object_index", mcr[@i]))
			{
			if(ds_list_size(mapNames[?object_index]) > 20){break}
			ds_list_add(mapNames[?object_index], self)
			}
		}
	}

#define scrDrive(driver, mount)
	{
	var aryD = ds_list_to_array(mapNames[?driver])
	var aryM = ds_list_to_array(mapNames[?mount])
	
	with(aryD)//with(instances_matching_ne(driver, "ntsDrive_CD", true))
		{
		with(aryM)//with(instances_matching_ne(mount, "ntsDrive_CB", true))
			{
			if(place_meeting(x, y, other))
				{
				ds_list_delete(mapNames[?driver], ds_list_find_index(mapNames[?driver], other))//other.ntsDrive_CD = true
				ds_list_delete(mapNames[?mount], ds_list_find_index(mapNames[?mount], self))//ntsDrive_CB = true
				aryD = ds_list_to_array(mapNames[?driver])
				aryM = ds_list_to_array(mapNames[?mount])
				
				ntsDrive_Driver = other
				script_bind_end_step(scrDrivePlace, 0, other, self, x, y, other.mask_index, variable_instance_get(self, "canfly", false), variable_instance_get(self, "team", variable_instance_get(other, "team", 1)), variable_instance_get(other, "spr_shadow", mskNone))
				scrDrivePlace_1(other, self, x, y, mskNone, true, variable_instance_get(other, "team", 1), mskNone)
				
				break
				}
			}
		}
	}

#define scrDrive_chest(driver, mount)
	{
	var aryD = ds_list_to_array(mapNames[?driver])
	var aryM = ds_list_to_array(mapNames[?mount])
	
	with(aryD)//with(instances_matching_ne(driver, "ntsDrive_CD", true))
		{
		with(aryM)//with(instances_matching_ne(mount, "ntsDrive_CB", true))
			{
			if(place_meeting(x, y, other))
				{
				ds_list_delete(mapNames[?driver], ds_list_find_index(mapNames[?driver], other))//other.ntsDrive_CD = true
				ds_list_delete(mapNames[?mount], ds_list_find_index(mapNames[?mount], self))//ntsDrive_CB = true
				aryD = ds_list_to_array(mapNames[?driver])
				aryM = ds_list_to_array(mapNames[?mount])
				
				ntsDrive_Driver = other
				script_bind_end_step(scrDrivePlace, 0, other, self, x, y, other.mask_index, variable_instance_get(self, "canfly", false), variable_instance_get(self, "team", 1), variable_instance_get(other, "spr_shadow", mskNone))
				scrDrivePlace_1(other, self, x, y, mskNone, true, variable_instance_get(self, "team", 1), mskNone)
				
				break
				}
			}
		}
	}

#define scrDrivePlace(driver, mount, sx, sy, msk, fly, t, shd)
	{
	scrDrivePlace_1(driver, mount, sx, sy, msk, fly, t, shd)
	//with(driver){ntsDrive_CD = false}
	//with(mount){ntsDrive_CB = false}
	instance_destroy()
	}
#define scrDrivePlace_1(driver, mount, sx, sy, msk, fly, t, shd)
	{
	with(mount){team = t}
	with(driver)
		{
		mask_index = msk
		canfly = fly
		spr_shadow = shd
		if(instance_exists(mount))
			{
			if(is_real(mapMountOffsetY[?mount.object_index]))
				{
				x = mount.x
				y = mount.y + mapMountOffsetY[?mount.object_index]
				speed = 0
				nexthurt = current_frame+1
				break
				}
			}
		if(place_free(x, y))
			{break}
		if(place_free(sx, sy))
			{
			x = sx
			y = sy
			break
			}
		my_health = 0
		}
	}

#define scrCarTurn
	{
	nts_turn += current_time_scale
	if(nts_turn mod argument0 < current_time_scale)
		{
		nts_turn = nts_turn div argument0
		return true
		}
	}

#define scrSearchRush
	{
	var ms = 3
	if(instance_exists(argument0))
		{
		var tar = instance_nearest(x, y, argument0)
		if(!collision_line(x, y, tar.x, tar.y, Wall, false, true))
			{
			if(distance_to_object(tar) < 96)
				{var ms = 6}
			else{direction = point_direction(x, y, tar.x, tar.y); var ms = 4}
			}
		}
	rush(1.5, ms)
	if(scrCarTurn(30))
		{direction = ntsDrive_Driver.gunangle + random_range(30, -30)}
	}



#define	rush(us, ms)	speed = min(speed+us*current_time_scale, ms)

#macro	mcrCDs			[BuffGator, Gator, Sniper, JungleBandit, Bandit]
#macro	mcrChests		[GoldChest, GoldBarrel, RadChest, WeaponChest, HealthChest, AmmoChestMystery, AmmoChest, ToxicBarrel, IDPDChest, RogueChest]
#macro	mcrOnames		[Ally, Car, ScrapBoss, BecomeScrapBoss, MeleeBandit, ScrapBossMissile, Maggot, BigDogExplo]
#macro	mcrCBs			[Nothing, BanditBoss, RatkingRage, JungleFly, GoldSnowTank, SnowTank, SnowTankExplode, Ratking, GoldScorpion, Scorpion, Salamander, BigMaggot, InvSpider, Spider, Exploder, SuperFrog, Barrel]
#macro	mcrChestMounts	[BanditBoss, RatkingRage, Ratking, GoldScorpion, Scorpion, BigMaggot, BuffGator, Gator, JungleBandit, Bandit]