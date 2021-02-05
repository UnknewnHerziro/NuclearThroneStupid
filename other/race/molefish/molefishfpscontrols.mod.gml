// fpscontrols.mod.gml: first person shooter controls using mouselock

#define init

global.mousesens = 1.7;

#define chat_command
	if argument0 == "setmousesens" {
		var newsens= real(argument1);
		if newsens > 0 {
			global.mousesens = newsens;
			trace("Mouse sensitivity set to " + string(newsens) + ".");
		} else {
			trace("Use with parameter >0 to set mouse sensitivity. (Default: 10)");
		}
		return true;
	}

#define step
	mouse_unlock(); 
	var mm=instances_matching(Player,"race","molefish")
	
	if array_length(mm)=instance_number(Player) && !instance_exists(menubutton) && !instance_exists(GenCont) {
		mouse_lock();
	}
	
	with(mm)
		{
		canaim = 0; canwalk = 0; 
		if(!instance_exists(menubutton) && !instance_exists(GenCont) && !button_check(index,"horn"))
			{
			gunangle = (gunangle - mouse_delta_x[index]*global.mousesens*(30/room_speed) + 360) mod 360;
			//vertangle = clamp(vertangle - mouse_delta_y[index]*global.mousesens*(30/room_speed), -90, 90);
			vertangle = 0
			
			if button_check(index, 'nort') motion_add(gunangle, maxspeed);
			if button_check(index, 'east') motion_add(gunangle-90, maxspeed);
			if button_check(index, 'west') motion_add(gunangle+90, maxspeed);
			if button_check(index, 'sout') motion_add(gunangle+180, maxspeed);
			}
		}
	