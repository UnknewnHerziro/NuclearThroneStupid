
#define init 

#define weapon_name		return "CACTUS"
#define weapon_sprt		return lq_defget(argument0, "wepspr", sprCactus)

#define weapon_type		return 0
#define weapon_melee	return false
#define weapon_auto		return false
#define weapon_load		return 10
#define weapon_cost		return 0
#define weapon_area		return -1
#define weapon_swap		return sndSwapGold

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"melting" : "Thorny. Hurt. ", 
	"plant" : "Born of the same root, we all. #Why hurt each other so cruel? ", 
	"chicken" : "Just like the western movies. ", 
	"rebel" : "He loves cactus flower. ", 
	"pumpking" : "The kings always walk through the thorny road. ", 
	"envoy" : "Holy natural. ", 
	"d" : "Natural weapon. The miracle of nature. ", 
	}



#define weapon_fire
	{
	if(!is_object(argument0))
		{wep = {wep:"cactus", name:"splinter", wepspr:sprCactus, ammo:irandom_range(32, 64)}}
	weapon_post(3, 0, 0)

	if(wep.ammo <= 0)
		{sound_play_hit(sndHitPlant, 0.3)}
	else{
		sound_play_hit(sndSplinterPistol, 0.3)
		var a = min(irandom_range(1,3), wep.ammo)
		repeat(a){with(instance_create(x, y, Splinter))
			{
			direction = random_range(5,-5) * other.accuracy + other.gunangle
			image_angle = direction
			speed = 10
			
			creator = other
			team = other.team
			}}
		wep.ammo -= a
		}
	}
