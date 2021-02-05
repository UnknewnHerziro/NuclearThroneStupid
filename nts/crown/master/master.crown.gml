#define init
global.icon = sprite_add("icon.png", 0, 12, 16)
global.lock = sprite_add("lock.png", 0, 12, 16)
global.spr_idle = sprite_add("idle.png", 1, 8, 8)
global.spr_walk = sprite_add("walk.png", 6, 8, 8)

#define crown_name
return "Crown of Master"
#define crown_text_base
return "THE WASTELAND IS A RUTHLESS PLACE"
#define crown_text_unlock
return "@sdefeat @bcaptain @sin @wL2"
#define crown_tip
return "an able man is always @rbusy"

#define crown_button
sprite_index = global.icon
#define crown_button_lock
sprite_index = global.lock

#define crown_avail
return GameCont.loops > 0

#define crown_take
	{
	sound_play(sndMenuCrown)
	sound_play(sndMenuScores)
	}

#define step
	{
		//code by Yokin
		// More Enemies:
	with(instances_matching(instances_matching_lt(instances_matching_gt(GenCont, "alarm1", 0), "alarm2", 0), "crownbloodmorenemies_check", null)){
		crownbloodmorenemies_check = true;
		
		with(Floor){
			if(
				random(8 + GameCont.hard) < GameCont.hard
				&& !place_meeting(x, y, chestprop)
				&& !place_meeting(x, y, RadChest)
				&& point_distance(x, y, other.spawn_x, other.spawn_y) > other.safedist
			){
				var _meeting = place_meeting(x, y, hitme);
				
				 // Spawn Enemies:
				area_pop_enemies();
				
				 // Clear Walls:
				if(instance_exists(self) && !_meeting){
					if(place_meeting(x, y, hitme) && place_meeting(x, y, Wall)){
						with(instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(Wall, "bbox_right", bbox_left), "bbox_left", bbox_right), "bbox_bottom", bbox_top), "bbox_top", bbox_bottom)){
							if(place_meeting(x, y, other)){
								instance_destroy();
							}
						}
					}
				}
			}
		}
	}
	if(!instance_exists(Crown))
		{instance_create(10016, 10016, Crown)}
	with(Crown)
		{
		spr_idle = global.spr_idle
		spr_walk = global.spr_walk
		}
	if(!instance_exists(GenCont) )
		{
		with(instances_matching_gt(enemy, "alarm1", current_time_scale+1))
			{if(!is_boss(object_index)){alarm1 -=1;}}
		with(instances_matching(enemy, "nts_coMaster_rads", undefined))
			{
			raddrop += 1;
			//if(irandom(4) == 0){a = instance_clone(object_index);a.nts_coMaster_rads = true;}
			nts_coMaster_rads = true
			}
		}
	if(GameCont.hard mod 2 == 0)
		{GameCont.hard++}
	}



#define nts_guard_text		return "@gHIGHER RATE@s"
#define nts_guard_tb_text	return "@gDEFENCE @sBIGGER AND SLOWER#EVEN HIGHER RATE@s"

#define nts_guard_ultra
	{
	reload = max(0, reload - (skill_get(mut_throne_butt) ? 0.3 : 0.2) * current_time_scale)
	
	return false
	}



#define crown_text
if(mod_exists("mod", "ntsCont"))
	{
	var v = mod_variable_get("mod", "ntsCont", "nts_save")
	if(is_object(v)){if(!lq_defget(v.crown, mod_current, false))
		{
		return `${crown_text_base()}#@sunlock: ${crown_text_unlock()}`
		}}
	}
return crown_text_base()
	
#define area_pop_enemies()
{
	/*
		Area enemy spawning logic, called from a Floor
	*/
	
	var _game = GameCont;
	
	 // Custom:
	if(is_string(_game.area)){
		try{
			mod_script_call("area", _game.area, "area_pop_enemies");
		}
		catch(_error){
			if(instance_is(other, GenCont)) trace(_error);
		}
	}
	
	 // Normal:
	else{
		var	_spawnLoop = (random(2) < random(_game.loops)),
			_spawnAlt = (styleb == 1),
			_x = (bbox_left + bbox_right + 1) / 2,
			_y = (bbox_top + bbox_bottom + 1) / 2,
			_obj = -1,
			_num = 1,
			_off = 0;
			
		switch(_game.area){
			
			case 1: /// DESERT
			
				if(variable_instance_get(UberCont, "showtutorial", false) == false){
					if(_spawnLoop){
						_obj = [Bandit, Bandit, Scorpion, Scorpion, JungleFly, JungleFly, Maggot, MeleeBandit, Sniper];
					}
					else if(_spawnAlt){
						_obj = [BigMaggot, BigMaggot, MaggotSpawn, Maggot];
					}
					else if(random(7) < 1){
						_obj = [Scorpion, MaggotSpawn];
					}
					else if(random(30) < 1){
						_obj = Bandit;
						_num = 3;
						_off = 2;
						instance_create(_x, _y, Barrel);
					}
					else{
						_obj = [Bandit, Bandit, Bandit, Bandit, Bandit, Bandit, Scorpion, Maggot];
					}
				}
				
				break;
				
			case 2: /// SEWERS
			
				if(_spawnLoop){
					_obj = [Exploder, Exploder, Ratking, Ratking, Rat, BuffGator, SuperFireBaller, LaserCrystal];
				}
				else if(_spawnAlt){
					_obj = [Gator, Gator, Rat, Rat, Exploder];
				}
				else if(random(9) < 1){
					_obj = [Ratking, Ratking, Ratking, Exploder, Exploder, Exploder, MeleeFake];
				}
				
				break;
				
			case 3: /// SCRAPYARDS
			
				if(random(5) < 4 && (_game.subarea != 3 || random(2) < 1)){
					if(_spawnLoop){
						_obj = [Raven, Raven, Sniper, Sniper, MeleeFake, MeleeFake, Salamander, BuffGator, SnowBot];
					}
					else if(_spawnAlt && random(3) < 1){
						_obj = Salamander;
					}
					else if(random(4) < 1){
						_obj = [Sniper, Sniper, Sniper, Sniper, MeleeFake, MeleeFake, MeleeBandit, Exploder];
					}
					else if(random(10) < 1){
						_obj = Raven;
						_num = 2;
						_off = 2;
						if(random(8) < 1) instance_create(_x, _y, Car);
					}
					else if(random(20) < 1){
						_obj = Salamander;
					}
					else if(random(4) < 3){
						_obj = [Raven, Raven, Bandit];
					}
				}
				
				break;
				
			case 4: /// CRYSTAL CAVES
			
				if(_spawnLoop){
					_obj = [LaserCrystal, LaserCrystal, LaserCrystal, Spider, Spider, LightningCrystal, RhinoFreak, ExploFreak, BuffGator];
				}
				else{
					_obj = [Spider, Spider, Spider, Spider, LaserCrystal];
				}
				
				break;
				
			case 5: /// FROZEN CITY
			
				if(_spawnLoop){
					_obj = [SnowBot, SnowBot, SnowBot, SnowTank, SnowTank, Wolf, DogGuardian, ExploGuardian, Necromancer];
				}
				else if(variable_instance_get(UberCont, "xmas", false) == true && random(1000) < 1){
					_obj = PotentialYeti;
				}
				else if(random(3) < 2){
					_obj = [SnowBot, SnowBot, SnowBot, Wolf, Wolf, SnowTank];
				}
				
				break;
				
			case 6: /// LABS
			
				if(!instance_is(other, GenCont) || point_distance(x, y, other.spawn_x, other.spawn_y) > other.safedist + 40){
					if(_spawnLoop){
						_obj = [RhinoFreak, RhinoFreak, ExploFreak, Necromancer, BecomeTurret, LaserCrystal, Ratking];
					}
					else if(random(14) < 1){
						_obj = [Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, ExploFreak, ExploFreak, RhinoFreak];
						_num = 10;
						_off = 4;
					}
					else if(random(8) < 1){
						_obj = [Necromancer, Necromancer, Necromancer, Necromancer, Necromancer, Necromancer, BecomeTurret, BecomeTurret, BecomeTurret, ExploFreak, RhinoFreak];
					}
				}
				
				break;
				
			case 7: /// PALACE
			
				if(_game.subarea != 3 && random(2) < 1){
					if(_spawnLoop){
						_obj = [ExploGuardian, ExploGuardian, DogGuardian, DogGuardian, JungleBandit, JungleBandit, Sniper, ExploFreak];
					}
					else if(random(4) < 1){
						_obj = [Guardian, Guardian, Guardian, Guardian, ExploGuardian, DogGuardian];
					}
					else if(random(16) < 1){
						_obj = IDPDSpawn;
					}
				}
				
				break;
				
			case 101: /// OASIS
			
				if(random(4) < 1){
					_obj = Crab;
				}
				else if(random(3) < 1){
					_obj = BoneFish;
					_num = 3;
					_off = 2;
				}
				
				break;
				
			case 103: /// MANSIOM
			
				if(random(5) < 1){
					_obj = [FireBaller, FireBaller, FireBaller, Jock, Jock, SuperFireBaller];
				}
				else if(random(4) < 1){
					_obj = [Molefish, Molefish, Molefish, Molefish, Molesarge];
					_num = 3;
					if(random(5) < 1) instance_create(_x, _y, GoldBarrel);
				}
				
				break;
				
			case 104: /// CURSED CRYSTAL CAVES
			
				if(random(5) < 4){
					_obj = [InvSpider, InvSpider, InvLaserCrystal];
				}
				
				break;
				
			case 105: /// JUNGLE
			
				if(random(8) < 1){
					_obj = JungleFly;
				}
				else if(random(30) < 1){
					_obj = JungleBandit;
					_num = 3;
					_off = 2;
					instance_create(_x, _y, Barrel);
				}
				else{
					_obj = [JungleBandit, JungleBandit, JungleBandit, JungleBandit, JungleBandit, JungleBandit, JungleAssassinHide, JungleAssassinHide, Maggot];
				}
				
				break;
				
			case 106: /// IDPD HQ
			
				if(_game.subarea != 3 && random(12) < 1){
					if(random(7) < 1){
						_obj = [EliteGrunt, EliteShielder, EliteInspector];
					}
					else if(random(4) < 1){
						_obj = Grunt;
						_num = 5;
					}
					else if(random(3) < 1){
						_obj = [Grunt, Shielder, Inspector];
					}
				}
				
				break;
				
		}
		
		 // Create Enemy:
		if(_num > 0) repeat(_num){
			var o = _obj;
			if(is_array(o)){
				o = o[irandom(array_length(_obj) - 1)];
			}
			if(object_exists(o)){
				instance_create(_x + random_range(-_off, _off), _y + random_range(-_off, _off), o);
			}
		}
	}
}

#define instance_clone(obj)
	{
	with(obj){with(instance_create(x, y, object_index))
		{
		var vn = variable_instance_get_names(other)
		var vn_len = array_length(vn)
		for(var i=0; i<vn_len; i++)
			{
			var v = variable_instance_get(other, vn[i], null)
			if(scrNoOnlyRead(vn[i], v))
				{variable_instance_set(self, vn[i], v)}
			}
		return id;
		}}
		
	}

#define scrNoOnlyRead(b, a)
if(a!=undefined && a!=null){return (b!="sprite_width" && b!="sprite_height" && b!="sprite_xoffset" && b!="sprite_yoffset" && b!="image_number" && b!="bbox_left" && b!="bbox_right" && b!="bbox_top" && b!="bbox_bottom" && b!="object_index" && b!="id")}

#define is_boss(obj)
return obj == BanditBoss || obj == ScrapBoss || obj == LilHunter || obj == Nothing || obj == Nothing2 || obj == FrogQueen || obj == HyperCrystal || obj == Last || obj == TechnoMancer || obj == CustomEnemy