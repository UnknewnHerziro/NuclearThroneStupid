
#define init
globalvar ls, data, datal
data = 
	[
		[Gator,				0.2,	true,	"gator shotgun",		0,	1], 
		[BuffGator,			0.5,	true,	"gator flak",			1,	2], 
		[MeleeBandit,		0.2,	true,	"pipe",					0,	0], 
		[Raven,				0.2,	true,	"raven gun",			0,	2], 
		[Sniper,			0.2,	true,	"sniper rifle",			0,	0], 
		[Molefish,			0.2,	true,	"molefish pistol",		0,	1], 
		[Molesarge,			0.2,	true,	"molefish shotgun",		0,	1], 
		[JungleAssassin,	0.2,	true,	"pipe",					0,	0], 
		[Grunt,				0.4,	true,	"idpd rifle",			0,	0], 
		[EliteGrunt,		0.8,	true,	"idpd elite rifle",		0,	0], 
		[Shielder,			0.4,	true,	"idpd heavy rifle",		0,	0], 
		[EliteShielder,		0.8,	true,	"idpd plasma minigun",	0,	0], 
		[Inspector,			0.4,	true,	"idpd slugger",			0,	0], 
		[EliteInspector,	0.8,	true,	"idpd baton",			0,	0], 
		[BanditBoss,		1,		false,	"big bandit gun",		2,	4], 
		[Nothing,			1,		false,	"throne scythe",		0,	0], 
	//	[EnemyHorror,		1,		false,	"lil.horror",			0,	0], 
	]
datal = array_length(data)

#define step
ls = sqr(GameCont.loops+1)

for(var i=0; i<datal; i++){with(instances_matching_le(data[i,0], "my_health", 0))
	{scrDrop(data[i,1], data[i,2], data[i,3], data[i,4], data[i,5])}}

with(Turtle){if(my_health<=0){with(instance_create(x,y,WepPickup)){wep="turtle"};instance_create(x,y,Corpse);instance_delete(self)}}

with(instances_matching_le(Bandit, "my_health", 0)){scrDrop(0.2, 1, random(1<0.05)?"bow":"bandit gun", 0, 1)}
with(instances_matching_le(Ally, "my_health", 0)){scrDrop(0.1, 1, random(1<0.05)?"bow":(skill_get(5)?"ally gun":"bandit gun"), 0, 1)}
with(instances_matching_le(LilHunter, "my_health", 0)){scrDrop(1, 0, choose("hunter rifle","hunter shotgun"), 2, 4)}

//if(GameCont.loops>0 && GameCont.loops<5){with(HyperCrystal){if(my_health <= 0){with(instance_create(x, y, WepPickup)){wep = GameCont.hcd[GameCont.loops]}}}}

with(ScrapBoss){if(my_health <= 0){with(instance_create(x, y, WepPickup))
	{
//	wep = "thief key"
	with(instance_create(0, 0, ProtoChest))
		{
		other.wep = (wep == "thief key") ? "raven laser cannon" : "thief key"
		instance_delete(self)
		}
	}}}



#define scrDrop(c, lp, w, amin, amax)
if(random(lp?ls:1)<c){with(instance_create(x, y, WepPickup))
	{
	wep = w
	ammo = random_range(amin, amax)
	}}
