
#define init 

#define weapon_name		return "IDPD RIFLE"
#define weapon_sprt		return sprPopoGun

#define weapon_type		return 1
#define weapon_melee	return false
#define weapon_auto		return true
#define weapon_load		return 6
#define weapon_cost		return 2
#define weapon_area		return -1
#define weapon_swap		return sndSwapPistol

#define weapon_gold			return false
#define weapon_laser_sight	return false

#define nts_weapon_examine	return
	{
	"fish" : "Feels like you are still working as a police... #But using a future-style rifle. ", 
	"venuz" : "popo succ ", 
	"rogue" : "You chose the smaller one when you defect. #Now you have another choice. ", 
	"d" : "An auto assault rifle be designed #to be easyly use by the people who move freqiently. ", 
	}	



#define weapon_fire
repeat(2)
	{
	sound_play_hit(sndGruntFire, 0.3)
	weapon_post(3, -6, 4)
	with(instance_create(x+lengthdir_x(4,gunangle), y+lengthdir_y(4,gunangle), IDPDBullet))
		{
		speed = 15
		
		direction	= random_range(3,-3) * other.accuracy + other.gunangle
		image_angle	= direction
		
		creator	= other
		team	= other.team
		}
	wait 2
	if(!instance_exists(self)){exit}
	}

