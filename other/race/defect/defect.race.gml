
#define init
	{
	global.lqoAssets = {}
	with(assets)
		{
		sndCardReject	= sound_add("sound/card_reject.ogg")
		sndCardSelect	= sound_add("sound/card_select.ogg")
		sndSlotGain		= sound_add("sound/slot_gain.ogg")
		sndFocus		= sound_add("sound/focus.ogg")
		
		aryOrgSound = 
			[
				[
				sound_add("sound/lightning_channel.ogg"), 
				sound_add("sound/lightning_passive.ogg"), 
				sound_add("sound/lightning_evoke.ogg"), 
				], 
				[
				sound_add("sound/frost_channel.ogg"), 
				sound_add("sound/frost_passive.ogg"), 
				sound_add("sound/frost_evoke.ogg"), 
				], 
				[
				sound_add("sound/dark_channel.ogg"), 
				sound_add("sound/dark_evoke.ogg"), 
				sndPortalOpen, 
				], 
				[
				sound_add("sound/plasma_channel.ogg"), 
				-1, 
				sound_add("sound/plasma_evoke.ogg"), 
				], 
			]
		
		sndFrostDefense = 
			[
			sound_add("sound/frost_defense_1.ogg"), 
			sound_add("sound/frost_defense_2.ogg"), 
			sound_add("sound/frost_defense_3.ogg"), 
			]
		}
	
	global.maxhand = skill_get(5) ? 6 : 4
	global.maxorbs = 3
	global.aryDeck = [ds_list_create(), ds_list_create(), ds_list_create(), ds_list_create()]
	global.aryPile = [ds_list_create(), ds_list_create(), ds_list_create(), ds_list_create()]
	global.aryOrbs = [ds_list_create(), ds_list_create(), ds_list_create(), ds_list_create()]
	
	global.aryCard = 
		[
			[
		//	"Strike", 
		//	"Zap", 
		//	"Dualcast", 
			"Ball_Lightning", 
		//	"Barrage", 
			"Cold_Snap", 
			"Coolheaded", 
		//	"Rebound", 
			"Recursion", 
			"Sweeping_Beam", 
			],
			[
			"Chaos", 
			"Darkness", 
			"Doom_and_Gloom", 
			"Double_Energy", 
			"Fusion", 
			"Glacier", 
			"Over_Clock", 
			"Rip_and_Tear", 
		//	"Scrape", 
			"Self_Repair", 
			"Skim", 
			"Tempest", 
			
			"Barrage", 
			"TURBO", 
			],
			[
			"Buffer", 
			"Fission", 
			"Multi_Cast", 
			"Rainbow", 
			"Reboot", 
			],
		]
	
	global.mapData = ds_map_create()
	mcrData[?"Strike"]				= [0,		txtStrike]
	mcrData[?"Zap"]					= [0,		txtOrb_lightning]
	mcrData[?"Dualcast"]			= [0,		`${txtOrb + txtEvoke}@2(sprMutant6Idle)`]
	mcrData[?"Ball_Lightning"]		= [1,		`${txtStrike}+${txtOrb_lightning}`]
	mcrData[?"Barrage"]				= [1,		`${txtOrb}=${txtStrike}`]
	mcrData[?"Cold_Snap"]			= [1,		`${txtStrike}+${txtOrb_frost}`]
	mcrData[?"Coolheaded"]			= [1,		`${txtDraw + txtDraw}+${txtOrb_frost}`]
	mcrData[?"Rebound"]				= [1,		`${txtStrike}+`]
	mcrData[?"Recursion"]			= [0,		`${txtOrb + txtEvoke}+${txtOrb}`]
	mcrData[?"Sweeping_Beam"]		= [2,		`${txtDraw}+@3(sprLaserCannon)`]
	mcrData[?"TURBO"]				= [0,		`${txtCost + txtCost + txtCost}+${txtSlow}`]
	mcrData[?"Chaos"]				= [1,		`?${txtOrb}${txtOrb}`]
	mcrData[?"Darkness"]			= [0,		`${txtOrb_dark}`]
	mcrData[?"Doom_and_Gloom"]		= [1,		`${txtOrb_dark}+@4(sprBlackSword)`]
	mcrData[?"Double_Energy"]		= [0,		`${txtCost}x2`]
	mcrData[?"Fusion"]				= [1,		`${txtOrb_plasma}`]
	mcrData[?"Glacier"]				= [1,		`${txtOrb_frost}+${txtOrb_frost}`]
	mcrData[?"Over_Clock"]			= [0,		`${txtDraw + txtDraw + txtDraw}+!@1(sprGroundFlameBig)`]
	mcrData[?"Rip_and_Tear"]		= [1,		`${txtStrike}@2(sprMutant6Idle)`]
	mcrData[?"Scrape"]				= [1,		`${txtStrike}+`]
	mcrData[?"Self_Repair"]			= [1,		`@1(sprHP)`, 7]
	mcrData[?"Skim"]				= [1,		`${txtDraw + txtDraw + txtDraw}`]
	mcrData[?"Tempest"]				= [null,	`${txtCost}=${txtOrb_lightning}`]
	mcrData[?"Buffer"]				= [1,		`@2(sprSkillIconHUD:${mut_strong_spirit})`]
	mcrData[?"Fission"]				= [0,		`${txtOrb}=${txtEvoke}+${txtDraw}`]
	mcrData[?"Multi_Cast"]			= [null,	`${txtCost}=${txtEvoke}`]
	mcrData[?"Rainbow"]				= [1,		`${txtOrb_lightning}${txtOrb_frost}${txtOrb_dark}`]
	mcrData[?"Reboot"]				= [0,		`@1(sprKeySmall:82)+${txtDraw + txtDraw + txtDraw + txtDraw}`]
	}
/*
global.spr_idle		= sprite_add("idle.png",		4,	12,	12)
global.spr_walk		= sprite_add("walk.png",		6,	12,	12)
global.spr_hurt		= sprite_add("hurt.png",		3,	12,	12)
global.spr_dead		= sprite_add("dead.png",		6,	12,	12)
global.spr_idleb	= sprite_add("idleb.png",		4,	12,	12)
global.spr_walkb	= sprite_add("walkb.png",		6,	12,	12)
global.spr_hurtb	= sprite_add("hurtb.png",		3,	12,	12)
global.spr_deadb	= sprite_add("deadb.png",		6,	12,	12)
global.portrait		= sprite_add("portrait.png",	1,	35,	200)
global.portraitb	= sprite_add("portraitb.png",	1,	36,	236)
global.mapicon		= sprite_add("mapicon.png",		1,	10,	10)
global.chs			= sprite_add("CharSelect.png",	1,	0,	0)
global.EGI1			= sprite_add("Icon1.png",		1,	9,	9)
global.EGI2			= sprite_add("Icon2.png",		1,	9,	9)
global.EG1			= sprite_add("Skill1.png",		1,	12,	16)
global.EG2			= sprite_add("Skill2.png",		1,	12,	16)
*/

#define clear_up
for(var i=0; i<maxp; i++)
	{
	ds_list_destroy(mcrDeck[@i])
	ds_list_destroy(mcrPile[@i])
	ds_list_destroy(mcrOrbs[@i])
	}
ds_map_destroy(mcrData)

/*
#define create
spr_idle = spr
spr_walk = spr
spr_hurt = spr
spr_dead = spr
spr_sit1 = spr
spr_sit2 = spr
snd_hurt = snd
snd_dead = snd
snd_lowa = snd
snd_lowh = snd
snd_chst = snd
snd_wrld = snd
snd_valt = snd
snd_crwn = snd
snd_thrn = snd
snd_spch = snd
snd_idpd = snd
snd_cptn = snd

#define create
image_speed_raw = 0.4
spr_idle = global.spr_idle
spr_walk = global.spr_walk
spr_hurt = global.spr_hurt
spr_dead = global.spr_dead
spr_sit1 = global.spr_sit1
spr_sit2 = global.spr_sit2
snd_hurt = -1
snd_dead = -1
snd_lowa = -1
snd_lowh = -1
snd_chst = -1
snd_wrld = -1
snd_valt = -1
snd_crwn = -1
snd_thrn = -1
snd_spch = -1
snd_idpd = -1
snd_cptn = -1
*/

#define game_start
	{
	global.maxhand = 4
	global.maxorbs = 3
	for(var i=0; i<maxp; i++)
		{
		ds_list_clear(mcrDeck)
		ds_list_clear(mcrPile)
		ds_list_clear(mcrOrbs)
		
		repeat(4){deck_add("Strike")}
		//deck_add("Zap")
		//deck_add("Dualcast")
		repeat(2){deck_add(mcrCardBonus)}
		
		ds_list_shuffle(mcrDeck)
		
		ds_list_add(mcrOrbs, orb_lightning)
		}
	}



#define create
	{
	canfire = false
	canswap = false
	
	buffer = false
	
	action_reload = 30
	action_max = 30
	my_cost = 3
	maxcost = 3
	hand_number = 2
	hand_index = 0
	shuffling = 20
	shuffle_max = 20
	rebound = 0
	echo = false
	
	orb_frame = random(360)
	orb_speed = 5
	orb_biase = 0
	orb_reload = 45
	orb_maxload = 30
	
	bonus_card = null
	}



#define step
	{
	global.maxorbs = floor(3 + GameCont.level * 0.5)
	script_bind_draw(scrDrDefect, -8, self)
//	ammo = [0, 0, 0, 0, 0, 0]
	
	if(hand_number!=0 && hand_index>=hand_number)
		{hand_index = hand_number-1}
	
	orb_frame = (orb_frame + orb_speed * current_time_scale) mod 360
	
	if(skill_get(mut_trigger_fingers) && array_length(instances_matching_le(enemy, "my_health", 0)))
		{
		action_reload *= 0.4
		shuffling *= 0.4
		hand_number ++
		}
	
//Extra Orbs $ Extra Hands
	while(ds_list_size(mcrOrbs)>global.maxorbs && global.maxorbs>=0)
		{
		orb_evoke(mcrOrbs[|0], 0)
		ds_list_delete(mcrOrbs, 0)
		orb_frame += 360 / global.maxorbs
		}
	
//Orbs Passive
	orb_reload -= current_time_scale
	if(orb_reload <= 0)
		{
		orb_reload = orb_maxload
		var size = ds_list_size(mcrOrbs)
		for(var i=0; i<size; i++)
			{orb_passive(mcrOrbs[|i], i)}
		}
	
//Bonus Cards
	if(is_array(bonus_card))
		{
		script_bind_draw(scrDrDefectBonus, -16, self)
		if(button_released(index, "pick") && !nearwep && array_length(bonus_card)>0)
			{
			var name = bonus_card[@(gunangle + 315) mod 360 div (360 / array_length(bonus_card))]
			deck_add(name)
			say(`${string_replace_all(name, "_", " ")}!`)
			bonus_card = []
			if(player_is_local_nonsync(index)){sound_play_shuffle()}
			}
		if(!instance_exists(Portal))
			{bonus_card = null}
		}
	else{
		if(instance_exists(Portal))
			{
			bonus_card = []
			repeat(3)
				{array_push(bonus_card, mcrCardBonus)}
			}
		}
	
//Shuffle
	if(shuffling > 0)
		{
		shuffling -= (skill_get(mut_stress) ? reloadspeed*(2-my_health/maxhealth) : reloadspeed) * current_time_scale
		if(button_pressed(index, "fire"))
			{
			if(player_is_local_nonsync(index))
				{audio_sound_gain(sound_play_pitch(sndFishTB, 3), 3, 0)}
			say("shuffling")
			}
		exit
		}
	
	action_reload -= (skill_get(mut_stress) ? reloadspeed*(2-my_health/maxhealth) : reloadspeed) * current_time_scale
	
//Draw & Pre-shuffle
	if(action_reload <= 0)
		{
		action_reload = action_max
		
		var m = 0
		var size = ds_list_size(mcrOrbs)
		for(var i=0; i<size; i++)
			{if(mcrOrbs[|i] == orb_plasma){m ++}}
		if(my_cost < maxcost + m)
			{my_cost = min(floor(my_cost + 1), maxcost) + m}
		
		if(ultra_get(mod_current, 1) && echo==false)
			{
			echo = true
			sound_pitch(sound_play_hit(sndHitMetal, 0), 0.1)
			}
		
		hand_number = min(floor(ultra_get(mod_current, 2) ? 3 : 1 + hand_number), global.maxhand)
		}
	
//Shuffle on Purpose
	if(button_pressed(index, "spec"))
		{scrShuffle()}
	
//Switch Index
	if(button_pressed(index, "swap"))
		{
		if(player_is_local_nonsync(index))
			{sound_play_hit(assets.sndCardSelect, 0.3)}
		hand_index ++
		if(hand_index >= hand_number)
			{hand_index = 0}
		say(`${string_replace_all(mcrDeck[|hand_index], "_", " ")}!`)
		}
	
//Play Out
	if(button_pressed(index, "fire"))
		{
		if(hand_number > 0)
			{
			var name = mcrDeck[|hand_index]
			var cost = mcrData[?name][@0]
			if(is_real(cost))
				{
				if(cost > my_cost)
					{
					wkick = -3
					if(player_is_local_nonsync(index))
						{sound_play_hit(assets.sndCardReject, 0.3)}
					say("no enough energy")
					}
				else{
					if(rebound > 0)
						{
						ds_list_insert(mcrDeck, hand_number, mcrDeck[|hand_index])
						rebound --
						}
					else{ds_list_add(mcrPile, mcrDeck[|hand_index])}
					ds_list_delete(mcrDeck, hand_index)
					repeat(echo ? 2 : 1)
						{mod_script_call("race", mod_current, `card_${name}`, my_cost)}
					hand_number --
					echo = false
					my_cost -= cost
					}
				}
			else{
				if(rebound > 0)
					{
					ds_list_insert(mcrDeck, hand_number, mcrDeck[|hand_index])
					rebound --
					}
				else{ds_list_add(mcrPile, mcrDeck[|hand_index])}
				ds_list_delete(mcrDeck, hand_index)
				repeat(echo ? 2 : 1)
					{mod_script_call("race", mod_current, `card_${name}`, my_cost)}
				hand_number --
				echo = false
				my_cost = 0
				}
			}
		else{say("empty")}
		if(ds_list_size(mcrDeck) <= 0)
			{scrShuffle()}
		}
	
	if(hand_number > ds_list_size(mcrDeck))
		{
		ds_list_shuffle(mcrPile)
		var size = ds_list_size(mcrPile)
		for(var i=0; i<size; i++)
			{ds_list_add(mcrDeck, mcrPile[|i])}
		ds_list_clear(mcrPile)
		var size = ds_list_size(mcrDeck)
		if(size < hand_number)
			{hand_number = size}
		sound_play_shuffle()
		}
	my_cost = min(my_cost, maxcost * 2)
	}



#define draw_begin
	{
	if(bwep != wep_none)
		{
		with(instance_create(x, y, WepPickup))
			{wep = other.bwep}
		bwep = wep_none
		}
	
//	for(var i=0; i<6; i++)
//		{ammo[@i] = typ_amax[@i]}
	
	if(echo)
		{draw_sprite(sprMindPower, image_index, x, y)}
	}

#define draw_end
	{
	if(buffer)
		{
		draw_sprite_ext(sprite_index, image_index, xprevious, yprevious, image_xscale * right, image_yscale, image_angle + sprite_angle + angle, c_aqua, image_alpha * 0.5)
		if(my_health<lsthealth && my_health<maxhealth)
			{
			buffer = false
			my_health = min(maxhealth, ceil(lsthealth))
			sound_play_hit(sndStrongSpiritLost, 0.3)
			}
		}
	}



#define ref_instance_destroy	instance_destroy()
#define deck_add				ds_list_add(mcrDeck, argument0)
#define sound_play_shuffle		audio_sound_gain(sound_play_pitch(sndFishTB, 3), 3, 0)
#define say						with(instance_create(x, y, PopupText)){mytext = argument0}

#macro fire_slash				fire_slash_1()
#define fire_slash_1			with(instance_create(x, y, Slash)){direction = other.gunangle; image_angle = direction; creator = other; team = other.team; return self}



#define card_Strike				if(GameCont.rad >= weapon_get_rads(wep)){if(ammo[@weapon_get_type(wep)] >= weapon_get_cost(wep)){return player_fire()}else{sound_play_hit(sndEmpty, 0.3)}}else{sound_play_hit(sndUltraEmpty, 0.3)}; wkick = -3
#define card_Zap				orb_add(orb_lightning)
#define card_Dualcast			card_Multi_Cast(2)
#define card_Ball_Lightning		card_Strike(); orb_add(orb_lightning)
#define card_Barrage			var size = ds_list_size(mcrOrbs); var dir = 360 / global.maxorbs; var ox = x; var oy = y; for(var i=0; i<size; i++){var d = orb_frame + i * dir; x = ox + lengthdir_x(24, d); y = oy + lengthdir_y(24, d); player_fire()}; x = ox; y = oy
#define card_Cold_Snap			card_Strike(); orb_add(orb_frost)
#define card_Coolheaded			orb_add(orb_frost); hand_number += 2
#define card_Rebound			card_Strike(); rebound ++
#define card_Recursion			var size = ds_list_size(mcrOrbs); orb_evoke(mcrOrbs[|0], 0); ds_list_insert(mcrOrbs, size, mcrOrbs[|0]); ds_list_delete(mcrOrbs, 0); if(size >= global.maxorbs){orb_frame += 360 / global.maxorbs}
#define card_Sweeping_Beam		var w = wep; var a = ammo; wep = wep_laser_cannon; player_fire(); wep = w; ammo = a; hand_number += 1
#define card_TURBO				my_cost += 3; action_reload += action_max; sound_play_hit(assets.sndSlotGain, 0.3)
#define card_Chaos				repeat(2){orb_add(irandom(3))}
#define card_Darkness			orb_add(orb_dark); var size = ds_list_size(mcrOrbs); for(var i=0; i<size; i++){if(mcrOrbs[|i] == orb_dark){orb_passive(orb_dark, i)}}
#define card_Doom_and_Gloom		orb_add(orb_dark); with(fire_slash){sprite_index = sprMegaSlash; mask_index = mskMegaSlash; image_blend = 0; image_yscale = 2; damage = 32}; sound_play_hit(sndBlackSword, 0.3)
#define card_Double_Energy		my_cost *= 2; sound_play_hit(assets.sndSlotGain, 0.3)
#define card_Fusion				orb_add(orb_plasma)
#define card_Glacier			repeat(2){orb_add(orb_frost)}
#define card_Over_Clock			hand_number += 2; repeat(12){with(instance_create(x, y, TrapFire)){direction = random(360); speed = 6; team = -1; damage = 2; hitid = [sprite_index, "over clock"]}}; sound_play_hit(sndFlameCannon, 0.3)
#define card_Rip_and_Tear		var g = gunangle; var a = accuracy; accuracy = 2; repeat(2){gunangle = g + random_range(15, -15); card_Strike()}; gunangle = g; accuracy = a
#define card_Scrape				card_Strike(); repeat(3){if(hand_number>=global.maxhand || hand_number>=ds_list_size(mcrDeck)){exit}; if(mcrData[?mcrDeck[|hand_number]][@0] > 0){ds_list_add(mcrPile, mcrDeck[|hand_number]); ds_list_delete(mcrDeck, hand_number)}else{hand_number ++}}
#define card_Self_Repair		instance_create(x, y, HPPickup)
#define card_Skim				hand_number += 3; sound_play_shuffle()
#define card_Tempest			if(argument0 > 0){repeat(argument0){orb_add(orb_lightning)}}
#define card_Buffer				if(!buffer){buffer = true; sound_play_hit(assets.sndFocus, 0.3)}
#define card_Fission			while(ds_list_size(mcrOrbs) > 0){orb_evoke(mcrOrbs[|0], 0); ds_list_delete(mcrOrbs, 0); hand_number ++}; sound_play_hit(assets.sndSlotGain, 0.3)
#define card_Multi_Cast			if(argument0>0 && ds_list_size(mcrOrbs)>0){orb_evoke_ext(mcrOrbs[|0], 0, argument0); ds_list_delete(mcrOrbs, 0)}
#define card_Rainbow			for(var i=0; i<3; i++){orb_add(i)}
#define card_Reboot				var c = my_cost; scrShuffle(); my_cost = c; hand_number = 6; shuffle = 10



#define orb_add		ds_list_add(mcrOrbs, argument0); sound_play_hit(mcrOrgSound[@argument0][@0], 0.3)



#define orb_passive(orb, ind)
	{
	var d = orb_frame + ind * 360 / global.maxorbs
	var ox = x
	var oy = y
	x = ox + lengthdir_x(24, d)
	y = oy + lengthdir_y(24, d)
	switch(orb)
		{
		case orb_lightning: {
			if(instance_exists(enemy))
				{
				with(instance_create(x, y, Lightning))
					{
					direction = other.gunangle + random_range(45, -45)
					image_angle = direction
					visible = false
					creator = other
					team = other.team
					ammo = 14
					event_perform(ev_alarm, 0)
					with(instance_create(x, y, LightningSpawn))
						{image_angle = other.image_angle}
					}
				sound_play_hit(mcrOrgSound[@orb_lightning][@1], 0.3)
				}
			}break
		
		case orb_frost: {
			with(instance_create(x, y, CustomSlash))
				{
				sprite_index = sprRogueExplosion
				mask_index = sprite_index
				image_speed = 0.4
				direction = random(360)
				image_angle = direction
				image_xscale = 0.5
				image_yscale = 0.5
				creator = other
				team = other.team
				on_anim = ref_instance_destroy
				on_wall = blank
				on_hit = orb_frost_on_hit
				on_grenade = orb_frost_on_projectile
				on_projectile = orb_frost_on_projectile
				}
			sound_play_hit(assets.sndFrostDefense[@irandom(2)], 0.3)
			}break
		
		case orb_dark: {
			with(instance_create(x, y, CustomProjectile))
				{
				sprite_index = sprRogueExplosion
				image_speed = 0.4
				direction = random(360)
				image_angle = direction
				image_xscale = 0.5
				image_yscale = 0.5
				image_blend = 0
				creator = other
				team = other.team
				on_anim = ref_instance_destroy
				on_wall = blank
				on_hit = blank
				on_step = orb_dark_on_step
				}
			sound_play_hit(mcrOrgSound[@orb_dark][@1], 0.3)
			}break
		
		case orb_plasma: {
		//	sound_play_hit(mcrOrgSound[@orb_plasma][@1], 0.3)
			}break
		
		default: break
		}
	x = ox
	y = oy
	}

#define orb_evoke					return orb_evoke_ext(argument0, argument1, 1)
#define orb_evoke_ext(orb, ind, times)
	{
	var ary = []
	var d = orb_frame + ind * 360 / global.maxorbs
	var ox = x
	var oy = y
	x = ox + lengthdir_x(24, d)
	y = oy + lengthdir_y(24, d)
	switch(argument0)
		{
		case orb_lightning: {
			repeat(times){with(instance_create(x, y, Lightning))
				{
				direction = other.gunangle + random_range(45, -45)
				image_angle = direction
				visible = false
				creator = other
				team = other.team
				ammo = 28
				event_perform(ev_alarm, 0)
				with(instance_create(x, y, LightningSpawn))
					{image_angle = other.image_angle}
				array_push(ary, self)
				}}
			sound_play_hit(mcrOrgSound[@orb_lightning][@2], 0.3)
			}break 
		
		case orb_frost: {
			with(instance_create(x, y, CustomSlash))
				{
				var scale = (times + 1) * 0.5
				sprite_index = sprRogueExplosion
				mask_index = sprite_index
				image_speed = 0.4
				direction = random(360)
				image_angle = direction
				image_xscale = scale
				image_yscale = scale
				creator = other
				team = other.team
				on_anim = ref_instance_destroy
				on_wall = blank
				on_hit = orb_frost_on_hit
				on_grenade = orb_frost_on_projectile
				on_projectile = orb_frost_on_projectile
				array_push(ary, self)
				}
			sound_play_hit(mcrOrgSound[@orb_frost][@2], 0.3)
			}break
		
		case orb_dark: {
			with(instance_create(x, y, CustomProjectile))
				{
				sprite_index = sprPopoExplo
				image_speed = 0.4
				direction = random(360)
				image_angle = direction
				image_blend = 0
				creator = other
				team = other.team
				damage = sqr(times + 3)
				on_anim = ref_instance_destroy
				on_wall = blank
				on_hit = orb_dark_on_hit
				on_step = orb_dark_on_step
				array_push(ary, self)
				}
			sound_play_hit(mcrOrgSound[@orb_dark][@2], 0.3)
			}break
		
		case orb_plasma: {
			repeat(times){my_cost += 2}
			sound_play_hit(mcrOrgSound[@orb_plasma][@2], 0.3)
			array_push(ary, self)
			}break
		
		default: break
		}
	x = ox
	y = oy
	}

#define orb_frost_on_hit			other.direction = point_direction(x, y, other.x, other.y)
#define orb_frost_on_projectile
	{
	switch(other.typ)
		{
		case 1: 
			var dir = other.direction
			other.direction = point_direction(x, y, other.x, other.y)
			other.image_angle += other.direction - dir
			other.team = team
			sound_play_hit(assets.sndFrostDefense[@irandom(2)], 0.3)
			exit
		case 2: 
			with(other){instance_destroy()}
			sound_play_hit(assets.sndFrostDefense[@irandom(2)], 0.3)
			exit
		default: exit
		}
	}

#define orb_dark_on_hit		if(other.nexthurt <= current_frame){projectile_hit(other, damage, 0, point_direction(x, y, other.x, other.y))}
#define orb_dark_on_step
	{
	with(instance_nearest(x, y, enemy))
		{
		var dir = point_direction(x, y, other.x, other.y)
		x += lengthdir_x(0.75, dir)
		y += lengthdir_y(0.75, dir)
		}
	}



#define scrShuffle
	{
	if(player_is_local_nonsync(index))
		{sound_play_shuffle()}
	var size = ds_list_size(mcrPile)
	for(var i=0; i<size; i++)
		{ds_list_add(mcrDeck, mcrPile[|i])}
	ds_list_clear(mcrPile)
	ds_list_shuffle(mcrDeck)
	shuffling = shuffle_max
	hand_index = 0
	hand_number = 2
	action_reload = action_max
	my_cost = maxcost
	say("shuffle!")
	}



#define scrDrDefect
with(argument0)
	{
	var dir = 360 / global.maxorbs
	var size = ds_list_size(mcrOrbs)
	draw_set_alpha(0.8)
	draw_set_color(c_white)
	for(var i=0; i<size; i++)
		{
		var d = orb_frame + i * dir
		var c = mcrOrbColor[@mcrOrbs[|i]]
		var dx = x + lengthdir_x(24, d)
		var dy = y + lengthdir_y(24, d)
		//draw_set_color(c[@2])
		//draw_circle(dx, dy, 7, false)
		if(i == 0)
			{draw_circle(dx, dy, 7, false)}
		draw_circle_color(dx, dy, 6, c[@0], c[@1], false)
		}
	draw_set_alpha(1)
	//draw_set_color(c_white)
	}
instance_destroy()

#define scrDrDefectBonus
with(argument0){if(is_array(bonus_card))
	{
	var len = array_length(bonus_card)
	if(len == 0){break}
	var dir = 360 / len
	var prt = 360 / array_length(bonus_card)
	var num = (gunangle + 450 - prt) mod 360 div prt
	
	var fa_oh = draw_get_halign()
	var fa_ov = draw_get_valign()
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_visible_all(false)
	draw_set_visible(index, true)
	
	for(var i=0; i<len; i++)
		{
		var d = 90 + i * dir
		var dx = x + lengthdir_x(64, d)
		var dy = y + lengthdir_y(64, d)
		var cost = mcrData[?bonus_card[@i]][@0]
		var name = 
			[
			`@(color:${player_get_color(index)})${is_undefined(cost) ? "X" : cost}.`, 
			string_replace_all(bonus_card[@i], "_", " ")
			]
		var text = (i==num && !nearwep) ? `@3(sprEPickup${button_check_nonsync(index, "pick")?"":":0"})${name[@0]}@w${name[@1]}##@s${mcrData[?bonus_card[@i]][@1]}` : `${name[@0]}@s${name[@1]}`
		draw_text_nt(dx, dy, text)
		}
	
	draw_set_halign(fa_oh)
	draw_set_valign(fa_ov)
	draw_set_visible_all(true)
	}}
instance_destroy()



#define race_name
return "defect"
#define race_text
return "combat automaton#manipulation of Orbs#from @yslay the spire@w, by HaZar."
/*
#define race_portrait
return global.portrait
#define race_mapicon
return global.mapicon
*/
#define race_swep
return wep_wrench

#define race_avail	return true
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){return lq_defget(v.race, mod_current, false)}
	}
#define race_lock
return ""

#define race_menu_button
//sprite_index = global.chs
if(!race_avail()){sprite_index = 1611; image_index = 16}
/*#define race_menu_select
return 
#define race_menu_confirm
return */
/*
#define race_skins
return 2
#define race_skin_name(skin)
switch(argument0)
	{
	case 0: return 
	case 1: return 
	default: break
	}
#define race_skin_button
switch(argument0)
	{
	case 0: sprite_index = ; break
	case 1: sprite_index = ; break
	default: break
	}
*/
#define race_tb_text
return "higher hand max"
#define race_tb_take
global.maxhand = argument0 ? 6 : 4

#define race_ultra_name
switch(argument0)
	{
	case 1: return "Echo Form"
	case 2: return "Machine Learning"
	default: return ""
	}

#define race_ultra_text
switch(argument0)
	{
	case 1: return "The first card you play#each turn is played twice"
	case 2: return "Draw 2 extra card#each turn"
	default: return ""
	}
/*
#define race_ultra_button
switch(argument0)
	{
	case 1: sprite_index = 
	case 2: sprite_index = 
	default: sprite_index = 
	}

#define race_ultra_take
switch(argument0)
	{
	case 1: break
	case 2: break
	default: break
	}

#define race_ultra_icon
switch(argument0)
	{
	case 1: return 
	case 2: return 
	default: return 
	}
*/
#define race_ttip
return []



#macro	mcrDeck			global.aryDeck[@index]
#macro	mcrPile			global.aryPile[@index]
#macro	mcrOrbs			global.aryOrbs[@index]
#macro	mcrData			global.mapData
#macro	mcrCard			global.aryCard
#macro	mcrCardBonus	mcrCardBonus_1()
#define mcrCardBonus_1	var r = irandom(12); r = r == 0 ? 2 : r < 4 ? 1 : 0; return mcrCard[@r][@irandom(array_length(mcrCard[@r]) - 1)]
#macro	mcrOrgSound		assets.aryOrgSound
#macro	assets		global.lqoAssets

#macro	txtSlow				`@2(sprCrown4Walk:-0.2)`
#macro	txtCost				`@1(sprEnergyIcon)`
#macro	txtDraw				`@2(sprSkillIconHUD:${mut_rabbit_paw})`
#macro	txtEvoke			`@2(sprSkillIconHUD:${mut_trigger_fingers})`
#macro	txtStrike			`@2(sprSkillIconHUD:${mut_lucky_shot})`
#macro	txtOrb				`@2(sprGuardianBullet)`
#macro	txtOrb_lightning	`@1(sprEnergyIcon)${txtOrb}`
#macro	txtOrb_frost		`@2(sprIcicle)${txtOrb}`
#macro	txtOrb_dark			`@3(sprPortal)${txtOrb}`
#macro	txtOrb_plasma		`@2(sprPlasmaBall:1)${txtOrb}`

#macro	orb_lightning	0
#macro	orb_frost		1
#macro	orb_dark		2
#macro	orb_plasma		3

#macro	mcrOrbColor		[[c_yellow, 32896, 13107], [c_aqua, 16744448, 8404992], [c_purple, 4194368, 851987], [c_aqua, c_orange, 5269568]]

#define blank
