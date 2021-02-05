#define init

//	race_set_active(0,	0)	//Random
//	race_set_active(7,	0)	//Steroids
	race_set_active(8,	0)	//Robot

	weapon_set_name(31,	"TOXIC CROSSBOW")	//ToxicBow
	weapon_set_name(67,	"BLOOD LUTE")		//BloodHammer

	weapon_set_area(2,	-1)		//TripleMachinegun
//	weapon_set_area(3,	3)		//Wrench
	weapon_set_area(5,	-1)		//Shotgun
//	weapon_set_area(8,	-1)		//DoubleShotgun
	weapon_set_area(29,	3)		//BloodLauncher
//	weapon_set_area(31,	-1)		//ToxicBow
	weapon_set_area(57,	2)		//LightningPistol
	weapon_set_area(58,	5)		//LightningRifle
	weapon_set_area(58,	6)		//LightningShotgun
	weapon_set_area(64,	10)		//LightningSMG
	weapon_set_area(65,	-1)		//SmartGun
	weapon_set_area(68,	10)		//LightningCannon
//	weapon_set_area(72,	-1)		//ToxicLauncher
	weapon_set_area(87,	-1)		//UltraLaserPistol
	weapon_set_area(91,	5)		//HeavySlugger
	weapon_set_area(93,	-1)		//UltraShotgun

//	skill_set_active(2,		0)		//ExtraFeet
//	skill_set_active(10,	0)		//BackMuscle
	skill_set_active(12,	0)		//Euphomia
	skill_set_active(15,	0)		//ShotgunShoulders
	skill_set_active(16,	0)		//RecycleGland
	skill_set_active(19,	0)		//EagleEyes
//	skill_set_active(24,	0)		//SharpTeeth
	skill_set_active(28,	0)		//OpenMind

for({pn = -1;i=0}; i<maxp; i++){pn+=player_is_active(i)};
var p=5+pn*3;
show=0;



list=
	[
	
	"main",
	
	["nts.mod.gml",				p],
	["ntsCont.mod.gml",			p],
	["enemy/ntsECont.mod.gml",	p],
	["ntsUI.mod.gml",			p],
	["altcharselect.mod.gml",	1],
	["ntsWepdrop.mod",			1],
	["ntsDrive.mod",			1],
	["ntsBlood.mod.gml",		1],
	["ntsSkirmish.mod.gml",		1],
	
	
	
	"area",
	
	["area/areaCont.area.gml",			p],
	["area/dungeon/dungeon.area.gml",	p],
	["area/parad/parad.area.gml",		p],
	["area/mansion/mansion.area.gml",	p],
	["area/helipad/helipad.area.gml",	p],
	["area/grove/grove.area.gml",		p],
	["area/outlab/outlab.area.gml",		p],
	["area/ruins/ruins.area.gml",		p],
//	["area/market.area.gml",			p],
	
	
	
	"wep1",
	
	["wep/ally gun.wep.gml",	1],
	
	["wep/bandit gun.wep.gml",		1],
	["wep/big bandit gun.wep.gml",	1],
	
	["wep/gator shotgun.wep.gml",	1],
	["wep/gator flak.wep.gml",		1],
	["wep/pipe.wep.gml",			1],
	["wep/cigarette.wep.gml",		1],
	
	["wep/sniper rifle.wep.gml",	1],
	["wep/raven gun.wep.gml",		1],
	
	["wep/molefish pistol.wep.gml",		1],
	["wep/molefish shotgun.wep.gml",	1],
	
	["wep/hunter rifle.wep.gml",	1],
	["wep/hunter shotgun.wep.gml",	1],
	
//	["wep/necrogun.wep.gml",	1],
	
	["wep/throne scythe.wep.gml",	1],
	["wep/throne cannon.wep.gml",	1],
	
	["wep/idpd rifle.wep.gml",				1],
	["wep/idpd elite rifle.wep.gml",		1],
	["wep/idpd heavy rifle.wep.gml",		1],
	["wep/idpd plasma minigun.wep.gml",		1],
	["wep/idpd slugger.wep.gml",			1],
	["wep/idpd baton.wep.gml",				1],
	
//	["wep/lil.horror.wep.gml",	1],
	
	
	
	"wep2",
	
	["wep/triple mg.wep.gml",			1],
//	["wep/explo bow.wep.gml",			1],
	["wep/terminal cannon.wep.gml",		1],
	["wep/stupid gun.wep.gml",			1],
	["wep/ultra chopper.wep.gml",		1],
	
	
	
	"wep3",
	
	["wep/bandit.wep.gml",	1],
	["wep/barrel.wep.gml",	1],
	["wep/cactus.wep.gml",	1],
	
	["wep/turtle.wep.gml",	1],
	
//	["wep/trap thrower.wep.gml",	1],
	
	["wep/golden barrel.wep.gml",	1],
	
//	["wep/streetlight.wep.gml",		1],
	
	
	
	"wep4",
	
	["wep/flesh arm.wep.gml",			1],
	["wep/flashlight.wep.gml",			1],
	["wep/broken royal sword.wep.gml",	1],
	["wep/royal sword.wep.gml",			1],
	["wep/envoy smg.wep.gml",			1],
	["wep/rusty buckler.wep.gml",	1],
	["wep/venuz knife.wep.gml",			1],
	["wep/rusty shovel.wep.gml",		1],
//	["wep/zero sword.wep.gml",			1],
//	["wep/wand.wep.gml",				1],
//	["wep/gundam energy sword.wep.gml",	1],
	
//	["wep/blood skull.wep.gml",		1],
//	["wep/blood bass.wep.gml",		1],
//	["wep/blood buckler.wep.gml",	1],
	
	["wep/lightning ladder.wep.gml",	1],
	
	["wep/toxic hammer.wep.gml",			1],
	["wep/auto toxic crossbow.wep.gml",		1],
	["wep/super toxic crossbow.wep.gml",	1],
	["wep/toxic thrower.wep.gml",			1],
	["wep/hyper toxic launcher.wep.gml",	1],
	["wep/toxic bazooka.wep.gml",			1],
	["wep/gatling toxic bazooka.wep.gml",	1],
	["wep/super toxic bazooka.wep.gml",		1],
	["wep/toxic nuke launcher.wep.gml",		1],
	
	["wep/bouncerka.wep.gml",	1],
	
	["wep/bullet shotgun.wep.gml",		1],
	["wep/auto bullet shotgun.wep.gml",	1],
	
	["wep/nuke bazooka.wep.gml",	1],
	
	["wep/crystal rapier.wep.gml",			1],
//	["wep/crystal buckler.wep.gml",			1],
	["wep/crystal hammer.wep.gml",			1],
	["wep/crystal giant sword.wep.gml",		1],
	["wep/crystal tank.wep.gml",			1],
	
	["wep/crowbar.wep.gml",			1],
	["wep/hyper katana.wep.gml",	1],
	
	["wep/sniper pistol.wep.gml",		1],
	["wep/sniper wand.wep.gml",			1],
	["wep/auto sniper rifle.wep.gml",	1],
	
	["wep/pizza cutter.wep.gml",	1],
	
	["wep/gamma pistol.wep.gml",	1],
	["wep/gamma rifle.wep.gml",		1],
	["wep/gamma cannon.wep.gml",	1],
	
//	["wep/unstable sword.wep.gml",		1],
//	["wep/unstable trichord.wep.gml",	1],
	
	["wep/camera.wep.gml",	1],
	
//	["wep/red claw.wep.gml",		1],
//	["wep/black spike.wep.gml",		1],
	
	["wep/blue rose.wep.gml",	1],
	["wep/red queen.wep.gml",	1],
	
	["wep/strike gun.wep.gml",	1],
	
	["wep/bow.wep.gml",			1],
	["wep/long bow.wep.gml",	1],
	["wep/ultra bow.wep.gml",	1],
	
//	["wep/raven laser cannon.wep.gml",	1],
	
	["wep/golden pipe.wep.gml",				1],
	["wep/golden crowbar.wep.gml",			1],
	["wep/golden venuz knife.wep.gml",		1],
	["wep/golden pizza cutter.wep.gml",		1],
//	["wep/golden wand.wep.gml",				1],
	["wep/golden sniper rifle.wep.gml",		1],
	
	["wep/thief key.wep.gml",	1],
//	["wep/helmet.wep.gml",		1],
	
	
	
	"wep5",
	
//	["wep/wspr/awp.mod.gml",		1],
	["wep/wspr/killfeed.wep.gml",	1],
	["wep/wspr/flakzooka.wep.gml",	1],
	["wep/wspr/laserwall.wep.gml",	1],
	["wep/wspr/ppnshot.wep.gml",	1],
	["wep/wspr/shotgod.wep.gml",	1],
	
	"wep6",
	
	["wep/REAwep/hand grenade.wep.gml",			1],
	["wep/REAwep/hand flare grenade.wep.gml",	1],
	
	
	
	"race",
	
	["race/robo/robo.race.gml",							p],
	["wep/robo merge.wep.gml",							1],
//	["race/pumpking/pumpking.race.gml",					p],
	["race/coward/coward.race.gml",						p],
	["race/cur/cur.race.gml",							p],
//	["race/molefish/molefish.race.gml",					p],
//	["race/molefish/molefishmd.mod.gml",				p],
//	["race/molefish/molefishfpscontrols.mod.gml",		p],
//	["race/clown/clown.race.gml",						p],
//	["race/cap/cap.race.gml",							p],
	["race/envoy/envoy.race.gml",						p],
//	["race/gaze/gaze.race.gml",							p],
	["race/guard/guard.race.gml",						p],
	["race/digger/digger.race.gml",						p],
	["race/tricker/tricker.race.gml",					p],
	["race/phantom/phantom.race.gml",					p],
	["race/awkwardman/awkwardman.race.gml",				p],
	["race/awkwardman/crazy.mod.gml",					1],
//	["race/zero/zero.race.gml",							p],
//	["race/bronya/bronya.race.gml",						p],
//	["race/shovel knight/shovel knight.race.gml",		p],
//	["race/kurosaki/kurosaki.race.gml",					p],
//	["race/vgundam/vgundam.race.gml",					p],
//	["race/binah/binah.race.gml",						p],
//	["race/defect/defect.race.gml",						p],
	
	
	
	"skin",
	
	["skin/pictographic.skin.gml",		1],
	["skin/gun god/gun god.skin.gml",	p],
	
	
	
	"mutation",
	
	["mtt/ge/ge.skill.gml",		1],
	["mtt/rj/rj.skill.gml",		1],
	["mtt/rw/rw.skill.gml",		1],
	["mtt/cl/cl.skill.gml",		1],
	["mtt/bc/bc.skill.gml",		1],
	["mtt/pl/pl.skill.gml",		1],
	["mtt/pn/pn.skill.gml",		1],
	["mtt/np/np.skill.gml",		1],
//	["mtt/nn/nn.skill.gml",		1],
	["mtt/al/al.skill.gml",		1],
//	["mtt/am/am.skill.gml",		1],
//	["mtt/ef.skill.gml",		1],
//	["mtt/br.skill.gml",		1],
	["mtt/ee.skill.gml",		1],
	["mtt/mb.skill.gml",		1],
	["mtt/comminuted_phalanx/comminuted_phalanx.skill.gml",			1],
	["mtt/purged_dhatuyo/purged_dhatuyo.skill.gml",					1],
	["mtt/shinning_fingernail/shinning_fingernail.skill.gml",		1],
	
	
	
	"crown",
	
	["crown/destimy/destimy.crown.gml",		1],
	["crown/master/master.crown.gml",		1],
	["crown/braid/braid.crown.gml",			1],
	["crown/evolution/evolution.crown.gml",	1],
	
	
	
	/*
	["wep/.wep.gml",	1],
	["race/.race.gml",	p],
	["mtt/.skill.gml",	1],
	["area/.area.gml",	p],
	["gml",	],
	*/
	"end"
	]

while(!mod_sideload()||!instance_exists(Menu)){wait 0}



show=1; lmax = array_length(list); ltxt = "";
for(load = 0; list[load]!="end"; load++)
	{
	a=list[load]
	if(array_length(a))
		{
		mod_load(a[0]); 
		wait a[1]
		}
	else{ltxt = a}
	}



mod_loadtext("main3.txt");

#define draw_gui
if(show)
	{
	draw_text_nt(32,32,string(load)+"/"+string(lmax))
	draw_text_nt(32,48,ltxt)
	}
