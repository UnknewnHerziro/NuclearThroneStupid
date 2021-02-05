// [ Throne, VenuzTV, VenuzCouch, ]
// [ Generator, TechnoMancer, Car, Pillar, Server, Terminal, SodaMachine, Hydrant, Tube, MutantTube, PizzaBox, Mimic, CarThrone, Chests, Packs]

// [ Ion, Nuke, ]


#define init
	global.FOV = 120;
	global.camera_index = -1;
	global.camera_height = 10;
	global.camera_x = 10016;
	global.camera_y = 10016;
	global.camera_angle = 0;
	global.camera_vangle = 0;
	global.view_dist = 200;

globalvar mdlVan, mdlWeaponChest, mdlAmmoChest, mdlIDPDChest, mdlGenerator, mdlNothing, mdlThroneStatue, mdlGuardianStatue

for(i=0; i<6; i++){mdlVan[i]=sprite_add(`van/${i}.png`,1,0,0)}
for(i=0; i<3; i++){mdlWeaponChest[i]=sprite_add(`wepchest/${i}.png`,1,0,0)}
for(i=0; i<3; i++){mdlAmmoChest[i]=sprite_add(`ammochest/${i}.png`,1,0,0)}
for(i=0; i<3; i++){mdlIDPDChest[i]=sprite_add(`idpdchest/${i}.png`,1,0,0)}
for(i=0; i<4; i++){mdlGenerator[i]=sprite_add(`generator/${i}.png`,1,0,0)}
for(i=0; i<3; i++){mdlNothing[i]=sprite_add(`nothing/${i}.png`,1,0,0)}
for(i=0; i<2; i++){mdlThroneStatue[i]=sprite_add(`thronestatue/${i}.png`,1,0,0)}
for(i=0; i<2; i++){mdlGuardianStatue[i]=sprite_add(`guardianstatue/${i}.png`,1,0,0)}

global.PortalColor=[0,c_purple,c_green,c_blue]



#define game_start

#define step

global.camera_index=-1
with(instances_matching(Player,"race","molefish"))
	{
	global.camera_index = index;
	global.camera_height = 14; 
	if("BeDriver"in self){if(instance_exists(BeDriver)){global.camera_height = 18+sprite_get_bbox_bottom(BeDriver.sprite_index)-sprite_get_yoffset(BeDriver.sprite_index)}}
	with(TopCont){fog=-1}
	script_bind_draw(draw_3d, -14);
	}
/*
	for(var i = 0; i < maxp; i++)
		{
		if(player_is_local_nonsync(i))
			{
			global.camera_index = i;
			break;
			}
		}
	
	//global.wspr=wspr()
	
	with(TopCont){fog=-1}
	script_bind_draw(draw_3d, -14);
*/

#define draw_gui

draw_set_visible_all(0)
if(global.camera_index>=0){draw_set_visible(global.camera_index, 1)}
var gwm=game_width*0.5; var ghm=game_height*0.5;
draw_sprite_ext(sprCrosshair, 2, gwm, ghm, 1, 1, 0, c_white, 0.5)



with(instances_matching(Player,"index",global.camera_index))
	{
		var dx=384; var dy=120; var dismax=432; var times=0.1

		draw_set_alpha(0.5)
		draw_circle_color(dx, dy, 48, 0, 0, 0)
		draw_circle_color(dx, dy, 47, c_gray, c_gray, 0)
		draw_circle_color(dx, dy, 46, 0, 0, 0)

		draw_set_alpha(1)
		
		if(ultra_get("molefish",2)){with(Wall)
			{
			var dis=point_distance(x,y,global.camera_x,global.camera_y); 
			if(dis<=dismax)
				{
				draw_rectangle_colour
					(
						dx+(global.camera_x-bbox_left)*times, dy+(global.camera_y-bbox_top)*times, 
						dx+(global.camera_x-bbox_right)*times, dy+(global.camera_y-bbox_bottom)*times, 
						c_white, c_white, c_white, c_white, 0
					)
				}
			}}
		
		with(Portal)
			{
			var dis=point_distance(x,y,global.camera_x,global.camera_y); 
			if(dis<=dismax)
				{draw_circle_color(dx+(global.camera_x-x)*times, dy+(global.camera_y-y)*times, 2, global.PortalColor[type], global.PortalColor[type], 0)}
			}
		
		draw_set_alpha(0.5)
		
		with(instances_matching_ne(enemy,"team",team))
			{
			var dis=point_distance(x,y,global.camera_x,global.camera_y); 
			if(dis<=dismax){draw_circle_color(dx+(global.camera_x-x)*times, dy+(global.camera_y-y)*times, 1.5, c_gray, c_red, 0)}
			}
		
		draw_set_alpha(1)
		if(ultra_get("molefish",1))
			{
			with(instances_matching_ne(projectile,"team",team))
				{
				var dis=point_distance(x,y,global.camera_x,global.camera_y); 
				if(dis<=dismax){draw_circle_color(dx+(global.camera_x-x)*times, dy+(global.camera_y-y)*times, 1, c_red, c_red, 0)}
				}
			}
		
		with(instances_matching_ne(Player,"index",global.camera_index))
			{
			var dis=point_distance(x,y,global.camera_x,global.camera_y); 
			if(dis<=dismax)
				{draw_circle_color(dx+(global.camera_x-x)*times, dy+(global.camera_y-y)*times, 1, c_white, player_get_color(p), 0)}
			}

		with(Revive)
			{
			var dis=point_distance(x,y,global.camera_x,global.camera_y); 
			if(dis<=dismax)
				{draw_circle_color(dx+(global.camera_x-x)*times, dy+(global.camera_y-y)*times, 2, c_black, player_get_color(p), 0)}
			}
			
	var color=player_get_color(index); 
	var lx=lengthdir_x(2,global.camera_angle); var ly=lengthdir_y(2,global.camera_angle); 
	var px=lengthdir_x(2,global.camera_angle+90); var py=lengthdir_y(2,global.camera_angle+90); 
	draw_triangle_color
		(
			dx-lx*2, dy-ly*2, 
			dx+lx+px, dy+ly+py, 
			dx+lx-px, dy+ly-py, 
			color, color, color, 0
		)
	}




draw_set_visible_all(1)

#define nsto
if(instance_exists(argument0)){return instance_nearest(global.camera_x,global.camera_y,argument0)}else{return noone}

#define draw_dark_end
draw_set_visible_all(false)
if(global.camera_index>=0)
	{
	draw_set_visible(global.camera_index, true)
	with(instances_matching(Player, "race", "molefish")){var nrlc = nts_ruins_lightc}
	if(skill_get("ee")){if(GameCont.area == "ruins"){draw_clear(nrlc)}else{draw_clear(c_gray)}}
	else{draw_clear(c_white)}
	draw_set_alpha(0.09)
	if(GameCont.area == "ruins"){draw_set_color(nrlc)}
	else{draw_set_color(0)}
	var tr = irandom_range(96,100)
	var br = irandom_range(64,60)-32
	var dx = view_xview[global.camera_index] + game_width/2
	var dy = view_yview[global.camera_index] + game_height/2
	for(var i=tr; i>br; i-=3)
		{draw_circle(dx, dy, i, 0)}
	}
draw_set_alpha(1)
draw_set_color(c_white)
draw_set_visible_all(true)

#define chat_command
	if argument0 == "setfov"
		{
		var newfov = real(argument1);
		if newfov > 0 && newfov < 180 && argument1 != ""
			{
			global.FOV = newfov;
			trace("FOV set to " + string(newfov) + ".");
			}
		else{
			trace("Use with parameter >0, <=180 to set horizontal FOV in degrees. (Default: 120)");
			}
		return true;
		}

	if argument0 == "setviewdist"
		{
		var newdist = real(argument1);
		if(newdist>0 && argument1!="")
			{
			global.view_dist = newdist;
			trace("View distance set to " + string(newdist) + ".")
			}
		else{
			trace("Use with parameter >0 to set view distance. (Default: 200)");
			}
		return true;
	}

#define draw_3d

draw_set_visible_all(0)
draw_set_visible(global.camera_index, 1)

	if instance_exists(Player)
		{
		with Player if(player_find(global.camera_index) == id)
			{
			global.camera_x = x;
			global.camera_y = y;
			global.camera_angle = gunangle;
			global.camera_vangle = "vertangle" in self ? vertangle : 0;
			}
		}
	else{instance_destroy();exit}
	
	draw_set_projection(0);
	if(instance_exists(TopCont))
		{
		if(TopCont.darkness){draw_set_color(0)}
		else{draw_set_color(background_color)}
		}
	draw_rectangle(0,0,game_width,game_height,0)
	
	d3d_start();
	draw_set_alpha_test(true);
	d3d_set_hidden(true);
	
	d3d_set_projection_ext(global.camera_x, global.camera_y, global.camera_height,
	global.camera_x + dcos(global.camera_vangle) * dcos(-global.camera_angle), global.camera_y + dcos(global.camera_vangle) * dsin(-global.camera_angle), global.camera_height + dsin(global.camera_vangle),
	dsin(-global.camera_vangle) * dcos(-global.camera_angle), dsin(-global.camera_vangle) * dsin(-global.camera_angle), dcos(global.camera_vangle),
	2*darctan(dtan(global.FOV/2) * (game_height/game_width)), game_width/game_height, 0.1, global.view_dist*1.1); // FOV argument is vertical, not horizontal
	if(instance_exists(TopCont))
		{
		if(TopCont.darkness){d3d_set_fog(true, 0, 0, global.view_dist)}
		else{d3d_set_fog(true, background_color, 0, global.view_dist)};
		}
	d3d_transform_set_identity();
	
	d3d_set_zwriteenable(0);
	with(Floor){FloorDraw()}
	with(SnowFloor){FloorDraw()}
	with(TrapScorchMark){FloorDraw()}
	with(Scorchmark){FloorDraw()}
	with(FloorMiddle){FloorDraw()}
	with(PizzaEntrance){FloorDraw()}
	with(Carpet){draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1.0)}
	with(VenuzCarpet){draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1.0)}
	with(CrownPed){FloorDraw()}
	with(Scorch){FloorDraw()}
	with(ScorchGreen){FloorDraw()}
	with(ScorchTop){FloorDraw()}
	with(MeltSplat){FloorDraw()}
	with(Shell){FloorDraw()}
	with(ReviveArea){FloorDraw()}
	with(NecroReviveArea){FloorDraw()}
	with(RevivePopoFreak){FloorDraw()}
	with(instances_matching(CustomObject,"ntstype","DiggerGrave")){FloorDraw()}
	d3d_set_zwriteenable(1);
	
	with(Mine){CommonDraw()}
	with(Detail){CommonDraw()}
	
	
	
	with(Wall){if(cmr())
		{
		
		if(!place_meeting(x+16,y,Wall)&&place_meeting(x+16,y,Floor))
			{
			d3d_transform_set_rotation_x(90);
			d3d_transform_add_rotation_z(270);
			d3d_transform_add_translation(x+16, y, 32);
			draw_sprite_part_ext(sprite_index, image_index, 0, 8, 16, 8, 0, 0, 1, 4, image_blend, 1.0);
			d3d_transform_set_identity();
			}
		
		if(!place_meeting(x,y+16,Wall)&&place_meeting(x,y+16,Floor))
			{
			d3d_transform_set_rotation_x(90);
			d3d_transform_add_rotation_z(180);
			d3d_transform_add_translation(x+16, y+16, 32);
			draw_sprite_part_ext(sprite_index, image_index, 0, 8, 16, 8, 0, 0, 1, 4, image_blend, 1.0);
			d3d_transform_set_identity();
			}
		
		if(!place_meeting(x-16,y,Wall)&&place_meeting(x-16,y,Floor))
			{
			d3d_transform_set_rotation_x(90);
			d3d_transform_add_rotation_z(90);
			d3d_transform_add_translation(x, y+16, 32);
			draw_sprite_part_ext(sprite_index, image_index, 0, 8, 16, 8, 0, 0, 1, 4, image_blend, 1.0);
			d3d_transform_set_identity();
			}
		
		if(!place_meeting(x,y-16,Wall)&&place_meeting(x,y-16,Floor))
			{
			d3d_transform_set_rotation_x(90);
			d3d_transform_add_translation(x, y, 32);
			draw_sprite_part_ext(sprite_index, image_index, 0, 8, 16, 8, 0, 0, 1, 4, image_blend, 1.0);
			d3d_transform_set_identity();
			}
		
		//d3d_transform_set_rotation_x(0);
		//d3d_transform_add_translation(x, y, 16);
		//draw_sprite_ext(topspr, topindex, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
		}}
	
	
	
	with(instances_matching_ne(Player,"index",global.camera_index)){CommonDraw()}
	
	with(Crown){CommonDraw()}
	with(CrownPickup){CommonDraw()}
	with(Tangle){CommonDraw()}
	with(Sapling){CommonDraw()}
	with(Ally){CommonDraw()}
	with(Revive){CommonDraw()}
	with(BigDogExplo){CommonDraw()}
	
	with(LilHunterDie){RotDraw(0.2)}
	with(LilHunterFly){ZDraw(0.2,1)}
	
	with(NothingBeam){StBoxDraw(0.5)}
	with(BecomeNothing2){CommonDraw()}
	with(Nothing2Death){CommonDraw()}
	with(FrogQueenDie){CommonDraw()}
	with(Messenger){CommonDraw()}
	with(LastFire){CommonDraw()}
	with(LastDie){CommonDraw()}
	
	with(CharredGround){CommonDraw()}
	with(Portal){FloorDraw()}
	with(YungCuz){StandDraw(0)}
	
	with(LaserCannon){CommonDraw()}
	with(PlasmaImpact){CommonDraw()}
	with(Explosion){CommonDraw()}
	with(MeatExplosion){CommonDraw()}
	
	with(RavenFly){ZDraw(0.2,2)}
	with(Trap)
		{
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(270);
		d3d_transform_add_translation(x+16.1, y+0.1, 16);
		draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(180);
		d3d_transform_add_translation(x+16.1, y+16.1, 16);
		draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(90);
		d3d_transform_add_translation(x-0.1, y+15.9, 16);
		draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_translation(x-0.1, y-0.1, 16);
		draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, 1.0);
		
		d3d_transform_set_identity();
		}
	
	with(SnowTankExplode){CommonDraw()}
	with(BecomeTurret){CommonDraw()}
	
	with(IDPDSpawn){CommonDraw()}
	with(VanSpawn){CommonDraw()}
	with(PopoShield){CommonDraw()}
	
	
	with(enemy){NorDraw()}
	with(prop){NorDraw()}
	with(Pickup){NorDraw()}
	with(chestprop){NorDraw()}
	with(projectile){ProjDraw()}
	with(Effect){EffDraw()}
	
	with(CustomObject){if("ntstype"in self){switch(ntstype)
		{
		case "naderhinobot": 
			if("iy"in self){
			d3d_transform_set_rotation_x(90);
			d3d_transform_add_rotation_z(point_direction(x,y,global.camera_x,global.camera_y)+90);
			d3d_transform_add_translation(x, y, 40+iy);
			draw_sprite_ext(sprite_index, 1, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
			d3d_transform_set_identity();
			}
			break; 
		
		case "BrFunnel": 
			if("gunangle"in self){
			d3d_transform_set_rotation_x(90);
			d3d_transform_add_rotation_z(gunangle);
			d3d_transform_add_translation(x, y, global.camera_height);
			draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
			d3d_transform_set_identity();
			}
			break; 
		
		case "MarketNPC": 
		case "MarketCar": CommonDraw(); break; 
		
		case "RuinsLine": FloorDraw(); break; 
		
		default: break;
		}}}
	
	with(Corpse){switch(sprite_index)
		{
		case sprBigTVDead: StandDraw(20); break;
		case sprBigGeneratorDead: FloorDraw(); break; 
		default: if(image_alpha==1){CommonDraw()}; break; 
		}}
	
	d3d_transform_set_identity();
	
	d3d_set_hidden(false);
	d3d_set_culling(false);
	d3d_end();
	draw_set_alpha_test(false); 
	
	draw_reset_projection();
	d3d_set_fog(false, 0, 0, 0);
	
	instance_destroy();
	
	

#define FloorDraw()
if(cmr()){draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1.0)}

#define NorDraw
switch(object_index)
	{
	case DogMissile: 
	case ScrapBossMissile: CommonProjDraw(); break; 
	
	case DogGuardian: ZDraw(0.2,-5); break; 
	
	case Grunt: 
	case EliteGrunt: RotDraw(0.2); break;
	
	case ScrapBoss: CommonDraw(); break; 
	
	case NothingInactive: 
	case BecomeNothing: 
	case NothingIntroMask: 
	case Nothing: 
		ThroneDraw(0)
		break; 
	
	case TechnoMancer: CommonDraw(); DsprDraw(0.2); break; 
	
	case LastIntro: 
		//CommonDraw(); 
		var c=2496282
		draw_set_color(c_white); 
		d3d_transform_set_identity();

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_translation(x+18, y-27, 43);
		//draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
		draw_sprite_part_ext(sprite_index, image_index, 0, 0, 36, 33, 0, 0, image_xscale, image_yscale, image_blend, image_alpha)
		
		d3d_transform_set_rotation_x(180);
		d3d_transform_add_translation(x, y, 10);
		draw_sprite_ext(sprDeskEmpty, 0, 0, 0, 1, 1, 0, image_blend, 1.0);

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(90);
		d3d_transform_add_translation(x-57, y+20, 10);
		draw_rectangle_color(0,0,40,10,c,c,c,c,0)

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(270);
		d3d_transform_add_translation(x+57, y-21, 10);
		draw_rectangle_color(0,0,40,10,c,c,c,c,0)

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_translation(x-57, y+20, 10);
		draw_rectangle_color(0,0,113,10,c,c,c,c,0)

		d3d_transform_set_identity();
		break; 
	case Last: if(sprite_index==spr_hurt){CommonDraw()}else{DsprDraw(0.2)}; break; 
	
	case Car: 
		if(cmr()){
			d3d_transform_set_rotation_x(90);
			d3d_transform_add_rotation_z(point_direction(x,y,global.camera_x,global.camera_y)+90);
			d3d_transform_add_translation(x, y, sprite_get_bbox_bottom(sprite_index)-sprite_get_yoffset(sprite_index));
			draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, abs(image_yscale), 0, image_blend, image_alpha);
			d3d_transform_set_identity();
			}		
		break; 
	
	case Van: 
		var r=right*180; 
		
		draw_set_color(c_white); 
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(90+r);
		d3d_transform_add_translation(x+37*right, y-22*right, 18);
		if(sprite_index==spr_hurt){draw_rectangle(0,0,44,16,0)}
		else{draw_sprite_ext(mdlVan[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0)};
		
		switch(drawspr)
			{
			case sprVanOpen: 
				
				d3d_transform_set_rotation_x(90);
				d3d_transform_add_rotation_z(90);
				d3d_transform_add_translation(x-right*32, y, 16);
				draw_sprite_ext(sprPopoPortalDisappear, drawimg, 0, 0, 1, 1, 0, image_blend, image_alpha);
				
				d3d_transform_set_rotation_x(270+22.5*drawimg); 
				d3d_transform_add_rotation_y(180);
				d3d_transform_add_rotation_z(270+r);
				d3d_transform_add_translation(x-37*right, y+22*right, 1); 
				break; 
			case sprVanDrive: 
				d3d_transform_set_rotation_x(270); 
				d3d_transform_add_rotation_y(180);
				d3d_transform_add_rotation_z(270+r);
				d3d_transform_add_translation(x-37*right, y+22*right, 1); 
				break; 
			default: 
				d3d_transform_set_rotation_x(0); 
				d3d_transform_add_rotation_y(180);
				d3d_transform_add_rotation_z(270+r);
				d3d_transform_add_translation(x-37*right, y+22*right, 1); 
				break; 
			}
		
		if(sprite_index==spr_hurt){draw_rectangle(0,0,-44,-34,0)}
		else{draw_sprite_ext(mdlVan[1], 0, 0, 0, -1, -1, 0, image_blend, 1.0)};
		
		d3d_transform_set_rotation_x(180);
		d3d_transform_add_translation(x-37*right, y+22, 33);
		if(sprite_index==spr_hurt){draw_rectangle(0,0,54*right,44,0)}
		else{draw_sprite_ext(mdlVan[2], 0, 0, 0, right, 1, 0, image_blend, 1.0)};
		
		d3d_transform_set_rotation_x(180);
		d3d_transform_add_translation(x-37*right, y+22, 1);
		if(sprite_index==spr_hurt){draw_rectangle(0,0,74*right,44,0)}
		else{draw_sprite_ext(mdlVan[3], 0, 0, 0, right, 1, 0, image_blend, 1.0)};
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(180+r);
		d3d_transform_add_translation(x-37*right, y+22*right, 33);
		draw_sprite_ext(mdlVan[4], 0, 0, 0, 1, 1, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(r);
		d3d_transform_add_translation(x-37*right, y-22*right, 33);
		draw_sprite_ext(mdlVan[4], 0, 0, 0, -1, 1, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(143);
		d3d_transform_add_rotation_z(90+r);
		d3d_transform_add_translation(x+17*right, y+22*right, 33);
		if(sprite_index==spr_hurt){draw_rectangle(0,0,-44,25,0)}
		else{draw_sprite_ext(mdlVan[5], 0, 0, 0, -1, 1, 0, image_blend, 1.0)};
		
		d3d_transform_set_identity();
		break; 
	
	case WeaponChest: 
		ChestDraw(mdlWeaponChest)
		break; 
	case AmmoChest: 
		ChestDraw(mdlAmmoChest); 
		break; 
	case IDPDChest: 
		ChestDraw(mdlIDPDChest); 
		break; 
	
	
	case SmallGenerator: 
		if(cmr()){
		draw_set_color(c_white); 
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_translation(x-8, y-16, 16);
		draw_sprite_ext(mdlGenerator[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(180);
		d3d_transform_add_translation(x-8, y+16, 16);
		draw_sprite_ext(mdlGenerator[1], 0, 0, 0, 1, 1, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(90);
		d3d_transform_add_translation(x-8, y+16, 16);
		draw_sprite_ext(mdlGenerator[2], 0, 0, 0, 1, 1, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(270);
		d3d_transform_add_translation(x+16, y-16, 16);
		draw_sprite_ext(mdlGenerator[2], 0, 0, 0, 1, 1, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_translation(x-8, y+16, 16);
		draw_sprite_ext(mdlGenerator[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);
		
		d3d_transform_set_identity();
		}
		break; 
	
	case GeneratorInactive: 
	case Generator: 
		draw_set_color(c_white); 
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_translation(x-32, y-31, 57);
		draw_sprite_ext(mdlGenerator[0], 0, 0, 0, 2.66, 3, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_translation(x-32, y-8, 48);
		draw_sprite_ext(mdlGenerator[3], 0, 0, 0, -2, 2, 0, image_blend, 1.0);
		draw_sprite_ext(mdlGenerator[3], 0, 64, 0, 2, 2, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_translation(x-32, y+16, 48);
		draw_sprite_ext(mdlGenerator[3], 0, 0, 0, -2, 2, 0, image_blend, 1.0);
		draw_sprite_ext(mdlGenerator[3], 0, 64, 0, 2, 2, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_translation(x-32, y+40, 48);
		draw_sprite_ext(mdlGenerator[3], 0, 0, 0, -2, 2, 0, image_blend, 1.0);
		draw_sprite_ext(mdlGenerator[3], 0, 64, 0, 2, 2, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(180);
		d3d_transform_add_translation(x-32, y+64, 57);
		draw_sprite_ext(mdlGenerator[1], 0, 0, 0, 2.66, 3, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(90);
		d3d_transform_add_translation(x-31, y+64, 57);
		draw_sprite_ext(mdlGenerator[2], 0, 0, 0, 3, 3, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(270);
		d3d_transform_add_translation(x+31, y-32, 57);
		draw_sprite_ext(mdlGenerator[2], 0, 0, 0, 3, 3, 0, image_blend, 1.0);
		
		d3d_transform_set_rotation_x(90);
		d3d_transform_add_translation(x-32, y+63, 57);
		draw_sprite_ext(mdlGenerator[0], 0, 0, 0, 2.66, 3, 0, image_blend, 1.0);
		
		d3d_transform_set_identity();
		break; 
	
	
	case NothingIntroMask: break;
	case BigTV: StandDraw(20); break; 
	case ProtoStatue: 
		CommonDraw(); 
		draw_text_nt(x,y,"@g"+string(rad))
		break; 
	
	case GuardianStatue:
		if(cmr()){
		draw_set_color(c_white); 

		d3d_transform_set_rotation_x(180);
		d3d_transform_add_rotation_z(45);
		d3d_transform_add_translation(x, y+11.3, 32);
		draw_sprite_ext(mdlGuardianStatue[1], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(45);
		d3d_transform_add_translation(x-11.3, y, 32);
		draw_sprite_ext(mdlGuardianStatue[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(135);
		d3d_transform_add_translation(x+11.3, y, 32);
		draw_sprite_ext(mdlGuardianStatue[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(225);
		d3d_transform_add_translation(x+11.3, y, 32);
		draw_sprite_ext(mdlGuardianStatue[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(315);
		d3d_transform_add_translation(x-11.3, y, 32);
		draw_sprite_ext(mdlGuardianStatue[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

		d3d_transform_set_identity();
		}
		break; 
	
	case ThroneStatue:
		if(cmr()){
		draw_set_color(c_white); 

		d3d_transform_set_rotation_x(180);
		d3d_transform_add_rotation_z(45);
		d3d_transform_add_translation(x, y+11.3, 32);
		draw_sprite_ext(mdlThroneStatue[1], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(45);
		d3d_transform_add_translation(x-11.3, y, 32);
		draw_sprite_ext(mdlThroneStatue[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(135);
		d3d_transform_add_translation(x+11.3, y, 32);
		draw_sprite_ext(mdlThroneStatue[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(225);
		d3d_transform_add_translation(x+11.3, y, 32);
		draw_sprite_ext(mdlThroneStatue[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

		d3d_transform_set_rotation_x(90);
		d3d_transform_add_rotation_z(315);
		d3d_transform_add_translation(x-11.3, y, 32);
		draw_sprite_ext(mdlThroneStatue[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

		d3d_transform_set_identity();
		}
		break; 
	
	case CustomProp: 
		if("ntstype"in self){switch(ntstype)
			{
			case "Door": 
				{
				
				d3d_transform_set_rotation_x(90);
				d3d_transform_add_rotation_z(270);
				if(type){d3d_transform_add_translation(x+16, y+8, 16); draw_sprite_ext(mod_variable_get("area", "dungeon", "sprdx"), 0, 0, 0, 1, 1, 0, image_blend, 1.0)}
				else{d3d_transform_add_translation(x+8, y, 16); draw_sprite_ext(mod_variable_get("area", "dungeon", "sprdy"), 0, 0, 0, 1, 1, 0, image_blend, 1.0)}
				d3d_transform_set_identity();
			
			
			
				d3d_transform_set_rotation_x(90);
				d3d_transform_add_rotation_z(180);
				d3d_transform_add_translation(x, y+16, 16)
				draw_sprite_ext(sprite_index, 0, 0, 0, 1, 1, 0, image_blend, 1.0);
				d3d_transform_set_identity();
			
			
			
				d3d_transform_set_rotation_x(90);
				d3d_transform_add_rotation_z(90);
				if(type){d3d_transform_add_translation(x-16, y+8, 16); draw_sprite_ext(mod_variable_get("area", "dungeon", "sprdx"), 0, 0, 0, 1, 1, 0, image_blend, 1.0)}
				else{d3d_transform_add_translation(x-8, y, 16); draw_sprite_ext(mod_variable_get("area", "dungeon", "sprdy"), 0, 0, 0, 1, 1, 0, image_blend, 1.0)}
				d3d_transform_set_identity();
			
			
			
				d3d_transform_set_rotation_x(90);
				if(type){d3d_transform_add_translation(x, y, 16)}
				else{d3d_transform_add_translation(x, y-16, 16)}
				draw_sprite_ext(sprite_index, 0, 0, 0, 1, 1, 0, image_blend, 1.0);
				d3d_transform_set_identity();
			
				}
				break; 
			
			default: CommonDraw(); break;
			}}
		else{CommonDraw()}
		break; 
	
	default: CommonDraw(); break; 
	}

#define ProjDraw
switch(object_index)
	{
	case LHBouncer: 
	case BouncerBullet: StProjDraw(0); StProjDraw(90); break; 
	
	case Flame: 
	case FlakBullet: 
	case SuperFlakBullet: 
	case EFlakBullet: 
	case ToxicGas: 
	case TrapFire: 
	case GuardianBullet: 
	case FireBall: RotDraw(0.5); break;
	
	case Slash:
	case GuitarSlash: 
	case BloodSlash: 
	case EnergySlash: 
	case EnergyHammerSlash: 
	case LightningSlash: 
	case Shank: 
	case EnergyShank: 
	
	case Disc: 
	
	case Lightning: 
	case EnemyLightning: FlatDraw(0.5); break;
	
	case LightningBall: 
	case FlameBall: StProjDraw(0); StProjDraw(90); break;
	
	case BigGuardianBullet: CommonDraw(); break; 
	
	case PlasmaBall:
	case PlasmaBig: 
	case PlasmaHuge: 
	case PopoPlasmaBall: StProjDraw(0)
	
	default: 
		with(Grenade){if(id=other){StProjDraw(0); CommonProjDraw(); exit}}
		CommonProjDraw(); 
		break; 
	}

#define EffDraw
switch(object_index)
	{
	case ChestOpen: 
		switch(sprite_index)
			{
			case sprWeaponChestOpen: 
			case sprCursedChestOpen: 
				ChestOpenDraw(mdlWeaponChest); 
				break; 
			case sprAmmoChestOpen: 
				ChestOpenDraw(mdlAmmoChest); 
				break; 
			case sprIDPDChestOpen: 
				ChestOpenDraw(mdlIDPDChest); 
				break; 
			default: CommonDraw(); break; 
			}
		break;
	case Debris: 
	case Bubble: 
	case AssassinNotice: 
	case Wind: 
	case ReviveFX: 
	case Breath: 
	case CaveSparkle: 
	case RainSplash: 
	case WindNight: 
	case GroundFlame: 
	case BlueFlame: 
	case FXChestOpen: 
	case SmallChestFade: 
	case ExploderExplo: 
	case LaserCharge: 
	case IDPDPortalCharge: CommonDraw(); break; 
	
	case BulletHit: 
	case EBulletHit: 
	case ScorpionBulletHit: 
	case PhantomBolt: 
	case BoltTrail: 
	case NothingBeamParticle: 
	case NothingBeamChargeParticle: CommonProjDraw(0.5); break; 
	
	case PlasmaTrail: 
	case TangleKill: 
	case PortalL: 
	case ChickenB: 
	case Dust: 
	case ImpactWrists: 
	case ThrowHit: 
	case FishBoost: 
	case Curse: 
	case Smoke: 
	case AllyDamage: 
	case DiscBounce: 
	case DiscDisappear: 
	case BloodStreak: 
	case AcidStreak: 
	case LightningHit: RotDraw(0.5); break; 
	
	case Deflect: 
	case DiscTrail: 
	case MeleeHitWall: 
	case LightningSpawn: FlatDraw(0.5); break; 
	
	case RainDrop: 
	case SnowFlake: RainDraw(0.2); break; 
	
	case Feather: FeatherDraw(0.2); break; 
	
	case BoltStick: BSDraw(0.2); break; 
	
	case Confetti: ZDraw(0.2,1); break; 
	
	case NothingBeamHit: StBoxDraw(0.5); break; 
	
	default: break; 
	}

#define DirDraw
if(cmr()){
d3d_set_zwriteenable(false);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, direction, image_blend, 1.0);
d3d_set_zwriteenable(true);
}

#define CommonDraw
if(cmr()){
var d=0
if("BeDriver"in self){if(instance_exists(BeDriver)){d=sprite_get_bbox_bottom(BeDriver.sprite_index)-sprite_get_yoffset(BeDriver.sprite_index)}}
d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(point_direction(x,y,global.camera_x,global.camera_y)+90);
d3d_transform_add_translation(x, y, d+sprite_get_bbox_bottom(sprite_index)-sprite_get_yoffset(sprite_index));
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
d3d_transform_set_identity();
}
#define CommonProjDraw
if(cmr()){
d3d_transform_add_translation(x, y, global.camera_height*0.5);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(image_angle);
d3d_transform_add_translation(x, y, global.camera_height*0.5);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
d3d_transform_set_identity();
}
#define StProjDraw
if(cmr()){
d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(image_angle+90+argument0);
d3d_transform_add_translation(x, y, global.camera_height*0.5);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 90, image_blend, image_alpha);
d3d_transform_set_identity();
}
#define DsprDraw
if(cmr()){
d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(point_direction(x,y,global.camera_x,global.camera_y)+90);
d3d_transform_add_translation(x, y, sprite_height*argument0);
draw_sprite_ext(drawspr, drawimg, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
d3d_transform_set_identity();
}
#define StDraw
if(cmr()){
d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(point_direction(x,y,global.camera_x,global.camera_y)+90);
d3d_transform_add_translation(x, y, sprite_height*argument0);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 90, image_blend, image_alpha);
d3d_transform_set_identity();
}
#define ZDraw
d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(point_direction(x,y,global.camera_x,global.camera_y)+90);
d3d_transform_add_translation(x, y, sprite_height*argument0-z*argument1);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
d3d_transform_set_identity();

#define RotDraw
if(cmr()){
var a=image_angle;
if("rot"in self){a=rot}
if("angle"in self){a=angle}
d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(point_direction(x,y,global.camera_x,global.camera_y)+90);
d3d_transform_add_translation(x, y, sprite_height*argument0);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, a, image_blend, image_alpha);
d3d_transform_set_identity();
}
#define StandDraw
d3d_transform_set_rotation_x(90);
d3d_transform_add_translation(x, y+argument0, sprite_height*0.5);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
d3d_transform_set_identity();

#define FlatDraw
if(cmr()){
//d3d_transform_add_rotation_z(point_direction(x,y,global.camera_x,global.camera_y)+90);
d3d_transform_add_translation(x, y, global.camera_height*argument0);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
d3d_transform_set_identity();
}
#define StBoxDraw
var dt=sprite_width/2
d3d_transform_set_rotation_y(0);
d3d_transform_add_translation(x, y, dt*2);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
d3d_transform_set_rotation_y(90);
d3d_transform_add_translation(x+dt, y, dt);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
d3d_transform_set_rotation_y(270);
d3d_transform_add_translation(x-dt, y, dt);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
d3d_transform_set_identity();

#define RainDraw
if(cmr()){
d3d_transform_set_rotation_x(90);
d3d_transform_add_translation(x+addx, y, sprite_height*argument0+addy);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
d3d_transform_set_identity();
}
#define FeatherDraw
if(cmr()){
d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(point_direction(x,y,global.camera_x,global.camera_y)+90);
d3d_transform_add_translation(x, y, sprite_height*argument0+fall);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, rot, image_blend, image_alpha);
d3d_transform_set_identity();
}
#define BSDraw
if(cmr()&&instance_exists(target)){
d3d_transform_add_translation(target.x, target.y, global.camera_height*0.5);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(image_angle);
d3d_transform_add_translation(target.x, target.y, global.camera_height*0.5);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
d3d_transform_set_identity();
}

#define ChestDraw
if(cmr()){
draw_set_color(c_white); 

d3d_transform_set_rotation_x(90);
d3d_transform_add_translation(x-8, y-8, 16);
draw_sprite_ext(argument0[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

d3d_transform_set_rotation_x(180);
d3d_transform_add_translation(x-8, y+8, 10);
draw_sprite_ext(argument0[1], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(90);
d3d_transform_add_translation(x-8, y+8, 16);
draw_sprite_ext(argument0[2], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(270);
d3d_transform_add_translation(x+8, y-8, 16);
draw_sprite_ext(argument0[2], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

d3d_transform_set_rotation_x(90);
d3d_transform_add_translation(x-8, y+8, 16);
draw_sprite_ext(argument0[2], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

d3d_transform_set_identity();
}

#define ChestOpenDraw
if(cmr()){
draw_set_color(c_white); 

d3d_transform_set_rotation_x(90);
d3d_transform_add_translation(x-8, y-8, 16);
draw_sprite_ext(argument0[0], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

d3d_transform_set_rotation_x(180);
d3d_transform_add_translation(x-8, y+8, 0);
draw_rectangle_color(0,0,15,15,0,0,0,0,0)

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(90);
d3d_transform_add_translation(x-8, y+8, 16);
draw_sprite_ext(argument0[2], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(270);
d3d_transform_add_translation(x+8, y-8, 16);
draw_sprite_ext(argument0[2], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

d3d_transform_set_rotation_x(90);
d3d_transform_add_translation(x-8, y+8, 16);
draw_sprite_ext(argument0[2], 0, 0, 0, 1, 1, 0, image_blend, 1.0);

d3d_transform_set_identity();
}

#define ThroneDraw
var d=argument0
draw_set_color(c_white); 
var c=1775178

d3d_transform_set_rotation_x(90);
d3d_transform_add_translation(x, y, d+52);
draw_sprite_ext(sprNothingMiddle, 0, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);

d3d_transform_set_rotation_x(90);
d3d_transform_add_translation(x, y+42, d+86);
draw_sprite_ext(mdlNothing[0], 0, -84, 0, 1, image_yscale, 0, image_blend, image_alpha);
draw_sprite_ext(mdlNothing[0], 0, 84, 0, -1, image_yscale, 0, image_blend, image_alpha);

d3d_transform_set_rotation_x(90);
d3d_transform_add_translation(x, y-24, d+86);
draw_sprite_ext(mdlNothing[0], 0, -84, 0, 1, image_yscale, 0, image_blend, image_alpha);
draw_sprite_ext(mdlNothing[0], 0, 84, 0, -1, image_yscale, 0, image_blend, image_alpha);

d3d_transform_set_rotation_x(0);
d3d_transform_add_translation(x, y-29, d+78);
draw_sprite_ext(mdlNothing[1], 0, -83, 0, 1, image_yscale, 0, image_blend, image_alpha);
draw_sprite_ext(mdlNothing[1], 0, 83, 0, -1, image_yscale, 0, image_blend, image_alpha);

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_y(90);
d3d_transform_add_rotation_z(90);
d3d_transform_add_translation(x-82, y-29, d+82);
draw_sprite_ext(mdlNothing[1], 0, 0, 0, -1, -image_yscale, 0, image_blend, image_alpha);

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_y(90);
d3d_transform_add_rotation_z(90);
d3d_transform_add_translation(x-47, y-29, d+82);
draw_sprite_ext(mdlNothing[1], 0, 0, 0, -1, -image_yscale, 0, image_blend, image_alpha);

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_y(90);
d3d_transform_add_rotation_z(90);
d3d_transform_add_translation(x+47, y-29, d+82);
draw_sprite_ext(mdlNothing[1], 0, 0, 0, -1, -image_yscale, 0, image_blend, image_alpha);

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_y(90);
d3d_transform_add_rotation_z(90);
d3d_transform_add_translation(x+82, y-29, d+82);
draw_sprite_ext(mdlNothing[1], 0, 0, 0, -1, -image_yscale, 0, image_blend, image_alpha);

d3d_transform_set_rotation_x(90);
d3d_transform_add_translation(x, y+80, d+42);
draw_sprite_ext(mdlNothing[2], 0, -125, 0, 1, 1, 0, image_blend, image_alpha);
draw_sprite_ext(mdlNothing[2], 0, 125, 0, -1, 1, 0, image_blend, image_alpha);

d3d_transform_set_rotation_x(90);
d3d_transform_add_translation(x, y-24, d+42);
draw_sprite_ext(mdlNothing[2], 0, -125, 0, 1, 1, 0, image_blend, image_alpha);
draw_sprite_ext(mdlNothing[2], 0, 125, 0, -1, 1, 0, image_blend, image_alpha);

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(90);
d3d_transform_add_translation(x-125, y+80, d+42);
draw_rectangle_color(0,0,103,41,c,c,c,c,0)

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(90);
d3d_transform_add_translation(x-29, y+80, d+42);
draw_rectangle_color(0,0,103,41,c,c,c,c,0)

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(90);
d3d_transform_add_translation(x+29, y+80, d+42);
draw_rectangle_color(0,0,103,41,c,c,c,c,0)

d3d_transform_set_rotation_x(90);
d3d_transform_add_rotation_z(90);
d3d_transform_add_translation(x+125, y+80, d+42);
draw_rectangle_color(0,0,103,41,c,c,c,c,0)

d3d_transform_set_rotation_x(0);
d3d_transform_add_translation(x-125, y-24, d+42);
draw_rectangle_color(0,0,95,103,c,c,c,c,0)
draw_rectangle_color(154,0,249,103,c,c,c,c,0)

if(argument0!=0)
	{
	d3d_transform_set_rotation_x(0);
	d3d_transform_add_translation(x-125, y-24, d+0);
	draw_rectangle_color(0,0,95,103,c,c,c,c,0)
	draw_rectangle_color(154,0,249,103,c,c,c,c,0)
	}

d3d_transform_set_identity();

#define cmr
if(object_index=Laser||object_index=EnemyLaser){return 1; exit}
var dis=point_distance(x,y,global.camera_x,global.camera_y)
if(dis<96){return 1}else{if(dis/*-max(sprite_width*image_xscale,sprite_height*image_yscale)*/<global.view_dist)
	{return 1
	/*var wd=x-sprite_get_xoffset(sprite_index)
	var wl=wd+sprite_get_bbox_left(sprite_index); 
	var wr=wd+sprite_get_bbox_right(sprite_index); 
	var hd=y-sprite_get_yoffset(sprite_index)
	var hl=hd+sprite_get_bbox_top(sprite_index); 
	var hr=hd+sprite_get_bbox_bottom(sprite_index); 
	if(cmrcl(wl,hl)&&cmrcl(wl,hr)&&cmrcl(wr,hl)&&cmrcl(wr,hr)){exit}
	var f1=(Player.gunangle+global.FOV+330)mod 360; var f2=(Player.gunangle-global.FOV+390)mod 360; 
	var dir=point_direction(x,y,global.camera_x,global.camera_y); 
	if(f1<f2){if(dir>f1&&dir<f2){return 1}}else{if(dir>f1||dir<f2){return 1}}
	*/}}

#define cmrcl
return collision_line(argument0, argument1, global.camera_x, global.camera_y, Wall, 1, 1)
