
#define init
global.MNPCRobotN = ["Fabric", "Organics", "Metal", "Bone", "Crocodile", "Alcohol", "Web", "Crystal"]
global.WideScreen = true
game_set_size(428,240)

globalvar mpm
if(instance_number(Player) > 1)
	{GameCont.MorePlayer=1; mpm=17}
else{GameCont.MorePlayer=0; mpm=0}

globalvar sprCowardBackup, sprCowardSmoke
sprCowardBackup = sprite_add("CowardBackup.png", 7, 0, 0)
sprCowardSmoke = sprite_add("CowardSmoke.png", 7, 0, 0)

#define game_start
if(instance_number(Player)>1){GameCont.MorePlayer=1; mpm=17}
else{GameCont.MorePlayer=0; mpm=0}

#define step
//with(Menu){script_bind_draw(scrFakeMenu, depth+1)}

#define scrFakeMenu
draw_set_color(0)
var dx = global.WideScreen ? 54 : 0
var ax = global.WideScreen ? 428 : 320
for(var i=0; i<maxp; i++)
	{
	draw_set_visible_all(false)
	draw_set_visible(i,1)
	draw_rectangle(view_xview[i], view_yview[i], view_xview[i]+ax, view_yview[i]+240, false)
	draw_sprite(bakMenu, 0, view_xview[i]+dx, view_yview[i])
	}
draw_set_visible_all(true)
draw_set_color(c_white)
instance_destroy()



#define chat_command
if(argument0 == "wide")
	{
	if(global.WideScreen){global.WideScreen=false; game_set_size(320,240); trace("Wide Screen display mode disable.")}
	else{global.WideScreen=true; game_set_size(428,240); trace("Wide Screen display mode enable.")}
	return 1;
	}

#define draw_gui
	{
	var h = draw_get_halign()
	var v = draw_get_valign()
	scrDrawP4()
	scrDrawP2()
	draw_set_font(4)
	draw_set_halign(h)
	draw_set_valign(v)
	draw_set_visible_all(true)
	}

#define scrDrawP4
	{
	draw_set_font(4)
	with(instances_matching(Player, "visible", true))
		{
		draw_set_visible_all(false)
		draw_set_visible(index,1)
		scrDrLQWepAmmo()
		}
	scrDrRace()
//	scrDrMarketNPC()
	}

#define scrDrLQWepAmmo
if(!instance_exists(TopCont)){exit}
if(TopCont.fade < 0)
	{
	if(is_object(wep)){if("ammo"in wep)
		{draw_text_nt(42-mpm, 21, `${wep.ammo>0?"":"@s"}${min(floor(wep.ammo), 999)}`)}}
	if(is_object(bwep)){if("ammo"in bwep)
		{draw_text_nt(86-mpm, 21, `${bwep.ammo>0?"":"@s"}${min(floor(bwep.ammo), 999)}`)}}
	}

#define scrDrRace
	{
	scrDrRaceCoward()
//	scrDrRaceClown()
	scrDrRaceTricker()
	scrDrRacePhantom()
//	scrDrRaceBronya()
//	scrDrRaceDefect()
	var ary = mod_variable_get("mod", "ntsCont", "binah_se")
	if(ary != undefined){scrDrBinah(ary)}
	}

#define scrDrRaceCoward
	{
	with(instances_matching(Player,"race","coward"))
		{
		draw_set_visible_all(false)
		draw_set_visible(index,1)
		draw_sprite_ext(ultra_get("coward",2)?sprCowardSmoke:sprCowardBackup, nts_coward_stored, 110-mpm, 4, 1, 1, 0, c_white, 1)
		}
	}

#define scrDrRaceClown
	{
	if("nts_clown_command" in GameCont)
		{
		with(instances_matching(Player, "race", "clown"))
			{
			draw_set_visible_all(false)
			draw_set_visible(index, true)
			var PCHUDText = "mode: "
			switch(GameCont.nts_clown_command[@index])
				{
				case 1: PCHUDText+="clear" ;break;
				case 2: PCHUDText+="goto" ;break;
				case 3: PCHUDText+="stand" ;break;
				case 4: PCHUDText+="attack" ;break;
				default: PCHUDText+="?"; break;
				}
			draw_text_nt(111-mpm, 7, PCHUDText)
			}
		}
	}

#define scrDrRaceTricker
	{
	with(instances_matching(Player,"race","tricker"))
		{
		draw_set_visible_all(false)
		draw_set_visible(index, true)
		draw_sprite_ext(weapon_get_sprite(nts_tricker_stwep[0]), 0, 120-mpm, 27, 1, 1, 90, c_white, 1)
		if(skill_get(5) || ultra_get("tricker",1) || ultra_get("tricker",2))
			{draw_text_nt(120-mpm, 30, `${min(99, floor(nts_tricker_stwep[@1] / weapon_get_load(nts_tricker_stwep[@0]) * 100))}%`)}
		}
	}

#define scrDrRacePhantom
	{
	with(instances_matching(Player,"race","phantom"))
		{
		draw_set_visible_all(false)
		draw_set_visible(index,1)

		var BlankHUD=113-mpm
		
		draw_sprite_ext(sprReviveBar, 0, BlankHUD+2, 22, 1, 1, 270, c_white, 1)
		draw_set_color(make_color_rgb(103,27,131));
		draw_rectangle(BlankHUD, 37-31*ect/ectmax, BlankHUD+3, 37, 0);
		}
	}

#define scrDrRaceDefect
	{
	with(instances_matching(Player, "race", "defect"))
		{
	//	if(is_array(bonus_card)){exit}
		
		draw_set_visible_all(false)
		draw_set_visible(index, true)
		
		if(shuffling > 0)
			{var text = "@rshuffling"}
		else{
			var c_p = player_get_color(index)
			var deck = mod_variable_get("race", "defect", "aryDeck")[@index]
			var size = ds_list_size(deck) - hand_number
			var text = `@(color:${c_p})${my_cost}/${maxcost} @${size>0?"w":"r"}${size}`
			
			for(var i=0; i<hand_number; i++)
				{
				var name = deck[|i]
				var cost = mod_variable_get("race", "defect", "mapData")[?name][@0]
				
				if(is_real(cost))
					{var ctxt = string(cost)}
				else{
					var ctxt = "X"
					cost = 0
					}
				
				text += `##@${hand_index==i ? "w" : "s"}${i}.@(color:${c_p})${ctxt}.@${cost>my_cost?"r":"w"}${string_replace_all(name, "_", " ")}`
				}
			}
		
		draw_text_nt(4, 48, text)
		
		draw_set_visible_all(true)
		}
	}

#define scrDrBinah
if(instance_exists(LevCont) && instance_exists(SkillIcon))
	{
	with(instances_matching(Player, "race", "binah"))
		{
		if(argument0[@index])
			{draw_text_nt(4, 48, `@(color:${player_get_color(index)})@3(sprKeySmall:spec)or@3(sprButSmall:spec)##secondary#extraction`)}
		else{draw_text_nt(4, 48, `@s@3(sprKeySmall:spec)or@3(sprButSmall:spec)##exhausted`)}
		}
	}

#define scrDrMarketNPC
	{
	with(instances_matching(CustomObject,"ntstype","MarketNPC")){if("BuyerDis"in self){if(BuyerDis>=0 and BuyerDis<=16)
		{
		switch(Data[0])
			{
			case "venuz":
				global.IndexScale=IndexScale; global.BadLuck=BadLuck; global.Deal=Deal;
				with(Buyer)
					{
					draw_set_visible_all(false)
					draw_set_visible(index,1)
					ShopHUDText = "  "
					switch(global.BadLuck[index])
						{
						case -4: ShopHUDText+="Hi Bro. "; break;
						case -1: ShopHUDText+="@su cant deal with zat. "; break;
						case -2: ShopHUDText+="@yu nee money bro. "; break;
						case 0: ShopHUDText+="have fun. "; break;
						case 1: ShopHUDText+="@sfailed but not my fault. "; break;
						default: break;
						}
					ShopHUDText+=`## @4(sprMoneyPile:0)=${GameCont.Money}## @4(sprRobotMenu:-0.4)=${weapon_get_area(wep)}##`
					if(GameCont.Money<global.Deal or global.Deal==-1){ShopHUDText+="@s"};
					ShopHUDText+="@2(keysmall:49)Change your wep## "
					if(global.Deal==-1){ShopHUDText+="@sdeal invalid"}
					else{
						ShopHUDText+="@wfor "
						if(GameCont.Money<global.Deal){ShopHUDText+="@r"}else{ShopHUDText+="@y"};
						ShopHUDText+=string(global.Deal);
						}
					draw_text_nt(4, 48, ShopHUDText)
					}
				break;
			
			case "steroids":
				break;
			
			case "robot": 
				/*
				global.ResourceVaule=ResourceVaule; global.SellScale=SellScale;
				with(GameCont){global.ShopHUDR=[Fabric, Organics, Metal, Bone, Crocodile, Alcohol, Web, Crystal]}
				
				with(Buyer)
					{
					draw_set_visible_all(false)
					draw_set_visible(index,1)
					ShopHUDText=` @4(sprMoneyPile:0)=${GameCont.Money} @wscale=${global.SellScale}##`
					for(Ri=0;Ri<8;Ri++){ShopHUDText+=`@s@2(keysmall:${Ri+49})${global.MNPCRobotN[Ri]}#  @1(sprMoney:0)@y${global.ResourceVaule[Ri]}@s/ @w${global.ShopHUDR[Ri]}#`}
					ShopHUDText+=`#@w@2(keysmall:57)change sell scale`
					draw_text_nt(4, 56, ShopHUDText)
					}
				*/
				break;
			
			case "horror":
				global.SellStuff=SellStuff;
				global.price=Price; global.ct=CT; global.skit=SkiT; 
				with(Buyer)
					{
					draw_set_visible_all(false)
					draw_set_visible(index,1)
					ShopHUDText=` @gradlump=${GameCont.RadiationLump}  price=${global.price}`
					for(Ri=0;Ri<6;Ri++)
						{
						ShopHUDText+=`##@w@2(keysmall:${Ri+49})`
						if(global.SellStuff[Ri]==-1){ShopHUDText+="@sEmpty"}
						else{
							if(global.price>GameCont.RadiationLump){ShopHUDText+="@s"};
							ShopHUDText+=skill_get_name(global.SellStuff[Ri])
							}
						}
					ShopHUDText+="##@w@2(keysmall:57)next page#  page("+string(global.ct+1)+"/"+string(global.skit+1)+")";
					draw_text_nt(4, 48, ShopHUDText)
					}
				break;
			
			case "rogue":
				global.sold=Sold;
				with(Buyer)
					{
					draw_set_visible_all(false)
					draw_set_visible(index,1)
					ShopHUDText=`  @ymoney=${GameCont.Money}##  @bdeposit=${GameCont.BankSave}##@w@2(keysmall:49)save @wall @ymoney##${(global.sold)?"@s":"@w"}@2(keysmall:50)draw @y400(+40 fee)##@b(10% fee)`
					draw_text_nt(4, 48, ShopHUDText)
					}
				
				break;
			
			case "frog":
				break;
			
			case "cuz":
				global.Sold=Sold; global.SellStuff=SellStuff;
				
				with(Buyer)
					{
					draw_set_visible_all(false)
					draw_set_visible(index,1)
					if(global.Sold){ShopHUDText="hav a nic trip. "}
					else{
						ShopHUDText=" where'd u go?"
						for(Ri=0;Ri<3;Ri++)
							{ShopHUDText+=`##@2(keysmall:${Ri+49})@s${global.SellStuff[Ri,1]}#  @w${global.SellStuff[Ri,0]}`}
						}
					draw_text_nt(4, 48, ShopHUDText)
					}
				
				break;
			
			default: 
				global.SellStuff=SellStuff;
				
				with(Buyer)
					{
					draw_set_visible_all(false)
					draw_set_visible(index,1)
					ShopHUDText=`@4(sprMoneyPile:0)=${GameCont.Money}##`
					for(var Ri=0;Ri<6;Ri++)
						{
						ShopHUDText+=`@2(keysmall:${Ri+49})`
						if(global.SellStuff[Ri,0]=="empty"){ShopHUDText+="@sEmpty#"}
						else{
							if(global.SellStuff[Ri,1]>GameCont.Money){ShopHUDText+="@s"};
							ShopHUDText+=`@4(${weapon_get_sprite(global.SellStuff[Ri,0])}:0)#  ${(global.SellStuff[Ri,1]>GameCont.Money)?"@r":"@y"}${global.SellStuff[Ri,1]}`
							}
						ShopHUDText+="##"
						}
					draw_text_nt(4, 56, ShopHUDText)
					}
				
				break;
			}
		}}}
	}

#define scrDrawP2
	{
	draw_set_font(2)
//	scrDrRaceClown()
	scrDrGameContSay()
	}

#define scrDrGameContSay
	{
	if("SayText"in GameCont && "DoTips"in GameCont)
		{
		var lev = instance_exists(LevCont)
		var gwm = game_width>>1
		var ghm = game_height>>1
		draw_set_halign(1)
		draw_set_valign(lev?1:2)
		
		for(var i=0; i<maxp; i++){if(GameCont.DoTips[@i] && GameCont.SayText[@i]!=" ")
			{
			draw_set_visible_all(false)
			draw_set_visible(i, true)
			
			var str = GameCont.SayText[i]
			var strb = string_replace_all(GameCont.SayText[i], "#", chr(13))
			var strw = string_width(strb)
			var strh = string_height(strb)
			var gwml = (game_width-strw)>>1
			var ghmt = (game_height-strh)>>1
			draw_set_alpha(0.5)
			draw_set_color(0)
			
			if(lev)
				{
				draw_rectangle(gwml-3, ghmt, gwml+strw-3, ghmt+strh, 0)
				draw_set_alpha(1)
				draw_set_color(c_white)
				draw_text_nt(gwm, 120, str)
				}
			else{
				draw_rectangle(gwml-3, 240, gwml+strw-3, 240-strh, 0)
				draw_set_alpha(1)
				draw_set_color(c_white)
				draw_text_nt(gwm, 240, str)
				}
			}}
		}
	}
