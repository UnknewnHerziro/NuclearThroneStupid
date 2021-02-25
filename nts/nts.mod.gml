
#define init
	{
	global.loadFinish = false
//Commands
	chat_comp_add("nts-help",		"Command list. ")
	chat_comp_add("lowquality",		"Low quality to decrease lags. ")
	chat_comp_add("fps60",			"60 fps mode or not. ")
	chat_comp_add("wide",			"Wide Screen display mode or not. ")
	chat_comp_add("bloodmax",		"[0~3]",	"Size of max number of dynamic bloodstains. ")
		chat_comp_add_arg("bloodmax",	0,	"0",	"Disable dynamic bloodstains. ")
		chat_comp_add_arg("bloodmax",	0,	"1",	"Dynamic bloodstains fade quickly. ")
		chat_comp_add_arg("bloodmax",	0,	"2",	"Dynamic bloodstains show in seconds. ")
		chat_comp_add_arg("bloodmax",	0,	"3",	"Moderate number of dynamic bloodstains show awhile. ")
//	chat_comp_add("bloodcorpse",	"Enable corpses leave blood or not when stay bloodstains. ")
	chat_comp_add("bloodstay",		"Enable stay bloodstains or not. ")
	chat_comp_add("customarea",		"Enable custom area or not. ")
	chat_comp_add("skirmish",		"Enable skirmish or not. ")
	chat_comp_add("stayportal",		"Enable stay portal or not in coop game. ")
	chat_comp_add("ridemax",		"Max loops for enable ride system. ")
	chat_comp_add("tips",			"Do tips or not. ")
	chat_comp_add("wepview",		"Only weapons examining for tips or not. ")

//Settings
	global.DoTips = false
	global.WepTips = false
	global.CustomArea = true
	global.RideEnable = -1
	global.ruleStayPortal = false
	global.ruleStayBlood = false
	global.ruleCorpseBlood = true
	global.ruleSkirmish = true

//Blood
	globalvar BloodMax, BloodSpeed
	BloodMax = 0
	BloodSpeed = 0

//Viewwep
	globalvar ViewwepData
	ViewwepData = ds_map_create()
	scrViewwepData()

//Mutsay
	globalvar SkillsayData, UltrasayData, CrownsayData
	SkillsayData = ds_map_create()
	scrSkillsayData()
	UltrasayData = ds_map_create()
	scrUltrasayData()
	CrownsayData = ds_map_create()
	scrCrownsayData()
	
	
	global.loadFinish = true
	}

#define clean_up
ds_map_destroy(ViewwepData)
ds_map_destroy(SkillsayData)
ds_map_destroy(UltrasayData)
ds_map_destroy(CrownsayData)



#define chat_command
	{switch(argument0){
		
		case "nts-help": 
			{
			repeat(3){trace("")}
			trace("NTS help list here. ")
			trace("/nts-help : Command list. ")
			trace("/lowquality : Low quality to decrease lags. ")
			trace("/fps60 : 60 fps mode or not. Make sure you are playing as NTT beta(9942+), otherwise there will be tons of bugs. ")
			trace("/wide : Wide Screen display mode or not. ")
			trace(`/bloodmax : Size of max number of dynamic bloodstains. Set it to 0 if game slowly. (0~3, default=0) `)
		//	trace("/bloodcorpse : Enable corpses leave blood or not when stay bloodstains. ")
			trace("/bloodstay : Enable stay bloodstains or not. ")
			trace("/customarea : Enable custom area or not. ")
			trace("/skirmish : Enable skirmish or not. ")
			trace("/stayportal : Enable stay portal or not in coop game. ")
			trace("/ridemax : Max loops for enable ride system. Set it to -1 if game slowly. (default=-1)")
			trace("/tips : Do tips or not. ")
			trace("/wepview : Only weapons examining for tips or not. ")
			trace("")
			trace("We strongly recommend that you play in the NTT beta(9942+), otherwise there will be lots of terrible glitches perhaps. (inevitable in 60fps mode) ")
			trace("Send E-mail to HaZar_GregorTruck@foxmail.com if you have any suggestion of question. ")
			trace("Have Fun. ")
			return true
			}
		
		case "lowquality": 
			{
			BloodMax = 0
				trace(`Dynamic bloodstains disable. `)
			global.ruleCorpseBlood = false
				trace("Bloody corpses disable. ")
			global.ruleStayBlood = false
				trace("Stay bloodstains disable. ")
			global.RideEnable = -1
				trace(`Ride disable. `)
			global.ruleSkirmish = false
				trace(`Skirmish disable. `)
			
			if(instance_exists(Menu))
				{
				global.CustomArea = false
				trace("Custom Area disable. ")
				}
			else{trace("Custom Area is only settable on menu. ")}
			
			return true
			}
		
		case "fps60": 
			{
			script_bind_step(scrFPSsetting, 0)
			return true
			}
		
		case "bloodmax": 
			{
			if(mod_exists("mod", "NT3D"))
				{
				trace("Dynamic bloodstains are inoperative in NT3D. ")
				return true
				}
			if(argument1 != "")
				{
				var a = clamp(floor(real(argument1)), 0, 5)
				if(a)
					{
					BloodMax = (16<<a) - 1
					BloodSpeed = real(1<<5-a) * 0.0005
					trace(`Set size of max number of dynamic bloodstains to ${a}. `)
					}
				else{
					BloodMax = 0
					trace(`Dynamic bloodstains disable. `)
					}
				}
			else{trace(`/bloodmax : Size of max number of dynamic bloodstains. (0~3, default=0)`)}
			return true
			}
		
		case "bloodcorpse":
			{
			if(mod_exists("mod", "NT3D"))
				{
				trace("Bloody corpses are inoperative in NT3D. ")
				return true
				}
			if(global.ruleCorpseBlood){global.ruleCorpseBlood = false; trace("Bloody corpses disable. ")}
			else{global.ruleCorpseBlood = true; trace("Bloody corpses enable. ")}
			return true
			}
		
		case "bloodstay": 
			{
			if(mod_exists("mod", "NT3D"))
				{
				trace("Stay bloodstains are inoperative in NT3D. ")
				return true
				}
			if(global.ruleStayBlood){global.ruleStayBlood = false; trace("Stay bloodstains disable. ")}
			else{global.ruleStayBlood = true; trace("Stay bloodstains enable. ")}
			return true
			}
		
		case "customarea": 
			{
			if(instance_exists(Menu))
				{
				if(global.CustomArea){global.CustomArea = false; trace("Custom Area disable. ")}
				else{global.CustomArea = true; trace("Custom Area enable. ")}
				}
			else{trace("Custom Area is only settable on menu. ")}
			return true
			}
		
		case "skirmish": 
			{
			if(global.ruleSkirmish){global.ruleSkirmish = false; trace("Skirmish disable. ")}
			else{global.ruleSkirmish = true; trace("Skirmish enable. ")}
			return true
			}
		
		case "stayportal": 
			{
			if(global.ruleStayPortal){global.ruleStayPortal = false; trace("Stay portal disable. ")}
			else{global.ruleStayPortal = true; trace("Stay portal enable. ")}
			return true
			}
		
		case "ridemax": 
			{
			if(mod_exists("mod", "NT3D"))
				{
				trace("Ride are inoperative in NT3D. ")
				return true
				}
			if(argument1 != "")
				{
				var a = floor(real(argument1))
				if(a < 0)
					{trace(`Ride disable. `)}
				else{trace(`Ride enable before L${a} be finished. `)}
				global.RideEnable = a
				}
			else{trace(`/ridemax : Max loops for enable ride system. Set it to -1 if game slowly. (default=-1)`)}
			return true
			}
		
		case "tips": 
			{
			if(global.DoTips){global.DoTips = false; trace("Tips disable. ")}
			else{global.DoTips = true; trace("Tips enable. ")}
			return true
			}
		
		case "wepview": 
			{
			if(global.WepTips){global.WepTips = false; trace("Weapon tips only disable. ")}
			else{global.WepTips = true; trace("Weapon tips only enable. ")}
			return true
			}
		
	default: break
	}}

#define scrFPSsetting
	{
	do{wait 1}until(current_frame mod 1 == 0)
	if(instance_exists(Menu))
		{
		if(current_time_scale==0.5 && room_speed==60)
			{
			current_time_scale = 1
			room_speed = 30
			trace("60 fps disable. ")
			}
		else{
			current_time_scale = 0.5
			room_speed = 60
			trace("60 fps enable. Make sure you are playing as NTT 9944, there will be tons of bugs in other version. ")
			trace("We strongly recommend that you play in the 9944 version, otherwise there will be a lot of terrible errors. (inevitable in 60fps mode)")
			}
		}
	else{trace("60 fps is only settable on menu. ")}
	instance_destroy()
	}



#define game_start
	{
	with(Player)
		{
		scrOriginalRacesWepReplace()
		scrPlayerGSV()
		}

	with(GameCont)
		{
		var list = ds_list_create()
		ds_list_add_array(list, ["crystal rapier", "crystal buckler", "crystal hammer"])
		ds_list_shuffle(list)
		hcd = ds_list_to_array(list)
		ds_list_destroy(list)
		
		Deal = 0
		with(instances_matching(Player, "race", "phantom")){GameCont.Deal = 5}
		
		DoTips = [global.DoTips, global.DoTips, global.DoTips, global.DoTips]
		nts_CustomArea = global.CustomArea
		
		Money = 0
		RadiationLump = 0
		
		SayText = [" ", " ", " ", " "]
		}
	}





#define step
	{
	if(mod_exists("mod", "NT3D"))
		{
		global.RideEnable = -1
		global.ruleStayBlood = false
		global.CorpseBlood = false
		BloodMax = 0
		}
	
	var PickDistance = skill_get(3) ? 32 : 4
	var CheckDistance = 4
	//var mm_index = scrLastMouseMovingIndex()
	
	scrInstancesNotDisappear()
	scrDealInvCrystals()
	scrSpecialWepChange()
	
	if(global.ruleSkirmish && instance_exists(GenCont))
		{script_bind_end_step(scrSkirmish, 0)}
	
	with(GameCont)
		{
		DoTips = [global.DoTips, global.DoTips, global.DoTips, global.DoTips]
		nts_CustomArea = global.CustomArea
		nts_RideEnable = global.RideEnable
		}
	with(instances_matching(Player, "visible", true))
		{
		scrPlayerRestats()
		scrWepangle()
		scrWepDrop()
		scrPunch()
		scrNoneSwap()
	//	scrPlayerDostats()
		scrPlayerPickPressed(PickDistance, CheckDistance)
	//	scrPlayerAutoPick(PickDistance, CheckDistance)
		scrPlayerViewWep()
	//	my_health_last = my_health
		}
	if(instance_number(Player)>1 && global.ruleStayPortal && instance_number(Portal)==1){scrStayPortal()}
	//scrMutbuttonSays(mm_index)
	for(var i=0; i<maxp; i++){scrMutbuttonSays(i)}
//	scrSetBlood()
	}



#define scrLastMouseMovingIndex
	{
	var a = -1
	try{is_array(mouse_delta_x)}catch(error){return -1; exit}
	for(var i=0; i<maxp; i++)
		{if(mouse_delta_x[i]!=0 || mouse_delta_y[i]!=0){a = i}}
	return a
	}

#define scrOriginalRacesWepReplace
	{
	switch(race)
		{
		case "venuz": break
		case "steroids": 
			if(wep == wep_revolver){wep = "crowbar"}
			if(bwep == wep_revolver){bwep = "flashlight"}
			break
		case "chicken": 
			if(wep==wep_chicken_sword && bwep==0)
				{bwep = "broken royal sword"}
			break
		case "rogue": break
		case "skeleton": break
		case "frog": break
		default: 
			if(wep == wep_revolver)
				{
				switch(race)
					{
					case "fish": 
						wep = wep_shotgun
						ammo[1] = 0
						ammo[2] = 30
						break
					case "crystal":
						wep = "sniper pistol"
						break
					case "eyes":
						wep = "pipe"
						ammo[1] = 0
						break
					case "melting":
						wep = "flesh arm"
						ammo[1] = 0
						break
					case "plant":
						wep = wep_crossbow
						ammo[1] = 0
						ammo[3] = 21
						break
					case "rebel":
						wep = "bow"
						ammo[3] = 21
						break
					case "horror": 
						wep = 0
						ammp[1] = 0
						break
					default: 
						break
					}
				}
			break
		}
	}

#define scrPlayerGSV
	{
	scrPlayerRestats()
	}

#define scrPlayerRestats
	{
	/*
	if("Bleed"!in self){Bleed = 0}
	if("Fracture"!in self){Fracture = 0}
	if("Infection"!in self){Infection = 0}
	if("Poisonation"!in self){Poisonation = 0}
	if("Scald"!in self){Scald = 0}
	if("Spasm"!in self){Spasm = 0}
	
	if("fracbf"!in self){fracbf = -1}
	if("bleedbf"!in self){bleedbf = -1}
	if("poisonrot"!in self){poisonrot = 0}
	if("scaldbf"!in self){scaldbf = -1}
	
	if("my_health_last"!in self){my_health_last = my_health}*/
	if("BeDriver"!in self){BeDriver = noone}
	}

#define scrPlayerDostats
	{
	if(Bleed > 0)
		{
		if(race == "melting"){}
		else{
			if(my_health > 1){if(!irandom(1000/(my_health-1)-1))
				{
				with(instance_create(x, y, BloodGamble))
					{image_angle = random(360)}
				sound_play(sndHitFlesh)
				my_health --
				lasthit=[sprBloodGamble, "bleed"]
				}}
			}
		Bleed --
		bleedbf = (bleedbf+0.6) mod 7
		script_bind_draw(Dbloom, depth+1, x, y-12, 1, 1, sprBloodStreak, bleedbf, 90, 1 )
		}
	
	if(Fracture > 0)
		{
		if(race == "eyes"){}
		else{maxspeed = (GameCont.StoredSpeed[index]+1)*0.5};
		Fracture --
		fracbf = (fracbf+0.2) mod 3
		if(fracbf<1){fracbf++}
		script_bind_draw(Dbloom, depth+1, x, y-24, 1, 1, sprBonePileDead, fracbf, 0, 0.5 )
		}
	else{maxspeed = GameCont.StoredSpeed[index]}
	
	if(Poisonation==0 && Infection > 0 && my_health<maxhealth)
		{
		if(!irandom(1000/(maxhealth-my_health)-1))
		{Poisonation+=Infection;say(alias+"'s infection is getting worse. ");};Infection-=maxhealth-my_health}
	
	if(Poisonation > 0)
		{
		if(random(1)<0.003 && my_health>(maxhealth*0.5))
			{
			with(instance_create(x, y, ToxicGas))
				{
				damage = 1
				direction = random(360)
				hitid = [sprToxicGas, "poisonation"]
				}
			}
		Poisonation --
		poisonrot = (poisonrot+12) mod 360
		script_bind_draw(Dbloom, depth+1, x, y-18, 1, 1, sprToxicGas, 0, poisonrot, 0.5 )
		}
	
	if(Scald > 0)
		{
		if(random(1)<0.03 && my_health>4 && !skill_get(14))
			{
			gone(GroundFlame, sndSwapFlame, -1)
			my_health --
			with(instance_create(x, y, Flame))
				{
				visible = 0
				direction = random(360)
				team = 0
				damage = 0
				hitid = [sprGroundFlameBig, "scald"]
				}
			Scald -= 30
			}
		Scald --
		scaldbf = (scaldbf+0.3) mod 8
		script_bind_draw(Dbloom, depth+1, x, y-12, 3, 3, sprGroundFlameBig, scaldbf, 0, 1 )
		}
	
	if(Spasm)
		{
		motion_set(random(360),2)
		Spasm --
		with(instance_create(x, y, LightningSpawn))
			{image_angle = random(360)}
		}
	}

#define scrInstancesNotDisappear
	{
/*	with(instances_matching_ne(Bolt, "nts_alarmed", true)){alarm0 = 0}
	with(instances_matching_ne(HeavyBolt, "nts_alarmed", true)){alarm0 = 0}
	with(instances_matching_ne(UltraBolt, "nts_alarmed", true)){alarm0 =  0}
*/	with(instances_matching_ne(Flare, "nts_alarmed", true)){alarm0 = 300; nts_alarmed=true}
//	with(instances_matching_ne(Shell, "nts_unlock_coward", true)){if(sprite_index==sprCigarette){alarm0 = 0}}
	}

#define scrDealInvCrystals
	{
	with(instances_matching_gt(GameCont, "Deal", 0)){with(instances_matching_ne(enemy, "PhtmT", true))
		{
		if(random(50)<min(GameCont.Deal,5) && object_index!=CustomEnemy && object_index!=ScrapBoss && object_index!=LilHunter && object_index!=Nothing && object_index!=Nothing2 && object_index!=FrogQueen && object_index!=HyperCrystal && object_index!=TechnoMancer && object_index!=Last)
			{
			with(instance_create(x, y, InvLaserCrystal))
				{
				my_health = other.my_health
				meleedamage = other.meleedamage
				raddrop = other.raddrop
				PhtmT = true
				instance_delete(other)
				}
			}
		else{PhtmT = true}
		}}
	}

#define scrSpecialWepChange		script_bind_end_step(scrSpecialWepChange_1, 0)
#define scrSpecialWepChange_1
	{
	with(WepPickup)
		{
		switch(is_object(wep) ? lq_get(wep, "wep") : wep)
			{
			case wep_none: 
				instance_destroy()
				break
			
			case "bandit": 
				say(`${palias} woke a bandit up. `)
				with(instance_create(x, y, Bandit))
					{
					my_health	= wep_data(other.wep, "vars", "my_health",	my_health)
					hitid		= wep_data(other.wep, "vars", "hitid",		hitid)
					gunspr		= wep_data(other.wep, "vars", "gunspr",		gunspr)
					spr_idle	= wep_data(other.wep, "vars", "spr_idle",	sprBanditIdle)
					spr_walk	= wep_data(other.wep, "vars", "spr_walk",	sprBanditWalk)
					spr_hurt	= wep_data(other.wep, "vars", "spr_hurt",	sprBanditHurt)
					spr_dead	= wep_data(other.wep, "vars", "spr_dead",	sprBanditDead)
					snd_hurt	= wep_data(other.wep, "vars", "snd_hurt",	sndBanditHit)
					snd_dead	= wep_data(other.wep, "vars", "snd_dead",	sndBanditDie)
					}
				instance_destroy()
				break
			
			case "barrel": 
				say(`${palias} put the barrel down carefully. `)
				instance_create(x, y, Barrel)
				instance_destroy()
				break
			
			//Mansion
			case "golden barrel": 
				say(`${palias} put the barrel down carefully. `)
				instance_create(x, y, GoldBarrel)
				instance_destroy()
				break
			
			default: break
			}
		}
	instance_destroy()
	}

#define scrSkirmish
	{
	if(!instance_exists(GenCont))
		{
		var a = GameCont.area
		if(is_real(a))
			{mod_script_call("mod", "ntsSkirmish", `_${a}`)}
		else{mod_script_call("area", a, "ntsSkirmish")}
		}
	instance_destroy()
	}

#define scrWepangle
	{
	if(!is_object(wep)){if(wep=="ally gun" || wep=="bandit gun" || wep=="big bandit gun"){}
	else{if(abs(wepangle)!=120){wepangle=120}}}
	if(!is_object(bwep)){if(bwep=="ally gun" || bwep=="bandit gun" || bwep=="big bandit gun"){}
	else{if(abs(bwepangle)!=120){bwepangle=120}}}
	}

#define scrWepDrop
	{
	if(variable_instance_get(self, "nts_can_drop", true) && curse<=0)
		{
		if(button_check(index, "pick"))
			{
			nts_wep_droping = variable_instance_get(self, "nts_wep_droping", 0) + current_time_scale
			if(nts_wep_droping >= 30)
				{
			//	if(wep != wep_none)
			//		{say(`${alias} dropped #${weapon_get_name(wep)}. `)}
				
				with(instance_create(x, y, WepPickup))
					{
					speed		= 10
					direction	= other.gunangle
					rotation	= random(360)
					
					creator	= other
					wep		= other.wep
					}
				
				wep = wep_none
				
				return true
				}
			return false
			}
		}
	nts_wep_droping = 0
	return false
	}

#define scrPunch
	{
	if(variable_instance_get(self, "nts_can_punch", true))
		{
		if(button_pressed(index,"fire"))
			{
			if(wep==0 && reload<=0)
				{
				reload = 10
				
				with(instance_create(x, y, Shank))
					{
					direction = other.gunangle
					image_angle = direction
					speed = 1
					team = other.team
					creator = other
					hitid = [other.spr_idle, other.alias]
					damage = ceil(sqrt(power(GameCont.level, 3))) * (skill_get(mut_impact_wrists) ? 2 : 1) + 1
					}
				
				sound_play_hit(sndImpWristHit, 0)
				motion_add(gunangle, maxspeed)
				}
			}
		
		if(race=="steroids" && button_pressed(index,"spec") && bwep==0 && breload<=0)
			{
			breload = 10
			with(instance_create(x, y, Shank))
				{
				direction = other.gunangle
				image_angle = direction
				speed = 1
				team = other.team
				creator = other
				hitid = [other.spr_idle, other.alias]
				damage = ceil(sqrt(power(GameCont.level, 3))) * (skill_get(mut_impact_wrists) ? 2 : 1) + 1
				}
			sound_play_hit(sndImpWristHit, 0)
			}
		}
	}

#define scrNoneSwap
	{
	if(button_pressed(index,"swap")){if(wep!=0 && bwep==0 && canswap)
		{
		if(fork())
			{
			wait current_time_scale
			bwep	= wep
			breload	= reload
			bcurse	= curse
			bwkick	= wkick
			
			wep		= wep_none
			curse	= 0
			wkick	= 0
			exit}else{exit}
		}}

	}

#define scrPlayerPickPressed(PickDistance, CheckDistance)
	{
	if(button_pressed(index,"pick") && !nearwep)
		{
		//IDK
		with(LightBeam){if(place_meeting(x, y, other))
			{say(other.alias+" found the light. ");gone(0,sndSwapGold,-1)}}
		with(ProtoStatue){if(place_meeting(x, y, other))
			{say(other.alias+" recollected the old legend. ");gone(0,sndSwapGold,-1)}}
		with(TutorialTarget){if(place_meeting(x, y, other))
			{gone(0,-2,1)}}
		
		//Desert and NightDesert
		with(Bandit){if(distance_to_object(other)<=PickDistance)
			{
			var w = {wep:"bandit", vars:{}}
			w.vars.my_health	= my_health
			w.vars.hitid		= hitid
			w.vars.gunspr		= gunspr
			w.vars.spr_idle		= spr_idle
			w.vars.spr_walk		= spr_walk
			w.vars.spr_hurt		= spr_hurt
			w.vars.spr_dead		= spr_dead
			w.vars.snd_hurt		= snd_hurt
			w.vars.snd_dead		= snd_dead
			rplc(w)
			picksay("bandit!")
			say(`${other.alias} picked a bandit up. `)
			gone(0, snd_hurt, 0)
			}}
		
		with(Barrel){if(distance_to_object(other)<=PickDistance){
			rplc("barrel");picksay("barrel!"); say(`${other.alias} picked a barrel up. `)
			gone(0,sndSwapFlame,0)}}
		
		with(Cactus){if(distance_to_object(other)<=PickDistance){
			rplc({wep:"cactus", name:"splinter", wepspr:sprite_index, ammo:irandom_range(32, 64)});picksay("cactus!"); say(`${other.alias} picked a cactus up. `)
			gone(0,sndHitPlant,1)}}
		
		with(BigSkull){if(place_meeting(x, y, other)){say(other.alias+" found a big fish skull. #It's so heavy that nobody can move it. ");gone(Dust,sndHammer,-1)}}
		
		//Oasis
		with(WaterMine){if(place_meeting(x, y, other)){say(other.alias+" can't move the water mine, #because it's going to explode. ");}}
		
		with(Anchor){if(place_meeting(x, y, other)){say(other.alias+" found A big anchor. #It's so heavy that nobody can move it. ");gone(0,sndHammer,-1);}}
		
		with(ToxicBarrel){if(place_meeting(x, y, other)){say(other.alias+" can't move the toxic barrel, #because it's going to be spilt. ");}}
		
		with(PizzaEntrance){if(place_meeting(x, y, other)){
			if(other.wep=="crowbar" || other.wep=="golden crowbar"){image_index=1;instance_create(x+16,y+16,Portal);GameCont.area=102;GameCont.subarea=0;gone(0,sndHammer,-1)}
			else{say(`${other.alias} found a manhole cover, #but ${other.alias} couldn't move it without any lever tool. `);gone(0,sndHammer,-1)};
			}}
		
		//Scrapyard
		with(CarVenus){if(place_meeting(x, y, other)){say(other.alias+" found a pretty car. #The engine is broken but easy to fixed with screwdriver. ");gone(Smoke,sndUseCar,-1)}}
		
		//Mansion
		with(GoldBarrel){if(distance_to_object(other)<=PickDistance){
			rplc("golden barrel");
			gone(0,-2,0);}}
		
		with(MoneyPile){if(place_meeting(x, y, other)){say(other.alias+" found a pile of useless green paper. ");gone(0,-1,1)}}
		
		with(SnowMan){if(place_meeting(x, y, other)){say("Lovely snowman. ");}}
		
		//Lab
		with(Tube){if(place_meeting(x, y, other)){say(other.alias+" broke the empty tube. #Nothing happened. ");gone(0,-1,1)}}
		
		with(MutantTube){if(place_meeting(x, y, other)){say("Now "+other.alias+" has known why the broken tube be all empty. ");}}
		
		//Palace
		with(SmallGenerator){if(place_meeting(x, y, other)){say(`It's dangerous to move a generator for ${other.alias}. `);}}
		
		//Throne
		with(Carpet){if(distance_to_object(other)<=PickDistance){
			say(other.alias+" stole the ROYAL CARPET. H O W   D A R E   Y O U . ");
			gone(0,sndWallBreak,0)}}
		
		//Proto
		with(Torch){if(place_meeting(x, y, other)){say(other.alias+" blew out the torch. ");gone(0,sndSwapCursed,1)}}
		
		
		
		}
	}

#define scrPlayerAutoPick(PickDistance, CheckDistance)
	{
	
	with(Bolt){if(!canhurt){if(place_meeting(x, y, other)){
		with(other)
			{
			say(alias+" removed the bolt. ");
			ammo[3]+=1;if(ammo[3]>typ_amax[3]){ammo[3]=typ_amax[3]};
			picksay("+1 bolt");
			};
		gone(0,-2,0)}}}
	with(HeavyBolt){if(!canhurt){if(place_meeting(x, y, other)){
		with(other)
			{
			say(alias+" removed the heavy bolt. ");
			ammo[3]+=2;if(ammo[3]>typ_amax[3]){ammo[3]=typ_amax[3]};
			picksay("+2 bolt");
			};
		gone(0,-2,0)}}}
	with(UltraBolt){if(!canhurt){if(place_meeting(x, y, other)){
		with(other)
			{
			say(alias+" removed the ultra bolt. ");
			ammo[3]+=1;if(ammo[3]>typ_amax[3]){ammo[3]=typ_amax[3]};
			picksay("+1 bolt");
			};
		gone(0,-2,0)}}}
	
	if(global.loadFinish){with(Corpse){if("CorpseChecked" !in self){if(distance_to_object(other)<=PickDistance and speed<=3){
		CorpseChecked=1; image_alpha=0.5;
		switch(sprite_index)
			{
			case sprBoneFish1Dead:
				picc(0, 5, other.alias+" took the bones from the corpse of fish. ", "#But they are broken. ", true)
				gone(0,sndOasisExplosionSmall,2)
				break;
			case sprCrabDead:
				picc(0, 100, other.alias+" took the plants from the corpse of crab. ", "#But they are digested. ", true)
				gone(0,sndOasisExplosionSmall,2)
				break;
			
			case sprMSpawnDead:
				picc(0, 10, other.alias+" took the bones from the corpse. ", "#But they are broken. ", true)
				gone(0,sndHitFlesh,2)
				break;
			case sprGoldScorpionDead:
				GameCont.RadiationLump++
				picksay("+1 RadiationLump")
				say(other.alias+" took the sting from the corpse of scorpion. ")
				gone(0,sndHitMetal,2)
				break;
			case sprScorpionDead:
				var a = irandom(4)
				if(a){say(other.alias+" took the sting from the corpse of scorpion. #But it's broken. ")}
				else{GameCont.RadiationLump++; say(other.alias+" took the sting from the corpse of scorpion. "); picksay("+1 RadiationLump")}
				gone(0,sndHitFlesh,2)
				break;
			case sprBanditDead:
				picc(0, 4, other.alias+" took the fabrics from the corpse of bandit. ", "#But they are damaged. ", true)
				gone(0,sndHitPlant,2)
				break;
			case sprSpookyBanditDead:
				picc(0, 4, other.alias+" took the fabrics from the corpse of bandit. ", "#But they are damaged. ", true)
				gone(0,sndHitPlant,2)
				break;
			case sprSnowBanditDead:
				picc(6, 10, other.alias+" took the fabrics from the corpse of bandit. ", "", true)
				gone(0,sndHitPlant,2)
				break;
			
			case sprSniperDead:
				picc(0, 3, other.alias+" took the metals from the wreckage of sniper. ", "The wreckage of sniper is totally damaged. ", false)
				gone(0,sndHitMetal,2)
				break;
			case sprSalamanderDead:
				picc(0, 30, other.alias+" took the alcohol from the corpse of salamander. ", `The salamander burned all alcohol. #${other.alias} found nothing. `, false)
				gone(0,sndSwapFlame,2)
				break;
			case sprRavenDead:
				say(other.alias+" plucked the raven. ")
				gone(0,sndRavenHit,2)
				break;
			case sprMeleeDead:
				picc(0, 4, other.alias+" took the fabrics from the corpse of assassin. ", "#But they are damaged. ", true)
				gone(0,sndHitPlant,2)
				break;
			
			case sprLaserCrystalDead:
				picc(0, 50, other.alias+" picked the crystal shards. ", "#But it's broken. ", true)
				gone(0,sndCrystalPropBreak,2);
				break;
			case sprSpiderDead:
				picc(0, 20, other.alias+" picked the web from the corpse of spider. ", other.alias+" tried to found the web from the corpse of spider. #But there's nothing. ", false)
				gone(0,sndCrystalPropBreak,2);
				break;
			case sprLightningCrystalDead:
				picc(10, 50, other.alias+" picked the crystal shards. ", "", true)
				gone(0,sndLightningCrystalHit,2);
				break;
			
			case sprWolfDead:
				picc(0, 3, other.alias+" took the metals from the wreckage of wolf. ", "The wreckage of wolf is totally damaged. ", false)
				gone(0,sndHitMetal,2);
				break;
			case sprSnowTankDead:
				picc(0, 9, other.alias+" took the metals from the wreckage of tank. ", "The wreckage of tank is totally damaged. ", false)
				gone(0,sndHitMetal,2);
				break;
			case sprSnowBotDead:
				picc(0, 3, other.alias+" took the metals from the wreckage of snowbot. ", "The wreckage of snowbot is totally damaged. ", false)
				gone(0,sndHitMetal,2);
				break;
			case sprGoldTankDead:
				picc(9, 15, other.alias+" took the metals from the wreckage of tank. ", "", false)
				gone(0,sndHitMetal,2);
				break;
			
			case sprRhinoFreakDead:
				picc(0, 50, other.alias+" picked the crystal shards. ", "#But it's broken. ", true)
				gone(0,sndCrystalPropBreak,2);
				break;
			case sprExploFreakDead:
				picc(0, 30, other.alias+" took the alcohol from the corpse of freak flower. ", `The explosion burned all alcohol. #${other.alias} found nothing. `, false)
				gone(0,sndSwapFlame,2);
				break;
			case sprTurretDead:
				picc(0, 3, other.alias+" took the metals from the wreckage of turret. ", "The wreckage of turret is totally damaged. ", false)
				gone(0,sndHitMetal,2);
				break;
			
			case sprMolesargeDead:
				gone(0,sndHitPlant,2);
				break;
			case sprMolefishDead:
				gone(0,sndHitPlant,2);
				break;
			
			case sprCrownGuardianDead:
				var a = irandom(5)
				if(a==0){say(other.alias+" checked the remains of guardian. #But they are depleted. ")}
				else{GameCont.RadiationLump+=a; say(other.alias+" checked the remains of guardian. "); picksay(`+${a} RadiationLump`)}
				gone(0,sndWallBreak,2);
				break;
			case sprOldGuardianDead:
				var a = irandom(5)
				if(a==0){say(other.alias+" checked the remains of guardian. #But they are depleted. ")}
				else{GameCont.RadiationLump+=a; say(other.alias+" checked the remains of guardian. "); picksay(`+${a} RadiationLump`)}
				gone(0,sndWallBreak,2);
				break;
			
			case sprGatorDead:
				picc(0, 30, other.alias+" skinned the corpse of gator. ", "#But the crocodiles damaged. ", true)
				gone(0,sndGatorDie,2);
				break;
			case sprRatkingDead:
				var a = irandom(2)
				if(a==0){say(other.alias+" tried to take the radiation lumps #from the corpse of big rat. #But it's depleted. ")}
				else{GameCont.RadiationLump+=a; say(other.alias+" took the radiation lumps from the corpse of big rat. "); picksay(`+${a} RadiationLump`)}
				gone(0,sndWallBreak,2);
				break;
			case sprBuffGatorDead:
				with(instance_create(x, y, Shell))
					{
					sprite_index = sprCigarette
					speed = random_range(3,5)
					direction = random(360)
					}
				picc(0, 90, other.alias+" skinned the corpse of gator. ", "#But the crocodiles damaged. ", true)
				gone(0,sndBuffGatorDie,2);
				break;
			
			case sprInvLaserCrystalDead: 
				picc(50, 50, other.alias+" picked the crystal shards. ", "", true)
				gone(0,sndCrystalPropBreak,2);
				break;
			case sprInvSpiderDead:
				picc(0, 50, other.alias+" picked the crystal shards. ", "#But it's broken. ", true)
				gone(0,sndCrystalPropBreak,2);
				break;
			
			case sprJungleBanditDead:
				picc(30, 100, other.alias+" took the fabrics from the corpse of bandit. ", "", true)
				gone(0,sndHitPlant,2);
				break;
			case sprJungleAssassinDead:
				picc(0, 40, other.alias+" took the fabrics from the corpse of assassin. ", "#But they are damaged. ", true)
				gone(0,sndHitPlant,2);
				break;
			
			case sprBanditBossDead:
				picc(100, 200, other.alias+" took the fabrics from the corpse of Big Bandit. ", "", true)
				gone(0,sndBigBanditShootLaugh,2)
				break;
			case sprScrapBossDead:
				gone(0,sndHitMetal,2)
				break;
			case sprLilHunterDead:
				gone(0,sndHitMetal,2)
				break;
			
			default: 
				if(sprite_index == sprWimicDead)
					{
					say(other.alias+" checked the corpse of wimic. ")
					gone(0,sndHitPlant,2); 
					break
					}
				if(sprite_index == sprEnvoyDead)
					{
					say(other.alias+" plucked the envoy. ")
					gone(0,sndRavenScreech,2); 
					break
					}
				if(sprite_index == sprFruitDeadR)
					{
					picc(0, 30, other.alias+" took the alcohol from the corpse of fruit. ", `The explosion burned all alcohol. #${other.alias} found nothing. `, false)
					gone(0,sndHitPlant,2);
					break
					}
					}
				if(sprite_index == sprFruitDeadB)
					{
					gone(0,sndHitPlant,2);
					break
					}
				if(sprite_index == sprFruitDeadG)
					{
					gone(0,sndHitPlant,2);
					break
					}
				if(sprite_index == sprAsnowsinDead)
					{
					picc(30, 100, other.alias+" took the fabrics from the corpse of asnowsin. ", "", true)
					gone(0,sndHitPlant,2);
					break
					}
				if(sprite_index == sprWaiterDead)
					{
					picc(0, 3, other.alias+" took the metals from the wreckage of waiter. ", "The wreckage of waiter is totally damaged. ", false)
					gone(0,sndHitMetal,2)
					break
					}
				break
			}}}}
	
	//IDK
	
	//Desert and NightDesert
	with(NightCactus){if(distance_to_object(other)<=PickDistance){
		picc(0, 20, other.alias+" picked a cactus. ", "#But it dead. ", true)
		gone(0,sndHitPlant,1)}}
	
	with(BonePile){if(distance_to_object(other)<=PickDistance){
		picc(0, 25, other.alias+" checked a pile of bones. ", "#But there's nothing useful. ", true)
		gone(0,sndHitFlesh,1)}}
	
	with(BonePileNight){if(distance_to_object(other)<=PickDistance){
		picc(0, 25, other.alias+" checked a pile of bones. ", "#But there's nothing useful. ", true)
		gone(0,sndHitFlesh,1)}}
	
	//Oasis
	with(WaterPlant){if(distance_to_object(other)<=PickDistance){
		picc(0, 20, other.alias+" picked a aquatic weed. ", "#It's dead. ", true)
		gone(0,sndOasisExplosionSmall,1);}}
	
	with(OasisBarrel){if(distance_to_object(other)<=PickDistance){
		picc(0, 6, other.alias+" broke the barrel. ", "#There's nothing useful. ", true)
		gone(0,sndOasisExplosionSmall,1);}}
	
	//Sewer & PizzaSewer
	with(Pipe){if(distance_to_object(other)<=PickDistance){
		picc(0, 6, other.alias+" broke the pipe. ", "#There's nothing useful. ", true)
		gone(0,-1,1);}}
	
	with(PizzaBox){if(distance_to_object(other)<=PickDistance){say(other.alias+" picked up the pizza box. ");gone(0,-1,1);}}
	
	//Scrapyard
	with(Tires){if(distance_to_object(other)<=PickDistance){
		say(other.alias+" broke the tires. ")
		gone(0,-1,1);}}
	
	//Mansion
	with(YVStatue){if(distance_to_object(other)<=PickDistance){
		var a = irandom(1)
		if(a){say(other.alias+" broke the statue. There is a wep in it. "); with(instance_create(x,y,WepPickup)){wep=irandom_range(1,127)}}
		else{say(other.alias+" broke the statue. ")}
		gone(0,sndWallBreak,1)}}
	
	//Cave & InvCave
	with(Cocoon){if(distance_to_object(other)<=PickDistance){
		picc(0, 200, other.alias+" broke the cocoon. ", other.alias+" broke the cocoon but all webs too. ", false)
		gone(0,-1,1)}}
	
	with(CrystalProp){if(distance_to_object(other)<=PickDistance){
		picc(0, 50, other.alias+" picked up a crystal. ", other.alias+" picked up a crystal but it's soulless. ", false)
		gone(0,-1,1)}}
	
	with(InvCrystal){if(distance_to_object(other)<=PickDistance){
		picc(50, 50, other.alias+" picked up a crystal. ", "", false)
		gone(0,-1,1)}}
	
	//City
	with(SodaMachine){if(distance_to_object(other)<=PickDistance){
		var a=irandom(10)
		if(a==0){say(other.alias+" broke the soda machine and drank the soda. #Thanks the humans. You healed. "); with(other){my_health++}; picksay(`+1 hp`)}
		else{say(other.alias+" broke the soda machine. "); a*=3; GameCont.Money+=a; msay(a)}
		gone(0,-1,1)}}
	
	with(Hydrant){if(distance_to_object(other)<=PickDistance){
		picc(0, 9, other.alias+" broke the hydrant. ", "", true)
		gone(0,-1,1);}}
	
	//Jungle
	with(Bush){if(distance_to_object(other)<=PickDistance){
		picc(0, 60, other.alias+" picked the bush. ", "#It's dead. ", true)
		gone(0,sndHitPlant,1);}}
	
	with(BigFlower){if(distance_to_object(other)<=PickDistance){
		picc(0, 100, other.alias+" picked the flower. ", "#It's dead. ", true)
		gone(0,sndHitPlant,1);}}
	
	//Lab
	with(Server){if(distance_to_object(other)<=PickDistance){
		var a=irandom(5)
		if(a==0){say(other.alias+" broke the server and damaged the lab. "); with(TechnoMancer){my_health-=100}}
		else{say(other.alias+" broke the server. "); a*=3; GameCont.Money+=a; msay(a)}
		gone(0,-1,1);}}
	
	with(Terminal){if(distance_to_object(other)<=PickDistance){
		var a=irandom(5)
		if(a==0){say(other.alias+" broke the terminal and damaged the lab. ");with(TechnoMancer){my_health-=100}}
		else{say(other.alias+" broke the terminal. "); a*=3; GameCont.Money+=a; msay(a)}
		gone(0,-1,1);}}
	
	//Palace
	with(Pillar){if(distance_to_object(other)<=PickDistance){
		var a = irandom(10)
		if(a==0){say(other.alias+" broke the pillar. #It's depleted. ")}
		else{GameCont.RadiationLump+=a; say(other.alias+" broke the pillar. "); picksay(`+${a} RadiationLump`)}
		gone(0,-1,1);}}
	
	//HQ
	with(PlantPot){if(distance_to_object(other)<=PickDistance){
		picc(0, 60, other.alias+" broke the pot. ", "#The plant is dead. ", true)
		gone(0,sndHitPlant,1);}}
	}

#define scrPlayerViewWep	
	{
	if(global.WepTips)
		{scrViewwep(is_object(wep) ? (wep.wep) : wep)}
	else{
		var mx = mouse_x_nonsync - view_xview_nonsync
		var my = mouse_y_nonsync - view_yview_nonsync
		if(my>=18 && my<30)
			{
			if(mx>=20 && mx<64){scrViewwep(is_object(wep) ? (wep.wep) : wep)}
			if(mx>=64 && mx<108){scrViewwep(is_object(bwep) ? (bwep.wep) : bwep)}
			}
		}
	}

#define scrViewwep(wep)
	{
	GameCont.DoTips[@index] = true
	var rtext = mod_script_call("race",		race,	"nts_weapon_examine")
	
	if(is_string(wep))
		{
		var wtext = mod_script_call("weapon",	wep,	"nts_weapon_examine")
		if(is_string(wtext)){return say(lq_defget(rtext, wep, wtext))}
		if(is_object(wtext)){return say(lq_defget(wtext, race, lq_defget(wtext, "d", "You are examining your weapon. ")))}
		}
	
	say(lq_defget(rtext, string(wep), is_string(ViewwepData[?wep]) ? ViewwepData[?wep] : lq_defget(ViewwepData[?wep], race, lq_defget(ViewwepData[?wep], "d", "You are examining your weapon. "))))
	}

#define scrStayPortal
	{
	with(instances_matching(Portal, "object_index", Portal)){with(Player)
		{
		if("nts_portal_size"!in self){nts_portal_size = 1}
		if(collision_point(x, y, other, true, false))
			{
			visible = false
			nts_portal_size = max(0, nts_portal_size-0.05)
			script_bind_draw(scrDrPortalPlayer, -8, self)
			}
		else{other.endgame = 30}
		}}
	with(SpiralCont){with(Player)
		{
		visible = true
		nts_portal_size = 1
		}}
	}

#define scrDrPortalPlayer
	{
	with(argument0)
		{draw_sprite_ext(sprite_index, image_index, x, y, nts_portal_size, nts_portal_size, angle, c_white, 1)}
	instance_destroy()
	}

#define scrMutbuttonSays(i)
	{
	if(i == -1){exit}
	with(mutbutton){if(collision_point(mouse_x_nonsync, mouse_y_nonsync, self, false, false)){switch(object_index)
		{
		case SkillIcon: skillsay(i, skill); break
		case CoopSkillIcon: 
		case EGSkillIcon: ultrasay(i, race, skill-1); break
		case CrownIcon: crownsay(i, crown); break
		default: break
		}}}
	}



#define say
sayto(argument0, 0)
sayto(argument0, 1)
sayto(argument0, 2)
sayto(argument0, 3)

#define sayto
GameCont.SayText[argument1] = argument0

#define skillsay(i, skill)
mutsay(i, SkillsayData[?skill])

#define ultrasay(i, race, skill)
var s = UltrasayData[?race]
if(s == undefined){exit}
mutsay(i, s[skill])

#define crownsay(i, crown)
mutsay(i, CrownsayData[?crown])

#define mutsay(i, s)
if(s == undefined){exit}
sayto(string_replace_all(s, "*p", player_get_alias(i)), i)

#define picksay
with(instance_create(x, y, PopupText))
	{mytext = argument0}

#define picc(mmin, mmax, text, btext, ad)
	{
	var a = irandom_range(mmin, mmax)
	GameCont.Money += a
	if(a){say(text); msay(a)}
	else{say(ad ? (text+btext) : btext)}
	}

#define msay
picksay(`+${argument0} money`)

#define gone
	{
	switch(argument0)
		{
		case 0:break;
		case -1:instance_create(x,y,FXChestOpen);break;
		default:instance_create(x,y,argument0);break;
		}
	switch(argument1)
		{
		case -1:break;
		case -2:sound_play_hit(sndWeaponPickup, 0);break;
		default:sound_play_hit(argument1, 0);break;
		}
	switch(argument2)
		{
		case 0:instance_delete(self);break;
		case 1:my_health=0;break;
		case 2:instance_create(x,y,FXChestOpen);
		default:break;
		}
	}

#define rplc
	{
	var p = other
	with(instance_create(x, y, GameObject)){if(fork())
		{
		wait 1
		with(p)
			{
			if(curse || !canpick){with(instance_create(x, y, WepPickup)){wep = argument0}}
			else{
				if(wep != 0)
					{
					if(bwep != 0)
						{with(instance_create(x, y, WepPickup)){wep = other.wep}}
					else{
						bwep = wep
						breload = reload
						}
					}
				wep = argument0
				reload = 0
				}
			}
		instance_delete(self)
		exit}else{exit}}
	}

#define wep_data	return lq_defget(lq_defget(argument0, argument1, {}), argument2, argument3)

#define Dbloom(dx, dy, xs, ys, spr, sf, rot, al)
	{
	draw_sprite_ext(spr, sf, dx, dy, xs, ys, rot, c_white, al);
	instance_destroy()
	}

#define scrViewwepData
	{
	var a = ViewwepData

	a[?wep_none] =
		{
		"fish" : "Your fists with fin. ", 
		"crystal" : "Your shiny fists. So pretty. ", 
		"eyes" : "Your fists. Sticky and slippy. ", 
		"melting" : "Your fists. They are melting. Hurt. ", 
		"plant" : "Your mouth. You need blood. ", 
		"venuz" : "your fistz. perfect geometry concept. ", 
		"steroids" : "Your trained fists. ", 
		"chicken" : "Your wings. Where's your sword? ", 
		"rebel" : "Your fists. You will retake them all. ", 
		"horror" : "Your mouth. Sadly that you can't see it. ", 
		"rogue" : "Your fists. And the uniform gloves. " , 
		"skeleton" : "Your weak fists. ", 
		"frog" : "Your fists... or some invisible magic, #because even nobody never seen your arms? ", 
	/*	
		"clown" : "Your fists. Born for weild a shovel. ", 
		"gaze" : "Your hands. Do a job? ", 
		"zero" : "Your fists. Proficient in sword skill. ", 
		"shovel knight" : "Your fists. Born to swing the shovel. ", 
		"jack hanma" : "Your fists. Not sharp as your teeth. #But enough for tearing up your preys. ", 
	*/	
		"d":  "Your fists. Clearly. ", 
		}
	a[?wep_revolver] = 
		"Familiar. Why cound you find it here? "
	a[?wep_triple_machinegun] = 
		"A antiquated large machinegun with three muzzles. "
	a[?wep_wrench] = 
		"A basic tool. #Wasteland artisans could fix something by it. "
	a[?wep_machinegun] = 
		"A antiquated common machinegun. "
	a[?wep_shotgun] = "An old shotgun. Antiquated and rare. #You couldn't distinguish it from the gators' shotguns. "
	a[?wep_crossbow] = 
		"A common crossbow. Wasteland hunters made them. "
	a[?wep_grenade_launcher] = 
		"A common grenade launcher. With a strange smell of food. "
	a[?wep_double_shotgun] = 
		"A shotgun with two muzzles. #Heavy and bulky. "
	a[?wep_minigun] = 
		"A common minigun. Symbol of Hunks. "
	a[?wep_auto_shotgun] = 
		"An black auto shotgun. Short and light. "
	a[?wep_auto_crossbow] = 
		"An black auto crossbow. Not so accurate. #Some wasteland hunters prefer to chase the targets. "
	a[?wep_super_crossbow] = 
		"A huge black crossbow. #Some wasteland hunters prefer to kill targets in one shot. "
	a[?wep_shovel] = 
		"A digging tool. You heard some beat from the deep underground. "
	a[?wep_bazooka] = 
		"A common rocket launcher. "
	a[?wep_sticky_launcher] = 
		"The sticky grenades are powerful. #You don't wanna know what the green slimes are. "
	a[?wep_smg] = 
		"A common inaccurate submachinegun. "
	a[?wep_assault_rifle] = 
		"The assault rifles used to be the most popular weapon #in Old Armies before the hyper rifle birth. "
	a[?wep_disc_gun] = 
		"The discs are dangers for the gunner too. "
	a[?wep_laser_pistol] = 
		"A common laser pistol. "
	a[?wep_laser_rifle] = 
		"A common laser rifle. "
	a[?wep_slugger] = 
		"A common slugger. "
	a[?wep_gatling_slugger] = 
		{
		"crystal" : "For some unknown reasons, #you feels bad from these gatling sluggers. ", 
		"eyes" : "Be cursed. Metaphysical. ", 
		"d" : "They used to be used to destroy Tanks. ", 
		}
	a[?wep_assault_slugger] = "They used to be used to destroy Tanks. "
	a[?wep_energy_sword] = 
		{
		"eyes" : "May the force be with you. ", 
		"chicken" : "You saw the power of the dark side. ", 
		"d" : "An engery sword that be designed #to be powerfully use by the people who more soberer. ", 
		}
	a[?wep_super_slugger] = 
		"A powerful slugger that fired five slug. "
	a[?wep_hyper_rifle] = 
		"The limit of bullet-based rifle. "
	a[?wep_screwdriver] = 
		"A basic tool. #Wasteland artisans could fix something by it. "
	a[?wep_laser_minigun] = 
		"A common laser minigun. "
	a[?wep_blood_launcher] = "A blood grenade launcher. #Could engulf bullets. "
	a[?wep_splinter_gun] = "A common splinter gun. #Wasteland hunters made them. "
	a[?wep_toxic_bow] = "A toxic crossbow. #Wasteland hunters made them but they abandoned them. "
	a[?wep_wave_gun] = "An artistic shotgun. "
	a[?wep_plasma_gun] = "A common plasma gun. "
	a[?wep_plasma_cannon] = "A plasma cannon abbreviated as PC. #PC means Powerful individual Combat weapon. "
	a[?wep_energy_hammer] = "An engery hammer that be designed to destroy fortresses. #But it's better at breaking walls. "
	a[?wep_jackhammer] = "A basic tool. Wasteland artisans could destroy something by it. "
	a[?wep_flak_cannon] = "A common flak cannon. The gators tried to make copies of them but they failed. "
	a[?wep_golden_revolver] = "Venus Power. "
	a[?wep_golden_machinegun] = "A common machinegun but golden. Expensive trash. "
	a[?wep_golden_wrench] = "A golden tool. #Venusian artisans could fix something by it. "
	a[?wep_golden_shotgun] = "A common shotgun but golden. #Much better than the imitations. "
	a[?wep_golden_crossbow] = 
		"A golden crossbow. #Venusian hunters made them. "
	a[?wep_golden_grenade_launcher] = 
		"A golden grenade launcher. #And golden nades. "
	a[?wep_golden_laser_pistol] = 
		"A common laser pistol but golden. "
	a[?wep_chicken_sword] = 
		"A sword made with stainless steel. #Much lighter than it looks like. "
	a[?wep_nuke_launcher] = 
		"A devastating bomb launcher. "
	a[?wep_ion_cannon] = 
		"Looks like another kind of space-based terminal. "
	a[?wep_quadruple_machinegun] = 
		"A large machinegun with four muzzles. #Not a popular weapon before. "
	a[?wep_flamethrower] = 
		"A common flamethrower. #The ravens made them but they don't like to use them. "
	a[?wep_dragon] = 
		"A artistic flamethrower. #The ravens made them but they don't like to use them. "
	a[?wep_flare_gun] = 
		"A common flare gun. #The ravens fire them to communicate. "
	a[?wep_energy_screwdriver] = 
		"An energy screwdriver that be designed #to fix some special machine. #But it's better at killing. "
	a[?wep_hyper_launcher] = 
		"Limit of kinetic energy weapon. "
	a[?wep_laser_cannon] = 
		"A common laser cannon. #There is a crystal in it. "
	a[?wep_rusty_revolver] = 
		"Familiar. Looks like some burial objects. "
	a[?wep_lightning_pistol] = 
		"A common lightning pistol. "
	a[?wep_lightning_rifle] = 
		"A common lightning rifle. "
	a[?wep_lightning_shotgun] = 
		"A common lightning shotgun. "
	a[?wep_super_flak_cannon] = 
		"A large flak cannon that fires compressed flak cannonball. "
	a[?wep_sawed_off_shotgun] = 
		"A sawed-off shotgun. #Powerful in the limited range. "
	a[?wep_splinter_pistol] = 
		"A common splinter pistol. #Some wasteland hunters prefer to chase the targets. "
	a[?wep_super_splinter_gun] = 
		"A larger splinter gun. #Wasteland hunters made them. "
	a[?wep_lightning_smg] = 
		"A common lightning submachinegun. "
	a[?wep_smart_gun] = 
		"A SMART rifle. If SMART means never auto-aim the right enemy. "
	a[?wep_heavy_crossbow] = 
		"A heavy crossbow. #Wasteland hunters made them. "
	a[?wep_blood_hammer] = 
		"A lute made by wiggly bones and flesh. #Will hurt the gunner if it couldn't eat any enemy. "
	a[?wep_lightning_cannon] = 
		"A common lightning cannon. "
	a[?wep_pop_gun] = 
		"A common pop gun. "
	a[?wep_plasma_rifle] = 
		"A common plasma rifle. "
	a[?wep_pop_rifle] = 
		"A common pop assault rifle. "
	a[?wep_toxic_launcher] = 
		"A toxic launcher. "
	a[?wep_flame_cannon] = 
		"A common flame cannon that fires huge flame ball. "
	a[?wep_lightning_hammer] = 
		"A hammer that fires lightning. #But you're not Thor. "
	a[?wep_flame_shotgun] = 
		"A shotgun that fires flame shells. "
	a[?wep_double_flame_shotgun] = 
		"A shotgun with two muzzles that fires flame shells. "
	a[?wep_auto_flame_shotgun] = 
		"An auto shotgun that fires flame shells. "
	a[?wep_cluster_launcher] = 
		"A cluster grenade launcher. "
	a[?wep_grenade_shotgun] = 
		"A launcher that fires mini grenades. "
	a[?wep_grenade_rifle] = 
		"A launcher that fires mini grenades. "
	a[?wep_rogue_rifle] = 
		{
		"rogue" : "The rifle you carried when you defected. #You've made some modifications to make it more like a pistol. ", 
		"d" : "An I.D.P.D. assault rifle. ", 
		}
	a[?wep_party_gun] = 
		"Happy? "
	a[?wep_double_minigun] = 
		"A double-fire minigun. "
	a[?wep_gatling_bazooka] = 
		"An auto rocket launcher. #The designer must be crazy. "
	a[?wep_auto_grenade_shotgun] = 
		"An auto launcher that fires mini grenades. "
	a[?wep_ultra_revolver] = 
		"An earthy color pistol with radiation green light #that fires bullets with incredible damage. "
	a[?wep_ultra_laser_pistol] = 
		"An earthy color laser pistol with radiation green light. "
	a[?wep_sledgehammer] = 
		"A big hammer. #Wasteland artisans could destroy something by it. "
	a[?wep_heavy_revolver] = 
		{
		"fish" : "You officer used to carry a heavy revolver. #Old-style. ", 
		"d" : "A common heavy revolver. ", 
		}
	a[?wep_heavy_machinegun] = 
		"A common heavy machinegun. "
	a[?wep_heavy_slugger] = 
		"A common heavy slugger. "
	a[?wep_ultra_shovel] = 
		"An earthy color shovel with radiation green light. #Light but powerful. "
	a[?wep_ultra_shotgun] = 
		"An earthy color shotgun with radiation green light. "
	a[?wep_ultra_crossbow] = 
		"An earthy color crossbow with radiation green light. #The Ultra Hunter use it to hide in the walls. "
	a[?wep_ultra_grenade_launcher] = 
		"An earthy color grenade launcher with radiation green light. #The green grenade have attraction force. "
	a[?wep_plasma_minigun] = 
		"A common plasma minigun. "
	a[?wep_devastator] = 
		"A plasma impact wave launcher. "
	a[?wep_golden_plasma_gun] = 
		"A common plasma gun but golden. "
	a[?wep_golden_slugger] = 
		"A common slugger but golden. "
	a[?wep_golden_splinter_gun] = 
		"A common splinter gun but golden. #Venusian hunters made them. "
	a[?wep_golden_screwdriver] = 
		"A golden tool. #Venusian artisans could fix something by it. "
	a[?wep_golden_bazooka] = 
		"A common rocket launcher but golden. "
	a[?wep_golden_assault_rifle] = 
		"A common assault rifle but golden. "
	a[?wep_golden_disc_gun] = 
		{
		"melting" : "KILL KILL KILL KILL KILL ", 
		"d" : "The discs are dangers for the gunner too. ", 
		}
	a[?wep_heavy_auto_crossbow] = 
		"An auto heavy crossbow. #Wasteland hunters made them. "
	a[?wep_heavy_assault_rifle] = 
		"The heavy assault rifles used to be a popular weapon #in Old Armies even after the hyper rifle birth. "
	a[?wep_blood_cannon] = 
		"A blood cannon. Could engulf bullets. "
	a[?wep_incinerator] = 
		"A large machinegun with three muzzles that fires flame bullets. "
	a[?wep_super_plasma_cannon] = 
		"A huge plasma cannon abbreviated as SPC. #SPC means Super Powerful individual Combat weapon. "
	a[?wep_eraser] = 
		"A slugger that fires a line of shells. "
	a[?wep_guitar] = 
		{
		"fish" : "Your old buddy. You love her so much. ", 
		"rogue" : "An old plucked instrument. A precious musical art relics. #The craft of making it has long been lost. #Solid and reliable but so extravagant to use it as a weapon. ", 
		"d" : "An old plucked instrument. ", 
		}
	a[?wep_bouncer_smg] = 
		"A submachinegun fires bouncable bullets. Inaccurate. "
	a[?wep_bouncer_shotgun] = 
		"A shotgun fires bouncable bullets. "
	a[?wep_hyper_slugger] = 
		"Limit of kinetic energy weapon. "
	a[?wep_heavy_slugger] = 
		"A huge slugger with five muzzles. So powerful. "
	a[?wep_frog_pistol] = 
		{
		"rogue" : "You felt some unknown power being #are in the frog shape gun. ", 
		"frog" : "Ohhonhhonhhonhhonhhonhhonhmmmm ", 
		"d" : "A pistol looks like a frog. ", 
		}
	a[?wep_black_sword] = 
		"A sword made with unknown black metal. #Much lighter than it looks like. "
	a[?wep_golden_nuke_launcher] = 
		"A golden devastating bomb launcher. "
	a[?wep_golden_disc_gun] = 
		"The shining discs are dangers for the gunner too. "
	a[?wep_heavy_grenade_launcher] = 
		"A heavy grenade launcher. "
	a[?wep_gun_gun] = 
		"The gun of guns. There is a mini factory in it. "
	a[?wep_eggplant] = 
		"? What's wrong with you "
	a[?wep_golden_frog_pistol] = 
		{
		"rogue" : "More puzzles. ", 
		"frog" : "Your destiny hohohommmn ", 
		"d" : "A pistol looks like a golden frog. ", 
		}
/*	
	a[?"lil.horror"] = 
		{
		"horror" : "You don't wanna share what you think about this weirdo. ", 
		"rogue" : "It's just a polymer of radiation. ", 
		"d" : "Don't be duped by this little monster dog. ", 
		}
	
	a[?"trap thrower"] = 
		{
		"melting" : "Hot and hurt. ", 
		"d" : "The cheap trick of ravens. ", 
		}
	
	a[?"wand"] = 
		{
		"eyes" : "Profound. ", 
		"melting" : "Warm. ", 
		"venuz" : " M A R G I K  ", 
		"chicken" : "You don't like fantacy movies. ", 
		"rogue" : "Weirder. ", 
		"d" : "A wooden wand that fires flame balls. ", 
		}
	
	a[?"blood bass"] = 
		{
		"melting" : "Fleshy... ", 
		"plant" : "Not yum. ", 
		"chicken" : "Just like the monsters in the third-rate horror movies. ", 
		"d" : "A living bass made by wiggly bones and flesh. #Will borrow the health from the gunner for building a flesh wall, #then repay the health when the flesh wall explode. ", 
		}
	
	a[?"blood buckler"] = "A wriggling bone. "
	
	a[?"crystal buckler"] = 
		{
		"crystal" : "A shield made with yellow crystals that making creepy laughs, sounds familiar. #When the energy swimming in it, #the crystals will appear and fire lasers. ", 
		"eyes" : "Dreamy. ", 
		"shovel knight" : "Shield, the weapon of weak people. ", 
		"d" : "A shield made with yellow crystals that making creepy laughs. #When the energy swimming in it, #the crystals will appear and fire lasers. ", 
		}
	
	a[?"hand grenade"] = 
		"A hand cluster grenade. "
	a[?"hand flare grenade"] = 
		"A hand flare grenade. "
*/	
	//NT:TE parts
/*	a[?"bubble bat"] = 
		"A bat runs by compressed air. "
	a[?"bubble cannon"] = 
		"A bubble cannon that fires by compressed air. "
	a[?"bubble minigun"] = 
		"A bubble minigun runs by compressed air. "
	a[?"bubble rifle"] = 
		"A bubble rifle runs by compressed air. "
	a[?"bubble shotgun"] = 
		"A bubble shotgun runs by compressed air. "
	a[?"clam shield"] = 
		"Seals bring them from warm ocean. "
	a[?"crabbone"] = 
		{
		"skeleton" : "Smells salty. ", 
		"d" : "Smells salty. ", 
		}
	a[?"electroplasma cannon"] = 
		"A electric plasma cannon. "
	a[?"electroplasma rifle"] = 
		"A electric plasma rifle. "
	a[?"electroplasma shotgun"] = 
		"A electric plasma shotgun. "
	a[?"energy bat"] = 
		{
		"eyes" : "May the force be with you. ", 
		"chicken" : "You saw the power of the right side. ", 
		"d" : "A bat that be designed #to be powerfully use by the people who more ebullient. ", 
		}
	a[?"hyper bubbler"] = 
		"A bubble cannon fires by high-compressed air. "
	a[?"lightring launcher"] = 
		{
		"steroids" : "How beautiful the electric arc are. ", 
		"d" : "A lightning ring launcher basic on bionics. ", 
		}
	a[?"trident"] = 
		"Seals bring them from deep ocean. #Nobody knows who made them. "
	a[?"teleport gun"] = 
		{
		"horror" : "You don't wanna share what you think about this. ", 
		"rogue" : "It's just a polymer of radiation #or something else like that. ", 
		"d" : "Makes you puzzled. ", 
		}
*/	}

#define scrSkillsayData
	{
	var a = SkillsayData
	a[?mut_none] = "*p has no thinking. "
	a[?mut_rhino_skin] = "*p wants a thick skin. "
	a[?mut_extra_feet] = "In fact it's a tail. "
	a[?mut_plutonium_hunger] = "An able man is always hungry. "
	a[?mut_rabbit_paw] = "The symbol of lucky. "
	a[?mut_throne_butt] = "Born as Wasteland Kings. "
	a[?mut_lucky_shot] = "Blind confidence. "
	a[?mut_bloodlust] = "*p is thirsty for killing more. "
	a[?mut_gamma_guts] = "*p is glowing. "
	a[?mut_second_stomach] = "Second stomach means double gastric peristalsis. "
	a[?mut_back_muscle] = "Looks like a ferocious ogre face. "
	a[?mut_scarier_face] = "Sacrifice the appearance to rule the land. "
	a[?mut_euphoria] = "*p is so exciting. "
	a[?mut_long_arms] = "One inch longer, one inch stronger. "
	a[?mut_boiling_veins] = "Burning with righteous indignation. "
	a[?mut_shotgun_shoulders] = "*p can really dance. "
	a[?mut_recycle_gland] = "*p is going to vomitting. "
	a[?mut_laser_brain] = "Inspirations are going to burst out from the brain of *p. "
	a[?mut_last_wish] = "*p hopes everyone will be okay. "
	a[?mut_eagle_eyes] = "*p is aiming. "
	a[?mut_impact_wrists] = "*p wanna bang punch out the enemies for justice. "
	a[?mut_bolt_marrow] = "Bony spur hurts. "
	a[?mut_stress] = "*p can't breathe. "
	a[?mut_trigger_fingers] = "Remember be always ready to shot. "
	a[?mut_sharp_teeth] = "*p grinding teeth nightly. "
	a[?mut_patience] = "Virtue. "
	a[?mut_hammerhead] = "*p wanna smash everyone. "
	a[?mut_strong_spirit] = "Never gonna give you up, never gonna let you down. "
	a[?mut_open_mind] = "*p is thinking and planning. "
	a[?mut_heavy_heart] = "*p is ready to take responsibility. "
	
	a[?"ge"] = "*p is activing elbow. "
	a[?"rj"] = "*p is drooling. "
	a[?"rw"] = "*p feels itchy on back. "
	a[?"cl"] = "*p haves lumbago. "
	a[?"bc"] = "*p is padding something. "
	a[?"pl"] = "*p is hawking and spating. "
	a[?"pn"] = "*p feels numb. "
	a[?"sp"] = "Nobody wanna this. "
	a[?"np"] = "*p is finding a suitable chest. "
	a[?"nn"] = "WE are going to be A whole. "
	a[?"al"] = "*p loves the science from old ages. "
	a[?"br"] = "*p is overreacted. "
	a[?"ee"] = "*p is aiming. "
	a[?"mb"] = "*p is thinking and planning. "
	}

#define scrUltrasayData
	{
	var a = UltrasayData
	}

#define scrCrownsayData
	{
	var a = CrownsayData
	}



#macro palias scrPAlias()
#define scrPAlias
	{
	with(instance_nearest(x, y, Player)){return alias}
	return "Someone"
	}
