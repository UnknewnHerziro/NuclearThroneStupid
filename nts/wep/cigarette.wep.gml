
#define init 

#define weapon_name		return "CIGARETTE"
#define weapon_sprt		return sprCigarette

#define weapon_type		return 0
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 29
#define weapon_cost		return 0
#define weapon_area		return -1
#define weapon_swap		return sndSalamanderEndFire

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "You used to smoke in the restroom #with your former colleagues. ", 
	"eyes" : "You don't have a mouth #so you will never know what it tastes like. ", 
	"venuz" : " C O O L S I M B O  ", 
	"chicken" : "Just like the spies. ", 
//	"rebel" : "He used to smoke a cigar alone #in the moonlight after midnight. ", 
	"rogue" : "A pastime product with medical meaning. #It's not something gators can make by themselves. ", 
	"envoy" : "Sins. ", 
	"digger" : "You prefer cigar. ", 
	"d" : "Smells like herb. ", 
	}



#define weapon_fire
sound_play_hit(sndSalamanderEndFire, 0.3)
if(race == "eyes")
	{
	with(instance_create(x, y, PopupText))
		{mytext = "@rno mouth"}
	}
else{
	with(instance_create(x, y, PopupText))
		{mytext = "tasted @gbitter"}
	wep=0; curse=0; 
	if(race == "coward")
		{nts_coward_smoke = 90}
	else{
		with(instance_create(x, y, Shell))
			{
			sprite_index = sprCigarette
			speed = random_range(3,5)
			direction = random(360)
			nts_unlock_coward = true
			}
		}
	}

