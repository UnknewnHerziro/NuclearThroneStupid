
#define init
	{
	global.portrait = sprite_duplicate_ext(sprBigPortrait, 15, 1)
	global.mapicon = sprite_duplicate_ext(sprMapIcon, 15, 1)
	global.chs = sprite_add("CharSelect.png", 1, 0, 0)
	
	globalvar wnp, wepAmmo, wepAuto, wepMN, wepIn, wepProj
	
	wnp=
	[
		[
			"MOLEFISH",
			"GOLDEN",
			"RUSTY",
			"SMART",
			"ULTRA",
			"CRYSTAL",
		],
		[
			"ASSAULT",
			"DOUBLE",
			"TRIPLE",
			"QUADRUPLE",
			"SUPER",
			"AUTO",
			"ENERGY",
			"HYPER",
			"HEAVY",
		],
		[
			"FLAK",
			"CLUSTER",
			"FLAME",
			"BLOOD",
			"TOXIC",
			"PARTY",
		],
		[
			"FROG",
			"BOUNCER",
			"SEEKER",
			"LASER",
			"LIGHTNING",
			"IDPD",
			"POP",
		],
		[
			"ERASER",
			"SLUGGER",
			"CROSSBOW",
			"SPLINTER",
			"DISC",
			"GRENADE",
			"BAZOOKA",
			"FLARE",
			"PLASMA",
		],
		[
			"PISTOL",
			"REVOLVER",
			"RIFLE",
			"SMG",
			"MINIGUN",
			"SHOTGUN",
	//		"CANNON",
	//		"THROWER",
	//		"DRAGON",
		],
		/*[
			//"SCREWDRIVER",
			//"SWORD",
			//"SHOVEL"
		]*/
	]

	wepAmmo=
	[
		["ENERGY",		5],
		["FROG",		1],
		["BOUNCER",		1],
		["SEEKER",		3],
		["LASER",		5],
		["LIGHTNING",	5],
		["IDPD",		1],
		["POP",			1],
			
		["ERASER",		2],
		["SLUGGER",		2],
		["CROSSBOW",	3],
		["SPLINTER",	3],
		["DISC",		3],
		["GRENADE",		4],
		["BAZOOKA",		4],
		["FLARE",		4],
		["PLASMA",		5],
			
		["PISTOL",		1],
		["REVOLVER",	1],
		["RIFLE",		1],
		["SMG",			1],
		["MINIGUN",		1],
			
		["SHOTGUN",		2],
		["CANNON",		4],
		["THROWER",		4],
		["DRAGON",		4]
	]

	wepAuto=
	[
		["PISTOL",		0],
		["REVOLVER",	0],
		["AUTO",		1],
		["IDPD",		1],
		["POP",			1],
		["SMG",			1],
		["MINIGUN",		1],
		["THROWER",		1],
		["DRAGON",		1]
	]

	wepMN=
	[
		[
			["ASSAULT",		3],
			["ERASER",		9],
			["POP",			2]
		],
		[
			["DOUBLE",		2,	10],
			["TRIPLE",		3,	10],
			["QUADRUPLE",	4,	10],
			["SHOVEL",		3,	60]
		],
		[
			["SPLINTER",	5,	20],
			["SHOTGUN",		7,	20]
		],
		
	]

	wepIn=
	[
		["FLAK",		Bullet2,		3,	15],
		["CLUSTER",		MiniNade,		3,	10],
		["FLAME",		Flame,			2,	5],
		["BLOOD",		MeatExplosion,	4,	3],
		["TOXIC",		ToxicGas,		3,	1],
		["PARTY",		ConfettiBall,	4,	10],
	]

	wepProj=
	[
		["FROG",		EnemyBullet2,	2,		13],
		["BOUNCER",		BouncerBullet,	4,		6],
		["SEEKER",		Seeker,			9,		1],	
		["LASER",		Laser,			2,		0],
		["LIGHTNING",	Lightning,		7,		0],
		["IDPD",		IDPDBullet,		3,		15],
		["POP",			Bullet2,		3,		15],
		["LIGHTNING",	Lightning,		7,		0],
		["ERASER",		Bullet2,		3,		15],
		["SLUGGER",		Slug,			22,		15],
		["CROSSBOW",	Bolt,			20,		24],
		["SPLINTER",	Splinter,		4,		24],
		["DISC",		Disc,			6,		5],
		["GRENADE",		Grenade,		15,		10],
		["BAZOOKA",		Rocket,			20,		0],
		["FLARE",		Flare,			10,		10],
		["PLASMA",		PlasmaBall,		4,		0],
		["PISTOL",		Bullet1,		3,		15],
		["REVOLVER",	Bullet1,		3,		15],
		["RIFLE",		Bullet1,		3,		15],
		["SMG",			Bullet1,		3,		15],
		["MINIGUN",		Bullet1,		3,		15],
		["SHOTGUN",		Bullet2,		3,		15],
	]
	}

#define nts_weapon_examine	return 
	{
	"0":		"Your gripper. Unmergeable. ", 
	"merge":	"!!! ERROR result ERROR !!! #DO IT JUST DO IT COME ON DO IT ", 
	"merging":	"!!! ERROR result ERROR !!! #DO IT JUST DO IT COME ON DO IT ", 
	}



#define create
spr_idle = sprMutant8BIdle
spr_walk = sprMutant8BWalk
spr_hurt = sprMutant8BHurt
spr_dead = sprMutant8BDead
spr_sit1 = sprMutant8BGoSit
spr_sit2 = sprMutant8BSit
snd_hurt= sndMutant8Hurt
snd_dead= sndMutant8Dead
snd_lowa= sndMutant8LowA
snd_lowh= sndMutant8LowH
snd_chst= sndMutant8Chst
snd_wrld= sndMutant8Wrld
snd_valt= sndMutant8Valt
snd_crwn= sndMutant8Crwn
snd_thrn= sndMutant8Thrn
snd_spch= sndMutant8Spch
snd_idpd= sndMutant8Cnfm
snd_cptn= sndMutant8Cptn
nts_color_blood = [make_color_rgb(96, 59, 52), c_black]

#define pick_say
with(instance_create(x, y, PopupText))
	{mytext = argument0}

#define step
if(button_pressed(index,"spec"))
	{
	if(wep==0 || bwep==0 || curse || bcurse)
		{
		sound_play_hit(sndEmpty, 0.3)
		pick_say("negative")
		exit
		}
	var a = scrGetEntry(wep, bwep)
	if(a == -1)
		{
		sound_play_hit(sndEmpty, 0.3)
		pick_say("negative")
		exit
		}
	else{
		sound_play_hit(snd_valt, 0.3)
		pick_say(weapon_get_name(wep) + "!!")
		if(!skill_get(5))
			{
			var t = weapon_get_type(wep)
			var b = typ_ammo[t]*2
			var a = ammo[t]+b
			if(a < typ_amax[t])
				{
				ammo[t] = a
				pick_say(`+${b} ${typ_name[t]}`)
				}
			else{
				ammo[t] = typ_amax[t]
				pick_say(`max ${typ_name[t]}`)
				}
			}
		}
	}

#define scrGetEntry(wep1, wep2)
return scrDefineEntry(scrGetEntry_1(scrGetEntry_2(wep1)), scrGetEntry_1(scrGetEntry_2(wep2)))

#define scrGetEntry_1
	{
	var w
	for(var ia=0; ia<array_length(wnp); ia++)
		{
		var a=null
		for(var ib=0; ib<array_length(wnp[ia]); ib++){if(string_pos(wnp[ia][ib],argument0)){a=wnp[ia][ib]}}
		w[ia]=a
		}
	return w
	}

#define scrGetEntry_2(w)
if(is_object(w))
	{
	if("name"in w){return string_upper(w.name)}
	if("base"in w){if("name"in w.base){return string_upper(w.base.name)}}		//For compatible with the Merge Weapons from NT:TE. 
	return string_upper(weapon_get_name(w.wep))
	}
return string_upper(weapon_get_name(w))



#define scrDefineEntry(w1, w2)
	{
	w=[]
	wo=""
	mn1=0; mn2=0; mn3=0; mn4=0; mnAuto=-1; mnSuper=0; 
	globalvar w, wo, mn1, mn2, mn3, mn4, mnAuto, mnSuper
	scrDefineEntry_1(w1, w2)
	if(scrDefineEntry_2() == -1){return -1}
	}

#define scrDefineEntry_1(w1, w2)
	{
	switch(w1[1])
		{
		case "ASSAULT": 
			mn1=1; break;
		
		case "DOUBLE": 
		case "TRIPLE": 
		case "QUADRUPLE": 
			mn2=1; break;
		
		case "SUPER": 
			mnSuper=1; break;
		
		default: break;
		}
	switch(w1[4])
		{
		case "ERASER": 
			mn1=1; break;
		case "SPLINTER":
			mn3=1; break;
		default: break;
		}
	switch(w1[5])
		{
		case "PISTOL": 
		case "REVOLVER": 
			scrOS(0); break;
		
		case "SMG": 
		case "MINIGUN": 
			scrOS(1); break;
		
		case "SHOTGUN": 
			mn3=1; break;
			
		case "THROWER": 
		case "DRAGON":
			mn4=1; break;
		
		default: break;
		}

	if(w1[@3]=="LASER"||w1[@3]=="LIGHTNING"){w2[@2]=null}
	if(w1[@5]=="THROWER"||w1[@5]=="DRAGON"){w2[@1]=null; w2[@3]=null; w2[@4]=null; w2[@5]=null; /*w2[@6]=null*/}

	switch(w2[@1])
		{
		case "ASSAULT": 
			if(mn1){w2[@1]=null}; break;
		
		case "DOUBLE": 
		case "TRIPLE": 
		case "QUADRUPLE": 
			if(mn2){w2[@1]=null}
			break;
		
		case "AUTO":
			if(mnAuto==0){w2[@1]=null}; break;
		
		default: break;
		}

	if(w1[@4]!=null || ((w2[@3]=="LASER"||w2[@3]=="LIGHTNING") && w1[@2]!=null)){w2[@3]=null}

	if(w1[@3]!=null){w2[@4]=null}
	else{
		switch(w2[@4])
			{
			case "ERASER":
				if(mn1){w2[@4]=null}; break;
			case "SHOTGUN":
				if(mn3){w2[@4]=null}; break;
			default: break;
			}
		}

	switch(w2[@5])
		{
		case "REVOLVER":
			if(mn1||mn2||mn3||mn4){w2[@5]=null}
		case "PISTOL":
			if(mnAuto==1){w2[@5]=null}; break;
		
		case "SMG": 
		case "MINIGUN": 
			if(mnAuto==0){w2[@5]=null}; break;
		
		case "SHOTGUN":
			if(mn3){w2[@5]=null}; break;
		
		case "CANNON":
			if(w1[@2]==null&&w1[3]==null&&w1[4]==null&&w2[@2]==null&&w2[@3]==null&&w2[@4]==null){w2[@5]=null}; break;
		
		case "THROWER":
		case "DRAGON":
			if(mn1||mn2||mn3||mn4||!(w1[@1]==null&&w1[3]==null&&w1[4]==null/*&&w1[6]==null*/&&w2[@1]==null&&w2[@3]==null&&w2[@4]==null/*&&w2[@6]==null*/)){w2[@5]=null}
		
		default: break;
		}

	if(w1[4]==null && w1[5]==null && w2[4]==null && w2[5]==null){return 0; exit}

	for(i=0; i<array_length(w1); i++)
		{
		switch((w1[i]==null)+(w2[i]==null)*2)
			{
			case 0: 
				w[i]=w1[i]; break;
			case 1: w[i]=w2[i]; break;
			case 2: w[i]=w1[i]; break;
			case 3: w[i]=null; break;
			}
		}

	for(i=0; i<array_length(w1); i++)
		{
		if(w[i]!=null){wo+=w[i]+" "}
		}

	if(w[5]==null)
		{
		switch w[4]
			{
			case "SPLINTER":
			case "DISC":
			case "FLARE":
			case "PLASMA": wo+="GUN"; break;
			case "GRENADE": wo+="LAUNCHER"; break;
			default: break;
			}
		}

	if(w[2]==null && w[3]==null && w[4]==null && w[5]=="CANNON"){return 0; exit}

	while(string_char_at(wo,string_length(wo))==" "){wo=string_delete(wo,string_length(wo),1)}; 
	}

#define scrDefineEntry_2()
	{
	globalvar ot, nwn, nw
	ot = 0
	if(ni("THROWER")){ot = 1}
	if(ni("DRAGON")){ot = 2}
	nwn = scrNWnum()
	if(nwn = -1){return -1; exit}
	var rbase = ot ? (ot*(!!ni("ULTRA"))*2) : (nwn[1]*nwn[2]*nwn[4]*nwn[6])
	if(ultra_get("robo",1)){nwn[0] = ceil(nwn[0]*0.5)}
	if(ultra_get("robo",2)){rbase = ceil(rbase*0.5)}
	
	if(nwn!=-1)
		{
		wep = 
			{
			wep: mod_variable_get("weapon", "robo merge", "mc"), 
			name: wo, 
			type: nwammo(), 
			auto: nwauto(), 
			load: nwn[0], 
			cost: ot ? 1 : nwcost(), 
			rads: rbase, 
			sprt: nwsprt(), 
			laser_sight: !!(ni("CROSSBOW") || ni("SPLINTER")), 
			
			sound: nwsnd(), 
			
			times: nwn[2], 
			accuracy: nwn[3], 
			angletimes: (nwn[4]-1)*0.5, 
			angleaccuracy: nwn[5], 
			shottimes: nwn[6], 
			shotaccuracy: nwn[7], 
			proj: nwn[8], 
			damage: nwn[9], 
			pspeed: nwn[10], 
			
			bproj: nwn[11], 
			bdamage: nwn[12], 
			bspeed: nwn[13], 
			btimes: (ni("SLUGGER")||ni("CROSSBOW")||ni("GRENADE")||ni("BAZOOKA")||ni("FLARE")||ni("PLASMA")||ni("DISC")) ? ((ni("BLOOD")||ni("FLAK")) ? 3 : 16) : 1, 
			
			energy: !!ni("ENERGY"), 
			molefish: !!ni("MOLEFISH"), 
			golden: !!ni("GOLDEN"), 
			smart: !!ni("SMART"), 
			hyper: !!ni("HYPER")&&!ni("SLUGGER")&&!ni("GRENADE")&&!ni("PLASMA")&&!ni("DISC"),
			ultra: !!ni("ULTRA"), 
			
			laser: !!ni("LASER"), 
			lightning: !!ni("LIGHTNING") * 14*(1+!!ni("RIFLE")), 
			}
		if(!skill_get(5)){bwep = 0}
		}
	}

#define scrNWnum
	{
	bnwbase = ot ? ["FLAME",Flame,2,5] : scrNWnumBase()
	var bnwBbase = scrNWnumBBase()
	if(ni("CANNON") && bnwbase==-1)
		{var bnwbase=["CANNON",CustomProjectile,8,10]}
	if(bnwbase == -1)
		{return -1}
	else{
		var bnwLoad=basenw[0]
		var bnwRads=0
		var bnw1Times=scrNWM(1)[1]
		var bnw1Angle=basenw[1]
		var bnw2=scrNWM(2)
		var bnw3=[0,1,0]
		var bnwDamage=bnwbase[2]
		var bnwSpeed=bnwbase[3]
		
		if(ot){bnwLoad=14/ot; if(bnwBbase[1]==0){bnwBbase=["FLAME",Flame,2,5]}}

		if(ni("ULTRA")){switch(bnwbase[1])
			{
			case EnemyBullet2: bnwbase[1]=FrogQueenBall; bnwDamage=5; bnwRads=32; break;
			case BouncerBullet: bnwDamage=24; bnwSpeed=24; bnwRads=4; break;
			case Seeker: bnwRads=2; break;
			case Bullet1: 
			case IDPDBullet: bnwbase[1]=UltraBullet; bnwDamage=18; bnwSpeed=24; bnwRads=4; break;
			case Bullet2: bnwbase[1]=UltraShell; bnwDamage=6; bnwRads=2; break;
			case Bolt: bnwbase[1]=UltraBolt; bnwDamage=45; bnwSpeed=20; bnwRads=14; break;
			case Grenade: bnwbase[1]=UltraGrenade; bnwDamage=40; bnwRads=20; break;
			case Laser: bnwbase[1]=EnemyLaser; bnwDamage=3; bnwRads=3; break; 
			case Lightning: bnwbase[1]=LightningBall; bnwDamage=40; bnwSpeed=5; bnwRads=3; break; 
			case Slug: bnwbase[1]=HyperSlug; bnwDamage=90; bnwSpeed=0; bnwRads=10; break;
			case Splinter: bnwDamage=24; bnwSpeed=36; bnwRads=4; break;
			case Disc: bnwRads=4; break;
			case Rocket: bnwbase[1]=Nuke; bnwDamage=90; bnwRads=4; break;
			case Flare: bnwRads=1; break; 
			case PlasmaBall: bnwRads=2; break; 
			default: break;
			}}
		if(ni("HYPER")){switch(bnwbase[1])
			{
			case Slug: bnwbase[1]=HyperSlug; bnwDamage=26; bnwSpeed=10; break; 
			case Grenade: bnwbase[1]=HyperGrenade; bnwDamage=25; break;
			default: bnwSpeed*=2; break;
			}}
		if(ni("HEAVY")){switch(bnwbase[1])
			{
			case Bullet1: bnwbase[1]=HeavyBullet; bnwDamage=7; break;
			case Slug: bnwbase[1]=HeavySlug; bnwDamage=60; bnwSpeed=12; break;
			case Bolt: bnwbase[1]=HeavyBolt; bnwDamage=50; bnwSpeed=16; break;
			case Grenade: bnwbase[1]=HeavyNade; bnwDamage=30; break;
			default: bnwDamage*=2; bnwLoad*=2; break;
			}}
		
		if(ni("ASSAULT")){bnwLoad*=2}
		if(ni("SUPER")){bnwLoad=floor(bnwLoad*1.5)}
		
		if(ni("FROG")){bnw3[1]*=2; bnw3[2]+=10}
		if(ni("SEEKER")){bnwLoad*=5; if(ni("ULTRA")){bnw3[1]*=4}else{bnw3[1]*=2; bnw3[2]+=10}}
		if(ni("LASER")){bnwLoad*=2}
		if(ni("LIGHTNING")){bnwLoad*=2}
		
		if(ni("ERASER")){bnwLoad*=3}
		if(ni("SLUGGER")){bnwLoad*=3}
		if(ni("CROSSBOW")){bnw1Angle*=0.5; bnwLoad*=4}
		if(ni("SPLINTER")){bnwLoad*=3; bnw3[1]*=5; bnw3[2]+=10;}
		if(ni("DISC")){bnwLoad=floor(bnwLoad*1.5)}
		if(ni("GRENADE")){bnwLoad*=3}
		if(ni("BAZOOKA")){bnwLoad*=5}
		if(ni("FLARE")){bnwLoad*=4; if(ni("ULTRA")){bnw3[1]*=6}}
		if(ni("PLASMA")){bnwLoad=ceil(bnwLoad*2.5)}
		
		if(ni("GOLDEN")){if(!scrNWMn(3)){bnwLoad-=(bnwLoad div 5)}}
		
		if(ni("AUTO")){bnwLoad=ceil(bnwLoad*0.4); bnw1Angle*=4}
		
		if(ni("CLUSTER")){bnwLoad=ceil(bnwLoad*1.25)}
		if(ni("FLAME")){bnwLoad=ceil(bnwLoad*1.25); if(bnwbase[1]==Bullet2){bnwBbase=[0,0,0,0]; bnwbase[1]=FlameShell}}
		if(ni("BLOOD")){bnwLoad=ceil(bnwLoad*0.6); if(bnwbase[1]==Grenade){bnwBbase=[0,0,0,0]; bnwbase[1]=BloodGrenade; bnwDamage=10}else{bnwDamage=ceil(bnwDamage*0.6)}}
		if(ni("TOXIC")){switch(bnwbase[1])
			{
			case Bolt: bnwBbase=[0,0,0,0]; bnwbase[1]=ToxicBolt; break;
			case Grenade: bnwBbase=[0,0,0,0]; bnwbase[1]=ToxicGrenade; break;
			default: break;
			}}
		
		if(ni("PISTOL")){if(bnwbase[1]==Grenade){bnwbase[1]=MiniNade; bnwDamage=3;}else{bnwLoad=floor(bnwLoad*0.5); if(bnw3[1]){bnw3[1]=ceil(bnw3[1]*0.5); bnw3[2]=ceil(bnw3[2]*0.5)}else{if(bnwbase[1]!=Laser&&bnwbase[1]!=Lightning){bnwDamage=ceil(bnwDamage*0.5)}}}}
		if(ni("REVOLVER")){bnw1Angle*=0.2; bnwSpeed*=1.5}
		if(ni("RIFLE")){if(ni("LIGHTNING")){bnwLoad*=2}else{bnwLoad=ceil(bnwLoad*0.6)}; if(bnw1Times){bnw1Angle*=0.5}else{bnw1Angle*=1.2}}
		if(ni("SMG")){bnw1Angle*=4; bnwLoad=ceil(bnwLoad*0.5)}
		if(ni("MINIGUN")){bnw1Angle*=4; bnwLoad=ceil(bnwLoad*0.1)}
		if(ni("SHOTGUN")){bnwLoad*=3; bnw3[1]*=7; bnw3[2]+=20}
		
		if(ni("GOLDEN")){if(scrNWMn(3)){bnw3[1]+=1}}
		
		if(ni("RUSTY")){bnwLoad+=1; bnw1Angle*=0.5; bnw3[1]*=0.5}
		
		return [bnwLoad, bnwRads, max(bnw1Times,1), bnw1Angle, max(bnw2[1],1), bnw2[2], max(bnw3[1],1), bnw3[2], bnwbase[1], bnwDamage, bnwSpeed, bnwBbase[1], bnwBbase[2], bnwBbase[3]]
		//[0.load, 1.rads, 2.1times, 3.accuracy, 4.angletimes, 5.angleaccuracy, 6.shottimes, 7.shotaccuracy, 8.projectile, 9.damage, 10.speed, 11.Bprojectile, 12.Bdamage, 13.Bspeed]
		}
	}

#define scrNWM(ar)
	{
	if(ar==2){if(ni("SUPER")&&!ni("CANNON")){return ["SUPER",5,15]; exit}}
	ar-=1
	for(var i=0; i<array_length(wepMN[ar]); i++)
		{if(ni(wepMN[ar][i][0])){return wepMN[ar][i]; exit}}

	return [0,0,0];
	}

#define scrNWMn(ar)
	{
	var a=scrNWM(ar)
	return a[1]
	}

#define scrNWnumBase()
	{
	for(var i=0; i<array_length(wepProj); i++)
		{if(ni(wepProj[i][0])){return wepProj[i]; exit}}
	return -1
	}

#define scrNWnumBBase()
	{
	for(var i=0; i<array_length(wepIn); i++)
		{if(ni(wepIn[i][0])){return wepIn[i]; exit}}
	return [0,0,0,0]
	}



#define draw

#define race_name
return "robo";
#define race_text
return "merge guns";

#define race_portrait
return global.portrait;
#define race_mapicon
return global.mapicon;

#define race_swep
return "robo merge";
#define game_start
if(wep == "robo merge")
	{
	wep = 
		{
		wep: mod_variable_get("weapon", "robo merge", "mc"), 
		name: "hyper pistol", 
		type: 1, 
		auto: false, 
		load: 3, 
		cost: 1, 
		rads: 0, 
		sprt: 0, 
		laser_sight: false, 
		
		sound: sndMachinegun, 
		
		times: 1, 
		accuracy: 3, 
		angletimes: 0, 
		angleaccuracy: 0, 
		shottimes: 1, 
		shotaccuracy: 0, 
		proj: 175, 
		damage: 3, 
		pspeed: 32, 
		
		bproj: 0, 
		bdamage: 0, 
		bspeed: 0, 
		btimes: 1, 
		
		energy: 0, 
		molefish: 0, 
		golden: 0, 
		smart: 0, 
		hyper: 1,
		ultra: 0, 
		
		laser: 0, 
		lightning: 0, 
		}
	}

#define race_avail	return true
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock
return "reach market"

#define race_menu_button
sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}
#define race_menu_select
return sndMutant8Slct
#define race_menu_confirm
return sndMutant8Cnfm
/*
#define race_skins
return 2;
#define race_skin_button
switch(argument0)
	{
	case 0: sprite_index = ; break;
	case 1: sprite_index = ; break;
	default: break;
	}
*/
#define race_tb_text
return "copy weps";
#define race_tb_take

#define race_ultra_name
switch(argument0)
	{
	case 1: return "Efficiency V";break;
	case 2: return "Unbreaking III";break;
	default: return "";break;
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return "less load";break;
	case 2: return "less cost";break;
	default: return "";break;
	}
/*
#define race_ultra_button
switch(argument0)
	{
	case 1: sprite_index  =  ;
	case 2: sprite_index  =  ;
	default: sprite_index  =  ;
	}

#define race_ultra_take
switch(argument0)
	{
	case 1: break;
	case 2: break;
	default: break;
	}

#define race_ultra_icon
switch(argument0)
	{
	case 1: return ;break;
	case 2: return ;break;
	default: return ;break;
	}
*/
#define race_ttip
return [];

#macro basenw [6,3]
#define scrOS if(mnAuto==-1){mnAuto=argument0}
#define ni return string_pos(argument0, wo)

#define nwsnd
	{
	switch(nwn[8])
		{
		case EnemyBullet2: return sndFrogPistol; exit; 
		case FrogQueenBall: return sndBallMamaFire; exit; 
		case BouncerBullet: return sndBouncerShotgun; exit; 
		case Seeker: return sndSeekerShotgun; exit; 
		case Laser: return sndLaser; exit; 
		case EnemyLaser: return sndLaserUpg; exit; 
		case Lightning: return sndLightningPistolUpg; exit; 
		case LightningBall: return sndLightningCannonUpg; exit; 
		case IDPDBullet: return sndGruntFire; exit; 
		case Bullet2: return sndShotgun; exit; 
		case FlameShell: return sndFireShotgun; exit; 
		case UltraShell: return sndUltraShotgun; exit; 
		case Slug: return sndSlugger; exit; 
		case HeavySlug: return sndHeavySlugger; exit; 
		case HyperSlug: return sndHyperSlugger; exit; 
		case Bolt: 
		case ToxicBolt: return sndCrossbow; exit; 
		case HeavyBolt: return sndHeavyCrossbow; exit; 
		case UltraBolt: return sndUltraCrossbow; exit; 
		case Splinter: return sndSplinterPistol; exit; 
		case Disc: return sndDiscgun; exit; 
		case Grenade: 
		case HeavyNade: 
		case HyperGrenade: 
		case MiniNade: return sndGrenade; exit; 
		case BloodGrenade: return sndBloodLauncher; exit; 
		case ToxicGrenade: return sndToxicLauncher; exit; 
		case UltraGrenade: return sndUltraGrenade; exit; 
		case Rocket: return sndRocket; exit; 
		case Nuke: return sndNukeFire; exit; 
		case Flare: return sndFlare; exit; 
		case PlasmaBall: return sndPlasma; exit; 
		case Bullet1: return sndMachinegun; exit; 
		case HeavyBullet: return sndHeavyMachinegun; exit;
		case UltraBullet: return sndUltraPistol; exit; 
		default: return -1; exit;
		}
	}
#define nwammo
for(var i=0; i<array_length(wepAmmo); i++)
	{if(ni(wepAmmo[i,0])){return wepAmmo[i,1]}}
return 0; 

#define nwauto
for(var i=0; i<array_length(wepAuto); i++)
	{if(ni(wepAuto[i,0])){return wepAuto[i,1]}}
if(ni("RIFLE")&&!scrNWMn(1)){return 1}
return 0;

#define nwcost
var a=nwn[4]
if(ni("HEAVY")){a*=2}
if(ni("PLASMA")){a*=1.5}
if!(ni("ERASER")&&(nwn[8]==Bullet2||nwn[8]==UltraShell||nwn[8]==FlameShell)){a*=nwn[2]}
if(ni("SHOTGUN")&&!(nwn[8]==Bullet2||nwn[8]==UltraShell||nwn[8]==FlameShell)){a*=7}
if(ni("CANNON")){if(ni("SUPER")){a*=16}else{a*=8}}
if(ultra_get("robo",2)){a*=0.5}
return ceil(a)

#define nwsprt
if(ni("RIFLE")){return nwauto() ? 2 : 1}
if(ni("SMG") || ni("MINIGUN")){return 2}
if(ni("SHOTGUN")){return 3}
if(ni("PLASMA") || ni("THROWER") || ni("DRAGON")){return 5}

if(ni("ERASER")){return 4}
if(ni("SLUGGER")){return 4}
if(ni("CROSSBOW")){return 1}
if(ni("SPLINTER")){return 2}
if(ni("DISC")){return 4}
if(ni("GRENADE")){return 2}
if(ni("BAZOOKA")){return 4}
if(ni("FLARE")){return 2}

if(ni("PISTOL") || ni("REVOLVER")){return 0}

