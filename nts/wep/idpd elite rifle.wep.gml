
#define init 

#define weapon_name		return "IDPD ELITE RIFLE"
#define weapon_sprt		return sprElitePopoGun

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 3
#define weapon_cost		return 2
#define weapon_area		return -1
#define weapon_swap		return sndSwapPistol

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "An auto assault rifle made with some hard black metal. #Comfortable. ", 
	"rogue" : "Large but light. Nice choice. ", 
	"d" : "An auto assault rifle made with some hard black metal that be designed# to be use easyly by the people who keeps moving. #But you couldn't found the rocket launcher. ", 
	}



#define weapon_fire
repeat(2)
	{
	sound_play_hit(sndGruntFire, 0.3)
	weapon_post(3, -6, 4)
	with(instance_create(x+lengthdir_x(4,gunangle), y+lengthdir_y(4,gunangle), IDPDBullet))
		{
		speed = 15
		
		direction	= random_range(5,-5) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	wait 1
	if(!instance_exists(self)){exit}
	}
