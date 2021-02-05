
#define init
	{
	scrInitGlobals()
	scrInitShop()
	scrInitSave()
	}



#define game_start
global.nts_gs_crown = true
//global.vgundam_unlock = 0
//global.binah_se = [true, true, true, true]
global.braid_unlock = array_create(3)
GameCont.crownpoints++





#define draw_shadows
	{
	if(GameCont.area=="mansion" || GameCont.area=="helipad")
		{draw_clear_alpha(0, 0)}
	}

#define draw_dark
if(skill_get("ee"))
	{draw_clear(c_gray)}

#define draw_dark_end
	{
	draw_set_alpha(1)
	if(GameCont.area == "ruins")
		{
		if(skill_get("ee"))
			{draw_clear(14680031)}
		else{draw_clear(c_white)}
		
		draw_set_visible_all(false)
		with(instances_matching(Player, "race", "eyes"))
			{draw_set_visible(index, true)}
		draw_clear(14680031)
		
		draw_set_blend_mode_ext(bm_src_alpha_sat, bm_src_colour)
		
		if(mod_exists("mod", "NT3D"))
			{
			with(Player)
				{
				draw_set_visible_all(false)
				draw_set_visible(index, true)
				draw_circle_color(view_xview_nonsync+game_width/2, view_yview_nonsync+game_height/2, irandom_range(96, 100), variable_instance_get(self, "nts_ruins_lightc_3d", variable_instance_get(self, "nts_ruins_lightc", 0)), c_white, 0)
				}
			}
		else{
			draw_set_visible_all(true)
		
			with(Player)
				{scrRuinsLight(variable_instance_get(self, "nts_ruins_lightc", 48896), irandom_range(96,100))}
			with(WepPickup)
				{scrRuinsLight(48896, 32)}
			with(projectile)
				{scrRuinsLight(48896, 32-image_index)}
			with(Explosion)
				{scrRuinsLight(12566272, 64-image_index*2)}
			with(MeatExplosion)
				{scrRuinsLight(12566272, 32-image_index*2)}
			with(LaserCannon)
				{scrRuinsLight(12517567, 64)}
			with(PlasmaImpact)
				{scrRuinsLight(12517567, 64-image_index*2)}
			for(var i=2; i>0; i--)
				{
				with(instances_matching(hitme, "nts_ruinsmachine", i)){if("nts_ruins_lightc"in self){if(nts_ruins_lightc < c_white)
					{scrRuinsLight(nts_ruins_lightc, nts_ruins_light[@1])}}}
				}
			with(Portal)
				{scrRuinsLight(0, irandom_range(96,100))}
			}
		}
	
	draw_set_visible_all(true)
	
	draw_set_blend_mode_ext(bm_src_alpha_sat, bm_src_colour)
	with(Player){scrFlashlight(wep); scrFlashlight(bwep)}
	
	draw_set_blend_mode(bm_normal)
	draw_set_color(c_white)
	draw_set_alpha(1)
	}





#define step
	{
	scrUnlockPart()
//	scrSpecialChest()
//	scrSpecialPickup()
	scrDestimyCrown()
//	scrBinahSECount()
//	scrMarketNPC()
//	scrMarketCar()
	}



#define scrInitGlobals
	{
	global.nts_gs_crown = true
//	global.vgundam_area = false
//	global.vgundam_unlock = 0
//	global.binah_se = array_create(4)
	global.braid_unlock = array_create(3)
	
//	global.binah_se = [true, true, true, true]
	}

#define scrInitShop
	{
	globalvar AllWep, MNPCType, MNPCSpecial, SSC1, SSC2, SSC3, SSC4, MNPCRobotV, MNPCHorrorM, MNPCCuzT
	
	AllWep = ds_list_create()
	
	var MNPCTypeBase = 
		[
			["fish",		sprFishMenu,		sprFishMenu,		"@y[shop]@w# welcome."],
			["crystal",		sprMutant2Idle,		sprCrystalMenu,		"@y[shop]@w# need help?"],
			["eyes",		sprMutant3BIdle,	sprMutant3BIdle,	"@y[shop]@w#hmmmn"],
			["melting",		sprMeltingMenu,		sprMeltingMenu,		"@y[shop]@w#...hi"],
			["plant",		sprMutant5BIdle,	sprMutant5BSit,		"@y[shop]@w#sssss"],
			["venuz",		sprMutant6Idle,		sprMutant6BSit,		"@s[gun deal]@w#hi dud"],
			["steroids",	sprMutant7BIdle,	sprMutant7BSit,		"@s[coming soon]#hello"/*"[crafting]#hello"*/],
			["robot",		sprMutant8BIdle,	sprMutant8BSit,		"@s[pawnshop]@w#not trash bin"],
			["chicken",		sprMutant9BIdle,	sprMutant9BIdle,	"@y[shop]@w#hi"],
			["rebel",		sprMutant10CIdle,	sprMutant10CIdle,	"@y[shop]@w# welcome."],
			["horror",		sprMutant11Idle,	sprMutant11Sit,		"@g[mutate]"],
			["rogue",		sprRogueMenu,		sprRogueMenu,		"@b[bank]@w#i'm busy now"],
			["skeleton",	sprMutant14BIdle,	sprMutant14BIdle,	"@y[shop]"],
			["frog",		sprMutant15Sit,		sprMutant15Sit,		"*singing*#press@4(keysmall:pick)please"],
			["cuz",			sprMutant16Idle,	sprMutant16Sit,		"@s[tour]@w#hi dud"],
		]
	MNPCType = ds_list_create()
	ds_list_add_array(MNPCType, MNPCTypeBase)
	
	var MNPCSpecialBase = ["venuz", "steroids", "robot", "horror", "rogue", "frog", "cuz", "end"]
	MNPCSpecial = ds_list_create()
	ds_list_add_array(MNPCSpecial, MNPCSpecialBase)
	
	var SSC1Base = 
		[
			//["helmet",				100],
			["pipe",					100],
			["rusty shovel",			100],
			[wep_energy_hammer,			100],
			["sniper rifle",			150],
			["toxic bazooka",			200],
			[wep_toxic_bow,				200],
			[wep_splinter_gun,			200],
			[wep_golden_splinter_gun,	240],
			[wep_sledgehammer,			300],
			["toxic hammer",			300],
			[wep_hyper_launcher,		300],
			["hyper toxic launcher",	300],
			[wep_hyper_slugger,			300],
			[wep_heavy_revolver,		300],
			[wep_heavy_machinegun,		350],
			[wep_laser_minigun,			400],
			[wep_plasma_minigun,		400],
		]
	SSC1 = ds_list_create()
	ds_list_add_array(SSC1, SSC1Base)
	
	var SSC2Base=
		[
			[wep_splinter_pistol,		200],
			["flesh arm",				200],
			[wep_devastator,			200],
			[wep_dragon,				250],
			[wep_eraser,				300],
			[wep_flak_cannon,			300],
			[wep_super_splinter_gun,	300],
			[wep_wave_gun,				350],
			["sniper wand",				400],
			[wep_energy_screwdriver,	400],
			[wep_blood_hammer,			400],
			["gatling toxic bazooka",	450],
			[wep_double_minigun,		450],
			[wep_hyper_rifle,			500],
			//["blood bass",				500],
			[wep_gatling_slugger,		500],
			[wep_super_slugger,			500],
			["idpd slugger",			550],
			[wep_nuke_launcher,			600],
			[wep_super_bazooka,			600],
			[wep_heavy_auto_crossbow,	600],
			[wep_incinerator,			600],
			["toxic nuke launcher",		800],
			["super toxic bazooka",		900],
		]
	SSC2 = ds_list_create()
	ds_list_add_array(SSC2, SSC2Base)
	
	var SSC3Base = 
		[
			["toxic thrower",				100],
			[wep_golden_disc_gun,			100],
			[wep_super_disc_gun,			200],
			["idpd rifle",					500],
			[wep_auto_shotgun,				500],
			[wep_lightning_smg,				500],
			[wep_jackhammer,				500],
			[wep_auto_flame_shotgun,		540],
			[wep_heavy_assault_rifle,		600],
			[wep_golden_nuke_launcher,		700],
			[wep_auto_crossbow,				700],
			["auto sniper rifle",			700],
			["idpd elite rifle",			700],
			[wep_laser_cannon,				700],
			["hyper katana",				800],
			["idpd heavy rifle",			800],
			["hunter rifle",				800],
			["hunter shotgun",				800],
			["idpd plasma minigun",			1000],
			["ultra bow",					1000],
			[wep_shovel,					1000],
			[wep_ultra_revolver,			1200],
			[wep_ultra_crossbow,			1200],
			[wep_ultra_grenade_launcher,	1600],
			[wep_super_flak_cannon,			1400],
			[wep_super_crossbow,			1400],
			["lightning ladder",			1400],
			[wep_gun_gun,					1600],
		]
	SSC3 = ds_list_create()
	ds_list_add_array(SSC3, SSC3Base)
	
	var SSC4Base = 
		[
			["bandit",					1],
			["bandit gun",				1],
			["bow",						1],
			["camera",					1],
			["killfeed",				100],
			["strike gun",				200],
			[wep_black_sword,			600],
			[wep_guitar,				800],
			//["unstable sword",			800],
			[wep_energy_sword,			900],
			[wep_lightning_hammer,		900],
			["idpd baton",				1000],
			["ultra chopper",			1000],
			[wep_plasma_cannon,			1400],
			//["unstable trichord",		1200],
			[wep_ultra_shovel,			1400],
			[wep_super_plasma_cannon,	2000],
		]
	SSC4 = ds_list_create()
	ds_list_add_array(SSC4, SSC4Base)
	
	var MNPCHorrorMBase = 
		[
			"ee", 
			"mb", 
			"ge", 
			"rj", 
			"rw", 
			"cl", 
			"bc", 
			"pl", 
			"pn", 
			"sp", 
			"np", 
			"al", 
			//"am", 
			//"br", 
		]
	var len = array_length(MNPCHorrorMBase)
	MNPCHorrorM = []
	for(var i=0; i<30; i++){if(i!=17 && i!=24){array_push(MNPCHorrorM, i)}}
	for(var i=0; i<len; i++){array_push(MNPCHorrorM, MNPCHorrorMBase[i])}
	
	MNPCCuzTBase = 
		[
		//	["desert",		"1-3",		1,			3],
		//	["dungeon",		"d-3",		"dungeon",	3],
		//	["cesspit",		"c-1",		"cesspit",	1],
		//	["oasis",		"1-?",		101,		1],
		//	["scrapyard",	"3-3",		3,			3],
			["mansion",		"3-?",		103,		1],
			["cave",		"4-1",		4,			1],
			["@q@pcave",	"@q@p4-?",	104,		1],
			["city",		"5-1",		5,			1],
			["jungle",		"5-?",		105,		1],
			["outlab",		"ol-1",		"outlab",	1],
			["lab",			"6-1",		6,			1],
		]
	MNPCCuzT = ds_list_create()
	ds_list_add_array(MNPCCuzT, MNPCCuzTBase)
	}

#define scrInitSave
	{
	globalvar nts_save
	nts_save = null
	var stat =
		[
			"race", 
			"skin", 
			"crown", 
		]
	var len = array_length(stat)
	
	wait file_load("nts_save.sav")
	var a = string_load("nts_save.sav")
	nts_save = (a==undefined) ? {} : json_decode(a)
	for(var i=0; i<len; i++){if(lq_get(nts_save, stat[i]) == null){lq_set(nts_save, stat[i], {})}}
	scrSave()
	}



#define scrCharUnlock(Name)
	{
	var name = string_lower(Name)
	if(!lq_defget(nts_save.race, name, false))
		{
		lq_set(nts_save.race, name, true)
		scrSave()
		trace(Name+" unlock!!!")
		sound_play(sndGoldUnlock)
		}
	}

#define scrSkinUnlock(Name, text)
	{
	var name = string_lower(Name)
	if(!lq_defget(nts_save.skin, name, false))
		{
		lq_set(nts_save.skin, name, true)
		scrSave()
		trace(`${Name}${text} skin unlock!!!`)
		sound_play(sndGoldUnlock)
		}
	}

#define scrCrownUnlock(name)
	{
	if(crown_current != name){exit}
	if(!lq_defget(nts_save.crown, name, false))
		{
		lq_set(nts_save.crown, name, true)
		scrSave()
		trace(`${crown_get_name(name)} unlock!!!`)
		sound_play(sndGoldUnlock)
		}
	}

#define scrSave
string_save(json_encode(nts_save, ""), "nts_save.sav")



#define scrUnlockPart
if(is_object(nts_save))
	{
	//with(BanditBoss){if(my_health<=0 && TopCont.darkness=1){scrCharUnlock("Pumpking")}}
	
//	with(instances_matching(Shell, "nts_unlock_coward", true)){scrCharUnlock("Coward")}
	
	with(BigDogExplo)
		{scrCharUnlock("Cur")}
	
	with(GameCont)
		{
		if(area == 5)
			{global.braid_unlock[@subarea-1] = true}
		else{
			if(array_equals(global.braid_unlock, [1, 1, 1]))
				{scrCrownUnlock("braid")}
			}
		
		if(area == 104)
			{
			with(instances_matching_le(HyperCrystal, "my_health", 0))
				{scrCharUnlock("Digger")}
			}
		
		if(level == 10)
			{scrCrownUnlock("evolution")}
		}
	
	with(instances_matching_le(CrownGuardian, "my_health", 0))
		{scrCharUnlock("Guard")}
	
	with(instances_matching_le(Last, "my_health", 0))
		{
		//scrCharUnlock("Clown")
		//scrCharUnlock("Dyscrat")
		if(GameCont.loops >= 2){scrCrownUnlock("master")}
		}
	
	
	
	with(instances_matching(ProtoChest, "wep", "thief key"))
		{scrCharUnlock("Tricker")}
	
	with(Player)
		{
		var n = string_lower(weapon_get_name(wep))
		var bn = string_lower(weapon_get_name(bwep))
		if(curse!=0 && bcurse!=0)
			{scrCharUnlock("Phantom")}
		if((wep==92&&bwep==111) || (wep==111 && bwep=92))
			{scrCharUnlock("AwkwardMan")}
		
		switch(race)
			{
			case "fish":	if(skill_get(mut_extra_feet) && skill_get(mut_last_wish) && skill_get(mut_stress) && skill_get(mut_sharp_teeth) && skill_get(mut_strong_spirit)){scrSkinUnlock("Pictographic", " of Fish'")}; break
			case "cur":		if(GameCont.area == 106){scrSkinUnlock("Cur", "'s Pure")}; break
			case "digger":	if(GameCont.area == 104){scrSkinUnlock("Digger", "'s Burier")}; break
			default: break
			}
		}
	
//	with(TechnoMancer){if(my_health <= 0){scrCharUnlock("Zero")}}
	
	scrGameStartCrown()
	}



#define scrGameStartCrown
	{
	if(global.nts_gs_crown && instance_exists(CrownIcon))
		{
		with(instances_matching_gt(CrownIcon, "num", mcrCustomCrownNum)){instance_destroy()}
		LevCont.maxselect = mcrCustomCrownNum
		global.nts_gs_crown = false
		with(instances_matching(CrownIcon, "num", 0))
			{
			crown = crown_current
			name = `@svanilla - @w${crown_get_name(crown)}`
			text = `the most familiar#is the best`
			if(is_real(crown)){image_index = crown}
			else{
				if(mod_exists("crown", crown)){if(mod_script_exists("crown", crown, "crown_button"))
					{mod_script_call("crown", crown, "crown_button")}}
				}
			}
		
		for(var i=0; i<mcrCustomCrownNum; i++)
			{
			with(instances_matching(CrownIcon, "num", i+1))
				{
				if(lq_defget(nts_save.crown, mcrCustomCrown[@i], false))
					{
					crown = mcrCustomCrown[@i]
					name = crown_get_name(crown)
					text = crown_get_text(crown)
					mod_script_call("crown", crown, "crown_button")
					}
				else{
					crown = crwn_none
					name = `@s${crown_get_name(mcrCustomCrown[@i])}`
					text = `@sunlock: ${mod_script_call("crown", mcrCustomCrown[@i], "crown_text_unlock")}`
					mod_script_call("crown", mcrCustomCrown[@i], "crown_button_lock")
					}
				}
			}
		}
	}
#macro	mcrCustomCrown		["master", "braid", "evolution"]
#macro	mcrCustomCrownNum	3

#define scrSpecialChest
with(chestprop){if(instance_exists(self)){if("ntstype"in self){switch(ntstype)
	{
	case "ShovelNPCChest": 
		sprite_index = sprWeaponChest
		spr_shadow = shd24
		spr_shadow_x = 0
		spr_shadow_y = -1
		if(place_meeting(x,y,Player))
			{
			with(instance_create(x,y,CustomObject)){ntstype="MarketNPC"; Num=choose(0,1,2,3,4,5,8,9,10,11,12,13)}; 
			with(instance_create(x,y,ChestOpen)){sprite_index=sprWeaponChestOpen}; 
			instance_create(x,y,FXChestOpen); sound_play_hit(sndChest, 0); 
			instance_create(x,y,PortalClear); 
			instance_destroy(); 
			}
		break
	
	default:break;
	}}}}

#define scrDestimyCrown
if(mod_exists("crown", "destimy"))
	{
	with(instances_matching(CrownIcon,"crown",8))
		{
		if("faked"!in self)
			{
			random_set_seed(random_get_seed())
			if(!irandom(10))
				{
				crown = "destimy"
				name = "crown of destimy"
				sprite_index = mod_variable_get("crown", "destimy", "icon")
				}
			faked = true
			}
		}
	}

#define scrBinahSECount
	{
	if(instance_exists(LevCont) && instance_exists(SkillIcon))
		{
		with(instances_matching(Player, "race", "binah"))
			{
			if(button_pressed(index, "spec"))
				{
				if(global.binah_se[@index])
					{
					var list = ds_list_create()
					var ary = mod_get_names("skill")
					var len = array_length(ary)
					
					for(var i=1; i<30; i++){if(skill_get_active(i) && !skill_get(i) && array_length(instances_matching(SkillIcon, "skill", i))==0)
						{ds_list_add(list, i)}}
					for(var i=0; i<len; i++)
						{
						var avail = mod_script_call("skill", ary[@i], "skill_avail")
						if(avail == null){avail = true}
						if(skill_get_active(ary[@i]) && avail && !skill_get(ary[@i]) && array_length(instances_matching(SkillIcon, "skill", ary[@i]))==0)
							{ds_list_add(list, ary[@i])}
						}
					
					ds_list_shuffle(list)
					with(SkillIcon)
						{
						if(num > ds_list_size(list)){break}
						skill = list[|num]
						if(is_real(skill))
							{
							sprite_index = sprSkillIcon
							image_index = skill
							}
						else{mod_script_call("skill", skill, "skill_button")}
						name = skill_get_name(skill)
						text = skill_get_text(skill)
						}
					ds_list_destroy(list)
					
					audio_sound_gain(sound_play(sndSewerDrip), 5, 0)
					global.binah_se[@index] = false
					}
				else{sound_play(sndSewerDrip)}
				}
			}
		}
	else{global.binah_se = [true, true, true, true]}
	}

#define scrMarketNPC
with(instances_matching(CustomObject,"ntstype","MarketNPC"))
	{
	
	if("Num"!in self){Num=irandom(ds_list_size(MNPCType)-1)}
	Data=ds_list_find_value(MNPCType,Num)
	
	image_speed=0.4; depth=-2;
	shd_depth=-1.9; spr_shadow=shd24; spr_shadow_x=0; spr_shadow_y=0; 
	
	if(instance_exists(Player))
		{
		Buyer=instance_nearest(x,y,Player);BuyerDir=point_direction(x,y,Buyer.x,Buyer.y);BuyerDis=distance_to_object(Buyer);
		if(Data == undefined){trace(Num)}
		if(BuyerDis<=64){if(BuyerDir<90 or BuyerDir>270 or Data[0]=="fish" or Data[0]=="rogue"){image_xscale=1}else{image_xscale=-1};sprite_index=Data[1];}else{sprite_index=Data[2];}
		if(BuyerDis<=16)
			{
			script_bind_draw(MarketTalk, -16, x, y-32, Data[3])
			if("SellCD"!in self){SellCD=0};
			if(SellCD>0){SellCD--}
			else{
				SellCD=0;
				switch(Data[0])
					{
					
					case "venuz":
						if("IndexScale"!in self){IndexScale=[1,1,1,1]}; if("BadLuck"!in self){BadLuck=[-4,-4,-4,-4]}
						if(weapon_get_area(Buyer.wep)=-1 or Buyer.curse){Deal=-1}else{Deal=IndexScale[Buyer.index]*(weapon_get_area(Buyer.wep)+1)*10}
						if(button_pressed(Buyer.index,"key1"))
							{
							if(Deal==-1){BadLuck[Buyer.index]=-1; sound_play_hit(sndMutant6No, 0)}
							else{
								if(GameCont.Money<=Deal){BadLuck[Buyer.index]=-2; sound_play_hit(sndMutant6No, 0)}
								else{
									GameCont.Money-=Deal; IndexScale[Buyer.index]+=1; Owep=Buyer.wep; var oa=weapon_get_area(Buyer.wep)
									var a=weapon_get_list(AllWep, oa, oa)
									Buyer.wep=ds_list_find_value(AllWep,irandom(ds_list_size(AllWep)-1))
									if(Owep==Buyer.wep){BadLuck[Buyer.index]=1; sound_play_hit(sndPartyHorn, 0)}
									else{BadLuck[Buyer.index]=0; sound_play_hit(sndMutant6Slct, 0); }
									sound_play_hit(sndWeaponPickup, 0);
									}
								}
							}
						break;
					
					case "steroids":
						break;
					
					case "robot": 
						/*
						if("ResourceVaule"!in self){for(Ri=0;Ri<8;Ri++){ResourceVaule[Ri]=irandom_range(MNPCRobotV[0,Ri],MNPCRobotV[1,Ri])}}
						if("SellScale"!in self){SellScale=1}
						with(GameCont){ShopHUDR=[Fabric, Organics, Metal, Bone, Crocodile, Alcohol, Web, Crystal]};
						for(Ki=0;Ki<8;Ki++){if(button_check(Buyer.index,"key"+string(Ki+1)))
							{repeat(SellScale){if(ShopHUDR[Ki]>0 and ResourceVaule[Ki]){RobotPawn(Ki);ShopHUDR[Ki]--;GameCont.Money+=ResourceVaule[Ki];sound_play(sndAmmoPickup)}else{sound_play(sndEmpty)};SellCD=5;}}}
						if(button_check(Buyer.index,"key9"))
							{if(SellScale<256){SellScale*=2}else{SellScale=1};SellCD=5}
						*/
						break;
					
					case "horror":
						if("SellStuff"!in self)
							{
							Ski=0;SkiT=0;CT=0;Price=GameCont.loops+1;StSk=[[-1,-1,-1,-1,-1,-1]]
							var len = array_length(MNPCHorrorM)
							for(Skill=0; Skill<len; Skill++)
								{
								if(skill_get(MNPCHorrorM[Skill]))
									{
									if(Ski<6)
										{StSk[SkiT,Ski]=MNPCHorrorM[Skill]}
									else{Ski=0; SkiT++; StSk[SkiT]=[-1,-1,-1,-1,-1,-1]; StSk[SkiT,Ski]=MNPCHorrorM[Skill]}; 
									Ski++; 
									}
								}
							}
						SellStuff=StSk[CT]
						for(Ki=0;Ki<6;Ki++){if(button_pressed(Buyer.index,"key"+string(Ki+1))){
							if(GameCont.RadiationLump>=Price and SellStuff[Ki]!=-1)
								{
								do{CS=irandom_range(0,array_length(MNPCHorrorM)-1)}until(!skill_get(MNPCHorrorM[CS])&&skill_get_active(MNPCHorrorM[CS])); 
								skill_set(MNPCHorrorM[CS],1); skill_set(SellStuff[Ki],0); sound_play(sndMutant11Chst);
								SellStuff[Ki]=MNPCHorrorM[CS]; GameCont.RadiationLump-=Price; Price=(Price+GameCont.loops)*2;
								}
							else{sound_play_hit(sndUltraEmpty, 0)}
							}}
						if(button_pressed(Buyer.index,"key9")){sound_play_hit(sndMutant11Wrld, 0); if(CT<SkiT){CT++}else{CT=0}}
						break;
					
					case "rogue":
						if("Sold"!in self){Sold=0}
						if(button_pressed(Buyer.index,"key1")){GameCont.BankSave+=ceil(GameCont.Money*0.9);GameCont.Money=0;string_save(string(GameCont.BankSave),"bank.sav");sound_play_hit(sndEmpty, 0)}
						if(button_pressed(Buyer.index,"key2"))
							{
							if(Sold){}
							else{if(GameCont.BankSave>440&!Sold)
								{GameCont.Money+=400; GameCont.BankSave-=440; string_save("0","bank.sav")}}
							sound_play_hit(sndEmpty, 0); Sold=1;
							}
						break;
					
					case "frog":
						if(button_pressed(Buyer.index,"pick")){sound_play_hit(sndPartyHorn, 0); }
						break;
					
					case "cuz":
						if("Sold"!in self){Sold=0}
						if("SellStuff"!in self){for(Si=0;Si<3;Si++)
							{SellStuff[Si]=ds_list_find_value(MNPCCuzT,irandom(ds_list_size(MNPCCuzT)-1))}}
						if(!Sold){for(Ki=0;Ki<3;Ki++){if(button_check(Buyer.index,"key"+string(Ki+1)))
							{GameCont.areaM = SellStuff[Ki,2]; GameCont.areaMs = SellStuff[Ki,3]; game_set_seed(random_get_seed()); Sold=1; sound_play_hit(sndCuzBye, 0)}}}
						break;
					
					default: 
						if("SellStuff"!in self){for(Si=0;Si<6;Si++)
							{
							ssc=choose(SSC1,SSC1,SSC1,SSC1, SSC2,SSC2,SSC2, SSC3,SSC3, SSC4)
							/*rarev=(irandom(9));
							if(rarev==0){ssc=SSC3}
							else{if(rarev<4){ssc=SSC2}
							else{ssc=SSC1}}*/
							pos=irandom(ds_list_size(ssc)-1);
							SellStuff[Si,0]=ds_list_find_value(ssc,pos)[0]
							SellStuff[Si,1]=round(ds_list_find_value(ssc,pos)[1]*random_range(0.8,1.25))
							
							}}
						for(Ki=0;Ki<6;Ki++){if(button_pressed(Buyer.index,`key${Ki+1}`))
							{if(GameCont.Money>SellStuff[Ki,1] and SellStuff[Ki,0]!="empty"){SellStuffCommon();SellStuff[Ki,0]="empty";sound_play_hit(sndWeaponPickup, 0)}else{sound_play_hit(sndEmpty, 0)}}}
						
						break;
					
					}
				
				}
			}
		}
	else{Buyer=noone;BuyerDis=-4;sprite_index=Data[2];}
	}

#define scrMarketCar
with(instances_matching(CustomObject,"ntstype","MarketCar"))
	{
	sprite_index = sprVenuzCar2
	with(instance_nearest(x, y, Player))
		{
		nearwep = noone
		if(button_released(index, "pick") && place_meeting(x, y, other)){with(other)
			{
			instance_create(x, y, Portal)
			instance_destroy()
			}}
		}
	}



#define drawshd(spr, dx, dy )
draw_sprite_ext(spr, 0, dx, dy, 1, 1, 0, c_white, 0.5);
instance_destroy();

#define MarketSpecial
if(ds_list_find_index(MNPCSpecial[i],Data[0])==-1){return 0;exit};return 1;

#define MarketTalk(dx, dy, text)
draw_set_font(4)
draw_text_nt(dx, dy, text)
instance_destroy()

#define SellStuffCommon
GameCont.Money -= SellStuff[Ki,1]
with(instance_create(x,y,WepPickup))
	{direction=other.BuyerDir; wep=other.SellStuff[other.Ki,0]; speed=10}

#define RobotPawn
switch(argument0)
	{
	case 0: GameCont.Fabric --; break;
	case 1: GameCont.Organics --; break;
	case 2: GameCont.Metal --; break;
	case 3: GameCont.Bone --; break;
	case 4: GameCont.Crocodile --; break;
	case 5: GameCont.Alcohol --; break;
	case 6: GameCont.Web --; break;
	case 7: GameCont.Crystal --; break;
	default:break;
	}

#define MNPCStuff(spr, dx, dy, rot)
draw_sprite_ext(spr, 0, dx, dy, 1, 1, rot, c_white, 1);
instance_destroy();

#define scrFlashlight(wep)
if(is_object(wep)){if(wep.wep == "flashlight"){if(wep.pow)
	{
	if(mod_exists("mod", "NT3D"))
		{draw_circle_color(view_xview_nonsync+game_width/2, view_yview_nonsync+game_height/2, irandom_range(96, 100), 0, c_white, 0)}
	else{draw_triangle_color(x+lengthdir_x(8, gunangle), y+lengthdir_y(8, gunangle), x+lengthdir_x(mcrFlashlightLength, gunangle+15), y+lengthdir_y(mcrFlashlightLength, gunangle+15), x+lengthdir_x(mcrFlashlightLength, gunangle-15), y+lengthdir_y(mcrFlashlightLength, gunangle-15), GameCont.area=="ruins" ? c_gray : c_black, c_white, c_white, false)}
	}}}

#macro	mcrFlashlightLength		256

#define scrRuinsLight(bc, tr)
	{draw_circle_color(x, y, tr, bc, c_white, 0)}

#define pick_say
with(instance_create(x, y, PopupText))
	{mytext = argument0}


