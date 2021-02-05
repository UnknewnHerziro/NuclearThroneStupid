#define init
icon = sprite_add("Icon.png", 1, 9, 9);
skill = sprite_add("Skill.png", 1, 12, 16);

globalvar icon, skill, lp, post_last_wish

#define game_start
post_last_wish = !skill_get(mut_last_wish)

#define skill_take
lp = GameCont.loops
post_last_wish = !skill_get(mut_last_wish)
if(instance_exists(LevCont))
	{sound_play_pitch(sndHyperCrystalChargeExplo, 0.5)}

#define skill_lose
with(Player)
	{
	curse = 0
	bcurse = 0
	}

#define step
	{
	if(GameCont.area == 104)
		{
		skill_set("cl", false)
		skill_set("purged_dhatuyo", true)
		sound_play(sndUncurse)
		exit
		}
	
	if(GameCont.loops>lp || GameCont.area==100 || (post_last_wish && skill_get(mut_last_wish)))
		{
		skill_set("cl", false)
		sound_play(sndUncurse)
		GameCont.skillpoints ++
		exit
		}

	with(Player)
		{
		curse = 2
		bcurse = 2
		}
	with(WepPickup){curse = 2}
	with(ThrownWep){curse = 2}
	with(BigWeaponChest)
		{
		instance_create(x, y, BigCursedChest)
		instance_delete(self)
		}
	if(instance_exists(Player)){with(AmmoPickup)
		{
		cursed = true
		sprite_index = sprCursedAmmo
		blink = 2
		num = 2
		var a = instance_nearest(x, y, Player)
		if(instance_exists(Portal) || speed==0 || distance_to_object(a)<8)
			{
			direction = point_direction(x, y, a.x, a.y)
			speed = 4
			}
		}}
	}



#define skill_name
return "Cursed Lithiasis"

#define skill_text
if(skill_get(mod_current)){return `${pc("CURSE")}#${pc("never")}#${pc("disappear")}`}
else{return "@pcurse @snever disappear"}

#define pc(str)
for(var i=string_length(str); i>1; i--)
	{str = string_insert(psglps(), str, i)}
return string_insert(ps(), str, 1)

#define psglps
return ps()+gl()+ps()

#define ps
return "@"+choose("p","p","p","s")

#define gl
do{var a = irandom_range(32,126)}until(!(a==35 || a==64))
return chr(a)


#define skill_tip
return "@p@qpay for it@s"

#define skill_icon
return icon
#define skill_button
sprite_index = skill

#define skill_wepspec
return false
#define skill_avail
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, "phantom", false)}
	}